import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import 'View/LoginPage/LoginPage.dart';

void main() {
  // Initialize the network connectivity
  WidgetsFlutterBinding.ensureInitialized();
  NetworkConnectivity.instance.initialise(); //
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Connection Checker Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const ConnectionCheckerDemo(),
    );
  }
}

class OnlinePage extends StatelessWidget {
  const OnlinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Online Page'),
          backgroundColor: Colors.blue,
        ),
        body: const Center(
          child: Text('You are online!'),
        ),

      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}

class ConnectionCheckerDemo extends StatefulWidget {
  const ConnectionCheckerDemo({Key? key}) : super(key: key);

  @override
  State<ConnectionCheckerDemo> createState() => _ConnectionCheckerDemoState();
}

class _ConnectionCheckerDemoState extends State<ConnectionCheckerDemo> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final NetworkConnectivity _networkConnectivity = NetworkConnectivity.instance;
  String string = 'Offline';

  @override
  void initState() {
    super.initState();
    // Listen for connectivity changes
    _networkConnectivity.myStream.listen((source) {
      _connectionStatus = source;
      _updateConnectionStatus();
    });
  }

  void _updateConnectionStatus() {
    setState(() {
      switch (_connectionStatus) {
        case ConnectivityResult.mobile:
          string = 'Mobile: Online';
          break;
        case ConnectivityResult.wifi:
          string = 'WiFi: Online';
          break;
        case ConnectivityResult.none:
        default:
          string = 'Offline';
      }
      print("xxx${string}");
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          string,
          style: const TextStyle(fontSize: 30),
        ),
      ),
    );

    // Check if the network is online, and if so, redirect to the OnlinePage
    if (string.contains('Online')) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => LoginPage(),
      ));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            string,
            style: const TextStyle(fontSize: 30),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff6ae792),
      ),
      body: Center(
        child: Text(
          string,
          style: const TextStyle(fontSize: 54),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _networkConnectivity.disposeStream();
    super.dispose();
  }
}

class NetworkConnectivity {
  NetworkConnectivity._();

  static final _instance = NetworkConnectivity._();

  static NetworkConnectivity get instance => _instance;
  final _networkConnectivity = Connectivity();
  final _controller = StreamController.broadcast();

  Stream get myStream => _controller.stream;

  void initialise() {
    _networkConnectivity.onConnectivityChanged.listen((result) {
      _controller.sink.add(result);
    });
  }

  void disposeStream() => _controller.close();
}
