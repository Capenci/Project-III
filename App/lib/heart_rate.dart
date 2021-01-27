import 'package:flutter/material.dart';
import 'HeartModel.dart';

class HeartRate extends StatefulWidget {
  HeartRate(
      {this.seriesList,
      this.dateTimeSelected,
      this.heartCurrent,
      this.temperatureCurrent});
  final List<HeartModel> seriesList;
  final String heartCurrent;
  final String temperatureCurrent;
  final DateTime dateTimeSelected;
  @override
  _HeartRateState createState() => _HeartRateState();
}

class _HeartRateState extends State<HeartRate> {
  var averageHeart;
  var total;
  var minHeart;
  var maxHeart;
  List<String> resultAverageHeart = [];

  @override
  void initState() {
    setState(() {
      var timeStart = widget.dateTimeSelected.toString().split(" ");
      averageHeart = 0;
      minHeart = 0;
      maxHeart = 0;
      total = 0.0;

      //Tính trung bình
      for (int i = 0; i < widget.seriesList.length; i++) {
        if (widget.seriesList[i].time.toString().contains(timeStart[0])) {
          if (minHeart >= widget.seriesList[i].bpm) {
            minHeart = widget.seriesList[i].bpm;
          }
          if (maxHeart <= widget.seriesList[i].bpm) {
            maxHeart = widget.seriesList[i].bpm;
          }
          total += widget.seriesList[i].bpm;
        }
      }
      averageHeart = (total / widget.seriesList.length);
      resultAverageHeart = averageHeart.toString().split(".");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      var timeStart = widget.dateTimeSelected.toString().split(" ");
      averageHeart = 0;
      minHeart = 0;
      maxHeart = 0;
      total = 0.0;
      //Tính trung bình
      for (int i = 0; i < widget.seriesList.length; i++) {
        if (widget.seriesList[i].time.toString().contains(timeStart[0])) {
          if (minHeart >= widget.seriesList[i].bpm) {
            minHeart = widget.seriesList[i].bpm;
          }
          if (maxHeart <= widget.seriesList[i].bpm) {
            maxHeart = widget.seriesList[i].bpm;
          }
          total += widget.seriesList[i].bpm;
        }
      }
      averageHeart = (total / widget.seriesList.length);
      resultAverageHeart = averageHeart.toString().split(".");
    });

    return Column(
      children: [
        Card(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.favorite, color: Colors.redAccent),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.heartCurrent,
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Current Heart", style: TextStyle(fontSize: 12))
                      ],
                    ),
                    Row(
                      children: [
                        Text("Current Temp", style: TextStyle(fontSize: 12)),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.temperatureCurrent,
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(Icons.ac_unit, color: Colors.blue),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "Average heart rate",
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(resultAverageHeart[0],
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              Text("Times/minutes",
                                  style: TextStyle(fontSize: 11)),
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text("Minimum heart rate",
                              style: TextStyle(fontSize: 12)),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(minHeart.round().toString(),
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              Text("Times/minutes",
                                  style: TextStyle(fontSize: 11)),
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text("Maximum heart rate",
                              style: TextStyle(fontSize: 12)),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(maxHeart.round().toString(),
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              Text("Times/minutes",
                                  style: TextStyle(fontSize: 11)),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
