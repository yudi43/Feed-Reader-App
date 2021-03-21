import 'package:demoapp/bloc/headlinesViewBloc.dart';
import 'package:demoapp/components/singleArticleTile.dart';
import 'package:demoapp/data/rest_datasource.dart';
import 'package:demoapp/models/article.dart';
import 'package:flutter/material.dart';

class HeadlinesView extends StatefulWidget {
  @override
  _HeadlinesViewState createState() => _HeadlinesViewState();
}

class _HeadlinesViewState extends State<HeadlinesView> {
  RestDatasource datasource = RestDatasource();
  HeadlinesViewBloc headlinesViewBloc;

  @override
  void initState() {
    super.initState();
    headlinesViewBloc = new HeadlinesViewBloc();
    headlinesViewBloc.getHeadlinesAndSink();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (context, snapshot) {
        return snapshot.connectionState == ConnectionState.waiting
            ? CircularProgressIndicator()
            : snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return SingleArticleTile(
                        article: snapshot.data[index],
                      );
                    })
                : Text('jkhjkh');
      },
      stream: headlinesViewBloc.listOfArticles.stream,
    );
  }
}
