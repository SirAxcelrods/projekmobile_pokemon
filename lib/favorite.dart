import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Page'),
        backgroundColor: Colors.red,
      ),
      backgroundColor: Colors.red,
      body: Center(
        child: Text(
          'Favorite Page Content',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
