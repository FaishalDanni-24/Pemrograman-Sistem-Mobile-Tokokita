// lib/screens/main_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';

import 'home_page.dart';
import 'cart_page.dart';
import 'profile_page.dart';

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
    const CartPage(),   // Tab 1: Keranjang
    const ProfilePagePlaceholder(),// Tab 2: Profil
  ];

  @override
  void initState(){
    super.initState();
    // Pendaftaran controller di awal aplikasi
    Get.put(CartController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
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