import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/application/future_weather/future_weather_bloc.dart';
import 'package:weather_app/application/locale_change/change_local_bloc.dart';
import 'package:weather_app/application/theme_mode_changing/theme__bloc.dart';
import 'package:weather_app/extansion/extantions.dart';
import 'package:weather_app/utils/typography/Typogriphy.dart';

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

  TextEditingController searchPlaceController = TextEditingController();
  bool showSearchBar = false;
  bool isDarkMode = false;
  bool engLocalChecked = true;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(.8),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(.8),
        leading: Row(
          children: [
            GestureDetector(
              onTap: () {
                isDarkMode = !isDarkMode;
                BlocProvider.of<ThemeBloc>(context)
                    .add(ChangeAppTheme(isDarkMode));
              },
              child: const Icon(Icons.menu),
            ),
            GestureDetector(
              onTap: () {
                engLocalChecked = !engLocalChecked;
                BlocProvider.of<ChangeLocalBloc>(context)
                    .add(ChangeLocal(engLocalChecked ? 'en' : 'ru'));
              },
              child: const Icon(Icons.language),
            )
          ],
        ),
        actions: [
          showSearchBar
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.60,
                    child: TextFormField(
                      controller: searchPlaceController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1),
                        ),
                        hintText: 'Search place',
                      ),
                    ),
                  ),
                )
              : BlocBuilder<FutureWeatherBloc, FutureWeatherState>(
                  buildWhen: (context, state) {
                    return state is FutureWeatherLoadedState;
                  },
                  builder: (context, state) {
                    if (state is FutureWeatherLoadedState) {
                      return Text(
                        "${state.data.location!.name!},${state.data.location!.country!}",
                        style: Typographies.cityNameStyle,
                      );
                    }
                    return const CircularProgressIndicator();
                  },
                ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              showSearchBar = !showSearchBar;
              setState(() {});
            },
            child: Icon(showSearchBar ? Icons.close : Icons.search),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<FutureWeatherBloc>(context)
              .add(GetFutureWeatherEvent());
        },
        child: SingleChildScrollView(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${state.data.current!.tempC!.ceil()}",
                                        style: const TextStyle(
                                            fontSize: 46, color: Colors.blue),
                                      ),
                                      const SizedBox(width: 4),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 16.0),
                                        child: Container(
                                          height: 12,
                                          width: 12,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              width: 3,
                                              color: Colors.blueAccent,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const Icon(Icons.cloud_done)
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.data.current!.condition!.text!,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                          'Feels like ${state.data.current!.feelslikeC!.ceil()}'),
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
                                  itemCount: state.data.forecast!.forecastday!
                                      .first.hour!.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(right: 16.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            "+${state.data.forecast!.forecastday!.first.hour![index].tempC!.ceil()}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          const Icon(Icons.cloud_done),
                                          const SizedBox(height: 8),
                                          Text(DateFormat('HH:mm').format(
                                              DateFormat("yyyy-MM-dd HH:mm")
                                                  .parse(state
                                                      .data
                                                      .forecast!
                                                      .forecastday!
                                                      .first
                                                      .hour![index]
                                                      .time!))),
                                          const SizedBox(height: 8),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n!.appFile,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                BlocBuilder<FutureWeatherBloc, FutureWeatherState>(
                  builder: (context, state) {
                    if (state is FutureWeatherLoadedState) {
                      return ListView.builder(
                          itemCount: state.data.forecast!.forecastday!.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                DateFormat('MMMM dd').format(
                                                    DateFormat("yyyy-MM-dd")
                                                        .parse(state
                                                            .data
                                                            .forecast!
                                                            .forecastday![index]
                                                            .date!)),
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text(
                                                '${state.data.forecast!.forecastday![index].day!.condition!.text}')
                                          ],
                                        ),
                                        const Spacer(),
                                        const Icon(Icons.cloud_done),
                                        const SizedBox(width: 8),
                                        Text(
                                            '+${state.data.forecast!.forecastday![index].day!.maxtempC!.ceil()}/+${state.data.forecast!.forecastday![index].day!.mintempC!.ceil()}'),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                              ],
                            );
                          });
                    }
                    return const CircularProgressIndicator();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
