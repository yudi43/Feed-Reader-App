import 'dart:async';

import 'package:demoapp/data/rest_datasource.dart';
import 'package:demoapp/models/article.dart';

class HeadlinesViewBloc {
  RestDatasource restDatasource = RestDatasource();
  final StreamController<List<Article>> listOfArticles =
      new StreamController<List<Article>>();
}
