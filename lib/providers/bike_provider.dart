import 'package:flutter/material.dart';
import '../models/bike.dart';

class BikeProvider extends ChangeNotifier {
  final List<Bike> _bikes = [
    Bike("Royal Enfield Hunter 350", "assets/hunter.png", "349cc", "36 km/l", "5-speed", "181 kg", "13L", "Trending", "₹1,78,950"),
    Bike("MT15", "assets/MT15.png", "1103cc", "15 km/l", "6-speed", "198 kg", "16L", "Trending", "₹2,50,000"),
    Bike("kawasaki Ninja", "assets/ninja.png", "373cc", "25 km/l", "6-speed", "172 kg", "13.7L", "Trending", "₹3,14,000"),
    Bike("Rider", "assets/apache.png", "1340cc", "17 km/l", "6-speed", "266 kg", "20L", "Trending", "₹16,40,000"),
    Bike("Shine", "assets/shine.png", "999cc", "18 km/l", "6-speed", "197 kg", "16.5L", "Trending", "₹19,75,000"),

    // Popular Bikes
    Bike("Yamaha R15", "assets/yamaha.png", "155cc", "40 km/l", "6-speed", "142 kg", "11L", "Popular", "₹1,57,000"),
    Bike("Honda CB350", "assets/honda_cb350.png", "348cc", "35 km/l", "5-speed", "181 kg", "15L", "Popular", "₹2,10,000"),
    Bike("Bajaj Pulsar NS200", "assets/ninja.png", "199cc", "36 km/l", "6-speed", "159 kg", "12L", "Popular", "₹1,40,000"),
    Bike("Hero Xpulse 200", "assets/gt.png", "199cc", "40 km/l", "5-speed", "157 kg", "13L", "Popular", "₹1,25,000"),

    // Electric Bikes
    Bike("Kawasaki Ninja e-1", "assets/ninja.png", "649cc", "23 km/l", "6-speed", "193 kg", "15L", "Electric", "₹6,50,000"),
    Bike("Revolt RV400", "assets/gt.png", "Electric", "150 km/charge", "Automatic", "108 kg", "Lithium-ion", "Electric", "₹1,25,000"),

    // Upcoming Bikes
    Bike("TVS Apache RR310", "assets/apache.png", "312cc", "30 km/l", "6-speed", "174 kg", "11L", "Upcoming", "₹2,65,000"),
    Bike("Ola S1 Pro Gen2", "assets/honda_cb350.png", "Electric", "181 km/charge", "Automatic", "116 kg", "Lithium-ion", "Upcoming", "₹1,40,000"),
  ];

  /// Get bikes filtered by category
  List<Bike> getBikesByCategory(String category) {
    return _bikes.where((bike) => bike.category == category).toList();
  }

  /// Get bikes with mileage greater than 40 km/l
  List<Bike> getBestMileageBikes() {
    return _bikes.where((bike) => _extractMileage(bike.mileage) > 40).toList();
  }

  /// Get bikes with mileage less than or equal to 40 km/l
  List<Bike> getLessMileageBikes() {
    return _bikes.where((bike) => _extractMileage(bike.mileage) <= 40).toList();
  }

  /// Get bikes sorted by on-road price (ascending)
  List<Bike> getBikesByOnRoadPrice() {
    List<Bike> sortedBikes = List.from(_bikes); // Avoid modifying original list
    sortedBikes.sort((a, b) => _extractPrice(a.price).compareTo(_extractPrice(b.price)));
    return sortedBikes;
  }

  /// Extract numeric mileage from string (e.g., "40 km/l" -> 40)
  int _extractMileage(String mileage) {
    return int.tryParse(mileage.split(" ")[0]) ?? 0;
  }

  /// Extract numeric price from string (e.g., "₹1,40,000" -> 140000)
  int _extractPrice(String price) {
    return int.tryParse(price.replaceAll(RegExp(r'[₹,]'), '')) ?? 0;
  }
}
