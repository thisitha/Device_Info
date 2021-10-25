
import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'cpuInfo.dart';
import 'global.dart';

class topDashboard extends StatefulWidget {
  @override
  _topDashboardState createState() => _topDashboardState();

}

class _topDashboardState extends State<topDashboard> {

  static const platform = const MethodChannel('samples.flutter.dev/battery');
  String batteryLevel;
  List<dynamic> newList1 = <dynamic>[];
  List<dynamic> GetBatteryList1 = <dynamic>[];
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.00),
                    bottomRight: Radius.circular(10.00),
                    topLeft: Radius.circular(10.00),
                    topRight: Radius.circular(10.00))),
            elevation: 30.00,
            child: Column(
              children: [
                ListTile(
                    leading: Icon(
                      Icons.apps,
                      size: 60.00,
                    ),
                    title: Text("Apps"),
                    subtitle: Text(newList1[4] + " Apps installed")),
              ],
            ),
          ),
        ),
        Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.00),
                      bottomRight: Radius.circular(10.00),
                      topLeft: Radius.circular(10.00),
                      topRight: Radius.circular(10.00))),
              elevation: 30.00,
              child: Column(
                children: [
                  ListTile(
                      leading: Icon(
                        Icons.sensor_door,
                        size: 60.00,
                      ),
                      title: Text("Sensors"),
                      subtitle: Text("Number Of Sensors" + core0.toString())),
                ],
              ),
            ))
      ],
    );
  }


}
