import 'package:flutter/material.dart';
import 'package:kartuhijau/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    String description = product.description ?? "";
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Column(
          children: [
            Text(
              product.name,
            ),
            Text(
              'Category: ${product.category}',
            ),
            Text(
                description.length > 100
                  ? '${description.substring(0, 100)}...'
                  : description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (product.isFeatured) const Text('Featured'),
          ]
        )
      )
    );
  }
}