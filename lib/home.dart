import 'package:debug_auto_complete/views/lists/sales_order_list.dart';
import 'package:flutter/material.dart';

///
///
///
class HomePage extends StatelessWidget {
  ///
  ///
  ///
  const HomePage({super.key});

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => SalesOrderList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
