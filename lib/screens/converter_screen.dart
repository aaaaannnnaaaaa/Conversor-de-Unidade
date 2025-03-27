import 'package:flutter/material.dart';
import '../models/unit.dart';
import '../utils/converter.dart';

class ConverterScreen extends StatefulWidget {
  @override
  _ConverterScreenState createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  String selectedCategory = 'Comprimento';
  Unit? fromUnit;
  Unit? toUnit;
  double inputValue = 0.0;
  double result = 0.0;
  String displayValue = '';
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _updateUnits();
    _controller.text = displayValue;
  }

  void _updateUnits() {
    final category = UnitConverter.categories.firstWhere(
      (cat) => cat.name == selectedCategory,
    );
    setState(() {
      fromUnit = category.units[0];
      toUnit = category.units[1];
    });
  }

  void _convert() {
    if (fromUnit != null && toUnit != null) {
      try {
        setState(() {
          inputValue = double.tryParse(displayValue) ?? 0.0;
          result = UnitConverter.convert(inputValue, fromUnit!, toUnit!);
        });
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Erro: Entrada inválida')));
      }
    }
  }

  void _onKeyPress(String value) {
    setState(() {
      if (value == 'C') {
        displayValue = '';
      } else {
        displayValue += value;
      }
      _controller.text = displayValue;
      inputValue = double.tryParse(displayValue) ?? 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final category = UnitConverter.categories.firstWhere(
      (cat) => cat.name == selectedCategory,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Converter de unidades'),
        backgroundColor: const Color(0xFF253745),
        foregroundColor: const Color(0xFFEEF2FF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF9BA8AB)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Alinha os textos à esquerda
                  children: [
                    const Text(
                      'Quero converter:',
                      style: TextStyle(
                        fontFamily: 'SourceSerif4',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF061416),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF9BA8AB)),
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xFFCCD0CF),
                      ),
                      child: DropdownButton<String>(
                        value: selectedCategory,
                        isExpanded: true,
                        underline: const SizedBox(),
                        items: UnitConverter.categories
                            .map(
                              (cat) => DropdownMenuItem(
                                value: cat.name,
                                child: Text(
                                  cat.name,
                                  style: const TextStyle(
                                    fontFamily: 'SourceSerif4',
                                    color: Color(0xFF061416),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCategory = value!;
                            _updateUnits();
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'De:',
                      style: TextStyle(
                        fontFamily: 'SourceSerif4',
                        fontSize: 16,
                        color: Color(0xFF061416),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF9BA8AB)),
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xFFCCD0CF),
                      ),
                      child: DropdownButton<Unit>(
                        value: fromUnit,
                        isExpanded: true,
                        underline: const SizedBox(),
                        items: category.units
                            .map(
                              (unit) => DropdownMenuItem(
                                value: unit,
                                child: Text(
                                  unit.name,
                                  style: const TextStyle(
                                    fontFamily: 'SourceSerif4',
                                    color: Color(0xFF061416),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) => setState(() => fromUnit = value),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Para:',
                      style: TextStyle(
                        fontFamily: 'SourceSerif4',
                        fontSize: 16,
                        color: Color(0xFF061416),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF9BA8AB)),
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xFFCCD0CF),
                      ),
                      child: DropdownButton<Unit>(
                        value: toUnit,
                        isExpanded: true,
                        underline: const SizedBox(),
                        items: category.units
                            .map(
                              (unit) => DropdownMenuItem(
                                value: unit,
                                child: Text(
                                  unit.name,
                                  style: const TextStyle(
                                    fontFamily: 'SourceSerif4',
                                    color: Color(0xFF061416),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) => setState(() => toUnit = value),
                      ),
                    ),
                    const SizedBox(height: 4),
                    TextField(
                      controller: _controller,
                      readOnly: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFCCD0CF),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFF9BA8AB),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFF9BA8AB),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFF4A5C6A),
                          ),
                        ),
                      ),
                      style: const TextStyle(
                        fontFamily: 'SourceSerif4',
                        color: Color(0xFF061416),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                color: const Color(0xd9d9d9),
                padding: const EdgeInsets.all(8.0),
                child: GridView.count(
                  crossAxisCount: 3,
                  childAspectRatio: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  children: [
                    _buildKey('1'),
                    _buildKey('2'),
                    _buildKey('3'),
                    _buildKey('4'),
                    _buildKey('5'),
                    _buildKey('6'),
                    _buildKey('7'),
                    _buildKey('8'),
                    _buildKey('9'),
                    _buildEnterButton(),
                    _buildKey('0'),
                    _buildDeleteButton(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFCCD0CF).withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.refresh, color: Color(0xFF4A5C6A)),
                  Text(
                    '${result.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontFamily: 'SourceSerif4',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF061416),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKey(String value) {
    return ElevatedButton(
      onPressed: () => _onKeyPress(value),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF9BA8AB),
        foregroundColor: const Color(0xFF061416),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(
        value,
        style: const TextStyle(
          fontFamily: 'SourceSerif4',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildEnterButton() {
    return ElevatedButton(
      onPressed: _convert,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF253745),
        foregroundColor: const Color(0xFFEEF2FF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: const Icon(Icons.check, size: 24),
    );
  }

  Widget _buildDeleteButton() {
    return ElevatedButton(
      onPressed: () => _onKeyPress('C'),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF253745),
        foregroundColor: const Color(0xFFEEF2FF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: const Icon(Icons.close, size: 24),
    );
  }
}