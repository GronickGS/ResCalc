import 'package:flutter/material.dart';

import '../bandas_3.dart';
import '../bandas_4.dart';
import '../bandas_5.dart';


class RoutesPage extends StatelessWidget {
  final int index;
  const RoutesPage({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> myList = [
      BandaTresPage(),
      BandaCuatroPage(),
      BandaCincoPage()
    ];
    return myList[index];
  }
}
