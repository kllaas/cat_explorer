import 'dart:async';

import 'package:meta/meta.dart';

import 'package:catexplorer/repositories/cats_api_client.dart';
import 'package:catexplorer/models/models.dart';

class CatsRepository {
  final CatsApiClient catsApiClient;

  List<Cat> catCache;

  CatsRepository({@required this.catsApiClient})
      : assert(catsApiClient != null);

  Future<List<Cat>> getCats(bool forceUpdate) async {
    if (catCache != null && !forceUpdate) {
      return catCache;
    }

    return catsApiClient.fetchCats().then(
      (cats) {
        catCache = cats;
        return cats;
      },
    );
  }
}
