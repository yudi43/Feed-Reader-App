import 'package:flutter/material.dart';

class InterestOverTime extends StatefulWidget {
  @override
  _InterestOverTimeState createState() => _InterestOverTimeState();
}

class _InterestOverTimeState extends State<InterestOverTime> {
  @override
  void initState() {
    super.initState();
    print("InterestOverTime");
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
