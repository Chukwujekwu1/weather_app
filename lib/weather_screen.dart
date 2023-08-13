import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String cityName = "Nigeria";
      final res = await http.get(
        Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=$cityName,africa&APPID=$openWeatherApiKey",
        ),
      );
      final data = jsonDecode(res.body);
      if (data['cod'] != "200") {
        throw data["message"];
      }

      return data;
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
            onPressed: () {
              setState(() {
                
              });
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }
          final data = snapshot.data!;

          final current = data["list"][0];
          final currentTemp = current["main"]["temp"];
          final currentSky = current["weather"][0]["main"];
          final currentPressure = current["main"]["pressure"];
          final currentHumidity = current["main"]["humidity"];
          final currentWind = current["wind"]["speed"];

          return Padding(
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
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                "$currentTemp°K ",
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Icon(
                                currentSky == "Clouds" || currentSky == "Rain"
                                    ? Icons.cloud
                                    : Icons.sunny,
                                size: 64,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "$currentSky",
                                style: const TextStyle(
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

                SizedBox(
                  height: 130,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 39,
                    itemBuilder: (context, index) {
                      final hourly = data["list"][index + 1];
                      final hourlyTemp =
                          data["list"][index + 1]["main"]["temp"].toString();
                      final hourlySky =
                          data["list"][index + 1]["weather"][0]["main"];
                      final time =
                          DateTime.parse(hourly["dt_txt"]);
                     
                      return HourlyForcastItem(
                          time: DateFormat.j().format(time),
                          value: hourlyTemp,
                          icon: hourlySky == "Clouds" || hourlySky == "Rain"
                              ? Icons.cloud
                              : Icons.sunny);
                    },
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AdditionalInfoItem(
                      icon: Icons.water_drop,
                      label: "Humidity",
                      value: "$currentHumidity",
                    ),
                    AdditionalInfoItem(
                      icon: Icons.air,
                      label: "Wind Speed",
                      value: "$currentWind",
                    ),
                    AdditionalInfoItem(
                      icon: Icons.beach_access,
                      label: "Presure",
                      value: "$currentPressure ",
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
