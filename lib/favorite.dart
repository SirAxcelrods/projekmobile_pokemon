import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Page'),
        backgroundColor: Colors.blue, // Ubah warna latar belakang navbar menjadi biru
      ),
      backgroundColor: Colors.blue, // Ubah warna latar belakang halaman menjadi biru
      body: Center(
        child: Text(
          'Favorite Page Content',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
