import 'package:flutter/material.dart';

class StockBadge extends StatelessWidget {
  final String statusStok;

  const StockBadge({
    super.key,
    required this.statusStok,
  });

  // Mendapatkan warna background berdasarkan status stok
  Color _getBadgeColor() {
    switch (statusStok) {
      case 'Tersedia':
        return Colors.green;
      case 'Stok Terbatas':
        return Colors.orange;
      case 'Habis':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: _getBadgeColor().withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(
          color: _getBadgeColor(),
          width: 1.0,
        ),
      ),
      child: Text(
        statusStok,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: _getBadgeColor(),
        ),
      ),
    );
  }
}