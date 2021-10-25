import 'dart:async';
import 'dart:developer' as developer;

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cpu_reader/cpu_reader.dart';
import 'package:cpu_reader/cpuinfo.dart';
import 'package:device_information/display.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_settings/open_settings.dart';
import 'batteryInfo.dart';
import 'cpuInfo.dart';
import 'deviceInfo.dart';
import 'global.dart';

main() {
  runApp((MaterialApp(
    title: 'Navigation Basics',
    home: Myapp(),
  )));

  hello();
}

class Myapp extends StatefulWidget {
  @override
  void dispose() {
    timer.cancel();
  }

  @override
  _MyappState createState() => _MyappState();
}

getCPUCore() async {
  CpuReader.cpuStream(4000).listen(
      (cpuInfo) async => core0 = await CpuReader.getCurrentFrequency(0));
  CpuInfo cpuInfo = await CpuReader.cpuInfo;

  MaxCPU = newList[10];
  currentCPU = core0;
  currentMAX = int.parse(MaxCPU);
  finalCPUAVERAGE = (currentCPU / ~currentMAX) * 100 * -1;
  finalCPUPERSENTAGE = finalCPUAVERAGE.toString().substring(0, 4);
  //log( finalCPUAVERAGE.toString().substring(0,4) );
  // log( currentMAX.toString()+"bbbbbbbbbbbbbbbbbbbb");
}

assignValues() {}

class _MyappState extends State<Myapp> {
  String hello = "sadfvb";

  @override
  void initState() {
    // const platform = const MethodChannel('samples.flutter.dev/battery');
    // String batteryLevel;
    // List<dynamic> newList = <dynamic>[];
    // List<dynamic> GetBatteryList = <dynamic>[];

    getBatteryLevel();
    timer = Timer.periodic(Duration(milliseconds: 4000), (_) {
      if (mounted) {
        setState(() {
          getBatteryLevel();
          getCPUCore();
          assignValues();
          newList.clear();
          newList = GetBatteryList;
        });
      } else {
        print("Timer closed");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: AnimatedSplashScreen(
        splash: Image.asset('assets/images/logo.png'),

        splashTransition: SplashTransition.fadeTransition,
        animationDuration: Duration(milliseconds: 1000),
        splashIconSize: 300.00,

        //pageTransitionType: PageTransitionType.scale,
        backgroundColor: Colors.white,

        nextScreen: DefaultTabController(
          length: 5,
          child: Scaffold(
              appBar: AppBar(
                actions: [
                  PopupMenuButton<int>(
                    onSelected: (item) => onSelected(context, item),
                    itemBuilder: (context) => [
                      PopupMenuItem<int>(
                        value: 0,
                        child: Text("About",
                            style: TextStyle(
                              fontSize: 18,
                              foreground: Paint(),
                            )),
                      )
                    ],
                    elevation: 20.00,
                    icon: Icon(Icons.more_vert),
                  )
                ],
                elevation: 10.00,
                shadowColor: Colors.green,
                backgroundColor: Colors.amber,
                bottom: TabBar(
                  labelStyle: TextStyle(fontSize: 20.00),
                  unselectedLabelColor: Colors.green,
                  unselectedLabelStyle: TextStyle(fontSize: 15.00),
                  isScrollable: true,
                  tabs: [
                    Tab(
                      child: Text("Dashboard"),
                    ),
                    Tab(
                      child: Text("Device"),
                    ),
                    Tab(
                      child: Text("CPU"),
                    ),
                    Tab(
                      child: Text("Battery"),
                    ),
                    Tab(
                      child: Text("Display"),
                    )
                  ],
                ),
                title: Text("Device Information"),
              ),
              body: TabBarView(
                children: [
                  // Column(
                  //   children: [
                  //     Center(
                  //       child: Card(
                  //        color: Colors.red,
                  //         child: Column(
                  //           children: [
                  //             Text("data"),
                  //             Text("Data2")
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  //  ),
                  dashboard(),
                  deviceInfomation(),
                  cpuIndormation(),

                  batteryInformation(),
                  //  batteryInformation(),
                  displayInformation()
                ],
              )),
        ),
      ),
    );
  }

  Future<void> getBatteryLevel() async {
    const platform = const MethodChannel('samples.flutter.dev/battery');
    String batteryLevel;

    try {
      GetBatteryList = await platform.invokeMethod('mainInfo');
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }
  }

  onSelected(BuildContext context, int item) {
    try {
      if (item == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SecondRoute()),
        );
      }
    } catch (Exception) {}
  }
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Me :)"),
        elevation: 10.00,
        shadowColor: Colors.green,
        backgroundColor: Colors.amber,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Developer: Thisitha Kavinda",
            style: TextStyle(fontSize: 22.00),
          ),
          Divider(
            height: 30,
            color: Colors.white,
          ),
          Text(
            "Version: v1.1",
            style: TextStyle(fontSize: 19.00),
          ),
        ],
      )),
    );
  }
}

class dashboard extends StatefulWidget {
  @override
  void dispose() {
    timer.cancel();
  }

  @override
  _dashboardState createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  @override
  void dispose() {
    timer.cancel();
  }

  @override
  void initState() {
    if (this.mounted) {
      new Timer.periodic(
          Duration(milliseconds: 2000),
          (Timer t) => setState(() {
                getBatteryLevel();
                newList = GetBatteryList;

                //batteryBAR = 0.8;//double.parse(newList[9]) /~100;
                cpuBAR =
                    double.parse(finalCPUAVERAGE.toString().substring(0, 4)) /
                        ~100 *
                        -1;
                // storageBAE =0.7;// double.parse(newList[8])/~100;
                batteryBAR = double.parse(newList[9]) / ~100 * -1;
                //  storageBAR =0.7;// double.parse(newList[8])/~100;
                meomryBAR = double.parse(newList[5]) / ~100 * -1;
                storageBAE = double.parse(newList[8]) / ~100 * -1;

                developer.log(storageBAE.toString());
              }));
    } else {
      super.dispose();
    }

    ////////

    // timer = Timer.periodic(Duration(milliseconds: 1000), (_) {
    //   if (mounted){
    //     setState(() {
    //
    //
    //     });
    //   }else{
    //     return;
    //   }
    //
    // });
  }

  static const platform = const MethodChannel('samples.flutter.dev/battery');
  String batteryLevel;
  List<dynamic> newList = <dynamic>[
    "Loading...",
    "Loading...",
    "Loading...",
    "Loading...",
    "Loading...",
    "Loading...",
    "Loading...",
    "Loading...",
    "Loading...",
    "Loading..."
  ];
  List<dynamic> GetBatteryList = <dynamic>[
    "Loading...",
    "Loading...",
    "Loading...",
    "Loading...",
    "Loading...",
    "Loading...",
    "Loading...",
    "Loading...",
    "Loading...",
    "Loading..."
  ];
  double batteryBAR = 0.1;
  double meomryBAR = 0.1;
  double storageBAE = 0.1;
  double cpuBAR = 0.1;

  /// String batteryLevel = 'batteryManager.level.toString()';

  @override
  Widget build(BuildContext context) {
    newList = GetBatteryList;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 10.00),
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
                        ListTile(onTap: (){
                          OpenSettings.openAppSetting();
                        },
                            leading: Icon(
                              Icons.apps,
                              size: 60.00,
                            ),
                            title: Text("Apps"),
                            subtitle: Text(newList[0] + " Apps installed")),
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
                          onTap: () {

                          },
                          leading: Icon(
                            Icons.sensor_door,
                            size: 60.00,
                          ),
                          title: Text("Sensors"),
                          subtitle: Text(newList[1] + " Sensors")),
                    ],
                  ),
                ))
              ],
            ),
            Divider(
              height: 3,
            ),
            Center(
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
                      onTap: (){
                        OpenSettings.openDeviceInfoSetting();
                      },
                        leading: Icon(
                          Icons.android,
                          size: 60.00,
                        ),
                        title: Text("Android Version"),
                        subtitle: Text(newList[2])),
                  ],
                ),
              ),
            ),
            Divider(
              height: 4,
            ),

            Center(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.00),
                        bottomRight: Radius.circular(10.00),
                        topLeft: Radius.circular(10.00),
                        topRight: Radius.circular(10.00))),
                elevation: 30.00,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(onTap: (){
                     // OpenSettings.openInternalStorageSetting();
                    },
                      leading: Icon(
                        Icons.memory_rounded,
                        size: 60.00,
                      ),
                      title: Text("Memory Usage"),
                      subtitle: Text("Usage : " +
                          newList[5] +
                          "%" +
                          "   (" +
                          newList[4] +
                          " GB" +
                          " / " +
                          newList[3] +
                          " GB" +
                          ")"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LinearProgressIndicator(
                        value: meomryBAR,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Divider(
              height: 4,
            ),
            Center(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.00),
                        bottomRight: Radius.circular(10.00),
                        topLeft: Radius.circular(10.00),
                        topRight: Radius.circular(10.00))),
                elevation: 30.00,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(onTap: (){
                      OpenSettings.openInternalStorageSetting();
                    },
                      leading: Icon(
                        Icons.sd_storage_outlined,
                        size: 40.00,
                      ),
                      title: Text('Internal Storage'),
                      subtitle: Text("Usage : " +
                          newList[8] +
                          "%" +
                          "   (" +
                          newList[7] +
                          " GB" +
                          " / " +
                          newList[6] +
                          " GB" +
                          ")"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LinearProgressIndicator(
                        value: storageBAE,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Divider(
              height: 4,
            ),
            Center(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.00),
                        bottomRight: Radius.circular(10.00),
                        topLeft: Radius.circular(10.00),
                        topRight: Radius.circular(10.00))),
                elevation: 30.00,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(
                        Icons.settings_applications,
                        size: 40.00,
                      ),
                      title: Text('CPU '),
                      subtitle: Text("Usage : " +
                          finalCPUPERSENTAGE +
                          "%" +
                          "   (" +
                          currentCPU.toString() +
                          "Mhz" +
                          " / " +
                          currentMAX.toString() +
                          "Mhz" +
                          ")"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LinearProgressIndicator(
                        value: cpuBAR,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Divider(
              height: 4,
            ),
            Center(
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
                    ListTile(onTap: (){
                      OpenSettings.openBatterySaverSetting();
                    },
                      leading: Icon(
                        Icons.battery_alert,
                        size: 60.00,
                      ),
                      title: Text("Battery Usage"),
                      subtitle: Text("Current : " +
                          newList[9] +
                          "%" +
                          "   (" +
                          newList[9] +
                          "%" +
                          " /  100%)"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LinearProgressIndicator(
                        value: batteryBAR,
                      ),
                    )
                  ],
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
      GetBatteryList = await platform.invokeMethod('mainInfo');
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {});
  }
}

/////////////
