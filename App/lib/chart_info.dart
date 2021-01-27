import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:smart_healthcare/HeartModel.dart';
import 'package:smart_healthcare/TemperatureChart.dart';
import 'package:smart_healthcare/database.dart';
import 'package:intl/intl.dart';
import 'package:smart_healthcare/heart_rate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:smart_healthcare/sign_in.dart';
import 'package:smart_healthcare/splash_screen_view.dart';
import 'HeartChart.dart';
import 'TemperatureModel.dart';

class LineChart extends StatefulWidget {
  @override
  _LineChartState createState() => _LineChartState();
}

class _LineChartState extends State<LineChart> {
  int _selectedIndex = 0;
  DatabaseService databaseService = new DatabaseService();
  Stream heartBeat;
  QuerySnapshot querySnapshot;
  List<HeartModel> listHeart = [];
  List<TemperatureModel> listTemperature = [];

  DateTime _selectedValue;

  var widgetOptions = [];

  getData() async {
    listHeart.clear();
    listTemperature.clear();
    await databaseService.getTimeNew().then((value) async {
      querySnapshot = await value;
      if (querySnapshot.documents.isNotEmpty) {
        int time = await querySnapshot.documents[0].data['timestamp'];
        var date = DateTime.fromMillisecondsSinceEpoch(time);
        _selectedValue =
            DateFormat("yyyy-MM-dd hh:mm:ss").parse(date.toString());
      }
    });
    await databaseService.getHeartChart().then((value) {
      heartBeat = value;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      getData();
    });
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.menu),
          title: Center(child: Text("Heart rate")),
          elevation: 0,
          backgroundColor: Colors.redAccent,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right:10.0),
              child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => SplashScreenView(),), (route) => false);
                  },child: Icon(Icons.exit_to_app)),
            )
          ],
        ),

        body: SafeArea(
          child: Column(
            children: [
              Container(
                color: Colors.redAccent,
                height: 100,
                child: DatePicker(
                  DateTime.now().subtract(Duration(days: 7)),
                  initialSelectedDate: DateTime.now(),
                  selectionColor: Colors.red,
                  selectedTextColor: Colors.white,
                  daysCount: 8,
                  onDateChange: (date) {
                    // New date selected
                    setState(() {
                      _selectedValue = date;
                    });
                  },
                ),
              ),
              Container(
                color: Colors.redAccent,
                child: GNav(
                    gap: 8,
                    activeColor: Colors.white,
                    iconSize: 24,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    duration: const Duration(milliseconds: 800),
                    tabBackgroundColor: Colors.red,
                    tabs: [
                      GButton(
                        icon: LineIcons.heartbeat,
                        text: 'Heart Chart',
                      ),
                      GButton(
                        icon: Icons.ac_unit,
                        text: 'Temperature Chart',
                      ),
                    ],
                    selectedIndex: _selectedIndex,
                    onTabChange: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    }),
              ),
              Expanded(
                child: Container(
                  color: Colors.redAccent,
                  child: StreamBuilder(
                      stream: heartBeat,
                      builder: (context, snapshot) {
                        if (snapshot.data == null ||
                            snapshot.data.documents.length == 0) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          listHeart.clear();
                          listTemperature.clear();
                          final docs = snapshot.data.documents;
                          final length = snapshot.data.documents.length;
                          final max = (length / 10).toInt();
                          int i = 0;
                          while (i < max * 10) {
                            var date = DateTime.fromMillisecondsSinceEpoch(
                                docs[i + 4]["timestamp"]);
                            DateTime time = DateFormat("yyyy-MM-dd HH:mm:ss")
                                .parse(date.toString());
                            var bpm = (docs[i]["bpm"] +
                                docs[i + 1]["bpm"] +
                                docs[i + 2]["bpm"] +
                                docs[i + 3]["bpm"] +
                                docs[i + 4]["bpm"] +
                                docs[i + 5]["bpm"] +
                                docs[i + 6]["bpm"] +
                                docs[i + 7]["bpm"] +
                                docs[i + 8]["bpm"] +
                                docs[i + 9]["bpm"]) /
                                10;
                            var temperature = (docs[i]["temperature"] +
                                docs[i + 1]["temperature"] +
                                docs[i + 2]["temperature"] +
                                docs[i + 3]["temperature"] +
                                docs[i + 4]["temperature"] +
                                docs[i + 5]["temperature"] +
                                docs[i + 6]["temperature"] +
                                docs[i + 7]["temperature"] +
                                docs[i + 8]["temperature"] +
                                docs[i + 9]["temperature"]) /
                                10;
                            if(_selectedValue.toString().contains(time.toString().split(" ")[0])){
                              listHeart.add(HeartModel(time: time, bpm: bpm));
                              listTemperature.add(TemperatureModel(
                                  time: time, temperature: temperature));
                            }
                            i += 10;
                          }
                          var date = DateTime.fromMillisecondsSinceEpoch(
                              docs[length - 1]["timestamp"]);
                          DateTime time = DateFormat("yyyy-MM-dd HH:mm:ss")
                              .parse(date.toString());
                          if(_selectedValue.toString().contains(time.toString().split(" ")[0])){
                            listHeart.add(HeartModel(
                                time: time, bpm: docs[length - 1]["bpm"]));
                            listTemperature.add(TemperatureModel(
                                time: time,
                                temperature: docs[length - 1]["temperature"]));
                          }


                          widgetOptions = [
                            HeartChart(
                                seriesList: listHeart,
                                dateTimeSelected: _selectedValue),
                            TemperatureChart(
                                seriesList: listTemperature,
                                dateTimeSelected: _selectedValue)
                          ];
                          return Column(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15,
                                        right: 10,
                                        left: 10,
                                        bottom: 10),
                                    child:
                                    widgetOptions.elementAt(_selectedIndex),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: HeartRate(
                                  heartCurrent:
                                  docs[length - 1]["bpm"].toString(),
                                  temperatureCurrent:  docs[length - 1]["temperature"].toString(),
                                  seriesList: listHeart,
                                  dateTimeSelected: _selectedValue,
                                ),
                              )
                            ],
                          );
                        }
                      }),
                ),
              ),
            ],
          ),
        ));
  }
}
