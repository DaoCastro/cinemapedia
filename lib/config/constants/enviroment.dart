import 'package:flutter_dotenv/flutter_dotenv.dart';

class Enviroment {
  static String theMovieDbKey =
      dotenv.env["THE_MOVIEDB_KEY"] ?? 'No hay key definida';

  static String theBaseUrlMovieDb =
      dotenv.env["BASE_URL_MOVIEDB"] ?? 'No hay url definida';
}
