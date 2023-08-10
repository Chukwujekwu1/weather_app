import 'package:flutter/material.dart';

class HourlyForcastItem extends StatelessWidget {
  final String time;
  final String value;
  final IconData icon;
  const HourlyForcastItem({
    super.key,
    required this.time,
    required this.value,
    required this.icon
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            18,
          ),
        ),
        child: Column(
          children: [
            Text(
              time,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
           Icon(
              icon,
              size: 32,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              value,
            )
          ],
        ),
      ),
    );
  }
}
