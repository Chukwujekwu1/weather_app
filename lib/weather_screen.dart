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
            onPressed: () {},
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

          final hourly1 = data["list"][1];
          final hourly1Temp = hourly1["main"]["temp"];
          final hourl1Sky = hourly1["weather"][0]["main"];

          final hourly2 = data["list"][2];
          final hourly2Temp = hourly2["main"]["temp"];
          final hourl2Sky = hourly2["weather"][0]["main"]; 

          
          final hourly3 = data["list"][3];
          final hourly3Temp = hourly3["main"]["temp"];
          final hourl3Sky = hourly3["weather"][0]["main"]; 

          final hourly4 = data["list"][4];
          final hourly4Temp = hourly4["main"]["temp"];
          final hourl4Sky = hourly4["weather"][0]["main"]; 

          final hourly5 = data["list"][5];
          final hourly5Temp = hourly5["main"]["temp"];
          final hourl5Sky = hourly5["weather"][0]["main"]; 

          final hourly6 = data["list"][6];
          final hourly6Temp = hourly6["main"]["temp"];
          final hourl6Sky = hourly6["weather"][0]["main"]; 




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
                //
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      HourlyForcastItem(
                        time: "03:00",
                        value: "$hourly1Temp",
                        icon: hourl1Sky == "Clouds" || hourl1Sky == "Rain" ? Icons.cloud : Icons.sunny
                      ),
                      HourlyForcastItem(
                        time: "06:00",
                        value: "$hourly2Temp",
                        icon: hourl2Sky == "Clouds" || hourl2Sky == "Rain" ? Icons.cloud : Icons.sunny,
                      ),
                      HourlyForcastItem(
                        time: "09:00",
                        value: "$hourly3Temp",
                        icon: hourl3Sky == "Clouds" || hourl3Sky == "Rain" ? Icons.cloud : Icons.sunny,
                      ),
                      HourlyForcastItem(
                        time: "12:00",
                        value: "$hourly4Temp",
                        icon: hourl4Sky == "Clouds" || hourl4Sky == "Rain" ? Icons.cloud : Icons.sunny,
                      ),
                      HourlyForcastItem(
                        time: "15:00",
                        value: "$hourly5Temp",
                        icon: hourl5Sky == "Clouds" || hourl5Sky == "Rain" ? Icons.cloud : Icons.sunny,
                      ),
                      HourlyForcastItem(
                        time: "15:00",
                        value: "$hourly6Temp",
                        icon: hourl6Sky == "Clouds" || hourl6Sky == "Rain" ? Icons.cloud : Icons.sunny,
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
