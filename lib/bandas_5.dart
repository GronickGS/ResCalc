import 'package:flutter/material.dart';

class BandaCincoPage extends StatefulWidget {
  const BandaCincoPage({super.key});

  @override
  BandaCincoPageState createState() => BandaCincoPageState();
}

class BandaCincoPageState extends State<BandaCincoPage> {
  String valorBanda1 = 'Marrón';
  String valorBanda2 = 'Negro';
  String valorBanda3 = 'Negro';
  String valorBanda4 = 'Rojo';
  String valorBanda5 = 'Oro';

  @override
  Widget build(BuildContext context) {
    int banda1 = colorValuesBanda1[valorBanda1] ?? 0;
    int banda2 = colorValuesBanda2[valorBanda2] ?? 0;
    int banda3 = colorValuesBanda3[valorBanda3] ?? 0;
    int multiplicador = multiplierValues[valorBanda4] ?? 0;
    double tolerancia = toleranceValues[valorBanda5] ?? 5.0;

    int valorNominal = int.parse('$banda1$banda2$banda3', radix: 10) * multiplicador;
    double valorMinimo = valorNominal * (1 - tolerancia / 100);
    double valorMaximo = valorNominal * (1 + tolerancia / 100);

    return Scaffold(
      
      body: Container(
        decoration: BoxDecoration(
          
        ),
        child: SingleChildScrollView(
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
              colorBanda1: getColorFromBand(colorValuesBanda1[valorBanda1], '1ª Banda'),
              colorBanda2: getColorFromBand(colorValuesBanda2[valorBanda2], '2ª Banda'),
              colorBanda3: getColorFromBand(colorValuesBanda3[valorBanda3], '3ª Banda'),
              colorBanda4: getColorFromBand(multiplierValues[valorBanda4], 'Multiplicador'),
              colorBanda5: getColorFromBand(toleranceValues[valorBanda5], 'Tolerancia'),
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
    required Color colorBanda4,
    required Color colorBanda5,
  }) {
    return CustomPaint(
      size: const Size(280, 120),
      painter: _ResistenciaPainter(
        colorBanda1: colorBanda1,
        colorBanda2: colorBanda2,
        colorBanda3: colorBanda3,
        colorBanda4: colorBanda4,
        colorBanda5: colorBanda5,
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
                _buildBandSelector('3ª Banda', colorValuesBanda3, (value) {
                  setState(() => valorBanda3 = value);
                }, valorBanda3, Icons.looks_3),
                _buildBandSelector('Multiplicador', multiplierValues, (value) {
                  setState(() => valorBanda4 = value);
                }, valorBanda4, Icons.close),
                _buildBandSelector('Tolerancia', toleranceValues, (value) {
                  setState(() => valorBanda5 = value);
                }, valorBanda5, Icons.percent),
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
    Map<String, dynamic> values,
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
              color: getColorFromBand(values[currentValue], title),
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
                          color: getColorFromBand(values[key], title),
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
              'INFORMACIÓN SOBRE RESISTENCIAS DE 5 BANDAS',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 16),
            _buildInfoItem('Código de colores', 'Las resistencias de 5 bandas son más precisas. Las primeras tres bandas son dígitos significativos, la cuarta es el multiplicador y la quinta es la tolerancia.'),
            _buildInfoItem('Mayor precisión', 'Al tener tres dígitos significativos en lugar de dos, las resistencias de 5 bandas ofrecen valores más precisos y una gama más amplia de valores posibles.'),
            _buildInfoItem('Aplicaciones', 'Se utilizan en aplicaciones donde se requiere alta precisión, como instrumentación médica, equipos de medición y circuitos de precisión.'),
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

  Color getColorFromBand(dynamic value, String title) {
    if (title == 'Tolerancia') {
      switch (value) {
        case 1.0: return const Color(0xFF795548); // Marrón
        case 2.0: return Colors.red;
        case 0.5: return Colors.green;
        case 0.25: return Colors.blue;
        case 0.1: return const Color(0xFF9C27B0); // Violeta
        case 0.05: return Colors.grey;
        case 5.0: return const Color(0xFFFFD700); // Oro
        case 10.0: return const Color(0xFFC0C0C0); // Plata
        default: return Colors.black;
      }
    } else if (title == 'Multiplicador') {
      switch (value) {
        case 1: return Colors.black;
        case 10: return const Color(0xFF795548); // Marrón
        case 100: return Colors.red;
        case 1000: return Colors.orange;
        case 10000: return Colors.yellow;
        case 100000: return Colors.green;
        case 1000000: return Colors.blue;
        case 10000000: return const Color(0xFF9C27B0); // Violeta
        case 100000000: return Colors.grey;
        case 1000000000: return Colors.white;
        default: return Colors.black;
      }
    } else {
      switch (value) {
        case 0: return Colors.black;
        case 1: return const Color(0xFF795548); // Marrón
        case 2: return Colors.red;
        case 3: return Colors.orange;
        case 4: return Colors.yellow;
        case 5: return Colors.green;
        case 6: return Colors.blue;
        case 7: return const Color(0xFF9C27B0); // Violeta
        case 8: return Colors.grey;
        case 9: return Colors.white;
        default: return Colors.black;
      }
    }
  }
}

class _ResistenciaPainter extends CustomPainter {
  final Color colorBanda1;
  final Color colorBanda2;
  final Color colorBanda3;
  final Color colorBanda4;
  final Color colorBanda5;

  _ResistenciaPainter({
    required this.colorBanda1,
    required this.colorBanda2,
    required this.colorBanda3,
    required this.colorBanda4,
    required this.colorBanda5,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;

    // Draw leads
    paint.color = Colors.grey;
    canvas.drawRect(
      Rect.fromLTWH(0, size.height * 0.4, size.width * 0.1, size.height * 0.2),
      paint,
    );
    canvas.drawRect(
      Rect.fromLTWH(
        size.width * 0.9,
        size.height * 0.4,
        size.width * 0.1,
        size.height * 0.2,
      ),
      paint,
    );

    // Draw resistor body
    paint.color = Colors.brown[300]!;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.1,
          size.height * 0.2,
          size.width * 0.8,
          size.height * 0.6,
        ),
        const Radius.circular(10),
      ),
      paint,
    );

    // Draw bands
    final bandWidth = size.width * 0.035;
    final bandHeight = size.height * 0.6;
    final startX = size.width * 0.2;

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

    // Band 3
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

    // Band 4 (multiplier)
    paint.color = colorBanda4;
    canvas.drawRect(
      Rect.fromLTWH(
        startX + bandWidth * 6,
        size.height * 0.2,
        bandWidth,
        bandHeight,
      ),
      paint,
    );

    // Band 5 (tolerance)
    paint.color = colorBanda5;
    canvas.drawRect(
      Rect.fromLTWH(
        startX + bandWidth * 8,
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

// Mapas de valores para las bandas
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

final Map<String, int> colorValuesBanda3 = {
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