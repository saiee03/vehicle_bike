import 'package:flutter/material.dart';
import '../models/bike.dart';
import '../screens/bike_detail_screen.dart';

class BikeSection extends StatelessWidget {
  final String category;
  final List<Bike> bikes;

  const BikeSection({super.key, required this.category, required this.bikes});

  @override
  Widget build(BuildContext context) {
    bool isTrending = category == "Trending";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(category, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.orange)),
        ),
        SizedBox(
          height: isTrending ? 250 : 180, // Bigger container for Trending section
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: bikes.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(
                  builder: (context) => BikeDetailScreen(bike: bikes[index]),
                )),
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: Colors.grey), // Add shadow color amber
                  ),
                  child: Container(
                    width: isTrending ? 220 : 150, // Bigger card for Trending section
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: Image.asset(bikes[index].image, fit: BoxFit.cover)),
                        const SizedBox(height: 5),
                        Text(
                          bikes[index].name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "${bikes[index].price} onwards",
                          textAlign: TextAlign.left,
                          style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                       const SizedBox(height: 5),
                       const SizedBox(height: 5),
ElevatedButton(
  onPressed: () => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => BikeDetailScreen(bike: bikes[index]),
    ),
  ),
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    foregroundColor: Colors.orange, // Text color
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: const BorderSide(color: Colors.orange), // Border color
    ),
  ),
  child: const Text("View More Details"),
),



                   ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
