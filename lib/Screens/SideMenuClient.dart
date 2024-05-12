import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:konstructora/Screens/login_screen.dart';
import 'package:konstructora/Screens/Settings_screen.dart';

class SideMenuClient extends StatefulWidget {
  final String userEmail;
  final VoidCallback? onLogout;

  SideMenuClient({
    required this.userEmail,
    this.onLogout,
  });

  @override
  _SideMenuClientState createState() => _SideMenuClientState();
}

class _SideMenuClientState extends State<SideMenuClient> {
  bool _isFrench = false;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: const Color(0xFFA68152),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isFrench ? 'Bienvenue !' : 'Welcome !',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  widget.userEmail,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text(
              _isFrench ? 'Accueil' : 'Home',
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'homeScreen');            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              _isFrench ? 'Paramètres' : 'Settings',
            ),
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, '/settingsClient'); // Utilisez la route nommée '/settings'
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text(
              _isFrench ? 'Déconnexion' : 'Logout',
            ),
            onTap: () {
              FirebaseAuth.instance.signOut(); // Déconnexion de l'utilisateur
              Navigator.pushReplacementNamed(context, 'loginScreen');
              // Redirection vers l'écran de connexion
            },
          ),
          Divider(),
          ListTile(
            title: Text(
              _isFrench ? 'Changer en anglais' : 'Switch to French',
            ),
            onTap: () {
              setState(() {
                _isFrench = !_isFrench;
              });
            },
          ),
        ],
      ),
    );
  }
}
