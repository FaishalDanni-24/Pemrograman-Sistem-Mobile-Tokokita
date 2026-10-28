import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class OrderDatabase {
  static final OrderDatabase instance = OrderDatabase._init();
  static Database? _database;

  OrderDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('tokokita_orders.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE orders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tanggal TEXT NOT NULL,
        daftarItem TEXT NOT NULL,
        totalHarga REAL NOT NULL,
        status TEXT NOT NULL
      )
    ''');
  }

  // Operasi CRUD
  // 1. CREATE / INSERT
  Future<int> insertOrder(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('orders', row);
  }

  // 2. READ / GET ALL
  Future<List<Map<String, dynamic>>> getAllOrders() async {
    final db = await instance.database;
    return await db.query('orders', orderBy: 'id DESC');
  }

  // 3. UPDATE STATUS
  Future<int> updateOrderStatus(int id, String newStatus) async {
    final db = await instance.database;
    return await db.update(
      'orders',
      {'status': newStatus},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // 4. DELETE ORDER
  Future<int> deleteOrder(int id) async {
    final db = await instance.database;
    return await db.delete(
      'orders',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Pencarian pesanan berdasarkan status menggunakan klausa WHERE
  Future<List<Map<String, dynamic>>> searchOrdersByStatus(String status) async {
    final db = await instance.database;
    return await db.query(
      'orders',
      where: 'status LIKE ?',
      whereArgs: ['%$status%'],
      orderBy: 'id DESC',
    );
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}