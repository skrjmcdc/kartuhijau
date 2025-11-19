# Kartuhijau

**Nama:** Muhammad Ibaadi Ilmi  
**NPM:** 2406357684  
**Kelas:** PBP A

# Tugas 9

Catatan: Saya menghapus sebagian besar widget _styling_ dalam preview-preview Flutter di bawah. _Source code_ yang lebih lengkap bisa dilihat di _repository_.

## Checklist

### API autentikasi di Django

Saya membuat 

### Instalasi package `pbp_django_auth` dan `provider`

Untuk memudahkan mengakses API autentikasi di Django, saya menambahkan _package_ `pbp_django_auth` karya tim asisten dosen. Untuk menggunakan _package_ tersebut, kita juga memerlukan _package_ `provider`, jadi saya menjalankan perintah berikut di _root_ proyek untuk menambahkan kedua _package_ tersebut:

```bash
flutter pub add provider
flutter pub add pbp_django_auth
```

### Halaman register di Flutter

Selanjutnya saya membuat halaman register.

(File: lib/screens/register.dart **(file baru)**)

```dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final pdjau = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: ListView(
        children: [
          const Text('Register'),
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(
              labelText: 'Username',
              hintText: 'Enter your username...',
            ),
          ),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(
              labelText: 'Password',
              hintText: 'Enter your password...',
            ),
            obscureText: true,
          ),
          TextField(
            controller: _confirmPasswordController,
            decoration: const InputDecoration(
              labelText: 'Confirm Password',
              hintText: 'Confirm...',
            ),
            obscureText: true,
          ),
          ElevatedButton(
            onPressed: () async {
              String username = _usernameController.text;
              String password1 = _passwordController.text;
              String password2 = _confirmPasswordController.text;
              final response = await pdjau.postJson(
                  "http://localhost:8123/auth/register/",
                  jsonEncode({
                    'username': username,
                    'password1': password1,
                    'password2': password2,
              }));
              if (context.mounted) {
                if (response['status'] == 'success') {
                  ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                          const SnackBar(
                            content: Text('Successfully registered account.')
                          ));
                  Navigator.pop(context);
                } else {
                  String message = response['message'];
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                        SnackBar(
                            content: Text('Login failed: $message')
                        ));
                }
              }
            },
            child: const Text('Register'),
          ),
        ],
      ),
    );
  }
}
```

### Halaman login di Flutter

Selanjutnya saya membuat halaman login.

(File: lib/screens/login.dart **(file baru)**)

```dart
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final pdjau = context.watch<CookieRequest>();
    return Scaffold(
        appBar: AppBar(
        title: const Text('Login'),
      ),
      body: ListView(
        children: [
          const Text('Login'),
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(
              labelText: 'Username',
              hintText: 'Enter your username...',
            ),
          ),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(
              labelText: 'Password',
              hintText: 'Enter your password...',
            ),
            obscureText: true,
          ),
          ElevatedButton(
            onPressed: () async {
              String username = _usernameController.text;
              String password = _passwordController.text;
              final response = await pdjau.login("http://localhost:8123/auth/login/", {
                'username': username,
                'password': password,
              });
              if (pdjau.loggedIn) {
                String message = response['message'];
                String uname = response['username'];
                if (context.mounted) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                        SnackBar(
                            content: Text('$message Welcome, $uname.')
                        ));
                  Navigator.pop(context);
                }
              } else {
              }
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}

```

### Membuat model `Product`

(File: lib/models/product.dart **(file baru)**)

```dart
import 'dart:convert';

List<Product> productsFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productsToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product{

  String id;
  String name;
  int price;
  String? description;
  String? thumbnail;
  String category;
  bool isFeatured;
  String userId;
  String username;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.thumbnail,
    required this.category,
    required this.isFeatured,
    required this.userId,
    required this.username,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    description: json["description"],
    thumbnail: json["thumbnail"],
    category: json["category"],
    isFeatured: json["is_featured"],
    userId: json["user_id"],
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "description": description,
    "thumbnail": thumbnail,
    "category": category,
    "is_featured": isFeatured,
    "user_id": userId,
    "username": username,
  };
}
```

### Halaman daftar semua produk

(File: lib/screens/all\_products.dart **(file baru)**)

```dart
import 'package:flutter/material.dart';
import 'package:kartuhijau/models/product.dart';
import 'package:kartuhijau/screens/menu.dart';
import 'package:kartuhijau/screens/product_detail.dart';
import 'package:kartuhijau/widgets/left_drawer.dart';
import 'package:kartuhijau/widgets/product_card.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {

  Future<List<Product>> fetchProducts(CookieRequest pdjau) async {
    final response = await pdjau.get('http://localhost:8123/json/');
    var data = response;
    List<Product> products = [];
    for (var p in data) {
      if (p != null) {
        products.add(Product.fromJson(p));
      }
    }
    return products;
  }
  @override
  Widget build(BuildContext context) {
    final pdjau = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder(
        future: fetchProducts(pdjau),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const CircularProgressIndicator();
          } else {
            if (!snapshot.hasData) {
              child: Text(
                'There are no products yet.'
              );
            } else {
              final screenWidth = MediaQuery.of(context).size.width;
              int crossAxisCount = screenWidth ~/ 300;
              // Display product cards in a grid.
              // Automatically change number of columns based on screen width
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: 1.0,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) {
                  var product = snapshot.data![index];
                  return ProductCard(
                    product: product,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailPage(
                            product: product
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
```

### Halaman detail produk

```dart
import 'package:flutter/material.dart';
import 'package:kartuhijau/models/product.dart';
import 'package:kartuhijau/widgets/left_drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatelessWidget {

  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Is Featured
                if (product.isFeatured) const Text(
                  'Featured',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                // Name
                Text(product.name),
                // Category
                Text('Category: ${product.category}'),
                // Price
                Text('Price: ${product.price}'),
                // Description 
                Text(
                  product.description ?? "(This product doesn't have a description.)",
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
```

### Filtering produk user yang sedang login

## Pertanyaan

### Pentingnya membuat model Dart saat mengambil/mengirim data JSON

### Fungsi package http dan CookieRequest

### Mengapa *instance* CookieRequest perlu untuk dibagikan ke semua komponen di aplikasi Flutter

# Tugas 8

## `Navigator.push()` vs. `Navigator.pushReplacement()`

Dalam Flutter, Navigator bekerja sebagai suatu stack, di mana halaman yang baru diakses akan di-push ke atas stack, sedangkan setiap pengguna meng-klik tombol untuk kembali ke halaman "sebelumnya", maka halaman teratas akan di-pop dari stack.

Perbedaan `Navigator.push()` dengan `Navigator.pushReplacement()`, yaitu `push()` bekerja seperti operasi push pada umumnya, sehingga halaman yang baru diakses akan diletakkan di bagian atas stack. Sedangkan `pushReplacement()` justru *mengganti* halaman teratas di stack dengan halaman yang baru diakses, sehingga `pushReplacement()` seolah-olah mem-pop halaman teratas, baru mem-push halaman yang akan diakses.

## Hierarchy widget

Berikut pemanfaatan hierarchy widget dalam aplikasi:
- `Scaffold`: Saya menggunakannya sebagai kerangka dasar untuk setiap halaman. Seluruh widget dalam setiap halaman akan termuat dalam widget ini. Selanjutnya saya tinggal menggunakannya sebagai widget dasar setiap halaman.
- `AppBar`: Saya mengguunakannya untuk membuat header yang akan muncul di bagian atas setiap halaman. Selanjutnya saya tinggal menambahkan bar tersebut pada Scaffold masing-masing halaman.
- `Drawer`: Saya menggunakannya untuk membuat elanjutnya saya tinggal menambahkan drawer tersebut tersebut pada Scaffold masing-masing halaman.

## Layout widget dalam form

Kelebihan menggunakan layout widget saat menampilkan elemen-elemen form yaitu kita dapat mengatur penempatan setiap widget dalam form. Sedangkan jika kita hanya menggunakan widget-widget form secara langsung, maka hasilnya akan terlihat jelek karena kita tidak bisa mengatur layout-nya. Misalnya, saya menggunakan `ListView` sebagai container setiap widget field dalam form agar pengguna bisa men-scroll seluruh widget jika tidak muat di layar.

## Warna tema

Sesuai dengan nama aplikasi, saya menggunakan warna tema hijau (`Colors.green`).

# Tugas 7

## Apa itu widget tree?

Widget tree merupakan representasi logical dari setiap widget dalam user interface.
Dalam Flutter, children dari suatu widget yaitu widget-widget yang muncul dalam method `build` widget tersebut. Widget parent bertugas mengatur layout dan positioning setiap anaknya.

## Penjelasan widget dalam proyek ini
- **`MyApp` (subclass `StatelessWidget`):** Root widget dari aplikasi Kartuhijau.
- **`MaterialApp`:** Melambangkan aplikasi yang menggunakan design language Material Design. Salah satu property-nya yaitu `home`, widget halaman beranda.
- **`MyHomePage` (subclass `StatefulWidget`):** Melambangkan halaman beranda dalam aplikasi Kartuhijau. Widget ini menempati property `home` di root widget.
- **`Scaffold`:** Widget container dalam Material Design.
- **`AppBar`:** Melambangkan *app bar* Material Design.
- **`Center`:** Merupakan widget *layout* yang berfungsi untuk meletakkan child widget-nya di tengah parent widget ini.
- **`Column`:** Widget ini berfungsi untuk menyusun setiap child-nya sejajar secara horizontal.
- **`ElevatedButton`:** Widget *structural* yang melambangkan tombol yang "menonjol" secara visual.
- **`SnackBar`:** Widget ini merepresentasikan sejenis pesan *toast* yang akan muncul di bagian bawah layar.

## Fungsi widget `MaterialApp`

## `StatelessWidget` vs. `StatefulWidget`

## Apa itu `BuildContext`?

## *Hot reload* vs. *hot restart*

Dalam *hot reload*, Flutter akan memuat perubahan kode ke VM dan me-render ulang seluruh widget **tanpa menghilangkan *state* aplikasi**. *Hot restart* mirip dengan *hot reload*, namun Flutter juga me-restart aplikasi seluruhnya, sehingga *state* aplikasi ikut hilang.
