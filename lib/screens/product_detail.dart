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
