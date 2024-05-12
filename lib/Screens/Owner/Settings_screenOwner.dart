import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:konstructora/Screens/login_screen.dart';
import 'package:konstructora/Screens/Owner/homescreenOwner.dart';

class SettingsScreenOwner extends StatefulWidget {
  const SettingsScreenOwner({Key? key}) : super(key: key);

  @override
  _SettingsScreenOwnerState createState() => _SettingsScreenOwnerState();
}

class _SettingsScreenOwnerState extends State<SettingsScreenOwner> {
    bool isDarkMode = false;

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _coffeeShopNameController = TextEditingController();
  final _locationController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

@override
  void initState() {
    super.initState();

    // Récupérer l'utilisateur actuellement connecté
    final currentUser = FirebaseAuth.instance.currentUser;

    // Vérifier si l'utilisateur est connecté
    if (currentUser != null) {
      // Accéder aux données du propriétaire dans Firestore
      FirebaseFirestore.instance
          .collection('owners')
          .doc(currentUser.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          // Récupérer les données du propriétaire
          final data = documentSnapshot.data() as Map<String, dynamic>?;

          if (data != null) {
            setState(() {
              // Remplir les champs avec les données récupérées
              _firstNameController.text = data['firstName'] ?? '';
              _lastNameController.text = data['lastName'] ?? '';
              _coffeeShopNameController.text = data['coffeeShopName'] ?? '';
              _locationController.text = data['location'] ?? '';
            });
          }
        } else {
          print('Owner data not found');
        }
      }).catchError((error) {
        print('Error retrieving owner data: $error');
      });
    }
  }



  Future<void> _updateProfile() async {
    try {
      // Update owner profile in Firebase Auth
      await FirebaseAuth.instance.currentUser?.updateProfile(
        displayName: '${_firstNameController.text} ${_lastNameController.text}',
      );

      // Get the current owner document from Firestore
      final ownerDoc = FirebaseFirestore.instance
          .collection('owners')
          .doc(FirebaseAuth.instance.currentUser?.uid);

      // Update the fields in the owner document
      await ownerDoc.update({
        'firstName': _firstNameController.text,
        'lastName': _lastNameController.text,
        'coffeeShopName': _coffeeShopNameController.text,
        'location': _locationController.text,
      });

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Owner information updated successfully'),
        ),
      );
    } catch (e) {
      // Handle errors here
      print('Error updating profile: $e');
    }
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      backgroundColor: Color.fromRGBO(233, 217, 203, 1.0),
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Color.fromRGBO(112, 60, 6, 1.0),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeOwner()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _firstNameController,
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _lastNameController,
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _coffeeShopNameController,
                  decoration: InputDecoration(
                    labelText: 'Coffee Shop Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your coffee shop name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    labelText: 'Location',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
ElevatedButton(
                  onPressed: _updateProfile,
                  child: Text(
                    'Save Changes',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(112, 60, 6, 1.0),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose the controllers when the widget is destroyed
    _firstNameController.dispose();
    _lastNameController.dispose();
    _coffeeShopNameController.dispose();
    _locationController.dispose();
    super.dispose();
  }
}
