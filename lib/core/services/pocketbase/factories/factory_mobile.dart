import 'factory.dart';

final HttpClientFactory httpClientFactory = HttpClientFactoryMobile();

class HttpClientFactoryMobile implements HttpClientFactory {
  @override
  getHttpClient() => null;
}
