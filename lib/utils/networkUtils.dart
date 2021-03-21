import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkUtil {
  // Making this class as a singleton so that we always have a single instance of this class in the app.
  static NetworkUtil _instance = new NetworkUtil.internal();
  NetworkUtil.internal();
  factory NetworkUtil() => _instance;

  final JsonDecoder _decoder = new JsonDecoder();

  Future<dynamic> get(Uri url, {Map<String, String> headers}) {
    return http.get(url, headers: headers).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 500 || json == null) {
        print('This was the reponse after error -> ');
        print(res);
        throw new Exception("Error while fetching data from server");
      }
      // Return decoded Json
      return _decoder.convert(res);
    });
  }
}
