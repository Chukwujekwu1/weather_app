import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/secret.dart';

import 'additional_info_item.dart';
import 'hourly_forcast_item.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    getCurrentWeather();
  }
  Future getCurrentWeather() async {
    try {
       String cityName = "Nigeria";
    final res = await http.get(
      Uri.parse(
        "https://api.openweathermap.org/data/2.5/forecast?q=$cityName,africa&APPID=$openWeatherApiKey",
      ),
    );
   final data =  jsonDecode(res.body);
   if (data['cod'] != "200") {
     throw "An unexpected erroe occurred"
   }
    } catch (e) {
      throw e.toString();
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Weather App",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // main card
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 10,
                      sigmaY: 10,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            "300°K ",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Icon(
                            Icons.cloud,
                            size: 64,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Rain",
                            style: TextStyle(
                              fontSize: 21,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            // weather forcast card
            const Text(
              "Weather Forcast",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            //
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  HourlyForcastItem(
                    time: "09:00",
                    value: "201.17",
                    icon: Icons.cloud,
                  ),
                  HourlyForcastItem(
                    time: "12:00",
                    value: "201.54",
                    icon: Icons.sunny,
                  ),
                  HourlyForcastItem(
                    time: "15:00",
                    value: "301.11",
                    icon: Icons.water,
                  ),
                  HourlyForcastItem(
                    time: "18:00",
                    value: "309.78",
                    icon: Icons.thunderstorm,
                  ),
                  HourlyForcastItem(
                    time: "21:00",
                    value: "403.45",
                    icon: Icons.tornado,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // Additional information card
            const Text(
              "Additional Forcast",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AdditionalInfoItem(
                  icon: Icons.water_drop,
                  label: "Humidity",
                  value: "91",
                ),
                AdditionalInfoItem(
                  icon: Icons.air,
                  label: "Wind Speed",
                  value: "7.69",
                ),
                AdditionalInfoItem(
                  icon: Icons.beach_access,
                  label: "Presure",
                  value: "beach",
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
