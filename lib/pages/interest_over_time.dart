import 'package:demoapp/bloc/headlinesViewBloc.dart';
import 'package:demoapp/models/chartData.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

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
    return charts.BarChart(
      [
        new charts.Series<ChartData, String>(
          id: 'Article counts',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (ChartData articles, _) => articles.day,
          measureFn: (ChartData articles, _) => articles.articleCount,
          data: chartsData,
        )
      ],
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (context, snapshot) {
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          onPressed: () => headlinesViewBloc
                              .getEverythingData(_controller.text),
                          icon: Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 100,
                child: createChart(snapshot.data),
              ),
              Container(
                child: Text('sometext'),
              ),
            ],
          ),
        );
      },
      stream: headlinesViewBloc.chartsDataController.stream,
    );
  }
}
