import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'cpuInfo.dart';

class displayInformation extends StatefulWidget {
  @override
  void dispose() {
    timer?.cancel();
  }

  @override
  _batteryInfomationState createState() => _batteryInfomationState();
}

class _batteryInfomationState extends State<displayInformation> {
  @override
  void initState() {
    getBatteryLevel();
    timer = Timer.periodic(Duration(milliseconds: 1000), (_) {
      if (mounted) {
        setState(() {
          newList = GetBatteryList;

          log(newList[3].toString());
        });
      } else {
        return;
      }
    });
  }

  static const platform = const MethodChannel('samples.flutter.dev/battery');
  String batteryLevel;
  List<dynamic> newList = <dynamic>[];
  List<dynamic> GetBatteryList = <dynamic>[
    "Loading...",
    "Loading...",
    "Loading...",
    "Loading...",
    "Loading...",
    "Loading..."
  ];

  ///String batteryLevel = 'batteryManager.level.toString()';

  @override
  Widget build(BuildContext context) {
    // BatteryManager batteryManager;
    newList = GetBatteryList;
    // getBatteryLevel();

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: double.infinity,
              height: 30,
              child: Card(
                // color: Colors.grey,

                child: Text(
                  "Density : " + newList[0] + " dpi",
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 15.00,
                  ),
                ),
              ),
            ),
            Divider(
              height: 2,
            ),
            Container(
              width: double.infinity,
              height: 30,
              child: Card(
                // color: Colors.grey,

                child: Text(
                  "Resolution : " + newList[1] + " x " + newList[2] + " Pixels",
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 15.00,
                  ),
                ),
              ),
            ),
            Divider(
              height: 2,
            ),
            Container(
              width: double.infinity,
              height: 30,
              child: Card(
                // color: Colors.grey,

                child: Text(
                  "Refresh Rate : " + newList[3] + " Hz",
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 15.00,
                  ),
                ),
              ),
            ),
            Divider(
              height: 2,
            ),
            Container(
              width: double.infinity,
              height: 60,
              child: Card(
                // color: Colors.grey,

                child: Text(
                  "HDR capabilities   " + newList[4],
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 15.00,
                  ),
                ),
              ),
            ),
            Divider(
              height: 2,
            ),
            Container(
              width: double.infinity,
              height: 30,
              child: Card(
                //color: Colors.grey,

                child: Text(
                  "HDR : " + newList[5],
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 15.00,
                  ),
                ),
              ),
            ),
            Divider(
              height: 2,
            ),
            Container(
              width: double.infinity,
              height: 30,
              child: Card(
                //color: Colors.grey,

                child: Text(
                  "Orientation : " + newList[6],
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 15.00,
                  ),
                ),
              ),
            ),
            Divider(
              height: 2,
            ),
            Container(
              width: double.infinity,
              height: 30,
              child: Card(
                //color: Colors.grey,

                child: Text(
                  "Wide Color Gamut : " + newList[7],
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 15.00,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getBatteryLevel() async {
    try {
      GetBatteryList = await platform.invokeMethod('displayInfo');
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {});
  }
}
