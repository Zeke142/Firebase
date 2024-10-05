import 'package:flutter/material.dart';

class DirtHubEliteApp extends StatefulWidget {
  const DirtHubEliteApp({super.key});  // Super parameter for key

  @override
  DirtHubEliteAppState createState() => DirtHubEliteAppState();  // Public state class
}

class DirtHubEliteAppState extends State<DirtHubEliteApp> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const Center(child: Text('Buyers Page')),    // Placeholder for BuyersPage
    const Center(child: Text('Sellers Page')),   // Placeholder for SellersPage
    const Center(child: Text('Transport Page')), // Placeholder for TransportPage
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DirtHub Elite'),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Buyers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Sellers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_shipping),
            label: 'Transport',
          ),
        ],
      ),
    );
  }
}