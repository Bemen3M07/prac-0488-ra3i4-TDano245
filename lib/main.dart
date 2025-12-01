import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/moto_provider.dart';
import 'pages/pagina_seleccio.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => MotoProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Examen Motos",
      home: const PaginaSeleccio(),
    );
  }
}