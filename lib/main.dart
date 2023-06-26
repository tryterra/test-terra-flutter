import 'package:flutter/material.dart';
import 'package:terra_flutter_bridge/terra_flutter_bridge.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

Future<String?> generateAuthToken() async {
  const String url = 'https://api.tryterra.co/v2/auth/generateAuthToken';
  const String devID = 'testing';
  const String apiKey = 'RDBIv0Ir6taL5tqyMkxAn7AjIxXufsq57SX7jEAb';

  final Map<String, String> headers = {
    'accept': 'application/json',
    'dev-id': devID,
    'x-api-key': apiKey,
  };

  final response = await http.post(Uri.parse(url), headers: headers);
  
  if (response.statusCode == 200) {
    // Request successful, extract and return the token
    final body = json.decode(response.body);
    final String? token = body['token'];
    return token;
  } else {
    // Request failed, handle the error here
    print('Request failed with status: ${response.statusCode}');
    return null;
  }
}

// Future<String?> deauthenticateUser() async {
//   const String url = 'https://api.tryterra.co/v2/auth/generateAuthToken';
//   const String devID = 'testing';
//   const String apiKey = 'RDBIv0Ir6taL5tqyMkxAn7AjIxXufsq57SX7jEAb';

//   final Map<String, String> headers = {
//     'accept': 'application/json',
//     'dev-id': devID,
//     'x-api-key': apiKey,
//   };

//   final response = await http.post(Uri.parse(url), headers: headers);
  
//   if (response.statusCode == 200) {
//     // Request successful, extract and return the token
//     final body = json.decode(response.body);
//     final String? token = body['token'];
//     return token;
//   } else {
//     // Request failed, handle the error here
//     print('Request failed with status: ${response.statusCode}');
//     return null;
//   }
// }

Future<String?> initializeTerra(String referenceID) async {
  const String devID = "testing";
  
  var sMsg = await TerraFlutter.initTerra(devID, referenceID);
  print("initTerra refId: $referenceID, : ${sMsg?.success}");
  
  var uidMsg = await TerraFlutter.getUserId(Connection.appleHealth);
  print("UserMsg Status: ${uidMsg?.success}, ${uidMsg?.userId}");
  
  return uidMsg?.userId;
}

void main1() async {
  const String devID = "testing";
  var uid1 = await initializeTerra("t1");
  var token = await generateAuthToken();
  var cMsg = await TerraFlutter.initConnection(Connection.appleHealth, token!, true, []);
  print("Connected to Apple Health: ${cMsg?.success}");

  print("deauth user?");

  var uid2 = await initializeTerra("t2");
  var token1 = await generateAuthToken();
  var cMsg1 = await TerraFlutter.initConnection(Connection.appleHealth, token1!, true, []);
  print("Connected to Apple Health: ${cMsg1?.success}");
  print("done");
}


void main() {
  WidgetsFlutterBinding.ensureInitialized();

  main1();
  // TerraFlutter.ba

  // const String devID = "testing";
  // const String referenceID = "iosFlutter29";
  // print("Ref Id: $referenceID"); 
  // Future<SuccessMessage?> sMsgFuture = TerraFlutter.initTerra(devID, referenceID);
  // Future<SuccessMessage?> sMsgFuture1 = TerraFlutter.initTerra(devID, referenceID);
  // sMsgFuture.then((sMsg) {
  //   print(sMsg?.success);

  //   if (Platform.isAndroid) {
  //     print('Running on Android');
  //     Future<UserId?> uidFuture = TerraFlutter.getUserId(Connection.samsung);
  //     uidFuture.then((uidMsg) {
  //       print("UserMsg Status:");
  //       print(uidMsg?.success);
  //       print("User Id:");
  //       print(uidMsg?.userId);
  //     });

  //     final end = DateTime.utc(2023, 4, 19);
  //     final start = DateTime.utc(2023, 4, 17);

  //     // Future<DataMessage?> dailyFuture = TerraFlutter.getDaily(Connection.samsung, start, end, toWebhook: false);
  //     // dailyFuture.then((dailyMsg) {
  //     //   print("DailyMsg Status:");
  //     //   print(dailyMsg?.success);
  //     //   print("Data:");
  //     //   print(dailyMsg?.data);
  //     // });

  //     const String token = "e9244212c169f19a62c8f58a78ac141b7b2e63d3aaf7907b1875803de3ef759f";
  //     Future<SuccessMessage?> sMsgFuture = TerraFlutter.initConnection(Connection.samsung, token, true, []);
      
  //     sMsgFuture.then((sMsg) {
  //       print("Connected to Apple Health:");
  //       print(sMsg?.success);

  //       Future<UserId?> uidFuture = TerraFlutter.getUserId(Connection.samsung);
  //       uidFuture.then((uidMsg) {
  //         print("UserMsg Status:");
  //         print(uidMsg?.success);
  //         print("User Id:");
  //         print(uidMsg?.userId);
  //       });
  //     }).catchError((err) {
  //       print("Error making device connection");
  //     });

  //   } else if (Platform.isIOS) {
  //     print('Running on iOS');
  //     Future<UserId?> uidFuture = TerraFlutter.getUserId(Connection.appleHealth);
  //     uidFuture.then((uidMsg) {
  //       print("UserMsg Status: ${uidMsg?.success}");
  //       print("User Id: ${uidMsg?.userId}");


  //       // var initTerra = await TerraFlutter.initTerra(devID, referenceID);

  //       if (uidMsg?.userId != null) {
  //         print("userId found on device already, deauth and create new connection");

  //         const String token = "f27ce779e8a944820568f9cc23b409b9bd463583dc89e7ed63e56bf48bb6a762";
  //         Future<SuccessMessage?> sMsgFuture = TerraFlutter.initConnection(Connection.appleHealth, token, true, []);
          
  //         sMsgFuture.then((sMsg) {
  //           print("Connected to Apple Health:");
  //           print(sMsg?.success);

  //           Future<UserId?> uidFuture = TerraFlutter.getUserId(Connection.appleHealth);
  //           uidFuture.then((uidMsg) {
  //             print("UserMsg Status:");
  //             print(uidMsg?.success);
  //             print("User Id:");
  //             print(uidMsg?.userId);
  //           });
  //         }).catchError((err) {
  //           print("Error making device connection");
  //         });
  //       }
  //     });

  //     print("Breakpoint 1");

  //     // final end = DateTime.utc(2023, 4, 19);
  //     // final start = DateTime.utc(2023, 4, 17);

  //     // Future<DataMessage?> dailyFuture = TerraFlutter.getDaily(Connection.appleHealth, start, end, toWebhook: false);
  //     // dailyFuture.then((dailyMsg) {
  //     //   print("DailyMsg Status:");
  //     //   print(dailyMsg?.success);
  //     //   print("Data:");
  //     //   print(dailyMsg?.data);
  //     // });

  //     // const String token = "0c8051588f0313dc5142faf434ae0379f69b0cd182d5d52407fa6433c285058b";
  //     // Future<SuccessMessage?> sMsgFuture = TerraFlutter.initConnection(Connection.appleHealth, token, true, []);
      
  //     // sMsgFuture.then((sMsg) {
  //     //   print("Connected to Apple Health:");
  //     //   print(sMsg?.success);

  //     //   Future<UserId?> uidFuture = TerraFlutter.getUserId(Connection.appleHealth);
  //     //   uidFuture.then((uidMsg) {
  //     //     print("UserMsg Status:");
  //     //     print(uidMsg?.success);
  //     //     print("User Id:");
  //     //     print(uidMsg?.userId);
  //     //   });
  //     // }).catchError((err) {
  //     //   print("Error making device connection");
  //     // });

  //   } else if (Platform.isMacOS) {
  //     print('Running on macOS');
  //   } else if (Platform.isWindows) {
  //     print('Running on Windows');
  //   } else if (Platform.isLinux) {
  //     print('Running on Linux');
  //   } else {
  //     print('Unknown platform');
  //   }
  // }).catchError((error) {
  //   print("Error initialising Terra");
  // });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
      print("Counter is: ");
      print(_counter);
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
