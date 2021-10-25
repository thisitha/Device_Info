
import 'dart:developer';
import 'dart:async';
import 'dart:io';



import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:device_info/device_info.dart';

import 'cpuInfo.dart';


class batteryInformation extends StatefulWidget {
  @override
  void  dispose() {
    timer?.cancel();
  }




  @override
  _batteryInfomationState createState() => _batteryInfomationState();
}

class _batteryInfomationState extends State<batteryInformation> {
  @override
  void  dispose() {
    timer?.cancel();
  }
  @override
  void initState() {
    if (mounted) {
      new Timer.periodic(Duration(milliseconds: 2000), (Timer t) =>

          setState(() {
            getBatteryLevel();
            newList = GetBatteryList;

            log("batterybaqttervvfdxhhn");
          }));
    }else{
          dispose();
        }





  }

  static const platform = const MethodChannel('samples.flutter.dev/battery');
  String batteryLevel;
  List<dynamic> newList = <dynamic>[];

  List<dynamic> GetBatteryList = <dynamic>["Loading...","Loading...","Loading...","Loading...","Loading...","Loading..."];



  /// String batteryLevel = 'batteryManager.level.toString()';

  @override
  Widget build(BuildContext context) {
    // BatteryManager batteryManager;
    newList =  GetBatteryList;
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

                child: Text("Battery Level : " + newList[0] +"%",

                  textAlign: TextAlign.center,

                  softWrap: true,
                  style: TextStyle(
                    fontSize: 15.00,
                  ),
                ),
              ),
            ),




            Divider(height: 2,),
            Container(

              width: double.infinity,
              height: 30,
              child: Card(

                // color: Colors.grey,

                child: Text("Battery Voltage : " + newList[1] +" mV",

                  textAlign: TextAlign.center,

                  softWrap: true,
                  style: TextStyle(
                    fontSize: 15.00,
                  ),
                ),
              ),
            ),

            Divider(height: 2,),Container(

              width: double.infinity,
              height: 30,
              child: Card(

                // color: Colors.grey,

                child: Text("Battery Temperature : " + newList[2]+" °C",

                  textAlign: TextAlign.center,

                  softWrap: true,
                  style: TextStyle(
                    fontSize: 15.00,
                  ),
                ),
              ),
            ),
            Divider(height: 2,),Container(

              width: double.infinity,
              height: 30,
              child: Card(

                // color: Colors.grey,

                child: Text("Battery Power Status : " + newList[3],

                  textAlign: TextAlign.center,

                  softWrap: true,
                  style: TextStyle(
                    fontSize: 15.00,
                  ),
                ),
              ),
            ),
            Divider(height: 2,),Container(

              width: double.infinity,
              height: 30,
              child: Card(

                // color: Colors.grey,

                child: Text("Battery Technology : " + newList[4],

                  textAlign: TextAlign.center,

                  softWrap: true,
                  style: TextStyle(
                    fontSize: 15.00,
                  ),
                ),
              ),
            ),
            Divider(height: 2,),Container(

              width: double.infinity,
              height: 30,
              child: Card(

                // color: Colors.grey,

                child: Text("Battery Health Status : " + newList[5],

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
      GetBatteryList = await platform.invokeMethod('getLevel');

    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {


    });
  }



}


