class Moto {
  final String marcaModelo;
  final double fuelTankLiters; // Depósito en litros
  final double consumptionL100; // Consumo en Litros por 100km

  Moto({
    required this.marcaModelo,
    required this.fuelTankLiters,
    required this.consumptionL100,
  });

  double autonomiaKm() {
    // autonomía = (litros / consumo) * 100
    return (fuelTankLiters / consumptionL100) * 100;
  }
}
