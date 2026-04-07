import 'package:flutter/material.dart';
import 'routes/nav.dart';
import 'routes/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Calculadora de Resistencias',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 160, 39, 39), Color.fromARGB(255, 161, 13, 13)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [Colors.grey[850]!, Colors.grey[900]!],
            center: Alignment.center,
            radius: 1.5,
          ),
        ),
        child: RoutesPage(index: _currentIndex),
      ),
      bottomNavigationBar: NavigationPage(
        currentIndex: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}