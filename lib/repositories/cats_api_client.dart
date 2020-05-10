import 'dart:convert';
import 'dart:async';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:catexplorer/models/models.dart';

class CatsApiClient {

  static const baseUrl = 'api.thecatapi.com';
  static const searchCatsPath = '/v1/images/search';

  final http.Client httpClient;

  CatsApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<List<Cat>> fetchCats() async {
    var queryParameters = {
      'limit': '50',
      'has_breeds': '1',
    };

    var uri = Uri.https(baseUrl, searchCatsPath, queryParameters);
    var headers = {'x-api-key': 'a0a4b749-bff0-4c7a-8eb3-8c737ac58326'};

    final response = await this.httpClient.get(uri, headers: headers);

    if (response.statusCode != 200) {
      throw Exception('error getting cats');
    }

    final catsJsonObjects = jsonDecode(response.body) as List;
    return catsJsonObjects.map((tagJson) => Cat.fromJson(tagJson)).toList();
  }
}
