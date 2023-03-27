import 'package:flutter/material.dart';

class StatsCard extends StatelessWidget {
  final String name;
  final String value;
  final String unit;
  const StatsCard({super.key, required this.name, required this.value, required this.unit});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300]!,
            blurRadius: 5,
            spreadRadius: 4,
            offset: Offset(0, 1),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(name),
          const SizedBox(height: 15),
          Text('$value $unit'),
        ],
      ),
    );
  }
}
