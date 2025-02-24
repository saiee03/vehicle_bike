import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/bike_provider.dart';
import '../widgets/bike_section.dart';
import '../models/bike.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchQuery = "";
  String selectedCategory = "Trending"; // Default category
  String selectedFilter = "Best Mileage"; // Default filter

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BikeProvider>(context);
    List<String> categories = ["Trending", "Popular", "Electric", "Upcoming"];
    List<String> filters = ["Best Mileage", "Less Mileage", "On-Road Price"];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/logo.png', height: 50),
            const SizedBox(width: 20),
            const Text(
              "Bike Finder",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.orange),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: "Search for bikes...",
                hintStyle: const TextStyle(color: Colors.black),
                prefixIcon: const Icon(Icons.search, color: Colors.black),
                filled: true,
                fillColor: Colors.grey[300],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
              ),
              style: const TextStyle(color: Colors.black),
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
            ),
            const SizedBox(height: 10),

            // Horizontally Scrollable Category List
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  String category = categories[index];
                  bool isSelected = category == selectedCategory;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.red : Colors.grey[300],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          category,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),

            // Bike Section based on selected category
            Expanded(
              child: ListView(
                children: [
                  Builder(
                    builder: (context) {
                      List<Bike> filteredBikes = provider
                          .getBikesByCategory(selectedCategory)
                          .where((bike) => bike.name.toLowerCase().contains(searchQuery))
                          .toList();

                      return filteredBikes.isNotEmpty
                          ? BikeSection(category: selectedCategory, bikes: filteredBikes)
                          : const Center(child: Text("No bikes found", style: TextStyle(color: Colors.black)));
                    },
                  ),
                  const SizedBox(height: 20),

                  // Scrollable Filter Buttons (Best Mileage, Less Mileage, On-Road Price)
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: filters.length,
                      itemBuilder: (context, index) {
                        String filter = filters[index];
                        bool isSelected = filter == selectedFilter;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedFilter = filter;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.green : Colors.grey[300],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                filter,
                                style: TextStyle(
                                  color: isSelected ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Bike Section based on selected filter
                  Builder(
                    builder: (context) {
                      List<Bike> filteredBikes = [];

                      if (selectedFilter == "Best Mileage") {
                        filteredBikes = provider.getBestMileageBikes();
                      } else if (selectedFilter == "Less Mileage") {
                        filteredBikes = provider.getLessMileageBikes(); // FIXED: Changed method name
                      } else {
                        filteredBikes = provider.getBikesByOnRoadPrice();
                      }

                      return filteredBikes.isNotEmpty
                          ? BikeSection(category: selectedFilter, bikes: filteredBikes)
                          : const Center(child: Text("No bikes found", style: TextStyle(color: Colors.black)));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
