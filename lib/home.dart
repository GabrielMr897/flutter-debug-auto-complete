import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: IconButton(
          icon: Icon(Icons.arrow_forward),
          onPressed: () {
            Navigator.pushNamed(context, '/salesorder');
          },
        ),
      ),
    );
  }
}

class RedirectedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Redirected Page'),
      ),
      body: Center(
        child: Text(
          'This is the redirected page!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
