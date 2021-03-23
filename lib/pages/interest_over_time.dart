import 'package:demoapp/bloc/headlinesViewBloc.dart';
import 'package:demoapp/components/chart.dart';
import 'package:demoapp/models/chartData.dart';
import 'package:flutter/material.dart';

class InterestOverTime extends StatefulWidget {
  @override
  _InterestOverTimeState createState() => _InterestOverTimeState();
}

class _InterestOverTimeState extends State<InterestOverTime> {
  HeadlinesViewBloc headlinesViewBloc;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    headlinesViewBloc = new HeadlinesViewBloc();
    headlinesViewBloc.getEverythingData('');
  }

  Widget createChart(List<ChartData> chartsData) {
    return SimpleBarChart(chartsData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: StreamBuilder(
          builder: (context, snapshot) {
            return Container(
              child: ListView(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
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
                              onPressed: () => headlinesViewBloc
                                  .getEverythingData(_controller.text),
                              icon: Icon(Icons.search),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: createChart(snapshot.data),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
                ],
              ),
            );
          },
          stream: headlinesViewBloc.chartsDataController.stream,
        ),
      ),
    );
  }
}
