import 'package:flutter/material.dart';
import '../services/order_database.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  List<Map<String, dynamic>> _orders = [];
  bool _isLoading = true;
  String _selectedFilter = 'Semua'; // Status filter aktif saat ini

  @override
  void initState() {
    super.initState();
    _fetchOrdersByFilter(_selectedFilter);
  }

  // Mengubah status pesanan
  Future<void> _toggleStatus(int id, String currentStatus) async {
    String nextStatus = currentStatus == 'Diproses' ? 'Selesai' : 'Diproses';
    await OrderDatabase.instance.updateOrderStatus(id, nextStatus);
    _fetchOrdersByFilter(_selectedFilter); // Refresh tampilan secara langsung
  }

  // Menghapus pesanan
  Future<void> _deleteOrder(int id) async {
    await OrderDatabase.instance.deleteOrder(id);
    _fetchOrdersByFilter(_selectedFilter); // Refresh tampilan secara langsung
  }

  // Mengambil data berdasarkan filter status menggunakan query SQLite
  Future<void> _fetchOrdersByFilter(String filter) async {
    setState(() {
      _isLoading = true;
      _selectedFilter = filter;
    });

    List<Map<String, dynamic>> data;
    if (filter == 'Semua') {
      data = await OrderDatabase.instance.getAllOrders();
    } else {
      // Memanggil fungsi pencarian dengan klausa WHERE status
      data = await OrderDatabase.instance.searchOrdersByStatus(filter);
    }

    setState(() {
      _orders = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Pesanan'),
        actions: [
          // Dropdown atau Tombol Filter di AppBar
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list),
            onSelected: (String value) {
              _fetchOrdersByFilter(value);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Semua',
                child: Text('Semua Pesanan'),
              ),
              const PopupMenuItem<String>(
                value: 'Diproses',
                child: Text('Filter: Diproses'),
              ),
              const PopupMenuItem<String>(
                value: 'Selesai',
                child: Text('Filter: Selesai'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Indikator filter aktif di bagian atas list
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.grey[200],
            width: double.infinity,
            child: Text(
              'Menampilkan: $_selectedFilter',
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _orders.isEmpty
                    ? const Center(
                        child: Text('Tidak ada riwayat pesanan ditemukan.'),
                      )
                    : ListView.builder(
                        itemCount: _orders.length,
                        itemBuilder: (context, index) {
                          final order = _orders[index];
                          final id = order['id'] as int;
                          final status = order['status'] as String;

                          return Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            child: ListTile(
                              title: Text('Item: ${order['daftarItem']}'),
                              subtitle: Text(
                                'Tanggal: ${order['tanggal'].toString().split('T')[0]}\nTotal: Rp ${order['totalHarga']} | Status: $status',
                              ),
                              isThreeLine: true,
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      status == 'Selesai'
                                          ? Icons.check_circle
                                          : Icons.hourglass_bottom,
                                      color: status == 'Selesai'
                                          ? Colors.green
                                          : Colors.orange,
                                    ),
                                    onPressed: () => _toggleStatus(id, status),
                                    tooltip: 'Ubah Status',
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () => _deleteOrder(id),
                                    tooltip: 'Hapus Pesanan',
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ]
      )
    );
  }
}