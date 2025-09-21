import 'package:flutter/material.dart';

// Color value maps
final Map<String, int> colorValuesBanda1 = {
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

final Map<String, int> colorValuesBanda2 = {
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

final Map<String, int> multiplierValues = {
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
  'Oro': 10,
  'Plata': 100,
};

final Map<String, double> toleranceValues = {
  'Marrón': 1.0,
  'Rojo': 2.0,
  'Verde': 0.5,
  'Azul': 0.25,
  'Violeta': 0.1,
  'Gris': 0.05,
  'Oro': 5.0,
  'Plata': 10.0,
};

class BandaTresPage extends StatefulWidget {
  const BandaTresPage({super.key});

  @override
  BandaTresPageState createState() => BandaTresPageState();
}

class BandaTresPageState extends State<BandaTresPage> {
  String valorBanda1 = 'Marrón';
  String valorBanda2 = 'Negro';
  String valorBanda3 = 'Rojo';

  @override
  Widget build(BuildContext context) {
    int banda1 = colorValuesBanda1[valorBanda1] ?? 0;
    int banda2 = colorValuesBanda2[valorBanda2] ?? 0;
    int multiplicador = multiplierValues[valorBanda3] ?? 0;
    double tolerancia = toleranceValues[valorBanda3] ?? 5.0;

    int valorNominal = int.parse('$banda1$banda2', radix: 10) * multiplicador;
    double valorMinimo = valorNominal * (1 - tolerancia / 100);
    double valorMaximo = valorNominal * (1 + tolerancia / 100);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildResistorDisplay(tolerancia),
            const SizedBox(height: 20),
            _buildBandSelectors(),
            const SizedBox(height: 20),
            _buildResultDisplay(valorNominal, valorMinimo, valorMaximo, tolerancia),
            const SizedBox(height: 20),
            _buildInfoPanel(),
          ],
        ),
      ),
    );
  }

  Widget _buildResistorDisplay(double tolerancia) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
          children: [
            const Text(
              'REPRESENTACIÓN DEL RESISTOR',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 10),
            _buildResistenciaWidget(
              colorBanda1: getColorFromValue(
                colorValuesBanda1[valorBanda1],
                'banda1',
              ),
              colorBanda2: getColorFromValue(
                colorValuesBanda2[valorBanda2],
                'banda2',
              ),
              colorBanda3: getColorFromValue(
                multiplierValues[valorBanda3],
                'banda3',
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Tolerancia: ±$tolerancia%',
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ),
        )
      ),
    );
  }

  Widget _buildResistenciaWidget({
    required Color colorBanda1,
    required Color colorBanda2,
    required Color colorBanda3,
  }) {
    return CustomPaint(
      size: const Size(250, 120),
      painter: _ResistenciaPainter(
        colorBanda1: colorBanda1,
        colorBanda2: colorBanda2,
        colorBanda3: colorBanda3,
      ),
    );
  }

  Widget _buildBandSelectors() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
          children: [
            const Text(
              'SELECCIONA LOS COLORES DE LAS BANDAS',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 10,
              runSpacing: 15,
              children: [
                _buildBandSelector('1ª Banda', colorValuesBanda1, (value) {
                  setState(() => valorBanda1 = value);
                }, valorBanda1, Icons.looks_one),
                _buildBandSelector('2ª Banda', colorValuesBanda2, (value) {
                  setState(() => valorBanda2 = value);
                }, valorBanda2, Icons.looks_two),
                _buildBandSelector('Multiplicador', multiplierValues, (value) {
                  setState(() => valorBanda3 = value);
                }, valorBanda3, Icons.close),
              ],
            ),
          ],
        ),
        )
      ),
    );
  }

  Widget _buildBandSelector(
    String title,
    Map<String, int> values,
    ValueChanged<String> onChanged,
    String currentValue,
    IconData icon,
  ) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 43, 43, 43),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white70, size: 16),
              const SizedBox(width: 5),
              Text(
                title,
                style: const TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: getColorFromValue(values[currentValue], title.contains('Multiplicador') ? 'banda3' : 'banda'),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButton<String>(
              isExpanded: true,
              value: currentValue,
              onChanged: (String? value) => onChanged(value!),
              dropdownColor: Colors.grey[900],
              underline: const SizedBox(),
              icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
              style: const TextStyle(color: Colors.white, fontSize: 14),
              items: values.keys.map((String key) {
                return DropdownMenuItem<String>(
                  value: key,
                  child: Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: getColorFromValue(values[key], title.contains('Multiplicador') ? 'banda3' : 'banda'),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white30),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(key, style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultDisplay(int valorNominal, double valorMinimo, double valorMaximo, double tolerancia) {
    String formattedValue = _formatResistanceValue(valorNominal);
    
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: const Color.fromARGB(255, 43, 43, 43),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'VALOR DE LA RESISTENCIA',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              formattedValue,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildToleranceBox('Mínimo', '${_formatResistanceValue(valorMinimo.toInt())}'),
                _buildToleranceBox('Máximo', '${_formatResistanceValue(valorMaximo.toInt())}'),
                _buildToleranceBox('Tolerancia', '±$tolerancia%'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToleranceBox(String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 30, 30, 30),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoPanel() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'INFORMACIÓN SOBRE RESISTENCIAS DE 3 BANDAS',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 16),
            _buildInfoItem('Código de colores', 'Las resistencias de 3 bandas usan un código de colores para indicar su valor. Las primeras dos bandas son dígitos y la tercera es el multiplicador. No incluyen banda de tolerancia, por lo que generalmente tienen una tolerancia del 20%.'),
            _buildInfoItem('Limitaciones', 'A diferencia de las resistencias de 4 bandas, las de 3 bandas no especifican tolerancia, lo que las hace menos precisas para aplicaciones críticas.'),
            _buildInfoItem('Uso común', 'Estas resistencias se utilizan comúnmente en circuitos donde la precisión no es crítica, como en fuentes de alimentación básicas o circuitos de polarización.'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            content,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }

  String _formatResistanceValue(int value) {
    if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(2)} MΩ';
    } else if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(2)} kΩ';
    } else {
      return '$value Ω';
    }
  }

  Color getColorFromValue(int? value, String bandType) {
    if (bandType == 'banda3') {
      switch (value) {
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
}

class _ResistenciaPainter extends CustomPainter {
  final Color colorBanda1;
  final Color colorBanda2;
  final Color colorBanda3;

  _ResistenciaPainter({
    required this.colorBanda1,
    required this.colorBanda2,
    required this.colorBanda3,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;

    // Draw leads
    paint.color = Colors.grey;
    canvas.drawRect(
      Rect.fromLTWH(0, size.height * 0.4, size.width * 0.15, size.height * 0.2),
      paint,
    );
    canvas.drawRect(
      Rect.fromLTWH(
        size.width * 0.85,
        size.height * 0.4,
        size.width * 0.15,
        size.height * 0.2,
      ),
      paint,
    );

    // Draw resistor body
    paint.color = Colors.brown[300]!;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.15,
          size.height * 0.2,
          size.width * 0.7,
          size.height * 0.6,
        ),
        const Radius.circular(10),
      ),
      paint,
    );

    // Draw bands
    final bandWidth = size.width * 0.05;
    final bandHeight = size.height * 0.6;
    final startX = size.width * 0.25;

    // Band 1
    paint.color = colorBanda1;
    canvas.drawRect(
      Rect.fromLTWH(startX, size.height * 0.2, bandWidth, bandHeight),
      paint,
    );

    // Band 2
    paint.color = colorBanda2;
    canvas.drawRect(
      Rect.fromLTWH(
        startX + bandWidth * 2,
        size.height * 0.2,
        bandWidth,
        bandHeight,
      ),
      paint,
    );

    // Band 3 (multiplier)
    paint.color = colorBanda3;
    canvas.drawRect(
      Rect.fromLTWH(
        startX + bandWidth * 4,
        size.height * 0.2,
        bandWidth,
        bandHeight,
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}