import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:konstructora/Screens/login_screen.dart';
import 'package:konstructora/Screens/HomeNouveau.dart';

class ScreenPanier extends StatefulWidget {
  final List<Map<String, dynamic>> cartList;

  const ScreenPanier({Key? key, required this.cartList}) : super(key: key);

  @override
  _ScreenPanierState createState() => _ScreenPanierState();
}

class Commande {
  String userID;
  String owners;
  String name;
  double price;
  double quantity;

  Commande({
    required this.name,
    required this.quantity,
    required this.price,
    required this.userID,
    required this.owners,
  });

  factory Commande.fromMap(Map<String, dynamic> map) {
    return Commande(
      name: map['name'],
      price: (map['price'] as num).toDouble(),
      quantity: map['quantity'],
      userID: map['userID'],
      owners: map['ownerID'], // Ajoutez cette ligne si nécessaire
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'quantity': quantity,
      'userID': userID,
      'ownerID': owners, // Ajoutez cette ligne si nécessaire
    };
  }
}

class _ScreenPanierState extends State<ScreenPanier> {
  late List<double> _selectedTypeList;
  late String _userID;
  String _selectedType = '';
  double sommePanier = 0;
  List<int> _quantities = [];

  @override
  void initState() {
    super.initState();
    _selectedTypeList = List<double>.filled(widget.cartList.length, 0.25);
    _userID = FirebaseAuth.instance.currentUser?.uid ?? '';
    _selectedType = '';
    _quantities = List<int>.filled(widget.cartList.length, 1);
  }

  double calculerSommePanier(List<Map<String, dynamic>> cartList,
      List<int> quantities, List<double> selectedTypeList) {
    double somme = 0;
    for (int i = 0; i < cartList.length; i++) {
      double prix = cartList[i]['price'];
      if (cartList[i]['quantity'] == null) {
        int quantite = quantities[i];
        somme += prix * quantite;
      } else {
        double quantite = selectedTypeList[i];
        somme += prix * quantite;
      }
    }
    return somme;
  }
  void _createNotification(String message, String ownerId) async {
    try {
      await FirebaseFirestore.instance.collection('notifications').add({
        'message': message,
        'ownerId': ownerId,
      });
    } catch (error) {
      print('Error creating notification: $error');
    }
  }
  Future<void> buildCommande() async {
    List<Commande> commandes = [];
    String selectedType = _selectedType;

    for (int i = 0; i < widget.cartList.length; i++) {
      double quantity = widget.cartList[i]['quantity'] == null
          ? _quantities[i].toDouble()
          : _selectedTypeList[i];

      Map<String, dynamic> element = {
        'name': widget.cartList[i]['name'],
        'price': widget.cartList[i]['price'],
        'userID': _userID, // Ajoutez l'ID de l'utilisateur connecté
        'ownerID': widget.cartList[i]['ownerId'],
        'quantity': quantity, // Utilisez la quantité appropriée
      };

      Commande commande = Commande.fromMap(element);
      commandes.add(commande);
    }

    for (int i = 0; i < commandes.length; i++) {
      await FirebaseFirestore.instance
          .collection('commande')
          .add(commandes[i].toMap());
      String message = 'New order: ${commandes[i].name} : ${commandes[i].quantity}';
      String ownerId = commandes[i].owners;
      _createNotification(message, ownerId);
    }
      // Afficher un message de succès
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Commande validée avec succès'),
        duration: Duration(seconds: 2), // Durée du SnackBar
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double sommePanier =
        calculerSommePanier(widget.cartList, _quantities, _selectedTypeList);
    return Scaffold(
        backgroundColor: Color.fromRGBO(233, 217, 203, 1.0),
        appBar: AppBar(
          title: Text('My Basket'),
          backgroundColor: Color.fromRGBO(112, 60, 6, 1.0),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeNew()),
              );
            },
          ),
        ),
        body: widget.cartList.isEmpty
            ? Center(
                child: Text('Nothing !!'),
              )
            : ListView.builder(
                itemCount: widget.cartList.length,
                itemBuilder: (context, index) {
                  bool isCoffee =
                      widget.cartList[index].containsKey('quantity');
                  // Vérifier si l'élément est un café ou un grain de café
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   'Owner : ${widget.cartList[index]['ownerId'] ?? ''}',
                        //   style: TextStyle(
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        // SizedBox(height: 8),
                        Text(
                          'Name: ${widget.cartList[index]['name'] ?? ''}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Price: ${widget.cartList[index]['price'] ?? ''}',
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              'Quantity:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 8),
                            // Vérifier si l'élément est un coffee ou un coffeebean
                            if (widget.cartList[index]['quantity'] == null)
                              // Coffee
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _quantities[index] =
                                          int.tryParse(newValue) ?? 0;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Quantity',
                                    border: OutlineInputBorder(),
                                  ),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter the Quantity of the coffee';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            if (widget.cartList[index]['quantity'] != null)
                              // CoffeeBean
                              Row(
                                children: [
                                  Radio<double>(
                                    value: 0.250,
                                    groupValue: _selectedTypeList[index],
                                    onChanged: (newValue) {
                                      setState(() {
                                        _selectedTypeList[index] = newValue!;
                                      });
                                    },
                                  ),
                                  Text('250g'),
                                  Radio<double>(
                                    value: 0.5,
                                    groupValue: _selectedTypeList[index],
                                    onChanged: (newValue) {
                                      setState(() {
                                        _selectedTypeList[index] = newValue!;
                                      });
                                    },
                                  ),
                                  Text('500g'),
                                  Radio<double>(
                                    value: 1,
                                    groupValue: _selectedTypeList[index],
                                    onChanged: (newValue) {
                                      setState(() {
                                        _selectedTypeList[index] = newValue!;
                                      });
                                    },
                                  ),
                                  Text('1kg'),
                                ],
                              ),
                          ],
                        ),
                        Divider(),
                      ],
                    ),
                  );
                },
              ),
        bottomNavigationBar: BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                buildCommande(); // Construire l'objet Commande
                // Ajouter ici la logique pour valider la commande avec les quantités sélectionnées
                // Par exemple, envoyer la commande à Firebase ou effectuer d'autres opérations
              },
              child: Text('Validate'),
            ),
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 19.0),
            // decoration: BoxDecoration(
            //   color: Color.fromARGB(255, 196, 139, 75), // Changer la couleur d'arrière-plan au besoin
            // ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total of your basket :',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  '\dt ${sommePanier.toStringAsFixed(3)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.black, // Changer la couleur de la police au besoin
                  ),
                ),
              ],
            ),
          ),
        ),
        );
  }
}
