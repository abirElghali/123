import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'cartscreen.dart';
import 'package:provider/provider.dart';
import 'homescreen.dart';

class ImageDetails {
  final String imagePath;
  final String description;
  ImageDetails({
    required this.imagePath,
    required this.description,
  });
}

final List<ImageDetails> imageDetailsList = [
  ImageDetails(
      imagePath:
          'assets/coffee_assets/americano/portrait/americano_pic_1_portrait.png',
      description:
          "Americano is a symphony of harmoniously balanced flavours. Imagine sipping this refreshing cocktail on a hot summer day. Sweet red vermouth blends with the pungent bitterness of Campari, while sparkling water softens every sip, creating an unforgettable taste experience. Accompanied by a slice of orange, this cocktail instantly transports you to the sunny streets of Italy."),
  ImageDetails(
    imagePath:
        'assets/coffee_assets/americano/portrait/americano_pic_2_portrait.png',
    description:
        "Classic among the classics, the Americano embodies the timeless elegance of another time. Served in an old-fashioned glass filled with ice, this cocktail evokes the glamour of past years. Its history goes back to the trendy cafés of Milan where artists and intellectuals met to chat and relax. Today, Americano continues to appeal to cocktail lovers around the world with its sophisticated look and subtly nuanced flavor palette.",
  ),
  ImageDetails(
    imagePath:
        'assets/coffee_assets/americano/portrait/americano_pic_3_portrait.png',
    description:
        "Americano is more than just a cocktail - it’s a literary legend. Ernest Hemingway, one of the most influential writers of the 20th century, was an avid fan of this beverage. His association with the Americano helped strengthen his status as a cultural icon. Each sip evokes the writer’s passions and adventures, adding an extra dimension to this taste experience. Discover the Americano and let yourself be transported into the fascinating world of literature and history.",
  ),
  ImageDetails(
    imagePath:
        'assets/coffee_assets/arabica_coffee_beans/arabica_coffee_beans_portrait.png',
    description:
        "Discover the excellence of arabica coffee beans, an incomparable sensory experience. Grown in regions with ideal climatic conditions, these grains offer a captivating aroma, a rich flavor and a velvety body. Whether you are a coffee lover or a connoisseur, immerse yourself in a cup of fine coffee and let yourself be carried away by the incomparable quality of arabica beans.",
  ),
  ImageDetails(
    imagePath:
        'assets/coffee_assets/black_coffee/portrait/black_coffee_pic_1_portrait.png',
    description:
        "Feel the pure intensity of black coffee in every sip. Without artifice or addition, this beverage highlights the essence of coffee. Its robust taste and velvety texture envelop you in an authentic sensory experience. Enjoy it as is or add a touch of your favorite milk for a personalized experience.",
  ),
  ImageDetails(
    imagePath:
        'assets/coffee_assets/black_coffee/portrait/black_coffee_pic_2_portrait.png',
    description:
        "Start your day off right with a cup of black coffee. Its intoxicating aroma and deep flavor instantly stimulate you, preparing you for the challenges ahead. With every sip, feel the energy flowing into your body, giving you the motivation to face the day with confidence.",
  ),
  ImageDetails(
    imagePath:
        'assets/coffee_assets/black_coffee/portrait/black_coffee_pic_3_portrait.png',
    description:
        "Black coffee embodies sophisticated simplicity. In a world full of complex choices, this humble but powerful beverage stands out for its purity and clarity. A cup of black coffee is much more than a drink - it’s a ritual, a welcome break from the daily hustle and bustle, where every sip takes you back to basics.",
  ),
  ImageDetails(
    imagePath:
        'assets/coffee_assets/cappuccino/portrait/cappuccino_pic_1_portrait.png',
    description:
        "Treat yourself to the luxurious indulgence of a cappuccino. With its velvety foam topping, rich espresso base, and a hint of steamed milk, this classic Italian coffee creation is a symphony of flavors and textures. Savor each sip as the creamy foam melts into the robust espresso, offering a moment of pure bliss in every cup.",
  ),
  ImageDetails(
    imagePath:
        'assets/coffee_assets/cappuccino/portrait/cappuccino_pic_2_portrait.png',
    description:
        "Elevate your morning routine with a perfectly crafted cappuccino. As you take your first sip, feel the warmth of the espresso mingling with the airy foam, awakening your senses with its bold flavor and smooth finish. Whether enjoyed alone or paired with your favorite breakfast treat, a cappuccino is the perfect way to start your day on a delicious note.",
  ),
  ImageDetails(
    imagePath:
        'assets/coffee_assets/cappuccino/portrait/cappuccino_pic_3_portrait.png',
    description:
        "Experience the essence of Italian elegance with a cappuccino. With its delicate balance of espresso and frothy milk, this beloved coffee classic embodies the sophistication and charm of Italian café culture. Whether enjoyed as a midday pick-me-up or a post-dinner delight, a cappuccino offers a moment of pure indulgence that transports you to the bustling streets of Italy with every sip.",
  ),
  ImageDetails(
    imagePath:
        'assets/coffee_assets/espresso/portrait/espresso_pic_1_portrait.png',
    description:
        "Experience the bold and intense flavor of espresso in every sip. Brewed to perfection through a process of finely ground coffee beans and pressurized water, espresso delivers a concentrated burst of rich, complex flavors. With its velvety crema and lingering aftertaste, each shot of espresso is a sensory journey that awakens the palate and invigorates the senses.",
  ),
  ImageDetails(
    imagePath:
        'assets/coffee_assets/espresso/portrait/espresso_pic_2_portrait.png',
    description:
        "Discover the pure essence of coffee with a shot of espresso. Made from carefully selected beans and expertly extracted, espresso captures the true essence of coffee in its most concentrated form. With its robust flavor and velvety texture, each sip offers a moment of pure coffee bliss that lingers long after the cup is empty.",
  ),
  ImageDetails(
    imagePath:
        'assets/coffee_assets/espresso/portrait/espresso_pic_3_portrait.png',
    description:
        "Embrace the timeless tradition of Italian espresso with every sip. Originating in the bustling cafes of Italy, espresso has become a global symbol of coffee culture, beloved for its intense flavor and satisfying depth. Whether enjoyed as a quick pick-me-up or savored slowly, espresso transcends borders to unite coffee lovers around the world in a shared appreciation for its unparalleled taste and quality.",
  ),
  ImageDetails(
    imagePath:
        'assets/coffee_assets/excelsa_coffee_beans/excelsa_coffee_beans_portrait.png',
    description:
        "Experience the distinctive allure of Excelsa coffee beans. Grown in select regions with unique climates and elevations, Excelsa beans offer a tantalizing flavor profile that sets them apart from other varieties. With hints of fruity tartness and a lingering complexity, each cup of coffee brewed from Excelsa beans promises a truly exceptional taste experience. Elevate your coffee ritual with the exotic allure of Excelsa.",
  ),
  ImageDetails(
    imagePath: 'assets/coffee_assets/latte/portrait/latte_pic_1_portrait.png',
    description:
        "Indulge in the creamy elegance of a latte. With its smooth, velvety texture and perfectly balanced blend of espresso and steamed milk, this beloved coffee beverage offers a luxurious treat for the senses. Whether enjoyed as a morning pick-me-up or an afternoon indulgence, each sip of a latte is a moment of pure comfort and sophistication.",
  ),
  ImageDetails(
    imagePath: 'assets/coffee_assets/latte/portrait/latte_pic_2_portrait.png',
    description:
        "Dive into the rich and inviting flavors of a latte. Crafted with a double shot of espresso and topped with a generous layer of frothy milk, a latte delivers a satisfyingly bold taste with a creamy finish. Whether you prefer it flavored with a hint of vanilla or caramel, or simply enjoyed in its classic form, a latte is sure to delight your taste buds and warm your soul.",
  ),
  ImageDetails(
    imagePath: 'assets/coffee_assets/latte/portrait/latte_pic_3_portrait.png',
    description:
        "Treat yourself to coffee bliss with a latte. Made with care and precision, each latte is a masterpiece of flavor and texture. From the moment you take your first sip to the last, you'll be enchanted by the smoothness of the milk, the richness of the espresso, and the comforting warmth that envelops you with every sip. Whether you're starting your day or winding down in the evening, a latte is the perfect companion for moments of relaxation and indulgence.",
  ),
  ImageDetails(
    imagePath:
        'assets/coffee_assets/liberica_coffee_beans/liberica_coffee_beans_portrait.png',
    description:
        "Embark on a journey of discovery with Liberica coffee beans. Renowned for their bold and distinctive flavor profile, Liberica beans offer a unique and unforgettable coffee experience. Grown in select regions with rich volcanic soil and ideal climates, these beans boast a robust body and intriguing fruity and floral notes. Elevate your coffee game with the exotic allure of Liberica beans, and savor each cup as a testament to the diversity and complexity of the coffee world.",
  ),
  ImageDetails(
    imagePath:
        'assets/coffee_assets/macchiato/portrait/macchiato_pic_1_portrait.png',
    description:
        "Experience the perfect balance of bold espresso and velvety milk in every sip of a macchiato. This Italian classic, meaning stained or spotted, features a shot of rich espresso stained with just a dollop of frothy milk. The result is a drink that packs a punch of flavor while still maintaining a smooth and creamy texture. Whether you prefer it as a quick pick-me-up or a leisurely indulgence, a macchiato is sure to satisfy your coffee cravings.",
  ),
  ImageDetails(
    imagePath:
        'assets/coffee_assets/macchiato/portrait/macchiato_pic_2_portrait.png',
    description:
        "Delight in the simplicity of a macchiato - a small but mighty espresso punctuated with a touch of creamy foam. With its concentrated espresso base and light layer of milk foam, a macchiato offers a bold coffee flavor with just a hint of sweetness. Whether enjoyed as a morning ritual or an afternoon treat, each sip of a macchiato is a moment of pure coffee bliss.",
  ),
  ImageDetails(
    imagePath:
        'assets/coffee_assets/macchiato/portrait/macchiato_pic_3_portrait.png',
    description:
        "Discover the true essence of espresso with a macchiato. Made with a single shot of espresso stained with a small amount of steamed milk, this classic coffee drink captures the pure intensity and flavor of espresso in its most concentrated form. With its rich, robust taste and creamy texture, a macchiato is the perfect choice for coffee lovers who appreciate simplicity and boldness in every cup.",
  ),
  ImageDetails(
    imagePath:
        'assets/coffee_assets/robusta_coffee_beans/robusta_coffee_beans_portrait.png',
    description:
        "Experience the bold and robust flavor of Robusta coffee beans. Grown in tropical regions around the world, Robusta beans are celebrated for their strong, earthy taste and higher caffeine content compared to Arabica beans. With a distinctively rich and full-bodied profile, Robusta coffee offers a wake-up call to the senses, delivering a hearty and satisfying brew that energizes and invigorates.",
  ),
];

class DetailsScreen extends StatefulWidget {
  final String imagePath;
  final double rating;
  final String name;
  final List<CartItem> cartItems;

  const DetailsScreen({
    Key? key,
    required this.imagePath,
    required this.rating,
    required this.name,
    required this.cartItems,
  }) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  String selectedSize = '';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    String description = imageDetailsList
        .firstWhere((detail) => detail.imagePath == widget.imagePath,
            orElse: () => ImageDetails(imagePath: '', description: ''))
        .description;

    return Scaffold(
      body: Container(
        color: Colors.black,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 1050,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Image.asset(
                        widget.imagePath,
                        width: screenWidth,
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                    Positioned(
                      top: 20,
                      left: 20,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 19,
                            color: Colors.white60,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      top: 410,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 15, left: 20),
                                child: Text(
                                  widget.name,
                                  style: GoogleFonts.dancingScript(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 45,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              RatingBar.builder(
                                initialRating: widget.rating,
                                minRating: 0,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 25,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 7.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 40, left: 20),
                                child: Text(
                                  'Description',
                                  style: GoogleFonts.pacifico(
                                    fontSize: 25,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  description,
                                  textAlign: TextAlign.justify,
                                  style: GoogleFonts.crimsonText(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: buildSizeBlock(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSizeBlock() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Size',
          style: GoogleFonts.pacifico(
            fontSize: 25,
            color: Colors.blueGrey,
          ),
        ),
        SizedBox(height: 10),
        if (!widget.imagePath.contains('beans'))
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildSizeButton('S'),
              SizedBox(width: 8),
              buildSizeButton('M'),
              SizedBox(width: 8),
              buildSizeButton('L'),
            ],
          ),
        SizedBox(height: 10),
        if (widget.imagePath.contains('beans'))
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildSizeButtonBean('250g'),
              SizedBox(width: 8),
              buildSizeButtonBean('500g'),
              SizedBox(width: 8),
              buildSizeButtonBean('1Kg'),
            ],
          ),
        SizedBox(height: 20),
        buildPrice(),
      ],
    );
  }

  Widget buildSizeButton(String size) {
    bool isSelected = selectedSize == size;
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            selectedSize = size;
          });
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            isSelected
                ? Color(0xFF59585d).withOpacity(0.2)
                : Color(0xFF59585d).withOpacity(0.2),
          ),
          foregroundColor: MaterialStateProperty.all<Color>(
            isSelected ? Color(0xFFf67828) : Colors.white,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              side: BorderSide(
                color: isSelected
                    ? Color(0xFFf67828)
                    : Color(0xFF59585d).withOpacity(0.2),
              ),
              borderRadius: BorderRadius.circular(50.0),
            ),
          ),
          minimumSize: MaterialStateProperty.all<Size>(
            Size(double.infinity, 50),
          ),
        ),
        child: Text(size),
      ),
    );
  }

  Widget buildPrice() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Price',
                  style: GoogleFonts.crimsonText(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
                if (!widget.imagePath.contains('beans'))
                  Text(
                    '${getPrice(selectedSize)} dt',
                    style: GoogleFonts.crimsonText(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                if (widget.imagePath.contains('beans'))
                  Text(
                    '${getPriceBean(selectedSize)} dt',
                    style: GoogleFonts.crimsonText(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(width: 20),
          ElevatedButton(
            onPressed: () {
              addToCart();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFf67828),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              fixedSize: Size(200, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            child: Text('Add to cart'),
          ),
        ],
      ),
    );
  }

  Widget buildSizeButtonBean(String size) {
    bool isSelected = selectedSize == size;
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            selectedSize = size;
          });
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            isSelected
                ? Color(0xFF59585d).withOpacity(0.2)
                : Color(0xFF59585d).withOpacity(0.2),
          ),
          foregroundColor: MaterialStateProperty.all<Color>(
            isSelected ? Color(0xFFf67828) : Colors.white,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              side: BorderSide(
                color: isSelected
                    ? Color(0xFFf67828)
                    : Color(0xFF59585d).withOpacity(0.2),
              ),
              borderRadius: BorderRadius.circular(50.0),
            ),
          ),
          minimumSize: MaterialStateProperty.all<Size>(
            Size(double.infinity, 50),
          ),
        ),
        child: Text(size),
      ),
    );
  }

  double getPrice(String size) {
    switch (size) {
      case 'S':
        return 2.99;
      case 'M':
        return 3.99;
      case 'L':
        return 4.99;
      default:
        return 0.0;
    }
  }

  double getPriceBean(String size) {
    switch (size) {
      case '250g':
        return 2.99;
      case '500g':
        return 3.99;
      case '1Kg':
        return 4.99;
      default:
        return 0.0;
    }
  }

  void addToCart() {
    double price;
    int newIndex = widget.cartItems.length; // Obtenir le nouvel index

    if (widget.imagePath.contains('beans')) {
      price = getPriceBean(selectedSize);
    } else {
      price = getPrice(selectedSize);
    }

    setState(() {
      widget.cartItems.add(
        CartItem(
          name: widget.name,
          size: selectedSize,
          price: price,
          originalImagePath: widget.imagePath,
          index: newIndex, // Utiliser le nouvel index
        ),
      );
    });

    Navigator.pop(context);
  }
}

class CartItem {
  final String name;
  final String size;
  final double price;
  final String originalImagePath;
  final int index;
  CartItem({
    required this.name,
    required this.size,
    required this.price,
    required this.originalImagePath,
    required this.index,
  });
}
