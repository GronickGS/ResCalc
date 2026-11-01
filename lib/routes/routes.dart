import 'package:flutter/material.dart';

import '../bandas_3.dart';
import '../bandas_4.dart';
import '../bandas_5.dart';
import '../ley_ohm_page.dart';

class RoutesPage extends StatelessWidget {
  final int index;
  const RoutesPage({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> myList = [
      const BandaTresPage(),
      const BandaCuatroPage(),
      const BandaCincoPage(),
      const LeyOhmPage(),
    ];
    return myList[index];
  }
}
