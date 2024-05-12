import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:konstructora/Screens/SideMenuClient.dart';
import 'package:konstructora/Screens/Panier_screen.dart';

class HomeNew extends StatefulWidget {
  const HomeNew({Key? key}) : super(key: key);

  @override
  _HomeNewState createState() => _HomeNewState();
}

class _HomeNewState extends State<HomeNew> {
  late User _currentUser;
  List<Map<String, dynamic>> _coffeeList = [];
  List<Map<String, dynamic>> _coffeeBeansList = [];
  List<Map<String, dynamic>> _cartList = [];

  @override
  void initState() {
    super.initState();
    _currentUser = FirebaseAuth.instance.currentUser!;
    _loadCoffeeData();
    _loadCoffeeBeansData();
  }

  // void selectCoffee(String coffeeId) {
  //   print("Café sélectionné avec l'ID: $coffeeId");
  //   commanderCoffee(coffeeId);
  // }

  Future<void> _loadCoffeeData() async {
    try {
      QuerySnapshot coffeeSnapshot =
      await FirebaseFirestore.instance.collection('coffees').get();

      setState(() {
        _coffeeList = coffeeSnapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          data['_id'] = doc.id;
          return data;
        }).toList();
      });
    } catch (error) {
      print('Error loading coffee data: $error');
    }
  }

  Future<void> _loadCoffeeBeansData() async {
    try {
      QuerySnapshot coffeeBeansSnapshot =
      await FirebaseFirestore.instance.collection('coffeebean').get();
      setState(() {
        _coffeeBeansList = coffeeBeansSnapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          data['_id'] = doc.id;
          return data;
        }).toList();
      });
    } catch (error) {
      print('Error loading coffee beans data: $error');
    }
  }


  void addToCart(Map<String, dynamic> item) {
    setState(() {
      _cartList.add(item);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Article ajouté au panier'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 223, 187, 134),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(112, 60, 6, 1.0),
        title: Text('Coffee Shop', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScreenPanier(cartList: _cartList),
                ),
              );
            },
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
          ),
        ],
      ),
      drawer: SideMenuClient(userEmail: _currentUser.email!),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Coffees:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 117, 71, 0),
                ),
              ),
            ),
            SizedBox(
              height: 280,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _coffeeList.length,
                itemBuilder: (context, index) {
                  String coffeeId = _coffeeList[index]['_id'];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        addToCart(_coffeeList[index]);
                      },
                      child: Container(
                        width: 110,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.11),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  _coffeeList[index]['image'] ?? '',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Text('Error loading image');
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                _coffeeList[index]['name'] ?? '',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Price: ${_coffeeList[index]['price'] ?? ''}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  addToCart(_coffeeList[index]);
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Color.fromARGB(255, 158, 104, 22),
                                  ), // Couleur de fond du bouton
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10), // Bord arrondi du bouton
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Add',
                                  style: TextStyle(
                                    color: Colors
                                        .white, // Couleur du texte du bouton
                                    fontWeight:
                                        FontWeight.bold, // Texte en gras
                                  ),
                                ), // Texte du bouton
                              ),
                            ),


                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Coffee Beans:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 117, 71, 0),
                ),
              ),
            ),
            SizedBox(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _coffeeBeansList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 110,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.11),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                _coffeeBeansList[index]['image'] ?? '',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _coffeeBeansList[index]['description'] ?? '',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Price/kg: ${_coffeeBeansList[index]['price'] ?? ''}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                addToCart(_coffeeBeansList[index]);
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Color.fromARGB(255, 158, 104, 22),
                                ), // Couleur de fond du bouton
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10), // Bord arrondi du bouton
                                  ),
                                ),
                              ),
                              child: Text(
                                'Add',
                                style: TextStyle(
                                  color: Colors
                                      .white, // Couleur du texte du bouton
                                  fontWeight: FontWeight.bold, // Texte en gras
                                ),
                              ), // Texte du bouton
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}