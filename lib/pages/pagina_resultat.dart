import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/moto_provider.dart';

class PaginaResultat extends StatefulWidget {
  const PaginaResultat({super.key});

  @override
  State<PaginaResultat> createState() => _PaginaResultatState();
}

class _PaginaResultatState extends State<PaginaResultat> {
  final controladorInicials = TextEditingController();
  final controladorActuals = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MotoProvider>();
    final moto = provider.motoSeleccionada!;

    return Scaffold(
      appBar: AppBar(title: const Text("Dades de la moto")),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              moto.marcaModelo,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            Text("Dipòsit: ${moto.fuelTankLiters} L"),
            Text("Consum: ${moto.consumptionL100} L/100km"),
            Text("Autonomia total: ${moto.autonomiaKm().toStringAsFixed(1)} km"),

            const SizedBox(height: 20),

            TextField(
              controller: controladorInicials,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: "Km quan vas omplir el dipòsit",
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: controladorActuals,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: "Km actuals",
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                final ini = double.tryParse(controladorInicials.text);
                final act = double.tryParse(controladorActuals.text);

                if (ini == null || act == null) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Introdueix nombres vàlids per als km.'),
                    duration: Duration(seconds: 2),
                  ));
                  return;
                }

                if (ini < 0 || act < 0) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Els km no poden ser negatius.'),
                    duration: Duration(seconds: 2),
                  ));
                  return;
                }

                if (act < ini) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Els km actuals han de ser >= km inicials.'),
                    duration: Duration(seconds: 2),
                  ));
                  return;
                }

                provider.setKmInicials(ini);
                provider.setKmActuals(act);
                setState(() {});
              },
              child: const Text("Calcular"),
            ),

            const SizedBox(height: 20),

            const Text("Quilòmetres restants:",
                style: TextStyle(fontSize: 18)),

            Text(
              "${provider.quilometresRestants().toStringAsFixed(1)} km",
              style: const TextStyle(
                  fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}