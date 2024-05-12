import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:konstructora/Screens/homescreen.dart';
import 'package:konstructora/Screens/login_screen.dart';
import 'package:konstructora/Screens/Owner/homescreenOwner.dart';

class Auth extends StatelessWidget {
  const Auth({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasData) {
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(snapshot.data!.uid)
                  .get(),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (userSnapshot.hasData) {
                  String role = userSnapshot.data!.get('role');
                  return role == 'owner' ? HomeOwner() : HomeScreen();
                } else {
                  return Center(child: Text('Error loading user data'));
                }
              },
            );
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }

  // void _initFavorites() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   if (!prefs.containsKey('favoriteCoffees') ||
  //       !prefs.containsKey('favoriteCoffeeBeans')) {
  //     // Si les préférences partagées ne contiennent pas de favoris, initialisez-les avec des listes vides
  //     prefs.setStringList('favoriteCoffees', []);
  //     prefs.setStringList('favoriteCoffeeBeans', []);
  //   }
  //}
}
