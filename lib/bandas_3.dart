import 'package:flutter/material.dart';

// Constantes centralizadas
class ResistorConstants {
  static const double defaultTolerance3Band =
      20.0; // 3 bandas = 20% por defecto

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
          return const Color(0xFFFFD700); // Oro
        case 0.01:
          return const Color(0xFFC0C0C0); // Plata
        case 1:
          return Colors.black;
        case 10:
          return const Color(0xFF795548); // Marrón
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
          return const Color(0xFF9C27B0); // Violeta
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
          return const Color(0xFF795548); // Marrón
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
          return const Color(0xFF9C27B0); // Violeta
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

class BandaTresPage extends StatefulWidget {
  const BandaTresPage({super.key});

  @override
  BandaTresPageState createState() => BandaTresPageState();
}

class BandaTresPageState extends State<BandaTresPage> {
  String valorBanda1 = 'Marrón';
  String valorBanda2 = 'Negro';
  String valorBanda3 = 'Rojo';

  // Tolerancia fija para 3 bandas
  static const double toleranciaFija = ResistorConstants.defaultTolerance3Band;

  @override
  Widget build(BuildContext context) {
    int banda1 = ResistorConstants.digitValues[valorBanda1] ?? 0;
    int banda2 = ResistorConstants.digitValues[valorBanda2] ?? 0;
    double multiplicador = ResistorConstants.multiplierValues[valorBanda3] ?? 1;

    double valorNominal = double.parse('$banda1$banda2') * multiplicador;
    double valorMinimo = valorNominal * (1 - toleranciaFija / 100);
    double valorMaximo = valorNominal * (1 + toleranciaFija / 100);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Header con gradiente sutil
              _buildHeader(),
              const SizedBox(height: 24),

              // Visualización del resistor
              _buildResistorDisplay(),
              const SizedBox(height: 24),

              // Selectores estilo iOS
              _buildIOSStyleBandSelectors(),
              const SizedBox(height: 24),

              // Resultados
              _buildResultDisplay(valorNominal, valorMinimo, valorMaximo),
              const SizedBox(height: 20),

              // Info panel minimalista
              _buildInfoPanel(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'Tolerancia fija: ±${toleranciaFija.toStringAsFixed(0)}%',
            style: const TextStyle(
              fontSize: 13,
              color: Colors.white70,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResistorDisplay() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const Text(
            'REPRESENTACIÓN',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.white54,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 100,
            child: Center(
              child: CustomPaint(
                size: const Size(280, 120),
                painter: _ResistenciaPainter3Bandas(
                  colorBanda1: ResistorConstants.getColorFromValue(
                    ResistorConstants.digitValues[valorBanda1],
                    isMultiplier: false,
                  ),
                  colorBanda2: ResistorConstants.getColorFromValue(
                    ResistorConstants.digitValues[valorBanda2],
                    isMultiplier: false,
                  ),
                  colorBanda3: ResistorConstants.getColorFromValue(
                    ResistorConstants.multiplierValues[valorBanda3],
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

  Widget _buildIOSStyleBandSelectors() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            'CONFIGURACIÓN',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.white54,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildIOSSelector(
                  title: '1ª Banda',
                  value: valorBanda1,
                  values: ResistorConstants.digitValues.keys.toList(),
                  onChanged: (value) => setState(() => valorBanda1 = value),
                  color: ResistorConstants.getColorFromValue(
                    ResistorConstants.digitValues[valorBanda1],
                    isMultiplier: false,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildIOSSelector(
                  title: '2ª Banda',
                  value: valorBanda2,
                  values: ResistorConstants.digitValues.keys.toList(),
                  onChanged: (value) => setState(() => valorBanda2 = value),
                  color: ResistorConstants.getColorFromValue(
                    ResistorConstants.digitValues[valorBanda2],
                    isMultiplier: false,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildIOSSelector(
                  title: 'Multiplicador',
                  value: valorBanda3,
                  values: ResistorConstants.multiplierValues.keys.toList(),
                  onChanged: (value) => setState(() => valorBanda3 = value),
                  color: ResistorConstants.getColorFromValue(
                    ResistorConstants.multiplierValues[valorBanda3],
                    isMultiplier: true,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIOSSelector({
    required String title,
    required String value,
    required List<String> values,
    required ValueChanged<String> onChanged,
    required Color color,
  }) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: color.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.5)),
          ),
          child: DropdownButton<String>(
            value: value,
            onChanged: (v) => onChanged(v!),
            dropdownColor: Colors.grey[850],
            underline: const SizedBox(),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            isExpanded: true,
            icon: Icon(Icons.arrow_drop_down, color: Colors.white70, size: 20),
            style: const TextStyle(color: Colors.white, fontSize: 13),
            items: values.map((key) {
              return DropdownMenuItem(
                value: key,
                child: Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: ResistorConstants.getColorFromValue(
                          ResistorConstants.digitValues.containsKey(key)
                              ? ResistorConstants.digitValues[key]
                              : ResistorConstants.multiplierValues[key],
                          isMultiplier: !ResistorConstants.digitValues
                              .containsKey(key),
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        key,
                        style: const TextStyle(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
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
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Text(
            'VALOR CALCULADO',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.white70,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            ResistorConstants.formatResistance(nominal),
            style: const TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildResultChip(
                'Mínimo',
                ResistorConstants.formatResistance(min),
              ),
              _buildResultChip(
                'Máximo',
                ResistorConstants.formatResistance(max),
              ),
              _buildResultChip(
                'Tolerancia',
                '±${toleranciaFija.toStringAsFixed(0)}%',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildResultChip(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Colors.white70),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 12,
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
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, size: 16, color: Colors.white54),
              const SizedBox(width: 8),
              const Text(
                'INFORMACIÓN',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Colors.white54,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Las resistencias de 3 bandas tienen una tolerancia fija del 20%. '
            'Las primeras dos bandas representan dígitos y la tercera es el multiplicador.',
            style: TextStyle(fontSize: 12, color: Colors.white70, height: 1.4),
          ),
        ],
      ),
    );
  }
}

// Painter personalizado para 3 bandas
class _ResistenciaPainter3Bandas extends CustomPainter {
  final Color colorBanda1;
  final Color colorBanda2;
  final Color colorBanda3;

  const _ResistenciaPainter3Bandas({
    required this.colorBanda1,
    required this.colorBanda2,
    required this.colorBanda3,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Cuerpo del resistor (beige claro estilo real)
    paint.color = const Color(0xFFE8D5B5);
    final bodyRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        size.width * 0.15,
        size.height * 0.2,
        size.width * 0.7,
        size.height * 0.6,
      ),
      const Radius.circular(8),
    );
    canvas.drawRRect(bodyRect, paint);

    // Sombras para efecto 3D
    paint.color = Colors.black.withOpacity(0.1);
    canvas.drawRRect(bodyRect.shift(const Offset(2, 2)), paint);

    // Bandas
    final bandWidth = size.width * 0.07;
    final bandHeight = size.height * 0.55;
    double startX = size.width * 0.28;

    paint.color = colorBanda1;
    canvas.drawRect(
      Rect.fromLTWH(startX, size.height * 0.225, bandWidth, bandHeight),
      paint,
    );

    paint.color = colorBanda2;
    canvas.drawRect(
      Rect.fromLTWH(
        startX + bandWidth * 1.8,
        size.height * 0.225,
        bandWidth,
        bandHeight,
      ),
      paint,
    );

    paint.color = colorBanda3;
    canvas.drawRect(
      Rect.fromLTWH(
        startX + bandWidth * 3.6,
        size.height * 0.225,
        bandWidth,
        bandHeight,
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
