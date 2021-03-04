import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';

//TOKEN USER
//d5Q7rT8pRDuFjGcLlgCNtf:APA91bGow8Zvkb4jBXY_AS_EEEChNUyWjhIJ0b5IL2MIyBDOybzs8GhW35qSdfLUUN98qJrsSw0sjr7TISa9yvboodMC1ATQBX_dIye12Vly5bGQ8K9hfoe1zTIFOOeg6pGtaR7hUA89

class PushNotificationsProvider {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _mensajesStreamController = StreamController<String>.broadcast();

  Stream<String> get mensajesStream => _mensajesStreamController.stream;

  static Future<dynamic> onBackgroundMessage(Map<String, dynamic> message) {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }

    // Or do other work.
  }

  initNotifications() async {
    await _firebaseMessaging.requestNotificationPermissions();
    final token = await _firebaseMessaging.getToken();

    print("==== FCM Token ====");
    print(token);

    _firebaseMessaging.configure(
      onMessage: onMessage,
      onBackgroundMessage: onBackgroundMessage,
      onLaunch: onLaunch,
      onResume: onResume,
    );
  }

  Future<dynamic> onMessage(Map<String, dynamic> message) {
    print("==== onMessage ====");
    //print('message: $message');
    //print('argumento: $argumento');

    final argumento = message['data']['Comida'];
    _mensajesStreamController.sink.add(argumento);
  }

  Future<dynamic> onLaunch(Map<String, dynamic> message) {
    print("==== onLaunch ====");
    //print('argumento: $argumento');
    //print('onLaunch: $message');

    final argumento = message['data']['Comida'];
    _mensajesStreamController.sink.add(argumento);
  }

  static Future<dynamic> onResume(Map<String, dynamic> message) {
    print("==== onResume ====");
    print('onResume: $message');

    final argumento = message['data']['Comida'];
    //print('argumento: $argumento');
  }

  dispose() {
    _mensajesStreamController?.close();
  }
}
