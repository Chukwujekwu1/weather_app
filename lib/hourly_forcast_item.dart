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
        padding: const EdgeInsets.all(10.0),
        width: 110,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            18,
          ),
        ),
        child: Column(
          children: [
            Text(
              time,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
           Icon(
              icon,
              size: 40,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
