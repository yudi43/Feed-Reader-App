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

  void getHeadlinesAndSink(String query) async {
    Map<String, dynamic> response = await restDatasource.getHeadlines(query);
    print(response);
    List<Article> oldArticles = [];
    List<Article> newArticles = [];
    response['articles']
        .forEach((item) => newArticles.add(Article.fromJson(item)));
    // sink only when:
    // 1. New article has come.
    // 2. No article already.
    if (oldArticles.length == 0) {
      oldArticles = newArticles;
      listOfArticles.sink.add(oldArticles);
    } else {
      //When old articles is not empty.
      //Check if old articles is same as new articles.
      if (oldArticles[0].title != newArticles[0].title) {
        oldArticles = newArticles;
        listOfArticles.sink.add(oldArticles);
      }
    }
  }
}
