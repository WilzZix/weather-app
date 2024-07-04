import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/application/future_weather/future_weather_bloc.dart';
import 'package:weather_app/application/locale_change/change_local_bloc.dart';
import 'package:weather_app/application/theme_mode_changing/theme__bloc.dart';
import 'package:weather_app/extansion/extantions.dart';
import 'package:weather_app/presentation/pages/main_page.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(
      const MyApp(),
    ),
    blocObserver: AppBlocObserver(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode themeMode = ThemeMode.system;
  Locale locale = const Locale('en');

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FutureWeatherBloc(),
        ),
        BlocProvider(create: (context) => ThemeBloc()),
        BlocProvider(create: (context) => ChangeLocalBloc())
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          if (state is AppThemeChanged) {
            themeMode = state.isDarkMode ? ThemeMode.dark : ThemeMode.light;
          }
          return BlocListener<ChangeLocalBloc, ChangeLocalState>(
            listener: (context, state) {
              if (state is LocalChanged) {
                locale = state.local == 'ru'
                    ? const Locale('ru')
                    : const Locale('en');

                setState(() {});
              }
            },
            child: MaterialApp(
              locale: locale,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              debugShowCheckedModeBanner: false,
              themeMode: themeMode,
              title: 'Flutter Weather App',
              theme: ThemeData(
                useMaterial3: true,
                colorSchemeSeed: const Color.fromRGBO(86, 80, 14, 171),
              ),
              darkTheme: ThemeData(
                useMaterial3: true,
                brightness: Brightness.dark,
                colorSchemeSeed: const Color.fromRGBO(86, 80, 14, 171),
              ),
              home: const MyHomePage(),
            ),
          );
        },
      ),
    );
  }
}

class AppBlocObserver extends BlocObserver {
  ///We can run something, when we create our Bloc
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);

    ///We can check, if the BlocBase is a Bloc or a Cubit
    if (bloc is Cubit) {
      print("This is a Cubit");
    } else {
      print("This is a Bloc");
    }
  }

  ///We can react to events
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print("an event Happened in $bloc the event is $event");
  }

  ///We can even react to transitions
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);

    /// With this we can specifically know, when and what changed in our Bloc
    print(
        "There was a transition from ${transition.currentState} to ${transition.nextState}");
  }

  ///We can react to errors, and we will know the error and the StackTrace
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    print(
        "Error happened in $bloc with error $error and the stacktrace is $stackTrace");
  }

  ///We can even run something, when we close our Bloc
  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print("BLOC is closed");
  }
}
