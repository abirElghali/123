import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:konstructora/Screens/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'homescreen.dart';

enum UserRole { owner, client }

class Owner extends User {
  List<String> products = [];

  Owner({required String email}) : super(email: email, role: 'Cafeteria owner');
}

class User {
  final String email;
  final String role;

  User({required this.email, required this.role});
}

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  UserRole _role = UserRole.client; // Default role is set to client

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  XFile? pickedFile;

  void signUp() async {
    if (_formKey.currentState!.validate() && passwordConfirmed()) {
      try {
        if (_emailController.text.trim().isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Please enter your email'),
          ));
          return;
        }

        // Check if the email is already used in the Firestore database
        QuerySnapshot<Map<String, dynamic>> querySnapshot =
            await FirebaseFirestore.instance
                .collection('users')
                .where('email', isEqualTo: _emailController.text.trim())
                .get();

        if (querySnapshot.docs.isEmpty) {
          // If email doesn't exist in Firestore, proceed with signup
          UserCredential userCredential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );

          // Get the newly created user's ID
          String userId = userCredential.user!.uid;

          // Create User object
          User newUser = User(
            email: _emailController.text.trim(),
            role: _role.toString().split('.').last,
          );

          if (newUser.role == 'owner') {
            // Create Owner object
            Owner owner = Owner(email: newUser.email);

            // Add owner details to Firestore
            await FirebaseFirestore.instance
                .collection('owners')
                .doc(userId)
                .set({
              'email': newUser.email,
              'products': owner.products,
              // Add more fields as needed
            });
          } else if (newUser.role == 'client') {
            // Add owner details to Firestore
            await FirebaseFirestore.instance
                .collection('clients')
                .doc(userId)
                .set({
              'email': newUser.email,
              //'products': owner.products,
              // Add more fields as needed
            });
            // Si le rôle de l'utilisateur est client, afficher la HomeScreen
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(builder: (context) => HomeScreen()),
            // );
          }

          // Add user details to Firestore
          await FirebaseFirestore.instance.collection('users').doc(userId).set({
            'email': _emailController.text.trim(),
            'role': _role.toString().split('.').last, // Save role as a string
            // You can add other fields here as needed
          });

          // Once signup is successful, navigate to login page
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        } else {
          // If email already exists in Firestore, show a notification
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text('The email address is already in use by another account.'),
          ));
        }
      } catch (e) {
        // Handle signup errors here
        print('Error: $e');
        if (e is FirebaseAuthException) {
          if (e.code == 'email-already-in-use') {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  'The email address is already in use by another account.'),
            ));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('An error occurred. Please try again later.'),
            ));
          }
        }
      }
    }
  }

  bool passwordConfirmed() {
    return _confirmpasswordController.text.trim() ==
        _passwordController.text.trim();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Color.fromRGBO(112, 60, 6, 1.0),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(112, 60, 6, 1.0),
                    Colors.grey[200]!,
                  ],
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/image-removebg-preview.png',
                    height: 150,
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Join Us !",
                    style: GoogleFonts.greatVibes(
                      fontSize: 50,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email',
                            ),
                            style: TextStyle(color: Colors.white),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                            ),
                            style: TextStyle(color: Colors.white),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a password';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: _confirmpasswordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Confirm Password',
                            ),
                            style: TextStyle(color: Colors.white),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please confirm your password';
                              }
                              if (value != _passwordController.text.trim()) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          Column(
                            children: [
                              RadioListTile<UserRole>(
                                title: Text('Owner'),
                                value: UserRole.owner,
                                groupValue: _role,
                                onChanged: (UserRole? value) {
                                  setState(() {
                                    _role = value!;
                                  });
                                },
                              ),
                              RadioListTile<UserRole>(
                                title: Text('Client'),
                                value: UserRole.client,
                                groupValue: _role,
                                onChanged: (UserRole? value) {
                                  setState(() {
                                    _role = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          GestureDetector(
                            onTap: signUp,
                            child: Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Color(0xFF937048),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  'Sign Up',
                                  style: GoogleFonts.cormorantGaramond(
                                    textStyle: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have an account?',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()),
                                  );
                                },
                                child: Text(
                                  'Sign In',
                                  style: TextStyle(
                                    color: Colors.blueAccent.withOpacity(0.8),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
