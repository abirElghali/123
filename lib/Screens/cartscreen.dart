import 'package:flutter/material.dart';
import 'details.dart'; // Importer la classe CartItem depuis details.dart
import 'homescreen.dart'; // Importer la fonction getDetailImagePath() depuis homescreen.dart
import 'package:google_fonts/google_fonts.dart';

// Classe CartScreen
class CartScreen extends StatefulWidget {
  final List<CartItem> cartItems;

  const CartScreen({
    Key? key,
    required this.cartItems,
  }) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late List<int> itemQuantities;
  late double totalPrice; // Déclarer la variable totalPrice ici

  @override
  void initState() {
    super.initState();
    itemQuantities = List<int>.filled(widget.cartItems.length, 1);
    totalPrice = calculateTotalPrice();
  }

  double calculateTotalPrice() {
    return widget.cartItems.isNotEmpty
        ? widget.cartItems.fold<double>(
            0.0,
            (previousValue, element) =>
                previousValue + (element.price * itemQuantities[element.index]),
          )
        : 0.0;
  }

  void updateTotalPrice() {
    setState(() {
      totalPrice = calculateTotalPrice();
    });
  }

  // Fonction pour supprimer un élément du panier
  void removeCartItem(int index) {
    setState(() {
      totalPrice -= widget.cartItems[index].price * itemQuantities[index];
      widget.cartItems.removeAt(index);
      itemQuantities.removeAt(index);
    });
    // Mettre à jour le prix total
    updateTotalPrice();
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = calculateTotalPrice();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
          style: GoogleFonts.dancingScript(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black, // Couleur de l'appbar en noir
        iconTheme: IconThemeData(
          color: Colors.white, // Couleur de l'icône de retour
        ),
      ),
      backgroundColor: Colors.black, // Couleur de fond du Scaffold en noir
      body: widget.cartItems.isNotEmpty
          ? ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                CartItem cartItem = widget.cartItems[index];
                int quantity = itemQuantities[index];
                double totalPriceItem = cartItem.price * quantity;
                return Dismissible(
                  key: Key(cartItem.name),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20.0),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    removeCartItem(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFf67828).withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(8.0),
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Image.asset(
                          getDetailImagePath(cartItem.originalImagePath),
                          width: 80,
                          height: 80,
                        ),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${cartItem.name}',
                              style: GoogleFonts.crimsonText(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              'Size: ${cartItem.size}',
                              style: GoogleFonts.crimsonText(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              'Price: ${totalPriceItem.toStringAsFixed(2)} dt',
                              style: GoogleFonts.crimsonText(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Spacer(), // Pour pousser les boutons sur les côtés
                        // Bouton moins
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              if (quantity > 1) {
                                itemQuantities[index] = quantity - 1;
                              }
                            });
                          },
                        ),
                        // Nombre d'articles
                        Text(
                          '$quantity',
                          style: TextStyle(fontSize: 16),
                        ),
                        // Bouton plus
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              itemQuantities[index] = quantity + 1;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/empty.png', // Chemin vers l'image vide
                    width: 200,
                    height: 200,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Empty',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: ${totalPrice.toStringAsFixed(2)} dt',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Ajoutez ici la logique pour passer à l'écran de commande
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFf67828).withOpacity(0.7),
              ),
              child: Text(
                'Order',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
