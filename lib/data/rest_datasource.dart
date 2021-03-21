import 'package:demoapp/utils/networkUtils.dart';

class RestDatasource {
  static final String apiKey = '0ccb712971d04577b20f6a87ab43d25d';
  static final BASE_URL = 'newsapi.org';
  NetworkUtil _netUtil = new NetworkUtil();

  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "Authorization": "Bearer 0ccb712971d04577b20f6a87ab43d25d",
  };

  Future<dynamic> getHeadlines() async {
    // RIGHT NOW WORKING ONLY FOR TRUMP
    String endpoint = 'v2/top-headlines';
    var queryParameters = {
      'q': 'trump',
    };
    var uri = Uri.https(BASE_URL, endpoint, queryParameters);
    var response = await _netUtil.get(uri, headers: headers);
    return response;
  }
}
