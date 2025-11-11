import 'package:flutter/material.dart';

class ProductFormPage extends StatefulWidget {

  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();

}

class _ProductFormPageState extends State<ProductFormPage> {

  final _formKey = GlobalKey<FormState>();

  String _name = "";
  int _price = 0;
  String _description = "";
  String _thumbnail = "";
  String _category = "misc";
  bool _isFeatured = false;

  final List<String> _categories = [
    'consumable',
    'equipment',
    'tool',
    'treasure',
    'misc',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Create Product'
          ),
        ),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            // === Name ===
            TextFormField(
              decoration: InputDecoration(
                hintText: "Enter the product name...",
                labelText: "Product Name",
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Product name cannot be blank.";
                }
                return null;
              },
            ),
            // === Price ===
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter the product price...",
                labelText: "Product Price",
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Product price cannot be blank.";
                }
                int? valueInt = int.tryParse(value);
                if (valueInt == null) {
                  return "Product price must be an integer.";
                }
                if (valueInt! < 0) {
                  return "Product price cannot be negative.";
                }
                return null;
              },
            ),
            // === Description ===
            TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                hintText: "Enter the product description...",
                labelText: "Product Description",
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Product description cannot be blank.";
                }
                return null;
              },
            ),
            // === Save Button ===
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.reset();
                  }
                },
                child: const Text(
                  "Save",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
