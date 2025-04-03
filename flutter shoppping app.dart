import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_checkout_outlined,
              size: 100,
              color: Colors.black,
            ),
            SizedBox(height: 20),
            Text(
              "MY SHOPPING APP",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Welcome to the app",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Shopping App"),
        backgroundColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ClothingPage()),
              );
            },
            child: Text("Clothing"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VegetablePage()),
              );
            },
            child: Text("Vegetables"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FruitPage()),
              );
            },
            child: Text("Fruits"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
            child: Text("View Cart"),
          ),
        ],
      ),
    );
  }
}

class ClothingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clothing"),
        backgroundColor: Colors.black,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: 4,
        itemBuilder: (context, index) {
          return ProductItem(
            name: "Product ${index + 1}",
            imageUrl: "https://via.placeholder.com/150",
            price: 20.0 + index * 5,
          );
        },
      ),
    );
  }
}

class VegetablePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vegetables"),
        backgroundColor: Colors.black,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: 4,
        itemBuilder: (context, index) {
          return ProductItem(
            name: "Vegetable ${index + 1}",
            imageUrl: "https://via.placeholder.com/150",
            price: 5.0 + index * 2,
          );
        },
      ),
    );
  }
}

class FruitPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fruits"),
        backgroundColor: Colors.black,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: 4,
        itemBuilder: (context, index) {
          return ProductItem(
            name: "Fruit ${index + 1}",
            imageUrl: "https://via.placeholder.com/150",
            price: 3.0 + index,
          );
        },
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final String name;
  final String imageUrl;
  final double price;

  ProductItem({required this.name, required this.imageUrl, required this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        children: [
          Image.network(imageUrl, width: 100, height: 100, fit: BoxFit.cover),
          Text(name),
          Text("\$${price.toString()}"),
          ElevatedButton(
            onPressed: () {},
            child: Text("Add to Cart"),
          ),
        ],
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems = [
    {"name": "T-Shirt", "price": 20.0},
    {"name": "Carrot", "price": 5.0},
  ];

  @override
  Widget build(BuildContext context) {
    double total = cartItems.fold(0, (sum, item) => sum + item["price"]);

    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(cartItems[index]["name"]),
                  trailing: Text("\$${cartItems[index]["price"]}"),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "Total: \$${total.toString()}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrderPage(total: total)),
              );
            },
            child: Text("Checkout"),
          ),
        ],
      ),
    );
  }
}

class OrderPage extends StatelessWidget {
  final double total;

  OrderPage({required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Confirmation"),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Your total is \$${total.toString()}", style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: Text("Confirm Order"),
            ),
          ],
        ),
      ),
    );
  }
}
