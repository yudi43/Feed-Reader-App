import 'package:demoapp/bloc/headlinesViewBloc.dart';
import 'package:flutter/material.dart';

class InterestOverTime extends StatefulWidget {
  @override
  _InterestOverTimeState createState() => _InterestOverTimeState();
}

class _InterestOverTimeState extends State<InterestOverTime> {
  HeadlinesViewBloc headlinesViewBloc;

  @override
  void initState() {
    super.initState();
    headlinesViewBloc = new HeadlinesViewBloc();
    headlinesViewBloc.getEverythingData('');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Interest Over Time"),
      ),
    );
  }
}
