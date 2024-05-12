import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:konstructora/Screens/login_screen.dart';
import 'package:konstructora/Screens/Settings_screen.dart';

class SideMenu extends StatelessWidget {
  final String userEmail;
  final VoidCallback? onLogout;
  final Color backgroundColor;
  final Color headerColor;
  final Color textColor;

  SideMenu({
    required this.userEmail,
    this.onLogout,
    this.backgroundColor = Colors.grey,
    this.headerColor = Colors.orange,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {

    final user = FirebaseAuth.instance.currentUser!;

    return Drawer(
      child: Container(
        color: backgroundColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: headerColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome !',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    userEmail,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, color: textColor),
              title: Text(
                'Home',
                style: TextStyle(color: textColor),
              ),
              onTap: () {
                // Navigate to home page
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: textColor),
              title: Text(
                'Settings',
                style: TextStyle(color: textColor),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/settings'); // Utilisez la route nommée '/settings'
              },

            ),
            Divider(
              color: textColor,
            ),
            ListTile(
              leading: Icon(Icons.logout, color: textColor),
              title: Text(
                'Logout',
                style: TextStyle(color: textColor),
              ),
                onTap: () {
                FirebaseAuth.instance.signOut(); // Déconnexion de l'utilisateur
                Navigator.pushReplacementNamed(context,'loginScreen');
                 // Redirection vers l'écran de connexion
              },
            ),
          ],
        ),
      ),
    );
  }
}
