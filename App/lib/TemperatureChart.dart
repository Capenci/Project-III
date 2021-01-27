import 'package:fl_animated_linechart/fl_animated_linechart.dart';
import 'package:flutter/material.dart';

import 'TemperatureModel.dart';

class TemperatureChart extends StatefulWidget {
  TemperatureChart({this.seriesList, this.dateTimeSelected});
  final List<TemperatureModel> seriesList;
  final DateTime dateTimeSelected;
  @override
  _TemperatureChartState createState() => _TemperatureChartState();
}

class _TemperatureChartState extends State<TemperatureChart> {
  Map<DateTime, double> data = {};
  @override
  void initState() {
    data.clear();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    setState(() {
      data.clear();
      var timeStart = widget.dateTimeSelected.toString().split(" ");
      for (int i = 0; i < widget.seriesList.length; i++) {
        if (widget.seriesList[i].time.toString().contains(timeStart[0])) {
          data[widget.seriesList[i].time] =
              widget.seriesList[i].temperature.toDouble();
        } else {
          data[widget.seriesList[i].time] = 0;
        }
      }
    });
    return AnimatedLineChart(
      LineChart.fromDateTimeMaps([data], [Colors.white], ['°C'],
          tapTextFontWeight: FontWeight.w400),
      key: UniqueKey(),
    );
  }
}
