import 'package:flutter_dotenv/flutter_dotenv.dart';

enum UrlEnvironment { development, production }

class UrlConfig {
  static UrlEnvironment _environment = UrlEnvironment.development;
  static UrlEnvironment get environment => _environment;
  static void setEnvironment(UrlEnvironment env) => _environment = env;

  static String get baseUrl => _baseUrl;

  static get _baseUrl {
    switch (_environment) {
      case UrlEnvironment.development:
        return dotenv.env['BASE_URL'];
      case UrlEnvironment.production:
        return dotenv.env['BASE_URL'];
    }
  }
}
