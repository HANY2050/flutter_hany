import 'package:flutter/material.dart';
import 'package:generalshops/product/product.dart';

class SizeColor extends StatefulWidget {
  // const SizeColor({Key? key}) : super(key: key);
  final Product product;

  SizeColor(this.product);
  @override
  _SizeColorState createState() => _SizeColorState();
}

class _SizeColorState extends State<SizeColor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.size1),
      ),
    );
  }
}
