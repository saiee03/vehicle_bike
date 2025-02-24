import 'package:flutter/material.dart';

class VehicleColor {
  static const Color green = Color(0xFF4CAF50); // Fuel Efficient & Low Pollutant
  static const Color amber = Color(0xFFFFA726); // Fuel Efficient but Moderately Pollutant
  static const Color red = Color(0xFFD32F2F);   // Not Fuel Efficient & High Pollutant

  static Color getVehicleColor(double mileage, int age) {
    if (mileage >= 15) {
      return (age <= 5) ? green : amber;
    } else {
      return red;
    }
  }
}
