import 'package:flutter/material.dart';

class AdditionalInfoItem extends StatelessWidget {
  const AdditionalInfoItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(10.0),
      child: const Column(
        children: [
          Icon(
            Icons.air,
            size: 32,
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "Wind Speed",
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "7.67",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
