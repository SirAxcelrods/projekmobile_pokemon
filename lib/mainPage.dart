import 'package:flutter/material.dart';
import 'API/API.dart';
import 'mainCardContainer.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'detailSets.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Future<List<dynamic>> _sets;

  @override
  void initState() {
    super.initState();
    _sets = _fetchSets();
  }

  Future<List<dynamic>> _fetchSets() async {
    final response = await http.get(Uri.parse('$API_LINK/sets'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load sets');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'POKÉMON',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true, // Centering the text
        backgroundColor: Colors.red,
      ),
      backgroundColor: Colors.red,
      body: FutureBuilder<List<dynamic>>(
        future: _sets,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final set = snapshot.data![index];
                  final logoUrl = set['logo'] ?? '';
                  final symbolUrl = set['symbol'] ?? '';
                  return GestureDetector(
                    onTap: () {
                      // Navigate to DetailSetsPage when a card is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailSetsPage(setId: set['id']),
                        ),
                      );
                    },
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: MainCardContainer(
                        id: set['id'],
                        logoUrl: logoUrl,
                        name: set['name'],
                        total: set['cardCount']['total'],
                        symbolUrl: symbolUrl,
                      ),
                      onPressed: () {
                        // Animasi sederhana saat kartu diklik
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 300),
                            pageBuilder: (_, __, ___) => DetailSetsPage(setId: set['id']),
                            transitionsBuilder: (_, animation, __, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );

  }
}

