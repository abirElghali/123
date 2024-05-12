import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:konstructora/Screens/details.dart';
import 'package:konstructora/Utilities/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'favoritescreen.dart';
import 'cartscreen.dart';
import 'HomeNouveau.dart';
import 'details.dart';
import 'package:provider/provider.dart';
import 'package:konstructora/Screens/SideMenuClient.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

List<Coffee> getAllCoffees() {
  return [
    Coffee(
      name: "Americano",
      imagePath:
      "assets/coffee_assets/americano/square/americano_pic_1_square.png",
      rating: 4.5,
      price: "3.99 dt",
    ),
    Coffee(
      name: "Americano",
      imagePath:
      "assets/coffee_assets/americano/square/americano_pic_2_square.png",
      rating: 4.5,
      price: "3.99 dt",
    ),
    Coffee(
      name: "Americano",
      imagePath:
      "assets/coffee_assets/americano/square/americano_pic_3_square.png",
      rating: 4.5,
      price: "3.99 dt",
    ),
    Coffee(
      name: "Black Coffee",
      imagePath:
      "assets/coffee_assets/black_coffee/square/black_coffee_pic_1_square.png",
      rating: 4.5,
      price: "3.99 dt",
    ),
    Coffee(
      name: "Black Coffee",
      imagePath:
      "assets/coffee_assets/black_coffee/square/black_coffee_pic_2_square.png",
      rating: 4.5,
      price: "3.99 dt",
    ),
    Coffee(
      name: "Black Coffee",
      imagePath:
      "assets/coffee_assets/black_coffee/square/black_coffee_pic_3_square.png",
      rating: 4.5,
      price: "3.99 dt",
    ),
    Coffee(
      name: "Cappuccino",
      imagePath:
      "assets/coffee_assets/cappuccino/square/cappuccino_pic_1_square.png",
      rating: 4.5,
      price: "3.99 dt",
    ),
    Coffee(
      name: "Cappuccino",
      imagePath:
      "assets/coffee_assets/cappuccino/square/cappuccino_pic_2_square.png",
      rating: 4.5,
      price: "3.99 dt",
    ),
    Coffee(
      name: "Cappuccino",
      imagePath:
      "assets/coffee_assets/cappuccino/square/cappuccino_pic_3_square.png",
      rating: 4.5,
      price: "3.99 dt",
    ),
    Coffee(
      name: "Espresso",
      imagePath:
      "assets/coffee_assets/espresso/square/espresso_pic_1_square.png",
      rating: 4.5,
      price: "3.99 dt",
    ),
    Coffee(
      name: "Espresso",
      imagePath:
      "assets/coffee_assets/espresso/square/espresso_pic_2_square.png",
      rating: 4.5,
      price: "3.99 dt",
    ),
    Coffee(
      name: "Espresso",
      imagePath:
      "assets/coffee_assets/espresso/square/espresso_pic_3_square.png",
      rating: 4.5,
      price: "3.99 dt",
    ),
    Coffee(
      name: "Latte",
      imagePath: "assets/coffee_assets/latte/square/latte_pic_1_square.png",
      rating: 4.5,
      price: "3.99 dt",
    ),
    Coffee(
      name: "Latte",
      imagePath: "assets/coffee_assets/latte/square/latte_pic_2_square.png",
      rating: 4.5,
      price: "3.99 dt",
    ),
    Coffee(
      name: "Latte",
      imagePath: "assets/coffee_assets/latte/square/latte_pic_3_square.png",
      rating: 4.5,
      price: "3.99 dt",
    ),
    Coffee(
      name: "Macchiato",
      imagePath:
      "assets/coffee_assets/macchiato/square/macchiato_pic_1_square.png",
      rating: 4.5,
      price: "3.99 dt",
    ),
    Coffee(
      name: "Macchiato",
      imagePath:
      "assets/coffee_assets/macchiato/square/macchiato_pic_2_square.png",
      rating: 4.5,
      price: "3.99 dt",
    ),
    Coffee(
      name: "Macchiato",
      imagePath:
      "assets/coffee_assets/macchiato/square/macchiato_pic_3_square.png",
      rating: 4.5,
      price: "3.99 dt",
    ),
  ];
}

List<CoffeeBean> getAllCoffeeBeans() {
  return [
    CoffeeBean(
      name: "Arabica Beans",
      imagePath:
      "assets/coffee_assets/arabica_coffee_beans/arabica_coffee_beans_square.png",
      origin: "Ethiopia",
      rating: 4.5,
      price: "4.99 dt",
    ),
    CoffeeBean(
      name: "Robusta",
      imagePath:
      "assets/coffee_assets/robusta_coffee_beans/robusta_coffee_beans_square.png",
      origin: "Brazil",
      rating: 4.5,
      price: "4.99 dt",
    ),
    CoffeeBean(
      name: "Liberica",
      imagePath:
      "assets/coffee_assets/liberica_coffee_beans/liberica_coffee_beans_square.png",
      origin: "Liberia",
      rating: 4.5,
      price: "4.99 dt",
    ),
    CoffeeBean(
      name: "Excelsa",
      imagePath:
      "assets/coffee_assets/excelsa_coffee_beans/excelsa_coffee_beans_square.png",
      origin: "Vietnam",
      rating: 4.5,
      price: "4.99 dt",
    ),
  ];
}

class CoffeeTile extends StatelessWidget {
  final List<CartItem> cartItems; // Définir cartItems ici
  final Coffee coffee;
  final int index; // Ajoutez l'indice ici
  final Function(int, String) toggleFavorite;

  @override
  void initState() {
  }
  // Ajoutez index comme paramètre requis dans le constructeur
  CoffeeTile(
      {required this.coffee,
        required this.index,
        required this.toggleFavorite,
        required this.cartItems});

  @override
  Widget build(BuildContext context)
  {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreen(
              imagePath: getDetailImagePath(
                  coffee.imagePath), // Assurez-vous que cette méthode renvoie le bon chemin d'accès
              rating: coffee.rating, // Utilisez le rating de getAllCoffees
              name: coffee.name,
              cartItems: cartItems, // Passer cartItems à DetailsScreen
            ),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.57,
        decoration: BoxDecoration(
          color: Color(0xFF59585d).withOpacity(0.11),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          coffee
                              .imagePath, // Utilisez la propriété imagePath de l'objet coffee
                          width: MediaQuery.of(context).size.width *
                              0.4, // Largeur spécifique
                          height: MediaQuery.of(context).size.width * 0.4,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      coffee.name,
                      style: GoogleFonts.dancingScript(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      coffee.price,
                      style: GoogleFonts.dancingScript(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 8,
              right: 8,
              child: Container(
                  width: 28, // Largeur du carré
                  height: 28,
                  decoration: BoxDecoration(
                    color: Color(0xFF59585d).withOpacity(0.11),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: IconButton(
                    iconSize: 20,
                    onPressed: () {
                      // Basculer l'état de l'élément favori
                      toggleFavorite(index, 'coffee');
                    },
                    icon: Icon(
                      Icons.favorite,
                      color:
                      coffee.isFavorite ? Color(0xFFf67828) : Colors.white,
                    ),
                  )),
            ),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color(0xFF59585d).withOpacity(0.5),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star, color: Color(0xFFf67828), size: 16),
                  SizedBox(width: 4),
                  Text(
                    '${coffee.rating}',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CoffeeBeanTile extends StatelessWidget {
  final List<CartItem> cartItems; // Définir cartItems ici
  final CoffeeBean coffeeBean;
  final int index;
  final Function(int, String) toggleFavorite;

  // Ajoutez index comme paramètre requis dans le constructeur
  CoffeeBeanTile(
      {required this.coffeeBean,
        required this.index,
        required this.toggleFavorite,
        required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreen(
              imagePath: getDetailImagePath(coffeeBean
                  .imagePath), // Assurez-vous que cette méthode renvoie le bon chemin d'accès
              rating: coffeeBean.rating, // Utilisez le rating de getAllCoffees
              name: coffeeBean.name,
              cartItems: cartItems, // Passer cartItems à DetailsScreen
            ),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.57,
        decoration: BoxDecoration(
          color: Color(0xFF59585d).withOpacity(0.11),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          coffeeBean
                              .imagePath, // Utilisez la propriété imagePath de l'objet coffee
                          width: MediaQuery.of(context).size.width *
                              0.4, // Largeur spécifique
                          height: MediaQuery.of(context).size.width * 0.4,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      coffeeBean.name,
                      style: GoogleFonts.dancingScript(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      coffeeBean.price,
                      style: GoogleFonts.dancingScript(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 8,
              right: 8,
              child: Container(
                  width: 28, // Largeur du carré
                  height: 28,
                  decoration: BoxDecoration(
                    color: Color(0xFF59585d).withOpacity(0.11),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: IconButton(
                    iconSize: 20,
                    onPressed: () {
                      // Basculer l'état de l'élément favori
                      toggleFavorite(index, 'coffeeBean');
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: coffeeBean.isFavorite
                          ? Color(0xFFf67828)
                          : Colors.white,
                    ),
                  )),
            ),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color(0xFF59585d).withOpacity(0.5),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star, color: Color(0xFFf67828), size: 16),
                  SizedBox(width: 4),
                  Text(
                    '${coffeeBean.rating}',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
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

int _page = 0; // Ajout de la déclaration de la variable _page

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home'; // Définissez le nom de route ici
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List<String> coffeeOptions = [
  'All',
  'Americano',
  'Black Coffee',
  'Cappuccino',
  'Espresso',
  'Latte',
  'Macchiato',
];
List<Coffee> filterCoffees(String option) {
  if (option == 'All') {
    return getAllCoffees();
  } else {
    return getAllCoffees().where((coffee) => coffee.name == option).toList();
  }
}

List<CoffeeBean> filterCoffeeBeans(String value) {
  if (value.isEmpty) {
    return getAllCoffeeBeans();
  } else {
    return getAllCoffeeBeans()
        .where((bean) => bean.name.toLowerCase().contains(value.toLowerCase()))
        .toList();
  }
}

String? selectedCoffeeOption =
    'All'; // Définir 'All' comme option sélectionnée par défaut

class _HomeScreenState extends State<HomeScreen> {
  late User _currentUser;
  List<CartItem> cartItems = []; // Définir la variable cartItems

    @override
  void initState() {
    super.initState();
    _currentUser = FirebaseAuth.instance.currentUser!;
  }
  void toggleFavorite(int index, String type) {
    setState(() {
      if (type == 'coffee') {
        filteredCoffees[index].isFavorite = !filteredCoffees[index].isFavorite;
        if (filteredCoffees[index].isFavorite) {
          favoriteCoffees.add(filteredCoffees[index]);
        } else {
          favoriteCoffees.remove(filteredCoffees[index]);
        }
      } else if (type == 'coffeeBean') {
        filteredCoffeeBeans[index].isFavorite =
        !filteredCoffeeBeans[index].isFavorite;
        if (filteredCoffeeBeans[index].isFavorite) {
          favoriteCoffeeBeans.add(filteredCoffeeBeans[index]);
        } else {
          favoriteCoffeeBeans.remove(filteredCoffeeBeans[index]);
        }
      }
    });
  }

  List<String> favoriteItems = [];
  List<Coffee> favoriteCoffees = [];
  List<CoffeeBean> favoriteCoffeeBeans = [];

  final user = FirebaseAuth.instance.currentUser!;
  List<Coffee> filteredCoffees =
  getAllCoffees(); // Définir une valeur par défaut
  List<CoffeeBean> filteredCoffeeBeans =
  getAllCoffeeBeans(); // Définir une valeur par défaut

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (context) => CartItemsModel(),
      child: Scaffold(
        // drawer(
        //     backgroundColor: Color.fromARGB(255, 238, 115, 0), // Remplacez "Colors.blue" par la couleur de votre choix
        //     child: SideMenuClient(userEmail: _currentUser.email!),
        //   ),
        drawer: SideMenuClient(userEmail: _currentUser.email!),
        appBar: AppBar(
          backgroundColor: Color(0xFFf67828),
          toolbarHeight: 50,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: lbackgroundclr,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/user.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),

        backgroundColor: Colors.black, // couleur de fond de l'écran
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12, top: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Find the best coffee for you",
                        style: GoogleFonts.dancingScript(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomeNew()),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.new_releases,
                            color: Color(0xFFE51293),
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),

                    SizedBox(height: 10),
                    SizedBox(height: screenSize.height * 0.025),
                    SizedBox(height: screenSize.height * 0.027),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: screenSize.height * 0.065,
                          width: screenSize.width * 0.885,
                          child: TextFormField(
                            style: TextStyle(color: Colors.white),
                            onChanged: (value) {
                              setState(() {
                                filteredCoffees = getAllCoffees()
                                    .where((coffee) => coffee.name
                                    .toLowerCase()
                                    .contains(value.toLowerCase()))
                                    .toList();
                                filteredCoffeeBeans = filterCoffeeBeans(value);
                              });
                            },
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                              hintText: "Find your coffee...",
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                              ),
                              fillColor: Color(0xFF59585d).withOpacity(0.2),
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Colors.black54),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Colors.black54),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenSize.height * 0.027),
                    SizedBox(
                      height: screenSize.height * 0.065,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: coffeeOptions.length,
                        itemBuilder: ((context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  selectedCoffeeOption = coffeeOptions[index];
                                  filteredCoffees = filterCoffees(selectedCoffeeOption!);
                                });
                              },
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    child: Text(
                                      coffeeOptions[index],
                                      style: GoogleFonts.cormorantGaramond(
                                        textStyle: TextStyle(
                                          color: selectedCoffeeOption ==
                                              coffeeOptions[index]
                                              ? Colors.orange.withOpacity(0.8)
                                              : Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (selectedCoffeeOption == coffeeOptions[index])
                                    Container(
                                      width: 6,
                                      height: 6,
                                      decoration: BoxDecoration(
                                        color: Colors.orange,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      height: screenSize.height * 0.3,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: filteredCoffees.length,
                        itemBuilder: ((context, index) {
                          return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: CoffeeTile(
                                coffee: filteredCoffees[index],
                                index: index,
                                toggleFavorite: toggleFavorite,
                                cartItems: cartItems,
                              ));
                        }),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'Coffee Beans',
                        style: GoogleFonts.cormorantGaramond(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.3,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: filteredCoffeeBeans.length,
                        itemBuilder: ((context, index) {
                          return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: CoffeeBeanTile(
                                coffeeBean: filteredCoffeeBeans[index],
                                index: index,
                                toggleFavorite: toggleFavorite,
                                cartItems: cartItems,
                              ));
                        }),
                      ),
                    ),
                  ],
                ),

              ),
            ),
          ),
bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Color(0xFF59585d).withOpacity(0.2),
          color: Color(0xFFf67828),
          animationDuration: const Duration(milliseconds: 300),
          items: const <Widget>[
            Icon(Icons.home, size: 26, color: Colors.white),
            Icon(Icons.favorite, size: 26, color: Colors.white),
            Icon(Icons.shopping_bag,
                size: 26, color: Colors.white), // Icône du panier
            Icon(Icons.notifications, size: 26, color: Colors.white),
          ],
          onTap: (index) {
            setState(() {
              _page = index;
              if (_page == 1) {
                // Navigation vers l'écran des favoris
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoriteScreen(
                      favoriteCoffees: favoriteCoffees,
                      favoriteCoffeeBeans: favoriteCoffeeBeans,
                      cartItems: cartItems, // Passer cartItems ici
                    ),
                  ),
                );
              } else if (_page == 2) {
                // Navigation vers l'écran du panier
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartScreen(cartItems: cartItems),
                  ),
                );
              }
            });
          },
        ),
      ),
    );
  }
}

class Coffee {
  final String name;
  final String imagePath;
  final double rating;
  final String price;
  bool isFavorite; // Nouvelle propriété pour suivre l'état des favoris
  Coffee({
    required this.name,
    required this.imagePath,
    required this.rating,
    required this.price,
    this.isFavorite = false, // Par défaut, l'élément n'est pas favori
  });
}

class CoffeeBean {
  final String name;
  final String imagePath;
  final String origin;
  final double rating;
  final String price;
  bool isFavorite; // Nouvelle propriété pour suivre l'état des favoris
  CoffeeBean({
    required this.name,
    required this.imagePath,
    required this.origin,
    required this.rating,
    required this.price,
    this.isFavorite = false, // Par défaut, l'élément n'est pas favori
  });
}
class CartItemsModel extends ChangeNotifier {
  List<CartItem> cartItems = [];

  void addToCart(CartItem item) {
    cartItems.add(item);
    notifyListeners(); // Notifier les écouteurs que les données ont changé
  }
}