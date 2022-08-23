import 'package:basic_project/widgets/GameWidget.dart';
import 'package:basic_project/widgets/UnityStore.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  String headerText = 'From Flutter';

  Widget topHeader() {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      padding: const EdgeInsets.all(20),
      child: Text(headerText),
    );
  }

  /// Handles incoming unity messages
  void onUnityMessage(dynamic message) {
    final event = UnityEvent.fromMap(message);

    switch (event.type) {
      case 'ChangeHeaderText':
        setState(() {
          headerText = event.data;
        });
    }
  }

  Widget loadSceneButton(String sceneName) {
    return RaisedButton(
      onPressed: () {
        UnityStore.switchScene(sceneName);
      },
      child: Text('Load $sceneName'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          GameWidget(onUnityMessage: onUnityMessage),
          topHeader(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Row(
                children: [
                  loadSceneButton('Scene1'),
                  loadSceneButton('Scene2'),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: const FloatingActionButton(
        onPressed: UnityStore.turnOnOffRotation,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
