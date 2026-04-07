import 'package:flutter/material.dart';

// Constantes centralizadas para 4 bandas
class Resistor4BandConstants {
  static const double defaultTolerance4Band = 20.0;

  static const Map<String, int> digitValues = {
    'Negro': 0,
    'Marrón': 1,
    'Rojo': 2,
    'Naranja': 3,
    'Amarillo': 4,
    'Verde': 5,
    'Azul': 6,
    'Violeta': 7,
    'Gris': 8,
    'Blanco': 9,
  };

  static const Map<String, double> multiplierValues = {
    'Negro': 1,
    'Marrón': 10,
    'Rojo': 100,
    'Naranja': 1000,
    'Amarillo': 10000,
    'Verde': 100000,
    'Azul': 1000000,
    'Violeta': 10000000,
    'Gris': 100000000,
    'Blanco': 1000000000,
    'Oro': 0.1,
    'Plata': 0.01,
  };

  static Color getColorFromValue(dynamic value, {required bool isMultiplier}) {
    if (isMultiplier) {
      switch (value) {
        case 0.1:
          return const Color(0xFFFFD700);
        case 0.01:
          return const Color(0xFFC0C0C0);
        case 1:
          return Colors.black;
        case 10:
          return const Color(0xFF795548);
        case 100:
          return Colors.red;
        case 1000:
          return Colors.orange;
        case 10000:
          return Colors.yellow;
        case 100000:
          return Colors.green;
        case 1000000:
          return Colors.blue;
        case 10000000:
          return const Color(0xFF9C27B0);
        case 100000000:
          return Colors.grey;
        case 1000000000:
          return Colors.white;
        default:
          return Colors.black;
      }
    } else {
      switch (value) {
        case 0:
          return Colors.black;
        case 1:
          return const Color(0xFF795548);
        case 2:
          return Colors.red;
        case 3:
          return Colors.orange;
        case 4:
          return Colors.yellow;
        case 5:
          return Colors.green;
        case 6:
          return Colors.blue;
        case 7:
          return const Color(0xFF9C27B0);
        case 8:
          return Colors.grey;
        case 9:
          return Colors.white;
        default:
          return Colors.black;
      }
    }
  }

  static String formatResistance(double value) {
    if (value >= 1_000_000) {
      return '${(value / 1_000_000).toStringAsFixed(2)} MΩ';
    } else if (value >= 1_000) {
      return '${(value / 1_000).toStringAsFixed(2)} kΩ';
    } else {
      return '${value.toStringAsFixed(2)} Ω';
    }
  }
}

class BandaCuatroPage extends StatefulWidget {
  const BandaCuatroPage({super.key});

  @override
  BandaCuatroPageState createState() => BandaCuatroPageState();
}

class BandaCuatroPageState extends State<BandaCuatroPage> {
  String valorBanda1 = 'Marrón';
  String valorBanda2 = 'Negro';
  String valorBanda3 = 'Rojo';
  String valorBanda4 = 'Oro';

  static const double toleranciaFija = Resistor4BandConstants.defaultTolerance4Band;

  @override
  Widget build(BuildContext context) {
    int banda1 = Resistor4BandConstants.digitValues[valorBanda1] ?? 0;
    int banda2 = Resistor4BandConstants.digitValues[valorBanda2] ?? 0;
    int banda3 = Resistor4BandConstants.digitValues[valorBanda3] ?? 0;
    double multiplicador = Resistor4BandConstants.multiplierValues[valorBanda4] ?? 1;

    double valorNominal = double.parse('$banda1$banda2$banda3') * multiplicador;
    double valorMinimo = valorNominal * (1 - toleranciaFija / 100);
    double valorMaximo = valorNominal * (1 + toleranciaFija / 100);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 12),
              _buildResistorDisplay(),
              _buildCompactBandSelectors(),
              const SizedBox(height: 12),
              _buildResultDisplay(valorNominal, valorMinimo, valorMaximo),
              const SizedBox(height: 12),
              _buildInfoPanel(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        '4 Bandas • Tolerancia ±${toleranciaFija.toStringAsFixed(0)}%',
        style: const TextStyle(
          fontSize: 11,
          color: Colors.white70,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildResistorDisplay() {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 41, 41, 41).withOpacity(0.05),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          const Text(
            'RESISTOR',
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w600,
              color: Colors.white54,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 80,
            child: Center(
              child: CustomPaint(
                size: const Size(280, 80),
                painter: _ResistenciaPainter4Bandas(
                  colorBanda1: Resistor4BandConstants.getColorFromValue(
                    Resistor4BandConstants.digitValues[valorBanda1],
                    isMultiplier: false,
                  ),
                  colorBanda2: Resistor4BandConstants.getColorFromValue(
                    Resistor4BandConstants.digitValues[valorBanda2],
                    isMultiplier: false,
                  ),
                  colorBanda3: Resistor4BandConstants.getColorFromValue(
                    Resistor4BandConstants.digitValues[valorBanda3],
                    isMultiplier: false,
                  ),
                  colorBanda4: Resistor4BandConstants.getColorFromValue(
                    Resistor4BandConstants.multiplierValues[valorBanda4],
                    isMultiplier: true,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactBandSelectors() {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 41, 41, 41).withOpacity(0.05),                                                                                                                 
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const Text(
            'BANDAS',
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w600,
              color: Colors.white54,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 8),
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildCompactSelector(
                      '1',
                      valorBanda1,
                      Resistor4BandConstants.digitValues.keys.toList(),
                      (v) => setState(() => valorBanda1 = v),
                      false,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildCompactSelector(
                      '2',
                      valorBanda2,
                      Resistor4BandConstants.digitValues.keys.toList(),
                      (v) => setState(() => valorBanda2 = v),
                      false,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Expanded(
                    child: _buildCompactSelector(
                      '3',
                      valorBanda3,
                      Resistor4BandConstants.digitValues.keys.toList(),
                      (v) => setState(() => valorBanda3 = v),
                      false,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildCompactSelector(
                      '×',
                      valorBanda4,
                      Resistor4BandConstants.multiplierValues.keys.toList(),
                      (v) => setState(() => valorBanda4 = v),
                      true,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCompactSelector(
    String label,
    String value,
    List<String> values,
    ValueChanged<String> onChanged,
    bool isMultiplier,
  ) {
    // Obtener el color basado en el valor actual
    dynamic currentVal;
    if (isMultiplier) {
      currentVal = Resistor4BandConstants.multiplierValues[value];
    } else {
      currentVal = Resistor4BandConstants.digitValues[value];
    }
    Color bgColor = Resistor4BandConstants.getColorFromValue(
      currentVal,
      isMultiplier: isMultiplier,
    );

    return StatefulBuilder(
      key: ValueKey('$label-$value'),
      builder: (context, setStateLocal) {
        return Container(
          decoration: BoxDecoration(
            color: bgColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: bgColor.withOpacity(0.5), width: 0.8),
          ),
          child: DropdownButton<String>(
            value: value,
            onChanged: (v) {
              onChanged(v!);
              setStateLocal(() {});
            },
            dropdownColor: Colors.grey[850],
            underline: const SizedBox(),
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            isExpanded: true,
            icon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Icon(Icons.arrow_drop_down, color: Colors.white70, size: 16),
              ],
            ),
            iconSize: 0,
            style: const TextStyle(color: Colors.white, fontSize: 11),
            items: values.map((key) {
              dynamic itemVal;
              if (isMultiplier) {
                itemVal = Resistor4BandConstants.multiplierValues[key];
              } else {
                itemVal = Resistor4BandConstants.digitValues[key];
              }
              Color itemColor = Resistor4BandConstants.getColorFromValue(
                itemVal,
                isMultiplier: isMultiplier,
              );

              return DropdownMenuItem(
                value: key,
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: itemColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        key,
                        style: const TextStyle(fontSize: 10),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildResultDisplay(double nominal, double min, double max) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[600]!, Colors.purple[600]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          const Text(
            'VALOR',
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w600,
              color: Colors.white70,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            Resistor4BandConstants.formatResistance(nominal),
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCompactChip('Min', Resistor4BandConstants.formatResistance(min)),
              _buildCompactChip('Max', Resistor4BandConstants.formatResistance(max)),
              _buildCompactChip('±', '${toleranciaFija.toStringAsFixed(0)}%'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCompactChip(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 9, color: Colors.white70)),
        const SizedBox(height: 2),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoPanel() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Icon(Icons.info_outline, size: 12, color: Colors.white54),
          const SizedBox(width: 6),
          const Expanded(
            child: Text(
              '4 bandas: 3 dígitos + multiplicador • Tolerancia 20%',
              style: TextStyle(fontSize: 9, color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}

// Painter compacto para 4 bandas
class _ResistenciaPainter4Bandas extends CustomPainter {
  final Color colorBanda1;
  final Color colorBanda2;
  final Color colorBanda3;
  final Color colorBanda4;

  const _ResistenciaPainter4Bandas({
    required this.colorBanda1,
    required this.colorBanda2,
    required this.colorBanda3,
    required this.colorBanda4,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    paint.color = const Color(0xFFE8D5B5);
    final bodyRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        size.width * 0.1,
        size.height * 0.15,
        size.width * 0.8,
        size.height * 0.7,
      ),
      const Radius.circular(6),
    );
    canvas.drawRRect(bodyRect, paint);

    paint.color = Colors.black.withOpacity(0.08);
    canvas.drawRRect(bodyRect.shift(const Offset(1, 1)), paint);

    final bandWidth = size.width * 0.045;
    final bandHeight = size.height * 0.65;
    double startX = size.width * 0.18;

    paint.color = colorBanda1;
    canvas.drawRect(
      Rect.fromLTWH(startX, size.height * 0.175, bandWidth, bandHeight),
      paint,
    );

    paint.color = colorBanda2;
    canvas.drawRect(
      Rect.fromLTWH(startX + bandWidth * 1.6, size.height * 0.175, bandWidth, bandHeight),
      paint,
    );

    paint.color = colorBanda3;
    canvas.drawRect(
      Rect.fromLTWH(startX + bandWidth * 3.2, size.height * 0.175, bandWidth, bandHeight),
      paint,
    );

    paint.color = colorBanda4;
    canvas.drawRect(
      Rect.fromLTWH(startX + bandWidth * 4.8, size.height * 0.175, bandWidth, bandHeight),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}