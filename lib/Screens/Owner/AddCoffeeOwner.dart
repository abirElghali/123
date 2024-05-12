import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:konstructora/Screens/Owner/homescreenOwner.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class AddCoffeeOwner extends StatefulWidget {
  const AddCoffeeOwner({Key? key}) : super(key: key);

  @override
  _AddCoffeeOwnerState createState() => _AddCoffeeOwnerState();
}

class _AddCoffeeOwnerState extends State<AddCoffeeOwner> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  String _selectedType = 'Liberica'; // Initial value for the dropdown
  File? _image;
  final _formKey = GlobalKey<FormState>();

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  // Function to add coffee data to Firestore
  Future<void> _addCoffeeToFirestore(String ownerId) async {
    try {
      String imageUrl = '';
      if (_image != null) {
        TaskSnapshot task = await FirebaseStorage.instance
            .ref('coffee_images/${DateTime.now()}.jpg')
            .putFile(_image!);
        imageUrl = await task.ref.getDownloadURL();
      }

      await FirebaseFirestore.instance.collection('coffees').add({
        'name': _nameController.text.trim(),
        'price': double.parse(_priceController.text.trim()),
        'image': imageUrl,
        'ownerId': ownerId,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Coffee added successfully'),
        ),
      );

      _nameController.clear();
      _priceController.clear();
      setState(() {
        _image = null;
      });
    } catch (error) {
      print('Error adding coffee: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add coffee'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(233, 217, 203, 1.0),
      appBar: AppBar(
        title: Text('Add Coffee'),
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
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name of Coffee',
                    border: OutlineInputBorder(),
                  ),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the name of the coffee';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                // Dropdown button for selecting coffee type
                RatingBar.builder(
                  initialRating: 3, // Note initiale
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 40,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    // Mettre à jour la variable de note ici
                  },
                ),

                SizedBox(height: 16),
                TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(
                    labelText: 'Price',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the price of the coffee';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                _image != null
                    ? Image.file(_image!)
                    : ElevatedButton.icon(
                        onPressed: _pickImage,
                        icon: Icon(Icons.photo, color: Colors.black),
                        label: Text(
                          'Select Image',
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(112, 60, 6, 1.0),
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _addCoffeeToFirestore(
                          FirebaseAuth.instance.currentUser!.uid);
                    }
                  },
                  child: Text(
                    'Add Coffee',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(112, 60, 6, 1.0),
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
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
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }
}
