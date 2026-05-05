import 'package:flutter/material.dart';
import 'package:product_app/core/utils/ui/custom_appbar.dart';
import 'package:product_app/core/utils/ui/custom_scaffold.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppbar(title: 'Cart', showBackButton: false),
      body: Container(),
    );
  }
}
