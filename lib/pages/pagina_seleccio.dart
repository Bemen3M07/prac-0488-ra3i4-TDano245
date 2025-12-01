import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/moto_provider.dart';
import '../models/moto.dart';
import 'pagina_resultat.dart';

class PaginaSeleccio extends StatefulWidget {
  const PaginaSeleccio({super.key});

  @override
  State<PaginaSeleccio> createState() => _PaginaSeleccioState();
}

class _PaginaSeleccioState extends State<PaginaSeleccio> {
  Moto? seleccionTemporal;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MotoProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Selecciona una moto")),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButton<Moto>(
              hint: const Text("Escull un model"),
              value: seleccionTemporal,
              isExpanded: true,
              items: provider.motos.map((m) {
                return DropdownMenuItem(
                  value: m,
                  child: Text(m.marcaModelo),
                );
              }).toList(),
              onChanged: (valor) {
                setState(() {
                  seleccionTemporal = valor;
                });
              },
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: seleccionTemporal == null
                  ? null
                  : () {
                      provider.seleccionarMoto(seleccionTemporal!);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PaginaResultat(),
                        ),
                      );
                    },
              child: const Text("Continuar"),
            )
          ],
        ),
      ),
    );
  }
}