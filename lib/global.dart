library my_project.global;

import 'dart:ffi';

import 'package:flutter/services.dart';

// set default values for the initial run

  const platform = const MethodChannel('samples.flutter.dev/battery');
String batteryLevel;
List<dynamic> newList = <dynamic>[];
List<dynamic> GetBatteryList = <dynamic>[];
String MaxCPU = "00";
double finalCPUAVERAGE=0.0000;
String finalCPUPERSENTAGE="0.000";
String hellox = "CDDD";
int totalCPU;
int  currentCPU     ;
int currentMAX      ;
//double batteryBAR ;
//String cpuBAR=finalCPUAVERAGE.toString().substring(0,4)/~100 ;
//double storageBAR ;
//double meomryBAR  ;
