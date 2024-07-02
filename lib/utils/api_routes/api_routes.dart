class ApiRoutes {
  const ApiRoutes();

  String get baseUrl => 'https://api.weatherapi.com/v1';

  String get forecastWeather => '/forecast.json?q=Tashkent&days=14';
}
