import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:konstructora/Screens/Owner/SideMenuOwner.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomeOwner extends StatefulWidget {
  const HomeOwner({Key? key}) : super(key: key);

  @override
  State<HomeOwner> createState() => _HomeOwnerState();
}

class _HomeOwnerState extends State<HomeOwner> {
  late User _currentUser;
  String _firstName = '';
  bool _hasNewNotification = false;
  String _lastName = '';
  String _coffeeshop = '';
  String _location = '';
  late List<DocumentSnapshot> _coffeeDocs = [];
  late List<DocumentSnapshot> _coffeebeansDocs = [];
  late List<DocumentSnapshot> _notifDocs = [];
  int _unreadMessageCount = 0;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentUser = FirebaseAuth.instance.currentUser!;
    _loadOwnerData();
    _loadCoffeeData();
    _loadCoffeeBeansData();
    _loadNotifData();
  }

  void checkForNewNotifications() {
    setState(() {
      _hasNewNotification = true;
    });
  }

  Future<void> _deleteNotification(String notificationId) async {
    try {
      final notificationRef = FirebaseFirestore.instance
          .collection('notifications')
          .doc(notificationId);
      await notificationRef.delete();
      await _loadNotifData();
    } catch (error) {
      print('Error deleting notification: $error');
    }
  }

  void _confirmDeleteNotification(String notificationId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this notification?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await _deleteNotification(notificationId);
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteCoffee(String coffeeId) async {
    try {
      await FirebaseFirestore.instance
          .collection('coffees')
          .doc(coffeeId)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Coffee deleted successfully'),
        ),
      );
      _loadCoffeeData(); // Mettre à jour la liste des cafés après la suppression
    } catch (error) 
    {
      print('Error deleting coffee: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete coffee'),
        ),
      );
    }
  }

  Future<void> _deleteCoffeeBeans(String coffeebeanId) async {
    try {
      await FirebaseFirestore.instance
          .collection('coffeebean')
          .doc(coffeebeanId)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Coffee bean deleted successfully'),
        ),
      );
      _loadCoffeeBeansData(); // Mettre à jour la liste des cafés après la suppression
    } catch (error) {
      print('Error deleting coffee bean: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete coffee bean'),
        ),
      );
    }
  }

  Future<void> _editCoffee(String coffeeId) async {
    // Récupérer les données du café à éditer
    DocumentSnapshot coffeeSnapshot = await FirebaseFirestore.instance
        .collection('coffees')
        .doc(coffeeId)
        .get();
    Map<String, dynamic> coffeeData =
        coffeeSnapshot.data() as Map<String, dynamic>;

    // Afficher un dialogue pour la modification
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController nameController =
            TextEditingController(text: coffeeData['name']);
        TextEditingController priceController =
            TextEditingController(text: coffeeData['price'].toString());

        return AlertDialog(
          title: Text('Edit Coffee'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: priceController,
                decoration: InputDecoration(labelText: 'Price'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Annuler la modification
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Enregistrer les modifications dans la base de données
                await FirebaseFirestore.instance
                    .collection('coffees')
                    .doc(coffeeId)
                    .update({
                  'name': nameController.text,
                  'price': double.parse(priceController.text),
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Coffee updated successfully'),
                  ),
                );
                Navigator.of(context).pop(); // Fermer le dialogue
                _loadCoffeeData(); // Mettre à jour la liste des cafés
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _editCoffeeBeans(String coffeebeanId) async {
    // Récupérer les données du café à éditer
    DocumentSnapshot coffeeSnapshot = await FirebaseFirestore.instance
        .collection('coffeebean')
        .doc(coffeebeanId)
        .get();
    Map<String, dynamic> coffeeData =
        coffeeSnapshot.data() as Map<String, dynamic>;

    // Afficher un dialogue pour la modification
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController nameController =
            TextEditingController(text: coffeeData['description']);
        TextEditingController priceController =
            TextEditingController(text: coffeeData['price'].toString());
        TextEditingController quantityController =
            TextEditingController(text: coffeeData['quantity'].toString());

        return AlertDialog(
          title: Text('Edit Coffee Beans'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: priceController,
                decoration: InputDecoration(labelText: 'Price'),
              ),
              TextField(
                controller: quantityController,
                decoration: InputDecoration(labelText: 'Quantity'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Annuler la modification
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Enregistrer les modifications dans la base de données
                await FirebaseFirestore.instance
                    .collection('coffeebean')
                    .doc(coffeebeanId)
                    .update({
                  'description': nameController.text,
                  'price': double.parse(priceController.text),
                  'quantity': double.parse(quantityController.text),
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Coffee bean updated successfully'),
                  ),
                );
                Navigator.of(context).pop(); // Fermer le dialogue
                _loadCoffeeBeansData(); // Mettre à jour la liste des grains de café
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _confirmDeleteCoffeeBean(String coffeeId) async {
    bool confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Are you sure you want to delete coffee bean?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Annuler la suppression
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Confirmer la suppression
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      await _deleteCoffeeBeans(coffeeId);
    }
  }

  Future<void> _confirmDeleteCoffee(String coffeeId, String coffeeName) async {
    bool confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content:
              Text('Are you sure you want to delete coffee "$coffeeName"?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Annuler la suppression
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Confirmer la suppression
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      await _deleteCoffee(coffeeId);
    }
  }

  Future<void> _loadOwnerData() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('owners')
          .doc(_currentUser.uid)
          .get();
      setState(() {
        _firstName = userDoc['firstName'];
        _lastName = userDoc['lastName'];
        _coffeeshop = userDoc['coffeeShopName'];
        _location = userDoc['location'];
      });
    } catch (error) {
      print('Error loading owner data: $error');
    }
  }

  Future<void> _loadCoffeeData() async {
    try {
      QuerySnapshot coffeeSnapshot = await FirebaseFirestore.instance
          .collection('coffees')
          .where('ownerId', isEqualTo: _currentUser.uid)
          .get();
      setState(() {
        _coffeeDocs = coffeeSnapshot.docs;
      });
    } catch (error) {
      print('Error loading coffee data: $error');
    }
  }

  Future<void> _loadNotifData() async {
    try {
      QuerySnapshot notifSnapshot = await FirebaseFirestore.instance
          .collection('notifications')
          .where('ownerId', isEqualTo: _currentUser.uid)
          .get();
      setState(() {
        _notifDocs = notifSnapshot.docs;
        _unreadMessageCount++;
      });
    } catch (error) {
      print('Error loading notif data: $error');
    }
  }

  Future<void> _loadCoffeeBeansData() async {
    try {
      QuerySnapshot coffeebeansSnapshot = await FirebaseFirestore.instance
          .collection('coffeebean')
          .where('ownerId', isEqualTo: _currentUser.uid)
          .get();
      setState(() {
        _coffeebeansDocs = coffeebeansSnapshot.docs;
      });

      // Vérifier si la quantité globale de grains de café est égale à 0
      //int totalQuantity = 0;
      for (var doc in _coffeebeansDocs) {
        Map<String, dynamic> coffeebeansData =
            doc.data() as Map<String, dynamic>;
        double quantity = coffeebeansData['quantity'] != null
            ? (coffeebeansData['quantity'] as num).toDouble()
            : 0.0;
        //totalQuantity += quantity;
          if ((coffeebeansData['quantity'] as num).toDouble() == 0) {
          // Créer un objet de notification avec le message approprié et l'ID du propriétaire connecté
          String message = 'Quantity of coffee beans was null ';
          String ownerId = _currentUser.uid;
          _createNotification(message, ownerId);
        }
      }

    } catch (error) {
      print('Error loading coffee beans data: $error');
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text('My Space'),
        backgroundColor: Color.fromRGBO(112, 60, 6, 1.0),
      ),
      drawer: SideMenuOwner(userEmail: _currentUser.email!),
      backgroundColor: Color.fromRGBO(233, 217, 203, 1.0),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12, top: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "My Space : " '$_coffeeshop',
                          style: TextStyle(
                            color: Color.fromARGB(
                                129, 112, 60, 0), // Couleur de texte modifiée
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          'Owner: $_firstName $_lastName',
                          style: TextStyle(
                            color: Colors.black, // Couleur de texte modifiée
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/owner2.png'),
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 27,
                ),
                CurvedNavigationBar(
                  backgroundColor: Color.fromRGBO(112, 60, 6, 1.0),
                  items: <Widget>[
                    Icon(Icons.coffee,
                        size: 20, color: Color.fromARGB(255, 0, 0, 0)),
                    Icon(Icons.grain,
                        size: 20, color: Color.fromARGB(255, 0, 0, 0)),
                    Icon(
                      _hasNewNotification
                          ? Icons.notifications_active
                          : Icons.notifications,
                      size: 20,
                      color: _hasNewNotification
                          ? Color.fromARGB(255, 219, 20, 6)
                          : Color.fromARGB(255, 0, 0, 0),
                    ),
                  ],
                  onTap: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  color: Color.fromRGBO(233, 217, 203, 1.0),
                  index: _selectedIndex,
                  buttonBackgroundColor: Color.fromRGBO(233, 217, 203, 1.0),
                  animationCurve: Curves.easeInOut,
                  animationDuration: Duration(milliseconds: 300),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.85,
                  child: _selectedIndex == 0
                      ? _buildCoffeeList() // Afficher la liste des cafés si l'index est 0
                      : _selectedIndex == 1
                          ? _buildBeansOfCoffeeList()
                          : _buildNotificationsList(), // Afficher la liste des grains de café si l'index est 1
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCoffeeList() {
    return _coffeeDocs.isEmpty
        ? Center(
            child: Text(
              'No coffees available',
              style: TextStyle(fontSize: 18),
            ),
          )
        : ListView.builder(
            itemCount: _coffeeDocs.length,
            itemBuilder: (context, index) {
              final coffeeData =
                  _coffeeDocs[index].data() as Map<String, dynamic>;
              return Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.brown,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            coffeeData['image'] as String,
                          ),
                        ),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      coffeeData['name'] as String,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Price: ${coffeeData['price']} dt',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _editCoffee(_coffeeDocs[index].id);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 165, 132, 82),
                          ),
                          child: Text(
                            'Edit',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _confirmDeleteCoffee(_coffeeDocs[index].id,
                                coffeeData['name'] as String);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 165, 132, 82),
                          ),
                          child: Text(
                            'Delete',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
  }

  Widget _buildBeansOfCoffeeList() {
    return _coffeebeansDocs.isEmpty
        ? Center(
            child: Text(
              'No coffees beans available',
              style: TextStyle(fontSize: 18),
            ),
          )
        : ListView.builder(
            itemCount: _coffeebeansDocs.length,
            itemBuilder: (context, index) {
              final coffeebeansData =
                  _coffeebeansDocs[index].data() as Map<String, dynamic>;
              return Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.brown,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            coffeebeansData['image'] as String,
                          ),
                        ),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                    ),
                    Text(
                      'Description : ${coffeebeansData['description']}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(height: 10),
                    Text(
                      'Price/kg : ${coffeebeansData['price']} dt',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Quantity: ${coffeebeansData['quantity']}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _editCoffeeBeans(_coffeebeansDocs[index].id);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 165, 132, 82),
                          ),
                          child: Text(
                            'Edit',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _confirmDeleteCoffeeBean(
                                _coffeebeansDocs[index].id);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 165, 132, 82),
                          ),
                          child: Text(
                            'Delete',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
  }

  Widget _buildNotificationsList() {
    return _notifDocs.isEmpty
        ? Center(
            child: Text(
              'No notification available',
              style: TextStyle(fontSize: 18),
            ),
          )
        : ListView.builder(
            itemCount: _notifDocs.length,
            itemBuilder: (context, index) {
              final notificationData =
                  _notifDocs[index].data() as Map<String, dynamic>;
              final notificationId = _notifDocs[index].id;

              return Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.brown,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.001,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notificationData['message'] as String,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            _confirmDeleteNotification(notificationId);
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              );
            },
          );
  }
}

class CoffeePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coffee Page'),
      ),
      body: Center(
        child: Text('This is the Coffee page'),
      ),
    );
  }
}

class BeansOfCoffeePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Beans of Coffee Page'),
      ),
      body: Center(
        child: Text('This is the Beans of Coffee page'),
      ),
    );
  }
}
