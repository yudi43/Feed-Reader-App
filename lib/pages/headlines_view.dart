import 'package:demoapp/data/rest_datasource.dart';
import 'package:demoapp/models/article.dart';
import 'package:flutter/material.dart';

class HeadlinesView extends StatefulWidget {
  @override
  _HeadlinesViewState createState() => _HeadlinesViewState();
}

class _HeadlinesViewState extends State<HeadlinesView> {
  RestDatasource datasource = RestDatasource();

  @override
  void initState() {
    super.initState();
    getHeadlinesData();
  }

  getHeadlinesData() async {
    print("Hitting top-headlines api");
    var response = await datasource.getHeadlines();
    List<Article> allArticles = [];
    response['articles']
        .forEach((item) => allArticles.add(Article.fromJson(item)));
    print(allArticles);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("HeadlinesView"),
      ),
    );
  }
}
