import 'package:demoapp/models/chartData.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SimpleBarChart extends StatelessWidget {
  final List<ChartData> seriesList;

  SimpleBarChart(this.seriesList);

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
        legend: Legend(
          isVisible: true,
          // Legend will be placed at the left
          position: LegendPosition.bottom,
        ),
        plotAreaBorderColor: Colors.transparent,
        primaryXAxis: CategoryAxis(
          majorTickLines: MajorTickLines(size: 0),
          majorGridLines: MajorGridLines(width: 0),
          labelRotation: 45,
        ),
        primaryYAxis: NumericAxis(
          majorTickLines: MajorTickLines(size: 0),
          majorGridLines: MajorGridLines(width: 0),
        ),
        series: <ChartSeries>[
          ColumnSeries<ChartData, dynamic>(
            width: 0.15,
            dataSource: this.seriesList,
            name: "Number of articles posted in last 7 days.",
            legendIconType: LegendIconType.rectangle,
            xValueMapper: (ChartData items, _) => items.day,
            yValueMapper: (ChartData items, _) => items.articleCount,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
        ]);
  }
}
