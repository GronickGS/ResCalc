import 'package:flutter/material.dart';

class NavigationPage extends StatefulWidget {
  final Function currentIndex;
  const NavigationPage({Key? key, required this.currentIndex})
      : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      onTap: (int i) {
        setState(() {
          index = i;
          widget.currentIndex(i);
        });
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xFFA61414),
      unselectedItemColor: Colors.white, // Color de iconos no seleccionados
      iconSize: 25.0,
      selectedFontSize: 15.0,
      unselectedFontSize: 12.0,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.circle), label: '3 bandas'),
        BottomNavigationBarItem(icon: Icon(Icons.square), label: '4 bandas'),
        BottomNavigationBarItem(icon: Icon(Icons.circle), label: '5 bandas'),
      ],
      backgroundColor: const Color.fromARGB(255, 26, 26, 26),
    );
  }
}