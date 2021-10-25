
import 'dart:async';
import 'dart:developer';

import 'dart:math';

import 'package:device_information/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:device_info/device_info.dart';
import 'package:cpu_reader/cpu_reader.dart';
import 'package:cpu_reader/cpuinfo.dart';
import 'package:system_info/system_info.dart';
import 'dart:developer' as developer;

  int core0 = 0;
int core1 = 0;
int core2 = 0;
int core3 = 0;
int core4 = 0;
int core5 = 0;
int core6 = 0;
int core7 = 0;
String deviceArchitecture = SysInfo.kernelArchitecture;
String devicecpuName = SysInfo.kernelName;

String devicekernalVersion = SysInfo.kernelVersion;
int devicenumberProcessors = SysInfo.processors.length;
int devicecpuType =SysInfo.kernelBitness;
final processors1 = SysInfo.processors;
var processor = processors1[1];
//String deviceCpuVndor = ;
String deviceCpuVndor = processor.vendor;
String deviceCpuName = processor.architecture as String;
String hello123;


//String deviceCores = processors1.ar



Timer timer;
cpuinfoGetter() async {
  CpuInfo cpuInfo = await CpuReader.cpuInfo;
  
  //print('Number of Cores ${cpuInfo.numberOfCores}');

     core0 = await CpuReader.getCurrentFrequency(3) ;



  //print('Core number 2 freq ${ex1} Mhz');


  CpuReader.cpuStream(2000).listen((cpuInfo) async => core0 = await CpuReader.getCurrentFrequency(0));
  CpuReader.cpuStream(2000).listen((cpuInfo) async => core1 = await CpuReader.getCurrentFrequency(1));
  CpuReader.cpuStream(2000).listen((cpuInfo) async => core2 = await CpuReader.getCurrentFrequency(2));
  CpuReader.cpuStream(2000).listen((cpuInfo) async => core3 = await CpuReader.getCurrentFrequency(3));
  CpuReader.cpuStream(2000).listen((cpuInfo) async => core3 = await CpuReader.getCurrentFrequency(3));
  CpuReader.cpuStream(2000).listen((cpuInfo) async => core4 = await CpuReader.getCurrentFrequency(4));
  CpuReader.cpuStream(2000).listen((cpuInfo) async => core5 = await CpuReader.getCurrentFrequency(5));
  CpuReader.cpuStream(2000).listen((cpuInfo) async => core6 = await CpuReader.getCurrentFrequency(6));
  CpuReader.cpuStream(2000).listen((cpuInfo) async => core7 = await CpuReader.getCurrentFrequency(7));


totalCPU= core0+core1+core2+core3+core4+core5+core6+core7;
  // CpuReader.cpuStream(1000).listen((cpuInfo) => print("Temperature: ${cpuInfo.cpuTemperature}"));
}

class cpuIndormation extends StatefulWidget {

  @override
  void  dispose() {
    timer?.cancel();
  }

  @override
  _cpuIndormationState createState() => _cpuIndormationState();
}

class _cpuIndormationState extends State<cpuIndormation> {



  @override
  void initState() {

      timer = Timer.periodic(Duration(milliseconds: 1000), (_) {
        if (mounted){
          setState(() {});
        }else{
          return;
        }

      });


  }
  void hello(){
   // BatteryManager batteryManager;
  }




  @override
  Widget build(BuildContext context) {
    cpuinfoGetter();

    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
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


                          title: Text("Core 0"),
                          subtitle: Text(core0.toString()+"Mhz")),
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


                          title: Text("Core 1"),
                          subtitle: Text(core1.toString()+"Mhz")),
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


                          title: Text("Core 2"),
                          subtitle: Text(core3.toString()+"Mhz")),
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


                          title: Text("Core 3"),
                          subtitle: Text(core3.toString()+"Mhz")),
                    ],
                  ),
                ),
              ),

            ],
          ),
          Row(
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


                          title: Text("Core 4"),
                          subtitle: Text(core4.toString()+"Mhz")),
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


                          title: Text("Core 5"),
                          subtitle: Text(core5.toString()+"Mhz")),
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


                          title: Text("Core 6"),
                          subtitle: Text(core6.toString()+"Mhz")),
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


                          title: Text("Core 7"),
                          subtitle: Text(core7.toString()+"Mhz")),
                    ],
                  ),
                ),
              ),

            ],
          ),
          Container(

            width: double.infinity,
            height: 30,
            child: Card(

              // color: Colors.grey,

              child: Text("Kernel Architecture : "+ deviceArchitecture,

                textAlign: TextAlign.center,

                softWrap: true,
                style: TextStyle(
                  fontSize: 15.00,
                ),
              ),
            ),
          ),
          Container(

            width: double.infinity,
            height: 30,
            child: Card(

              // color: Colors.grey,

              child: Text("Kernel Name : " + devicecpuName,

                textAlign: TextAlign.center,

                softWrap: true,
                style: TextStyle(
                  fontSize: 15.00,
                ),
              ),
            ),
          ),
          Container(

            width: double.infinity,
            height: 30,
            child: Card(

              // color: Colors.grey,

              child: Text("CPU Type : "+ devicecpuType.toString() + " bit",

                textAlign: TextAlign.center,

                softWrap: true,
                style: TextStyle(
                  fontSize: 15.00,
                ),
              ),
            ),
          ),
          Container(

            width: double.infinity,
            height: 30,
            child: Card(

              // color: Colors.grey,

              child: Text("Kernel Version : " +devicekernalVersion,

                textAlign: TextAlign.center,

                softWrap: true,
                style: TextStyle(
                  fontSize: 15.00,
                ),
              ),
            ),
          ),
          Container(

            width: double.infinity,
            height: 30,
            child: Card(

              // color: Colors.grey,

              child: Text("Number Of Cores : "+ devicenumberProcessors.toString(),

                textAlign: TextAlign.center,

                softWrap: true,
                style: TextStyle(
                  fontSize: 15.00,
                ),
              ),
            ),
          ),
          Container(

            width: double.infinity,
            height: 30,
            child: Card(

              // color: Colors.grey,

              child: Text("Processor Vendor : " +deviceCpuVndor,

                textAlign: TextAlign.center,

                softWrap: true,
                style: TextStyle(
                  fontSize: 15.00,
                ),
              ),
            ),
          ),
          Container(

            width: double.infinity,
            height: 30,
            child: Card(

              // color: Colors.grey,

              child: Text("CPU  Architecture : " + deviceArchitecture,

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
    );
  }
}