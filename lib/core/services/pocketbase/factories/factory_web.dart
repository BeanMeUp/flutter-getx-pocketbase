import 'package:fetch_client/fetch_client.dart';
import 'factory.dart';

final HttpClientFactory httpClientFactory = HttpClientFactoryWeb();

class HttpClientFactoryWeb implements HttpClientFactory {
  @override
  getHttpClient() => () => FetchClient(mode: RequestMode.cors);
}
