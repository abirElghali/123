import 'package:flutter/material.dart';
import 'package:konstructora/Screens/homescreen.dart';
import 'package:konstructora/Screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:konstructora/Screens/signup_screen.dart';
import 'package:konstructora/auth.dart';
import '../Screens/SplashScreen.dart';
import 'package:konstructora/Screens/Settings_screen.dart';
import 'package:konstructora/Screens/Owner/homescreenOwner.dart';
import 'package:konstructora/Screens/Owner/AddCoffeeOwner.dart';
import 'package:konstructora/Screens/Owner/Settings_screenOwner.dart';
import 'package:konstructora/Screens/Settings_screenClient.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:konstructora/Screens/Coffee_beans/AddCoffeeBeans.dart';
import 'package:konstructora/Screens/Panier_screen.dart';
import 'package:konstructora/Screens/Owner/CoffeeShopMap.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyDE0--gneY1C2B8X4mXoIWhHcl4V55V3v0",
          appId: "1:396650734298:web:7a85629aa25dca4d127be3",
          messagingSenderId: "396650734298",
          projectId: "projetmodbile",
          storageBucket: "projetmodbile.appspot.com"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp(
      supportedLocales: [
        Locale('en', 'US'), // Anglais
        Locale('fr', 'FR'), // Français
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        if (locale != null) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
        }
        return supportedLocales.first;
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => SplashScreen(), 
        'signupScreen': (context) => const SignupScreen(),
        'homeScreen': (context) => const HomeScreen(),
        'homeScreenOwner': (context) => const HomeOwner(),
        'loginScreen': (context) => const LoginScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/settingsOwner': (context) => const SettingsScreenOwner(),
        '/settingsClient': (context) => const SettingsScreenClient(),
        '/panierClient': (context) => const ScreenPanier(cartList:[]),
        '/addcoffeowner': (context) => const AddCoffeeOwner(),
        '/addcoffeebeans': (context) => const AddCoffeeBeans(),
        '/location': (context) => CoffeeShopMap()
      },
    );
  }
}
