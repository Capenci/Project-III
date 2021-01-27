import 'package:flutter/material.dart';
import 'package:fl_animated_linechart/fl_animated_linechart.dart';

import 'HeartModel.dart';

class HeartChart extends StatefulWidget {
  HeartChart({this.seriesList, this.dateTimeSelected});
  final List<HeartModel> seriesList;
  final DateTime dateTimeSelected;
  @override
  _HeartChartState createState() => _HeartChartState();
}

class _HeartChartState extends State<HeartChart> {
  Map<DateTime, double> data = {};
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    setState(() {
      var timeStart = widget.dateTimeSelected.toString().split(" ");
      print(timeStart[0]);
      for (int i = 0; i < widget.seriesList.length; i++) {
        if (widget.seriesList[i].time.toString().contains(timeStart[0])) {
          data[widget.seriesList[i].time] = widget.seriesList[i].bpm.toDouble();
        } else {
          data[widget.seriesList[i].time] = 0;
        }
      }
    });
    return AnimatedLineChart(
      LineChart.fromDateTimeMaps([data], [Colors.white], ['Bpm'],
          tapTextFontWeight: FontWeight.w400),
      key: UniqueKey(),
    );
  }
}
