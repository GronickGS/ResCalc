import 'package:flutter/material.dart';

class LeyOhmPage extends StatefulWidget {
  const LeyOhmPage({super.key});

  @override
  State<LeyOhmPage> createState() => _LeyOhmPageState();
}

class _LeyOhmPageState extends State<LeyOhmPage> {
  int _selectedTab = 0;

  String ejercicioTipo = 'V';
  final TextEditingController valor1Controller = TextEditingController();
  final TextEditingController valor2Controller = TextEditingController();
  String resultadoEjercicio = '';

  String calcularModo = 'V';
  final TextEditingController vController = TextEditingController();
  final TextEditingController iController = TextEditingController();
  final TextEditingController rController = TextEditingController();
  String calculoResultado = '';

  @override
  void dispose() {
    valor1Controller.dispose();
    valor2Controller.dispose();
    vController.dispose();
    iController.dispose();
    rController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildTabs(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(12),
                child: _buildCurrentTab(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[600]!, Colors.purple[600]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Text(
            'Ley de Ohm',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'V = I × R',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Colors.white.withOpacity(0.9),
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Fundamento de la electrónica',
              style: TextStyle(fontSize: 11, color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          _buildTabButton('Teoría', 0, Icons.school),
          _buildTabButton('Ejemplos', 1, Icons.visibility),
          _buildTabButton('Ejercicios', 2, Icons.edit_note),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, int index, IconData icon) {
    final isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.white.withOpacity(0.2)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(26),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: isSelected ? Colors.white : Colors.white54,
              ),
              const SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected ? Colors.white : Colors.white54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentTab() {
    switch (_selectedTab) {
      case 0:
        return _buildTeoria();
      case 1:
        return _buildEjemplos();
      case 2:
        return _buildEjercicios();
      default:
        return _buildTeoria();
    }
  }

  Widget _buildTeoria() {
    return Column(
      children: [
        _buildTeoriaCard('¿Qué es la Ley de Ohm?', Icons.help_outline, [
          'La Ley de Ohm establece que la corriente que fluye a través de un conductor es directamente proporcional al voltaje aplicado e inversamente proporcional a la resistencia.',
          'Fue descubierta por el físico alemán Georg Ohm en 1827 y es la base de toda la electrónica moderna.',
        ]),
        const SizedBox(height: 12),
        _buildFormulaCard(),
        const SizedBox(height: 12),
        _buildTeoriaCard('Triángulo de la Ley de Ohm', Icons.change_circle, [
          'El triángulo es una forma sencilla de recordar las fórmulas:',
          '• V = I × R  (Voltaje = Corriente × Resistencia)',
          '• I = V / R  (Corriente = Voltaje ÷ Resistencia)',
          '• R = V / I  (Resistencia = Voltaje ÷ Corriente)',
        ]),
        const SizedBox(height: 12),
        _buildTeoriaCard('Aplicaciones prácticas', Icons.build, [
          '• Cálculo de resistencias en circuitos electrónicos',
          '• Diseño de fuentes de alimentación',
          '• Protección de componentes electrónicos',
          '• Análisis de fallas en circuitos',
        ]),
        const SizedBox(height: 12),
        _buildCalculadoraInteractiva(),
      ],
    );
  }

  Widget _buildTeoriaCard(String title, IconData icon, List<String> content) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: Colors.blue[400]),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...content.map(
            (text) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '• ',
                    style: TextStyle(color: Colors.blue[400], fontSize: 12),
                  ),
                  Expanded(
                    child: Text(
                      text,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormulaCard() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange[700]!, Colors.deepOrange[700]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            'FÓRMULAS PRINCIPALES',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.white70,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildFormulaItem('V = I × R', 'Voltaje (V)'),
              _buildFormulaItem('I = V / R', 'Corriente (I)'),
              _buildFormulaItem('R = V / I', 'Resistencia (Ω)'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFormulaItem(String formula, String description) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            formula,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: const TextStyle(fontSize: 9, color: Colors.white70),
        ),
      ],
    );
  }

  Widget _buildCalculadoraInteractiva() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.calculate, size: 18, color: Colors.green[400]),
              const SizedBox(width: 8),
              const Text(
                'Calculadora Interactiva',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Calcula cualquier valor ingresando los otros dos:',
            style: TextStyle(fontSize: 11, color: Colors.white54),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildModoButton('Calcular V', 'V'),
              const SizedBox(width: 8),
              _buildModoButton('Calcular I', 'I'),
              const SizedBox(width: 8),
              _buildModoButton('Calcular R', 'R'),
            ],
          ),
          const SizedBox(height: 12),
          if (calcularModo == 'V') ...[
            _buildInputField('Corriente (I) - Amperios', iController),
            const SizedBox(height: 8),
            _buildInputField('Resistencia (R) - Ohmios', rController),
          ] else if (calcularModo == 'I') ...[
            _buildInputField('Voltaje (V) - Voltios', vController),
            const SizedBox(height: 8),
            _buildInputField('Resistencia (R) - Ohmios', rController),
          ] else ...[
            _buildInputField('Voltaje (V) - Voltios', vController),
            const SizedBox(height: 8),
            _buildInputField('Corriente (I) - Amperios', iController),
          ],
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: _calcular,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[600],
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Calcular', style: TextStyle(fontSize: 13)),
          ),
          if (calculoResultado.isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: calculoResultado.contains('Error')
                    ? Colors.red.withOpacity(0.2)
                    : Colors.green.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: calculoResultado.contains('Error')
                      ? Colors.red.withOpacity(0.5)
                      : Colors.green.withOpacity(0.5),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    calculoResultado.contains('Error')
                        ? Icons.error_outline
                        : Icons.check_circle,
                    size: 20,
                    color: calculoResultado.contains('Error')
                        ? Colors.red[400]
                        : Colors.green[400],
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      calculoResultado,
                      style: const TextStyle(fontSize: 13, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildModoButton(String label, String modo) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() {
          calcularModo = modo;
          calculoResultado = '';
        }),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: calcularModo == modo
                ? Colors.blue.withOpacity(0.3)
                : Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: calcularModo == modo
                  ? Colors.blue
                  : Colors.white.withOpacity(0.1),
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: calcularModo == modo ? Colors.white : Colors.white54,
              fontWeight: calcularModo == modo
                  ? FontWeight.w600
                  : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      style: const TextStyle(color: Colors.white, fontSize: 13),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white54, fontSize: 11),
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blue),
        ),
      ),
    );
  }

  void _calcular() {
    setState(() {
      try {
        if (calcularModo == 'V') {
          double i = double.parse(iController.text);
          double r = double.parse(rController.text);
          double v = i * r;
          calculoResultado =
              'V = I × R = $i A × $r Ω = ${v.toStringAsFixed(2)} V';
        } else if (calcularModo == 'I') {
          double v = double.parse(vController.text);
          double r = double.parse(rController.text);
          if (r == 0) {
            calculoResultado = 'Error: La resistencia no puede ser 0';
            return;
          }
          double i = v / r;
          calculoResultado =
              'I = V / R = $v V / $r Ω = ${i.toStringAsFixed(2)} A';
        } else {
          double v = double.parse(vController.text);
          double i = double.parse(iController.text);
          if (i == 0) {
            calculoResultado = 'Error: La corriente no puede ser 0';
            return;
          }
          double r = v / i;
          calculoResultado =
              'R = V / I = $v V / $i A = ${r.toStringAsFixed(2)} Ω';
        }
      } catch (e) {
        calculoResultado = 'Error: Ingresa valores válidos';
      }
    });
  }

  Widget _buildEjemplos() {
    return Column(
      children: [
        _buildEjemploCard(
          'Ejemplo 1: Cálculo de Voltaje',
          'Un circuito tiene una resistencia de 100 Ω y una corriente de 0.5 A. ¿Cuál es el voltaje?',
          'Solución: V = I × R = 0.5 A × 100 Ω = 50 V',
          Icons.bolt,
        ),
        const SizedBox(height: 12),
        _buildEjemploCard(
          'Ejemplo 2: Cálculo de Corriente',
          'Una bombilla de 220 V tiene una resistencia de 1100 Ω. ¿Qué corriente circula?',
          'Solución: I = V / R = 220 V / 1100 Ω = 0.2 A',
          Icons.electrical_services,
        ),
        const SizedBox(height: 12),
        _buildEjemploCard(
          'Ejemplo 3: Cálculo de Resistencia',
          'Un LED funciona con 3 V y 0.02 A. ¿Qué resistencia necesita?',
          'Solución: R = V / I = 3 V / 0.02 A = 150 Ω',
          Icons.tune,
        ),
        const SizedBox(height: 12),
        _buildEjemploCard(
          'Ejemplo 4: Aplicación con Resistencias',
          'Tienes una resistencia de 4 bandas: Marrón, Negro, Rojo, Oro. ¿Cuál es su valor y corriente a 12V?',
          'Valor: 10 × 100 = 1000 Ω (1 kΩ) ±5%\nCorriente: I = V / R = 12V / 1000Ω = 0.012 A (12 mA)',
          Icons.calculate,
        ),
      ],
    );
  }

  Widget _buildEjemploCard(
    String title,
    String problema,
    String solucion,
    IconData icon,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: Colors.orange[400]),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              problema,
              style: const TextStyle(fontSize: 12, color: Colors.white70),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              solucion,
              style: const TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEjercicios() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Resuelve los siguientes ejercicios',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildEjercicioModo('Calcular Voltaje', 'V'),
                  const SizedBox(width: 8),
                  _buildEjercicioModo('Calcular Corriente', 'I'),
                  const SizedBox(width: 8),
                  _buildEjercicioModo('Calcular Resistencia', 'R'),
                ],
              ),
              const SizedBox(height: 16),
              if (ejercicioTipo == 'V') ...[
                _buildEjercicioInput('Corriente (A):', valor1Controller),
                const SizedBox(height: 8),
                _buildEjercicioInput('Resistencia (Ω):', valor2Controller),
                const Text(
                  'Fórmula: V = I × R',
                  style: TextStyle(fontSize: 10, color: Colors.white54),
                ),
              ] else if (ejercicioTipo == 'I') ...[
                _buildEjercicioInput('Voltaje (V):', valor1Controller),
                const SizedBox(height: 8),
                _buildEjercicioInput('Resistencia (Ω):', valor2Controller),
                const Text(
                  'Fórmula: I = V / R',
                  style: TextStyle(fontSize: 10, color: Colors.white54),
                ),
              ] else ...[
                _buildEjercicioInput('Voltaje (V):', valor1Controller),
                const SizedBox(height: 8),
                _buildEjercicioInput('Corriente (A):', valor2Controller),
                const Text(
                  'Fórmula: R = V / I',
                  style: TextStyle(fontSize: 10, color: Colors.white54),
                ),
              ],
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _resolverEjercicio,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple[600],
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Verificar', style: TextStyle(fontSize: 13)),
              ),
              if (resultadoEjercicio.isNotEmpty) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: resultadoEjercicio.contains('Error')
                        ? Colors.red.withOpacity(0.2)
                        : Colors.green.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: resultadoEjercicio.contains('Error')
                          ? Colors.red.withOpacity(0.5)
                          : Colors.green.withOpacity(0.5),
                    ),
                  ),
                  child: Text(
                    resultadoEjercicio,
                    style: const TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 12),
        _buildTipsCard(),
      ],
    );
  }

  Widget _buildEjercicioModo(String label, String modo) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() {
          ejercicioTipo = modo;
          resultadoEjercicio = '';
          valor1Controller.clear();
          valor2Controller.clear();
        }),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: ejercicioTipo == modo
                ? Colors.purple.withOpacity(0.3)
                : Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: ejercicioTipo == modo
                  ? Colors.purple
                  : Colors.white.withOpacity(0.1),
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: ejercicioTipo == modo ? Colors.white : Colors.white54,
              fontWeight: ejercicioTipo == modo
                  ? FontWeight.w600
                  : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEjercicioInput(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      style: const TextStyle(color: Colors.white, fontSize: 13),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white54, fontSize: 11),
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.purple),
        ),
      ),
    );
  }

  void _resolverEjercicio() {
    setState(() {
      try {
        double val1 = double.parse(valor1Controller.text);
        double val2 = double.parse(valor2Controller.text);

        if (ejercicioTipo == 'V') {
          double v = val1 * val2;
          resultadoEjercicio =
              '✅ Resultado: V = $val1 A × $val2 Ω = ${v.toStringAsFixed(2)} V';
        } else if (ejercicioTipo == 'I') {
          if (val2 == 0) {
            resultadoEjercicio = '❌ Error: La resistencia no puede ser 0';
            return;
          }
          double i = val1 / val2;
          resultadoEjercicio =
              '✅ Resultado: I = $val1 V / $val2 Ω = ${i.toStringAsFixed(2)} A';
        } else {
          if (val2 == 0) {
            resultadoEjercicio = '❌ Error: La corriente no puede ser 0';
            return;
          }
          double r = val1 / val2;
          resultadoEjercicio =
              '✅ Resultado: R = $val1 V / $val2 A = ${r.toStringAsFixed(2)} Ω';
        }
      } catch (e) {
        resultadoEjercicio = '❌ Error: Ingresa valores numéricos válidos';
      }
    });
  }

  Widget _buildTipsCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.tips_and_updates, size: 18, color: Colors.yellow[600]),
              const SizedBox(width: 8),
              const Text(
                'Consejos para recordar',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            '• Usa el triángulo mnemotécnico: tapa la letra que quieres calcular\n'
            '• Recuerda: Voltaje = Presión, Corriente = Flujo, Resistencia = Freno\n'
            '• En un circuito en serie, la corriente es la misma en todos los componentes\n'
            '• Las resistencias de colores que calculaste antes siguen esta ley',
            style: TextStyle(fontSize: 11, color: Colors.white70, height: 1.4),
          ),
        ],
      ),
    );
  }
}
