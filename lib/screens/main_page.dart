// lib/screens/main_page.dart
import 'package:flutter/material.dart';
import 'home_page.dart';

// Placeholder halaman cart
class CartPagePlaceholder extends StatelessWidget {
  const CartPagePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Halaman Keranjang (Dalam Pengembangan)', style: TextStyle(fontSize: 16)),
    );
  }
}

// Placeholder halaman profil
class ProfilePagePlaceholder extends StatelessWidget {
  const ProfilePagePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Halaman Profil (Dalam Pengembangan)', style: TextStyle(fontSize: 16)),
    );
  }
}

// Halaman utama
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  // Daftar halaman yang akan ditampilkan sesuai tab
  final List<Widget> _pages = [
    const HomePage(),             // Tab 0: Beranda
    const CartPagePlaceholder(),   // Tab 1: Keranjang
    const ProfilePagePlaceholder(),// Tab 2: Profil
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Keranjang',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}