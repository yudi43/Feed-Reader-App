import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:demoapp/pages/headlines_view.dart';
import 'package:demoapp/pages/interest_over_time.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return ConnectivityAppWrapper(
        app: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text(
                    'Headlines',
                    style: TextStyle(
                        color: Colors.black, fontFamily: "Merriweather-title"),
                  ),
                ),
                Tab(
                  child: Text(
                    'Interest Over Time',
                    style: TextStyle(
                        color: Colors.black, fontFamily: "Merriweather-title"),
                  ),
                ),
              ],
            ),
            title: Text(
              'News Reader App',
              style: TextStyle(
                  color: Colors.black, fontFamily: "Merriweather-title"),
            ),
          ),
          body: TabBarView(
            children: [
              HeadlinesView(),
              InterestOverTime(),
            ],
          ),
        ),
      ),
    ));
  }
}
