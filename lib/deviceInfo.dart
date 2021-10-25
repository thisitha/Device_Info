
import 'dart:developer';

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:device_info/device_info.dart';
import 'package:device_information/main.dart';

import 'cpuInfo.dart';

String deviceName = "";
String deviceModel ="";
String deviceManufacturer ="";
String device ="";
String deviceBoard ="";
String deviceHardware ="";
String deviceBrand ="";
String deviceID ="";
String deviceFingerprint ="";

hello() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  deviceName = androidInfo.device;
  deviceModel=androidInfo.model;
  deviceManufacturer= androidInfo.manufacturer;
  device =androidInfo.device;
  deviceBoard = androidInfo.board;
  deviceHardware = androidInfo.hardware;
  deviceBrand = androidInfo.brand;
  deviceID = androidInfo.id;
  deviceFingerprint  =androidInfo.fingerprint;

  print('Running on ${androidInfo.model}');
}
class deviceInfomation extends StatelessWidget {
  @override
  void  dispose() {
    timer?.cancel();
  }


  @override
  Widget build(BuildContext context) {
hello();

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

                child: Text("Device Name : "+ deviceName,

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

                child: Text("Device Model: "+deviceModel,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 15.00,
                  ),
                ),
              ),
            ),
            Divider(height:2,),
            Container(
              height: 30,
              width: double.infinity,
              child: Card(
                // color: Colors.grey,

                child: Text("Manufacturer:"+deviceManufacturer,
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
              height: 30,
              width: double.infinity,
              child: Card(
                // color: Colors.grey,

                child: Text("Device: "+ device,
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
              height: 30,
              width: double.infinity,
              child: Card(
                // color: Colors.grey,

                child: Text("Board: "+deviceBoard,
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
              height: 30,
              width: double.infinity,
              child: Card(
                // color: Colors.grey,

                child: Text("Hardware: "+deviceHardware,
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
              height: 30,
              width: double.infinity,
              child: Card(
                // color: Colors.grey,

                child: Text("Brand: " +deviceBrand,
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
              height: 30,
              width: double.infinity,
              child: Card(
                // color: Colors.grey,

                child: Text("Android Device ID: "+ deviceID,
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
              child: Card(
                // color: Colors.grey,

                child: Text("Build FingerPrint: " +deviceFingerprint,
                  textAlign: TextAlign.center,

                  maxLines: 3,
                  softWrap: true,
                  style: TextStyle(
                    fontStyle:FontStyle.italic,
                    fontSize: 15.00,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
