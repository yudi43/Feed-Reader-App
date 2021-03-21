import 'dart:async';

import 'package:demoapp/data/rest_datasource.dart';
import 'package:demoapp/models/article.dart';
import 'package:demoapp/models/chartData.dart';

class HeadlinesViewBloc {
  RestDatasource restDatasource = RestDatasource();
  final StreamController<List<Article>> listOfArticles =
      new StreamController<List<Article>>();
  final StreamController<List<ChartData>> chartsDataController =
      new StreamController<List<ChartData>>();

  dispose() {
    // To close the stream when not in use.
    listOfArticles.close();
  }

  void getHeadlinesAndSink(String query) async {
    Map<String, dynamic> response = await restDatasource.getHeadlines(query);
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

  void getEverythingData(String query) async {
    Map<String, dynamic> response = await restDatasource.getEverything(query);
    print(response);
    List<Article> articles = [];

    response['articles']
        .forEach((item) => articles.add(Article.fromJson(item)));
    articles.sort((a, b) => (a.publishedAt).compareTo(b.publishedAt));

    Map<String, int> groupedData = Map<String, int>();

    articles.reversed.forEach((element) {
      DateTime publishDate = DateTime.parse(element.publishedAt);
      String date = publishDate.day.toString() +
          '/' +
          publishDate.month.toString() +
          '/' +
          publishDate.year.toString();
      if (groupedData.containsKey(date)) {
        groupedData[date] = groupedData[date] + 1;
      } else {
        groupedData[date] = 1;
      }
    });

    List<ChartData> chartsData = [];
    var dateCounter = DateTime.now();
    for (int i = 0; i < 7; i++) {
      // Check if the entry is there in groupedData for dateCounter
      String date = dateCounter.day.toString() +
          '/' +
          dateCounter.month.toString() +
          '/' +
          dateCounter.year.toString();
      if (groupedData.containsKey(date)) {
        chartsData
            .add(new ChartData(day: date, articleCount: groupedData[date]));
      } else {
        chartsData.add(new ChartData(day: date, articleCount: 0));
      }
      dateCounter = dateCounter.subtract(Duration(days: 1));
    }
    // Sink the chartsData list to the chartsDataController stream.
    chartsDataController.sink.add(chartsData);
  }
}
