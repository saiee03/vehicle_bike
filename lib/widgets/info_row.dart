import 'package:flutter/material.dart';

class InfoRow extends StatelessWidget {
  final String label, value;

  const InfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
          Text(value, style: const TextStyle(fontSize: 16, color: Colors.orange)),
        ],
      ),
    );
  }
}
