import 'package:flutter/material.dart';
import 'package:kartuhijau/widgets/left_drawer.dart';

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

  final List<(String, String)> _categories = [
    ('consumable', "Consumables"),
    ('equipment', "Equipments"),
    ('tool', "Tools"),
    ('treasure', "Artifacts"),
    ('misc', "Miscellaneous"),
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
      drawer: LeftDrawer(),
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
              onChanged: (String value) {
                setState(() {
                  _name = value;
                });
              },
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Product name cannot be blank.";
                }
                if (value!.length > 255) {
                  return "Product name is too long.";
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
              onChanged: (String value) {
                setState(() {
                  _price = int.tryParse(value) ?? 0;
                });
              },
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
              onChanged: (String value) {
                setState(() {
                  _description = value;
                });
              },
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Product description cannot be blank.";
                }
                return null;
              },
            ),
            // === Thumbnail ===
            TextFormField(
              decoration: InputDecoration(
                hintText: "Enter the thumbnail link...",
                labelText: "Thumbnail",
              ),
              onChanged: (String value) {
                setState(() {
                  _thumbnail = value;
                });
              },
              validator: (String? value) {
                if (value == null) {
                  return "Thumbnail link cannot be null.";
                }
                return null;
              },
            ),
            // === Category ===
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: "Category",
              ),
              value: _category,
              items: _categories
                  .map((cat) => DropdownMenuItem(
                        value: cat.$1,
                        child: Text(cat.$2),
                      ))
                  .toList(),
              onChanged: (String? value) {
                setState(() {
                  _category = value!;
                });
              },
            ),
            // === Is Featured ===
            SwitchListTile(
              title: const Text("Featured product?"),
              value: _isFeatured,
              onChanged: (bool value) {
                setState(() {
                  _isFeatured = value;
                });
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
                    showDialog(
                      context: context,
                      builder: (context) {
                        String categoryReadable = _categories
                            .firstWhere((cat) => (cat.$1 == _category), orElse: () => ('misc', "Miscellaneous"))
                            .$2;
                        return AlertDialog(
                          title: const Text('Successfully created product.'),
                          content: SingleChildScrollView(
                            child: Column(
                              children: [
                                Text('Name: $_name'),
                                Text('Price: $_price'),
                                Text('Description: $_description'),
                                Text('Thumbnail: $_thumbnail'),
                                Text('Category: $categoryReadable'),
                                Text('Featured: ${_isFeatured ? "Yes" : "No"}'),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                    // _formKey.currentState!.reset();
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
