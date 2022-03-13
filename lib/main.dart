import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:trainning_firebase/firebase_messaging/custom_firebase_messaging.dart';
import 'package:trainning_firebase/remote_config/custom_remote_config.dart';
import 'package:trainning_firebase/remote_config/custom_visible_rc_widget.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await CustomFirebaseMessaging().inicialize();
  await CustomFirebaseMessaging().getTokenFirebase();

  await CustomRemoteConfig().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: navigatorKey,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/home',
      routes: {
        '/home': (_) => const MyHomePage(title: 'home page'),
        '/virtual': (_) => Scaffold(
              appBar: AppBar(),
              body: const SizedBox.expand(
                child: Center(
                  child: Text('Virtual Page'),
                ),
              ),
            )
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isLoading = false;

  final int _counter = 0;

  void _incrementCounter() async {
    setState(() {
      _isLoading = true;
    });
    await CustomRemoteConfig().forceFetch();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomRemoteConfig()
                .getValueOrDefault(key: 'isActiveBlue', defaultValue: false)
            ? Colors.blue
            : Colors.red,
        title: Text(widget.title),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    CustomRemoteConfig()
                        .getValueOrDefault(
                            key: "novaString", defaultValue: 'defaultValue')
                        .toString(),
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  CustomVisibleRCWidget(
                    rmKey: 'show_container',
                    defaultValue: false,
                    child: Container(
                      color: Colors.blue,
                      height: 100,
                      width: 100,
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
