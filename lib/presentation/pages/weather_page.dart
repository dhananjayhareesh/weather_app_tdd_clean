import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/constants.dart';
import '../bloc/weather_bloc.dart';
import '../bloc/weather_event.dart';
import '../bloc/weather_state.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1D1E22),
        title: const Text(
          'Weather Forecast',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'Enter city name',
                fillColor: const Color(0xffF3F3F3),
                filled: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
              ),
              onChanged: (query) {
                context.read<WeatherBloc>().add(OnCityChanged(query));
              },
            ),
            const SizedBox(height: 24.0),
            Expanded(
              child: BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  if (state is WeatherLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                    );
                  }
                  if (state is WeatherLoaded) {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                state.result.cityName,
                                style: const TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Image.network(
                                Urls.weatherIcon(state.result.iconCode),
                                height: 40.0,
                                width: 40.0,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          Text(
                            '${state.result.main} | ${state.result.description}',
                            style: const TextStyle(
                              fontSize: 18.0,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 32.0),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Table(
                              defaultColumnWidth: const FixedColumnWidth(150.0),
                              border: TableBorder.all(
                                color: Colors.grey[300]!,
                                style: BorderStyle.solid,
                                width: 1,
                              ),
                              children: [
                                _buildTableRow('Temperature',
                                    state.result.temperature.toString()),
                                _buildTableRow('Pressure',
                                    state.result.pressure.toString()),
                                _buildTableRow('Humidity',
                                    state.result.humidity.toString()),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  if (state is WeatherLoadFailue) {
                    return Center(
                      child: Text(
                        state.message,
                        style:
                            const TextStyle(color: Colors.red, fontSize: 16.0),
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  TableRow _buildTableRow(String title, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
