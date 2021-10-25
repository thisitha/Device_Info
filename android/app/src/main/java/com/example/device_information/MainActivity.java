package com.example.device_information;

import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

import android.app.ActivityManager;
import android.content.Context;
import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.hardware.Sensor;
import android.hardware.SensorManager;
import android.hardware.display.DisplayManager;
import android.os.BatteryManager;
import android.os.Build;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;
import android.os.Bundle;
import android.os.Environment;
import android.os.StatFs;
import android.text.format.Formatter;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.Display;
import android.view.WindowManager;

import com.igrik.cpu_reader.CpuInfo;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.RandomAccessFile;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;


public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "samples.flutter.dev/battery";
    public DisplayManager displayManager ;
    ArrayList<String> batteryDetails = new ArrayList<>();
    ArrayList<String> displayDetails = new ArrayList<>();
    ArrayList<String> mainDetails = new ArrayList<>();


    BatteryManager batteryManager;

    @RequiresApi(api = VERSION_CODES.N)
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            // Note: this method is invoked on the main thread.

                             if (call.method.equals("getLevel")) {
                                    batteryDetails.clear();
                                 result.success(batteryInfo());

//
//                                if (batteryLevel != -1) {
//                                    result.success(newList);
//                                } else {
//                                    result.error("UNAVAILABLE", "Battery level not available.", null);
//                                }
                            }else if(call.method.equals("displayInfo")){
                                 result.success(displayInfo());
                             }else if(call.method.equals("mainInfo")){
                                 result.success(mainUI());
                             }
                             else {
                                result.notImplemented();
                            }
                        }
                );
    }

    @RequiresApi(api = VERSION_CODES.N)
    public ArrayList<String> displayInfo(){




        DisplayMetrics metrics = getResources().getDisplayMetrics();
        String displayDensity =Integer.toString(metrics.densityDpi);
        String displayHight = Integer.toString(metrics.heightPixels);
        String displayWidth = Integer.toString(metrics.widthPixels);

        Display display = ((WindowManager) getSystemService(Context.WINDOW_SERVICE)).getDefaultDisplay();


        Boolean displayWideColour= false;
        String displayWide= "";//WIDE COLOUR GAMUT
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
            displayWideColour =display.isWideColorGamut();
            if(displayWideColour==true){
                displayWide="Supported";
            }
            else {
                displayWide = "Not Supported";
            }
        }




        String displayO = String.valueOf(display.getRotation()); ///Orientation
        String displayOrientation;
        if(displayO.equals(1)){
            displayOrientation = "Landscape";
        }else{
            displayOrientation = "Portrait";
        }
        Display.HdrCapabilities hdrCapabilities = display.getHdrCapabilities();

        int [] hdr = hdrCapabilities.getSupportedHdrTypes();
        int value = hdr.length;
        String displayHDR="";
        String displayHDRsupport = "Not Support" ;
        Log.e("xa", "HDR: "+ value );
        for(int i=0; i<value;i++){
            if(hdr[i]==1){
                displayHDR  = displayHDR + " , Dolby Vision high dynamic range (HDR)";
            }else if(hdr[i]==2){
                displayHDR  = displayHDR + ", HDR10 display";
            }else if(hdr[i]==3){
                displayHDR  = displayHDR + ",  Hybrid Log-Gamma HDR display";
            }
            displayHDRsupport= "Suppported";

        }
        int numberOfInstalledApps = getPackageManager().getInstalledApplications(0).size();
        float refreshRating = display.getRefreshRate();
        String displayRefresh = Float.toString(refreshRating);
       //displayDetails.add(Integer.toString(displayDensity));
        //Log.e("TAG", "displayInfo: " displayDensity) );
        Log.e("TAG", "displayInfo: "+ displayHight );
        Log.e("TAG", "displayInfo: "+ displayWidth  );
        //displayDetails.add(displayDensity);
//        displayDetails.add(Integer.toString(displayWidth));
//        displayDetails.add(Float.toHexString(displayRefresh));
         displayDetails.add(displayDensity);
        displayDetails.add(displayHight);
        displayDetails.add(displayWidth);
        displayDetails.add(displayRefresh);
        displayDetails.add(displayHDR);
        displayDetails.add(displayHDRsupport);
         displayDetails.add(displayOrientation);
         displayDetails.add( displayWide);





        return (displayDetails);

    }

    @RequiresApi(api = VERSION_CODES.N)
    public ArrayList<String> mainUI(){

        mainDetails.clear();
        SensorManager sensorManager;

        sensorManager = (SensorManager) getSystemService(Context.SENSOR_SERVICE);
        List<Sensor> deviceSensors = sensorManager.getSensorList(Sensor.TYPE_ALL);
        int sensorQty = deviceSensors.size();


////////////////////////////////////////////////////////////////////////////////

        String androidVersion = VERSION.RELEASE;
        float androidV  = Float.parseFloat(androidVersion);
        if(androidV == 11) {
            androidVersion = "Android 11";

        } if(androidV == 10){
            androidVersion= "Android 10";
        } if(androidV == 9){
            androidVersion= "Android Pie(9.0)";
        } if((androidV >7) && (androidV<9)){
            androidVersion= "Oreo";
        }if((androidV >6) && (androidV<8)){
            androidVersion= "Nougat("+androidVersion+")";
        }if((androidV >5) && (androidV<7)){
            androidVersion= "Marshmallow("+androidVersion+")";
        }if((androidV >4) && (androidV<6)){
            androidVersion= "Lollipop("+androidVersion+")";
        }if((androidV >4.3) && (androidV<5)){
            androidVersion= "KitKat("+androidVersion+")";
        }if((androidV >4) && (androidV<4.4)){
            androidVersion= "Jelly Bean("+androidVersion+")";
        }if((androidV >3.3) && (androidV<4.1)){
            androidVersion= "Ice Cream Sandwich("+androidVersion+")";
        }

///////////////////////////////////////////////////////////////////////////////////////////////////



        IntentFilter ifilter = new IntentFilter(Intent.ACTION_BATTERY_CHANGED);
        Intent batteryStatus = getApplicationContext().registerReceiver(null, ifilter);
        int level = batteryStatus.getIntExtra(BatteryManager.EXTRA_LEVEL, -1);

        int numberOfInstalledApps = getPackageManager().getInstalledApplications(0).size();

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        String maxCPU = "";
        ProcessBuilder cmd;
        try {
            String[] args = { "/system/bin/cat",
                    "/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq" };
            cmd = new ProcessBuilder(args);
            Process process = cmd.start();
            InputStream in = process.getInputStream();
            byte[] re = new byte[24];
            while (in.read(re) != -1) {
                maxCPU = maxCPU + new String(re);
            }
            in.close();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        String FinalMAXCPU = maxCPU.substring(0,4);

        String finalCURRENTCPUUSAGE = "null";
try {
    double currentFreq;
    RandomAccessFile readerCurFreq;
    readerCurFreq = new RandomAccessFile("/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq", "r");
    String curfreg = readerCurFreq.readLine();
    currentFreq = Double.parseDouble(curfreg) / 1000;
    double temp = Double.parseDouble(FinalMAXCPU);
    currentFreq = (currentFreq/temp)*100;
    readerCurFreq.close();
    finalCURRENTCPUUSAGE = Double.toString(currentFreq).substring(0,4);
  //  Log.e("RAM PERSENTAGE",finalCURRENTCPUUSAGE);
}catch (Exception e){

}




///////////////////////////////////////////////////////////////////////////////////////////////////////////////



        StatFs stat = new StatFs(Environment.getExternalStorageDirectory().getPath());
        long bytesAvailable = (long)stat.getBlockSize() *(long)stat.getBlockCount();
        long avilableStorage = stat.getFreeBytes();//bytesAvailable / 1048576;
        float avilableStorageGB = Float.valueOf(avilableStorage);
        avilableStorageGB = avilableStorageGB/1024/1024/1024;


        File path = Environment.getDataDirectory();
        StatFs stat2 = new StatFs(path.getPath());
        long blockSize = stat2.getBlockSize();
        long availableBlocks = stat2.getAvailableBlocks();
        long totalStorage = stat2.getTotalBytes();

        Float totaltemp  = Float.valueOf(totalStorage)/1024/1024/1024;
         DecimalFormat df = new DecimalFormat("0.00");
         avilableStorageGB  = Float.parseFloat(df.format(avilableStorageGB));
         String finalAVILABLESTORAGE = Float.toString(avilableStorageGB);

        Float totalStorageGB = Float.valueOf(df.format(totaltemp));
        String finalTOTALSTORAGE = Float.toString(totalStorageGB);
        //totaltemp = Float.valueOf(Math.round(totaltemp));
        String finalSTORAGEAVERAGE= "";
        try{
            Float temp2 = 100- ((avilableStorageGB/totalStorageGB) *100);
              finalSTORAGEAVERAGE = String.valueOf(temp2).substring(0,4);
            Log.e("Storage Persentage", finalSTORAGEAVERAGE);
        }catch (Exception e){

        }



/////////////////////////////////////////////////////////////////////////////////////////////////////////////

        ActivityManager.MemoryInfo mi = new ActivityManager.MemoryInfo();
        ActivityManager activityManager = (ActivityManager) getSystemService(ACTIVITY_SERVICE);
        activityManager.getMemoryInfo(mi);
        double availableMegs = mi.availMem / 0x100000L;
        double percentAvail = mi.availMem / (double)mi.totalMem * 100.0;
        percentAvail = 100-percentAvail;
        long totalMemory = mi.totalMem;
        String finalRAMPERSENTAGE = Double.toString(percentAvail).substring(0,4);


        Float finalTOTALRAM = Float.parseFloat(String.valueOf(totalMemory ));
        Float finalAVILABLERAM = Float.parseFloat(String.valueOf(availableMegs/1024 ));
      //  Log.e("","RAM PERSENTAGE : "+percentAvail);


        double avilableRAM = mi.availMem / (double)mi.totalMem * 100.0;
        //////////////////
        IntentFilter ifilter2 = new IntentFilter(Intent.ACTION_BATTERY_CHANGED);
        Intent batteryStatus2 = getApplicationContext().registerReceiver(null, ifilter);
        int batteryLevel2 = batteryStatus.getIntExtra(BatteryManager.EXTRA_LEVEL, -1);
 ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        mainDetails.add(Integer.toString(numberOfInstalledApps));
        mainDetails.add(Integer.toString(sensorQty));
        mainDetails.add(androidVersion);
        mainDetails.add(Float.toString(finalTOTALRAM).substring(0,4));
        mainDetails.add(Float.toString(finalAVILABLERAM).substring(0,4));
        mainDetails.add(finalRAMPERSENTAGE);
        mainDetails.add(finalTOTALSTORAGE);
        mainDetails.add(finalAVILABLESTORAGE);
        mainDetails.add(finalSTORAGEAVERAGE);
        mainDetails.add(Integer.toString(batteryLevel2));
        mainDetails.add(FinalMAXCPU);

//        Log.e("TOTAL Storage", finalTOTALSTORAGE);
//        Log.e("AVILABLE storage",finalAVILABLESTORAGE);
//        Log.e("AVILABLE RAM",Float.toString(finalAVILABLERAM).substring(0,4));
//        Log.e("MAXCPU",finalCURRENTCPUUSAGE);
//        Log.e("RAM PERSENTAGE",finalRAMPERSENTAGE);
//        Log.e("TOTAL RAM",Float.toString(finalTOTALRAM).substring(0,4));
//        Log.e("TAG",Double.toString(avilableRAM));
//        Log.e("TAG",Double.toString(avilableRAM));



        return (mainDetails);

    }





    public ArrayList<String> batteryInfo(){
        IntentFilter ifilter = new IntentFilter(Intent.ACTION_BATTERY_CHANGED);
        Intent batteryStatus = getApplicationContext().registerReceiver(null, ifilter);
        String batteryPowerSource= "";

        int batteryStatusNumber = batteryStatus.getIntExtra(BatteryManager.EXTRA_PLUGGED,-1);

        if(batteryStatusNumber==1){
                batteryPowerSource  = "Plugged In AC";
        }else if(batteryStatusNumber==2){
                batteryPowerSource="Plugged In USB";
        }else if (batteryStatusNumber==4){
                batteryPowerSource= "Charging Wireless";

        }else if (batteryStatusNumber ==0){
                batteryPowerSource = "Discharging";
        }

        int batteryHealth = batteryStatus.getIntExtra(BatteryManager.EXTRA_HEALTH, -2);


        String batteryHealthStatus = "";
            if(batteryHealth==1){
                batteryHealthStatus = "Battery Health Unknown";
            }else  if(batteryHealth==6){
                batteryHealthStatus = "Battery Failure";
            }else if(batteryHealth==5){
                    batteryHealthStatus = "Battery Over Voltage";
            }else if(batteryHealth==3){
                    batteryHealthStatus = "Battery OverHeating";
            }else if (batteryHealth==2){
                    batteryHealthStatus = "Battery Health is Good";
            }else if(batteryHealth==4){
                    batteryHealthStatus = "Battery Is DEAD!";
            }else if (batteryHealth==7){
                    batteryHealthStatus = "Battery Is in Cold State";
            }



        String batteryTechnology = batteryStatus.getStringExtra(BatteryManager.EXTRA_TECHNOLOGY);
        int batteryVoltage = batteryStatus.getIntExtra(BatteryManager.EXTRA_VOLTAGE, -1);
        int batteryLevel = batteryStatus.getIntExtra(BatteryManager.EXTRA_LEVEL, -1);
        int batteryTemperature =batteryStatus.getIntExtra(BatteryManager.EXTRA_TEMPERATURE, -1)/10;
        //int ex2 = batteryStatus.getIntExtra( BatteryManager.EXTRA_TECHNOLOGY , -2);

        batteryDetails.add(Integer.toString(batteryLevel));
        batteryDetails.add(Integer.toString(batteryVoltage));
        batteryDetails.add(Integer.toString(batteryTemperature));
        batteryDetails.add(batteryPowerSource);
        batteryDetails.add(batteryTechnology);
       batteryDetails.add(batteryHealthStatus);
    //  batteryDetails.add(ex1);

        return(batteryDetails);
    }


}
