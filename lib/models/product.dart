// Control flow (Loop dan fungsi digunakan di main())
// Function menggunakan if-else
String tampilkanStatusProduk(int stok) {
  if (stok > 10) {
    return 'Tersedia';
  } else if (stok > 0) {
    return 'Stok Terbatas';
  } else {
    return 'Habis';
  }
}

// Function untuk logika produk dan diskon
// Function Positional Parameters biasa
double hitungHargaSetelahDiskonBiasa(double harga, double persenDiskon) {
  return harga - (harga * (persenDiskon / 100));
}

// Function Named Parameters dengan Default Value
double hitungHargaSetelahDiskon(double harga, {double persenDiskon = 0.0}) {
  return harga - (harga * (persenDiskon / 100));
}

// Arrow Function
String formatRupiah(double harga) => 'Rp ${harga.toStringAsFixed(0)}';


// Fungsi main (hanya terjalan saat run langsung di kode ini)
void main() {
  // Variabel dan Tipe Data
  // Deklarasi variabel var, final, const
  const namaToko = "Tokokita";
  final tanggalDibuat = DateTime.now();
  var kategoriUtama = "Gadget";
  kategoriUtama = "Elektronik";

  print('=== Perilaku Variabel ===');
  print('Nama Toko (const) : $namaToko');
  print('Kategori (var)    : $kategoriUtama');
  print('Dibuat Pada (final): $tanggalDibuat\n');

  // Deklarasi variabel dengan tipe data spesifik
  String namaProduk = "Laptop Notebook";
  int stok = 10;
  double harga = 10000000.0;
  bool statusTersedia = true;

  print('=== Detail Produk ===');
  print('Nama Produk : $namaProduk');
  print('Stok        : $stok unit');
  print('Harga       : Rp $harga');
  print('Tersedia    : $statusTersedia\n');

  // Menggunakan List<String>
  List<String> daftarKategori = ['Elektronik', 'Fashion', 'Makanan'];

  // Menggunakan Map<String, dynamic>
  Map<String, dynamic> produkDataMentah = {
    'id': 101,
    'nama': 'Kemeja Batik',
    'harga': 150000.0,
    'stok': 20,
    'isAvailable': true,
    'kategori': 'Fashion',
  };

  print('=== Koleksi Data ===');
  print('Daftar Kategori di Toko: $daftarKategori');
  print('Data Mentah Produk: $produkDataMentah');

  // Operator untuk Perhitungan Harga
  // Operasi Aritmatika untuk Hitung total harga dan jumlah stok
  int jumlahBeli = 3;
  double totalHarga = harga * jumlahBeli; // Perkalian
  int sisaStok = stok - jumlahBeli; // Pengurangan

  // Tampilkan hasil operasi aritmatika
  print('\n=== Operasi Aritmatika ===');
  print('Total Harga ($jumlahBeli item) : Rp $totalHarga');
  print('Sisa Stok : $sisaStok unit');

  // Operasi perbandingan
  double hargaProdukLain = 15000000.0;

  bool isHargaSama = harga == hargaProdukLain;
  bool isHargaLebihBesar = harga > hargaProdukLain;
  bool isHargaLebihKecil = harga < hargaProdukLain;

  // Tampilkan hasil operasi perbandingan
  print('\n=== Operasi Perbandingan ===');
  print('Harga Produk A = Harga Produk B : Rp $isHargaSama');
  print('Harga Produk A > Harga Produk B : Rp $isHargaLebihBesar');
  print('Harga Produk A < Harga Produk B : Rp $isHargaLebihKecil');

  // Operasi logika
  bool produkTersedia = true;

  bool tampilkanProduk = (stok > 0) && (harga > 0) && produkTersedia;

  // Tampilkan hasil operasi logika
  print('\n=== Operasi logika ===');
  print('Apakah produk $namaProduk ditampilkan : $tampilkanProduk');

  // Control Flow
  // Cek status stok produk
  int stokSimulasi = 7;

  print("\n === Control Flow ===");
  print(
    'Status stok produk ($stokSimulasi) : ${tampilkanStatusProduk(stokSimulasi)}',
  );

  // Perulangan for
  List<double> daftarHarga = [50000, 120000, 35000, 80000];
  double totalBelanja = 0;

  for (int i = 0; i < daftarHarga.length; i++) {
    totalBelanja += daftarHarga[i];
  }

  print('Total Belanja (for loop): Rp $totalBelanja');

  // Perulangan while
  print('Simulasi Pembelian:');
  while (stokSimulasi > 0) {
    print(' - Item dibeli. Sisa stok: ${stokSimulasi - 1}');
    stokSimulasi--;
  }

  // Switch case
  String kategori = 'Fashion';
  double persentaseDiskon;

  switch (kategori) {
    case 'Elektronik':
      persentaseDiskon = 0.10; // 10%
      break;
    case 'Fashion':
      persentaseDiskon = 0.15; // 15%
      break;
    case 'Makanan':
      persentaseDiskon = 0.05; // 5%
      break;
    default:
      persentaseDiskon = 0.0;
  }
  print('Diskon untuk kategori $kategori: ${persentaseDiskon * 100}%\n');

  // Uji coba Function
  // Panggilan Function biasa
  double h1 = hitungHargaSetelahDiskonBiasa(100000, 10);
  print('Harga biasa (100rb, diskon 10%): ${formatRupiah(h1)}');

  // Panggilan Named Parameter tanpa diskon (pakai nilai default yaitu 0.0)
  double h2 = hitungHargaSetelahDiskon(100000);
  print('Harga tanpa argumen diskon: ${formatRupiah(h2)}');

  // Panggilan Named Parameter dengan diskon
  double h3 = hitungHargaSetelahDiskon(100000, persenDiskon: 15);
  print('Harga dengan named diskon 15%: ${formatRupiah(h3)}\n');

  // Tes Class
  // Instance 1: Dengan deskripsi
  Product produk1 = Product(
    id: 1,
    name: 'Sepatu Lari',
    price: 450000,
    imageUrl: 'https://example.com/sepatu.jpg',
    category: 'Fashion',
    stock: 12,
    description: 'Sepatu lari ringan dan nyaman.',
  );

  // Instance 2: Tanpa deskripsi (description bernilai null)
  Product produk2 = Product(
    id: 2,
    name: 'Mouse Wireless',
    price: 150000,
    imageUrl: 'https://example.com/mouse.jpg',
    category: 'Elektronik',
    stock: 5,
  );

  // Instance 3: DiscountedProduct (Inheritance)
  DiscountedProduct produkDiskon = DiscountedProduct(
    id: 3,
    name: 'Kemeja Batik',
    price: 200000,
    imageUrl: 'https://example.com/batik.jpg',
    category: 'Fashion',
    stock: 20,
    discountPercent: 20,
  );

  print(produk1.infoLengkap);
  print('---');
  print(produk2.infoLengkap);
  print('---');
  print(
    '${produkDiskon.name} - Harga Asli: Rp ${produkDiskon.price}, Harga Setelah Diskon (${produkDiskon.discountPercent}%): Rp ${produkDiskon.finalPrice}',
  );

  // Tes Null Safety di Dart (uncomment untuk mencobanya)
  // Product produkError = Product(
  //   id: null,
  //   name: null,
  //   price: null,
  //   imageUrl: null,
  //   category: null,
  //   stock: null,
  //   description: null
  // );
}

// Class Product & Null Safety (Class di bawah ini yang akan digunakan)
class Product {
  final int id;
  final String name;
  final double price;
  final String imageUrl;
  final String category;
  final int stock;

  // Properti Nullable (boleh null)
  final String? description;

  // Constructor
  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.stock,
    this.description, // Optional / Nullable
  });

  // Method tambahan untuk mengecek status stok berdasarkan jumlahnya
  String getStatusStok() {
    if (stock > 10) {
      return 'Tersedia';
    } else if (stock > 0) {
      return 'Stok Terbatas';
    } else {
      return 'Habis';
    }
  }

  // Getter Method untuk menampilkan informasi
  String get infoLengkap {
    String descText = description ?? 'Tidak ada deskripsi.';
    return '[$id] $name ($category) - Rp $price | Stok: ${getStatusStok()}\nDeskripsi: $descText';
  }

  // Function untuk total belanja produk
double hitungTotalBelanja(List<Product> keranjang) {
  double total = 0.0;
  for (var produk in keranjang) {
    total += produk.price;
  }
  return total;
}


  // Dummy data untuk percobaan
  List<Product> dummyProducts = [
  Product(
    id: 1,
    name: 'Smartphone Android X',
    price: 2500000.0,
    imageUrl: 'https://example.com/images/phone.jpg',
    category: 'Elektronik',
    stock: 15,
    description: 'Smartphone layar AMOLED 6.5 inci dengan baterai 5000mAh.',
  ),
  Product(
    id: 2,
    name: 'Laptop Slim Pro 14',
    price: 8500000.0,
    imageUrl: 'https://example.com/images/laptop.jpg',
    category: 'Elektronik',
    stock: 5,
    description: 'Laptop tipis dan ringan, ideal untuk produktivitas harian.',
  ),
  Product(
    id: 3,
    name: 'Headphone Wireless Bass',
    price: 450000.0,
    imageUrl: 'https://example.com/images/headphone.jpg',
    category: 'Elektronik',
    stock: 0,
  ),
  Product(
    id: 4,
    name: 'Kemeja Batik Modern',
    price: 175000.0,
    imageUrl: 'https://example.com/images/batik.jpg',
    category: 'Fashion',
    stock: 25,
    description: 'Kemeja batik katun halus dengan motif modern.',
  ),
  Product(
    id: 5,
    name: 'Sepatu Sneaker Casual',
    price: 320000.0,
    imageUrl: 'https://example.com/images/sneakers.jpg',
    category: 'Fashion',
    stock: 8,
  ),
  Product(
    id: 6,
    name: 'Jaket Denim Oversize',
    price: 280000.0,
    imageUrl: 'https://example.com/images/jacket.jpg',
    category: 'Fashion',
    stock: 12,
    description: 'Jaket denim gaya klasik cocok untuk berbagai acara.',
  ),
  Product(
    id: 7,
    name: 'Kopi Arabika Premium 250g',
    price: 65000.0,
    imageUrl: 'https://example.com/images/kopi.jpg',
    category: 'Makanan',
    stock: 30,
    description: 'Biji kopi pilihan roasted medium dengan aroma khas.',
  ),
  Product(
    id: 8,
    name: 'Cokelat Matchalicious 100g',
    price: 35000.0,
    imageUrl: 'https://example.com/images/cokelat.jpg',
    category: 'Makanan',
    stock: 0,
  ),
];
}

// Inheritance: DiscountedProduct
class DiscountedProduct extends Product {
  final double discountPercent;

  DiscountedProduct({
    required super.id,
    required super.name,
    required super.price,
    required super.imageUrl,
    required super.category,
    required super.stock,
    super.description,
    required this.discountPercent,
  });

  // Method menghitung harga final setelah diskon
  double get finalPrice {
    return price - (price * (discountPercent / 100));
  }
}
