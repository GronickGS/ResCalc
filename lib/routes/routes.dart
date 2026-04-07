import 'package:flutter/material.dart';

import '../bandas_3.dart';
import '../bandas_4.dart';
import '../bandas_5.dart';
import '../ley_ohm_page .dart'; // ← Importar Ley de Ohm

class RoutesPage extends StatelessWidget {
  final int index;
  const RoutesPage({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> myList = [
      const BandaTresPage(),
      const BandaCuatroPage(),
      const BandaCincoPage(),
      const LeyOhmPage(), // ← Agregar Ley de Ohm
    ];
    return myList[index];
  }
}