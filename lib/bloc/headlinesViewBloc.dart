import 'dart:async';

import 'package:demoapp/data/rest_datasource.dart';
import 'package:demoapp/models/article.dart';

class HeadlinesViewBloc {
  RestDatasource restDatasource = RestDatasource();
  final StreamController<List<Article>> listOfArticles =
      new StreamController<List<Article>>();

  dispose() {
    // To close the stream when not in use.
    listOfArticles.close();
  }

  void getHeadlinesAndSink() async {
    Map<String, dynamic> response = await restDatasource.getHeadlines();
    List<Article> allArticles = [];
    response['articles']
        .forEach((item) => allArticles.add(Article.fromJson(item)));
    listOfArticles.sink.add(allArticles);
  }
}
