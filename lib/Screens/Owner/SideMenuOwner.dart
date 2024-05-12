import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:konstructora/Screens/Owner/SideMenuOwner.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class SideMenuOwner extends StatefulWidget {
  final String userEmail;
  final VoidCallback? onLogout;
  final Color backgroundColor;
  final Color headerColor;
  final Color textColor;

  SideMenuOwner({
    required this.userEmail,
    this.onLogout,
    this.backgroundColor = const Color(0xFFFFFFFF),
    this.headerColor = const Color(0xFFA68152),
    this.textColor = Colors.black,
  });

  @override
  _SideMenuOwnerState createState() => _SideMenuOwnerState();
}


class _SideMenuOwnerState extends State<SideMenuOwner> {

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Drawer(
      child: Container(
        color: widget.backgroundColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: widget.headerColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome !',
                    style: TextStyle(
                      color: widget.textColor,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.userEmail,
                    style: TextStyle(
                      color: widget.textColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, color: widget.textColor),
              title: Text(
                'Home',
                style: TextStyle(color: widget.textColor),
              ),
              onTap: () {
                // Navigate to home page
              },
            ),
            ListTile(
              leading: Icon(Icons.coffee, color: widget.textColor),
              title: Text(
                'Add coffee',
                style: TextStyle(color: widget.textColor),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/addcoffeowner');
              },
            ),
            ListTile(
              leading: Icon(Icons.grain, color: widget.textColor),
              title: Text(
                'Add coffee beans',
                style: TextStyle(color: widget.textColor),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/addcoffeebeans');
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: widget.textColor),
              title: Text(
                'Settings',
                style: TextStyle(color: widget.textColor),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/settingsOwner');
                // Utilisez la route nommée '/settingsOwner'
              },
            ),
            ListTile(
              leading: Icon(Icons.lightbulb_outline, color: widget.textColor),
              title: Text(
                'Dark Mode',
                style: TextStyle(color: widget.textColor),
              ),
            ),
            Divider(
              color: widget.textColor,
            ),
            ListTile(
              leading: Icon(Icons.logout, color: widget.textColor),
              title: Text(
                'Logout',
                style: TextStyle(color: widget.textColor),
              ),
              onTap: () {
                FirebaseAuth.instance.signOut();
                // Déconnexion de l'utilisateur
                Navigator.pushReplacementNamed(context, 'loginScreen');
                // Redirection vers l'écran de connexion
              },
            ),
          ],
        ),
      ),
    );
  }
}
