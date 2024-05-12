import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'homescreen.dart';
import 'details.dart'; // Importez DetailsScreen si ce n'est pas déjà fait

class FavoriteScreen extends StatelessWidget {
  final List<Coffee> favoriteCoffees;
  final List<CoffeeBean> favoriteCoffeeBeans;
  final List<CartItem> cartItems; // Ajout de cartItems

  const FavoriteScreen({
    required this.favoriteCoffees,
    required this.favoriteCoffeeBeans,
    required this.cartItems, // Déclaration de cartItems
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite',
          style: GoogleFonts.dancingScript(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Colors.black,
        child: (favoriteCoffees.isEmpty && favoriteCoffeeBeans.isEmpty)
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/coffee-lover-hot-coffee.gif',
                // Remplacez par le chemin de votre GIF
                width: 200,
                height: 200,
              ),
              Text(
                'Empty',
                style: GoogleFonts.dancingScript(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        )
            : ListView.builder(
          itemCount: favoriteCoffees.length + favoriteCoffeeBeans.length,
          itemBuilder: (context, index) {
            if (index < favoriteCoffees.length) {
              final coffee = favoriteCoffees[index];
              return _buildFavoriteItem(
                coffee.imagePath,
                coffee.name,
                    () {
                  _navigateToDetails(
                      context, coffee); // Suppression de cartItems ici
                },
              );
            } else {
              final coffeeBean =
              favoriteCoffeeBeans[index - favoriteCoffees.length];
              return _buildFavoriteItem(
                coffeeBean.imagePath,
                coffeeBean.name,
                    () {
                  _navigateToDetails(
                      context, coffeeBean); // Suppression de cartItems ici
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildFavoriteItem(String imagePath, String name, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Image.asset(
              imagePath,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            Container(
              margin: EdgeInsets.all(8.0),
              padding: EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
              ),
              child: Icon(
                Icons.favorite,
                color: Color(0xFFE51293),
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToDetails(BuildContext context, dynamic item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            DetailsScreen(
              imagePath: getDetailImagePath(item.imagePath),
              name: item.name,
              rating: item.rating,
              cartItems: cartItems,
              // Ajoutez les autres détails ici si nécessaire
            ),
      ),
    );
  }
}


String getDetailImagePath(String originalImagePath) {
  // Logique de mapping des chemins d'image
  if (originalImagePath.contains(
      "assets/coffee_assets/americano/square/americano_pic_1_square.png")) {
    return "assets/coffee_assets/americano/portrait/americano_pic_1_portrait.png";
  } else if (originalImagePath.contains(
      "assets/coffee_assets/americano/square/americano_pic_2_square.png")) {
    return "assets/coffee_assets/americano/portrait/americano_pic_2_portrait.png";
  } else if (originalImagePath.contains(
      "assets/coffee_assets/americano/square/americano_pic_3_square.png")) {
    return "assets/coffee_assets/americano/portrait/americano_pic_3_portrait.png";
  } else if (originalImagePath.contains(
      "assets/coffee_assets/black_coffee/square/black_coffee_pic_1_square.png")) {
    return "assets/coffee_assets/black_coffee/portrait/black_coffee_pic_1_portrait.png";
  } else if (originalImagePath.contains(
      "assets/coffee_assets/black_coffee/square/black_coffee_pic_2_square.png")) {
    return "assets/coffee_assets/black_coffee/portrait/black_coffee_pic_2_portrait.png";
  } else if (originalImagePath.contains(
      "assets/coffee_assets/black_coffee/square/black_coffee_pic_3_square.png")) {
    return "assets/coffee_assets/black_coffee/portrait/black_coffee_pic_3_portrait.png";
  } else if (originalImagePath.contains(
      "assets/coffee_assets/cappuccino/square/cappuccino_pic_1_square.png")) {
    return "assets/coffee_assets/cappuccino/portrait/cappuccino_pic_1_portrait.png";
  } else if (originalImagePath.contains(
      "assets/coffee_assets/cappuccino/square/cappuccino_pic_2_square.png")) {
    return "assets/coffee_assets/cappuccino/portrait/cappuccino_pic_2_portrait.png";
  } else if (originalImagePath.contains(
      "assets/coffee_assets/cappuccino/square/cappuccino_pic_3_square.png")) {
    return "assets/coffee_assets/cappuccino/portrait/cappuccino_pic_3_portrait.png";
  } else if (originalImagePath.contains(
      "assets/coffee_assets/espresso/square/espresso_pic_1_square.png")) {
    return "assets/coffee_assets/espresso/portrait/espresso_pic_1_portrait.png";
  } else if (originalImagePath.contains(
      "assets/coffee_assets/espresso/square/espresso_pic_2_square.png")) {
    return "assets/coffee_assets/espresso/portrait/espresso_pic_2_portrait.png";
  } else if (originalImagePath.contains(
      "assets/coffee_assets/espresso/square/espresso_pic_3_square.png")) {
    return "assets/coffee_assets/espresso/portrait/espresso_pic_3_portrait.png";
  } else if (originalImagePath
      .contains("assets/coffee_assets/latte/square/latte_pic_1_square.png")) {
    return "assets/coffee_assets/latte/portrait/latte_pic_1_portrait.png";
  } else if (originalImagePath
      .contains("assets/coffee_assets/latte/square/latte_pic_2_square.png")) {
    return "assets/coffee_assets/latte/portrait/latte_pic_2_portrait.png";
  } else if (originalImagePath
      .contains("assets/coffee_assets/latte/square/latte_pic_3_square.png")) {
    return "assets/coffee_assets/latte/portrait/latte_pic_3_portrait.png";
  } else if (originalImagePath.contains(
      "assets/coffee_assets/macchiato/square/macchiato_pic_1_square.png")) {
    return "assets/coffee_assets/macchiato/portrait/macchiato_pic_1_portrait.png";
  } else if (originalImagePath.contains(
      "assets/coffee_assets/macchiato/square/macchiato_pic_2_square.png")) {
    return "assets/coffee_assets/macchiato/portrait/macchiato_pic_2_portrait.png";
  } else if (originalImagePath.contains(
      "assets/coffee_assets/macchiato/square/macchiato_pic_3_square.png")) {
    return "assets/coffee_assets/macchiato/portrait/macchiato_pic_3_portrait.png";
  } else if (originalImagePath.contains(
      "assets/coffee_assets/arabica_coffee_beans/arabica_coffee_beans_square.png")) {
    return "assets/coffee_assets/arabica_coffee_beans/arabica_coffee_beans_portrait.png";
  } else if (originalImagePath.contains(
      "assets/coffee_assets/robusta_coffee_beans/robusta_coffee_beans_square.png")) {
    return "assets/coffee_assets/robusta_coffee_beans/robusta_coffee_beans_portrait.png";
  } else if (originalImagePath.contains(
      "assets/coffee_assets/liberica_coffee_beans/liberica_coffee_beans_square.png")) {
    return "assets/coffee_assets/liberica_coffee_beans/liberica_coffee_beans_portrait.png";
  } else if (originalImagePath.contains(
      "assets/coffee_assets/excelsa_coffee_beans/excelsa_coffee_beans_square.png")) {
    return "assets/coffee_assets/excelsa_coffee_beans/excelsa_coffee_beans_portrait.png";
  } else {
    // Par défaut, renvoyez le chemin d'image d'origine
    return originalImagePath;
  }
}