import 'dart:typed_data';

// ignore: import_of_legacy_library_into_null_safe
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:url_launcher/url_launcher.dart';


Future<List<String>> readTextFile({required String txtFileName}) async {

  String allFile =  await rootBundle.loadString('assets/$txtFileName');

  return allFile.split('\n');
}

void launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch : $url';
  }
}

  Future<bool> checkConnectivity ()async{
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    // I am connected to a mobile network.
  }
  else if (connectivityResult == ConnectivityResult.wifi) {
    // I am connected to a wifi network.
  }
  else if(connectivityResult == ConnectivityResult.none){
    return false;
  }
  return true;
}

//---- simple notification message -----
void simpleNotificationMessage({
  required String msgText,
  Color msgColor = Colors.green,
  NotificationPosition notificationPosition = NotificationPosition.bottom,
}){
  showSimpleNotification(
    Text(
      msgText,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 20),
    ),
    position: notificationPosition,
    background: msgColor,
  );
}
//---- simple notification message -----