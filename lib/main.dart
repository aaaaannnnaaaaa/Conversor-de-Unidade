import 'package:flutter/material.dart';
import '../screens/converter_screen.dart'; // Importa o arquivo converter_screen.dart

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ConverterScreen(), // Define ConverterScreen como a tela inicial
    );
  }
}
