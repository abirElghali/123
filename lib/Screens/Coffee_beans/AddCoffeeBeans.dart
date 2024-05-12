import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:konstructora/Screens/Owner/homescreenOwner.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class AddCoffeeBeans extends StatefulWidget {
  const AddCoffeeBeans({Key? key}) : super(key: key);

  @override
  _AddCoffeeBeansState createState() => _AddCoffeeBeansState();
}

class _AddCoffeeBeansState extends State<AddCoffeeBeans> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();
  final _descriptionController = TextEditingController();
  double _selectedRating = 0.0; // Nouvelle variable pour la note

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

  Future<void> _addCoffeeBeansToFirestore(String ownerId) async {
    try {
      String imageUrl = '';
      if (_image != null)
      {
        TaskSnapshot task = await FirebaseStorage.instance
            .ref('coffeebeans_images/${DateTime.now()}.jpg')
            .putFile(_image!);
        imageUrl = await task.ref.getDownloadURL();
      }

      await FirebaseFirestore.instance.collection('coffeebean').add({
        'name': _nameController.text.trim(),
        'price': double.parse(_priceController.text.trim()),
        'image': imageUrl,
        'ownerId': ownerId,
        'quantity': double.parse(_quantityController.text.trim()),
        'description' : _descriptionController.text.trim(), // Utilisez la description saisie
        'rating': _selectedRating, // Utilisez la note sélectionnée
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Coffee Beans added successfully'),
        ),
      );

      _nameController.clear();
      _priceController.clear();
      _quantityController.clear();
      _descriptionController.clear();
      setState(() {
        _image = null;
        _selectedRating = 0.0; // Réinitialisez la note sélectionnée
      });
    } catch (error) {
      print('Error adding coffee: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add coffee beans'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(233, 217, 203, 1.0),
      appBar: AppBar(
        title: Text('Add Coffee Beans'),
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
                  controller: _priceController,
                  decoration: InputDecoration(
                    labelText: 'Price (Kg)',
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
                TextFormField(
                  controller: _quantityController,
                  decoration: InputDecoration(
                    labelText: 'Global Quantity',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the quantity';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the description';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                RatingBar.builder(
                  initialRating: _selectedRating,
                  minRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      _selectedRating = rating;
                    });
                  },
                ),

                SizedBox(height: 16),
                _image != null
                    ? Image.file(_image!)
                    : ElevatedButton.icon(
                  onPressed: _pickImage,
                  icon: Icon(Icons.photo,
                    color: Colors.black,
                  ),
                  label: Text('Select Image',
                      style: TextStyle(color: Colors.black)),
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
                      _addCoffeeBeansToFirestore(
                          FirebaseAuth.instance.currentUser!.uid);
                    }
                  },
                  child: Text('Add Coffee Beans',
                    style: TextStyle(color: Colors.black),),
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
    _quantityController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
