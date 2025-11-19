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
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder(
        future: fetchProducts(pdjau),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData) {
              return Center(
                child: Text(
                  'There are no products yet.'
                ),
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
