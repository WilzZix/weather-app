import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/application/future_weather/future_weather_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<FutureWeatherBloc>(context).add(GetFutureWeatherEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.white70,
        leading: const Icon(Icons.menu),
        actions: [
          BlocBuilder<FutureWeatherBloc, FutureWeatherState>(
            buildWhen: (context, state) {
              return state is FutureWeatherLoadedState;
            },
            builder: (context, state) {
              if (state is FutureWeatherLoadedState) {
                return Text(
                    "${state.data.location!.name!},${state.data.location!.country!}");
              }
              return const CircularProgressIndicator();
            },
          ),
          const Icon(Icons.keyboard_arrow_down)
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const SizedBox(height: 16),
              BlocBuilder<FutureWeatherBloc, FutureWeatherState>(
                builder: (context, state) {
                  if (state is FutureWeatherLoadingErrorState) {
                    return Center(
                      child: Text(state.msg),
                    );
                  }
                  if (state is FutureWeatherLoadedState) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${state.data.current!.tempC}",
                                  style: const TextStyle(
                                      fontSize: 46, color: Colors.blue),
                                ),
                                const Icon(Icons.cloud_done)
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(state.data.current!.condition!.text!),
                                    Text(
                                        'Feels like ${state.data.current!.feelslikeC}'),
                                  ],
                                ),
                                //  Text('Max 20, Min 10')
                              ],
                            ),
                            const SizedBox(height: 8),
                            Container(
                              width: double.infinity,
                              height: 2,
                              decoration:
                                  const BoxDecoration(color: Colors.grey),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              height: 90,
                              child: ListView.builder(
                                itemCount:
                                    state.data.forecast!.forecastday!.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(right: 16.0),
                                    child: Column(
                                      children: [
                                        Text(
                                            "${state.data.forecast!.forecastday![index].day!.avgtempC}"),
                                        SizedBox(height: 8),
                                        Icon(Icons.cloud_done),
                                        SizedBox(height: 8),
                                        Text(
                                            "${state.data.forecast!.forecastday![index].day!.condition!.text}"),
                                        SizedBox(height: 8),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              const SizedBox(height: 32),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '10 days forecast',
                    style: TextStyle(fontSize: 24),
                  ),
                  Text(
                    'View details',
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ListView.builder(
                  itemCount: 15,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16)),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Column(
                                  children: [Text('Today'), Text('Clear')],
                                ),
                                Spacer(),
                                Icon(Icons.cloud_done),
                                SizedBox(width: 8),
                                Text('+20/+10'),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
