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
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: "Headlines"),
                Tab(text: "Interest Over Time"),
              ],
            ),
            title: Text('News Reader App'),
          ),
          body: TabBarView(
            children: [
              HeadlinesView(),
              InterestOverTime(),
            ],
          ),
        ),
      ),
    );
  }
}
