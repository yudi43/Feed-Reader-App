class ChartData {
  final String day;
  final int articleCount;

  ChartData({this.day, this.articleCount});

  factory ChartData.from({int articleCount, String day}) {
    return ChartData(articleCount: articleCount, day: day);
  }
}
