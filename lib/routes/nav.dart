import 'package:flutter/material.dart';

class NavigationPage extends StatefulWidget {
  final Function(int) currentIndex;
  const NavigationPage({Key? key, required this.currentIndex})
      : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int index = 0;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      // 👇 FONDO VERDE DETRÁS (CAMBIA AQUÍ EL COLOR)
      color: const Color.fromARGB(255, 41, 41, 41), // ← CAMBIA ESTE COLOR AL QUE QUIERAS
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: const BoxDecoration(
            // 👇 GRADIENTE DEL BOTTOM NAV BAR (ROJO)
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 160, 39, 39), Color.fromARGB(255, 161, 13, 13)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: BottomNavigationBar(
            currentIndex: index,
            onTap: (int i) {
              setState(() {
                index = i;
                widget.currentIndex(i);
              });
            },
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white70,
            iconSize: 24,
            selectedFontSize: 11,
            unselectedFontSize: 11,
            backgroundColor: Colors.transparent,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.filter_3), 
                label: '3 Bandas'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.filter_4), 
                label: '4 Bandas'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.filter_5), 
                label: '5 Bandas'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bolt), 
                label: 'Ley Ohm'
              ),
            ],
          ),
        ),
      ),
    );
  }
}