enum UrlEnvironment { development, production }

class UrlConfig {
  static UrlEnvironment _environment = UrlEnvironment.development;
  static UrlEnvironment get environment => _environment;
  static void setEnvironment(UrlEnvironment env) => _environment = env;

  static String get baseUrl => _baseUrl;

  static get _baseUrl {
    switch (_environment) {
      case UrlEnvironment.development:
        return 'https://fakestoreapi.com';
      case UrlEnvironment.production:
        return 'https://fakestoreapi.com';
    }
  }
}
