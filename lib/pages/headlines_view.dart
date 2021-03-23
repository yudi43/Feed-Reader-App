import 'dart:async';

import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:demoapp/bloc/headlinesViewBloc.dart';
import 'package:demoapp/components/shimmerTile.dart';
import 'package:demoapp/components/singleArticleTile.dart';
import 'package:demoapp/data/rest_datasource.dart';
import 'package:demoapp/pages/interest_over_time.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    headlinesViewBloc = new HeadlinesViewBloc();
    headlinesViewBloc.getHeadlinesAndSink('');
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  checkForUpdates(query) {
    Timer.periodic(const Duration(seconds: 30), (timer) {
      if (!_autorefresh) {
        print('Cancelling timer');
        timer.cancel();
      }
      print('Checking for updates...');
      headlinesViewBloc.getHeadlinesAndSink(query);
      showInSnackBar("Checking for new articles...");
    });
  }

  searchArticles(String query) {
    headlinesViewBloc.getHeadlinesAndSink(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: ConnectivityWidgetWrapper(
        child: StreamBuilder(
          builder: (context, snapshot) {
            return Column(
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
                            onPressed: () => searchArticles(_controller.text),
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
                    if (_autorefresh) {
                      showInSnackBar(
                          'The app will now fetch data every 30 seconds, if new news article is found then will update the list automatically.');
                    } else {
                      showInSnackBar('Auto refresh turned off.');
                    }
                    checkForUpdates(_controller.text);
                  },
                  secondary: const Icon(Icons.refresh),
                ))),
                Expanded(
                  child: snapshot.connectionState == ConnectionState.waiting
                      ? ListView.builder(
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            return ShimmerTile();
                          })
                      : ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return SingleArticleTile(
                              article: snapshot.data[index],
                            );
                          }),
                ),
              ],
            );
          },
          stream: headlinesViewBloc.listOfArticles.stream,
        ),
      ),
    );
  }
}
