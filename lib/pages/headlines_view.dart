import 'dart:async';

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
  TextEditingController _controller = TextEditingController();
  bool _autorefresh = false;

  @override
  void initState() {
    super.initState();
    headlinesViewBloc = new HeadlinesViewBloc();
    headlinesViewBloc.getHeadlinesAndSink('');
  }

  checkForUpdates(query) {
    Timer.periodic(const Duration(seconds: 30), (timer) {
      if (!_autorefresh) {
        print('Cancelling timer');
        timer.cancel();
      }
      print('Checking for updates...');
      headlinesViewBloc.getHeadlinesAndSink(query);
    });
  }

  searchArticles(String query) {
    headlinesViewBloc.getHeadlinesAndSink(query);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (context, snapshot) {
        return snapshot.connectionState == ConnectionState.waiting
            ? CircularProgressIndicator()
            : snapshot.hasData
                ? Column(
                    children: [
                      Container(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 10.0,
                              left: 8.0,
                              right: 8.0,
                            ),
                            child: TextField(
                              controller: _controller,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Search news",
                                suffixIcon: IconButton(
                                  onPressed: () =>
                                      searchArticles(_controller.text),
                                  icon: Icon(Icons.search),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                          child: Center(
                              child: SwitchListTile(
                        title: const Text('Auto Refresh'),
                        value: _autorefresh,
                        onChanged: (bool value) {
                          setState(() {
                            _autorefresh = value;
                          });
                          checkForUpdates(_controller.text);
                        },
                        secondary: const Icon(Icons.lightbulb_outline),
                      ))),
                      Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return SingleArticleTile(
                                article: snapshot.data[index],
                              );
                            }),
                      ),
                    ],
                  )
                : Text('jkhjkh');
      },
      stream: headlinesViewBloc.listOfArticles.stream,
    );
  }
}
