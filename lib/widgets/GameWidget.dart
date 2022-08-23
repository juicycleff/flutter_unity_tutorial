import 'package:basic_project/widgets/UnityStore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

class GameWidget extends StatefulWidget {
  const GameWidget({Key? key, required this.onUnityMessage}) : super(key: key);

  final Function(dynamic message) onUnityMessage;

  @override
  State<GameWidget> createState() => _GameWidgetState();
}

class _GameWidgetState extends State<GameWidget> {
  @override
  Widget build(BuildContext context) {
    return UnityWidget(
      onUnityCreated: onUnityCreated,
      onUnityMessage: widget.onUnityMessage,
      onUnitySceneLoaded: onUnitySceneLoaded,
      fullscreen: false,
    );
  }

  /// Handles unity scene changed
  void onUnitySceneLoaded(SceneLoaded? payload) {
    print(payload?.name);
  }

  /// Receives unity controller reference for interacting with unity
  void onUnityCreated(UnityWidgetController controller) {
    UnityStore.unityController = controller;
  }
}
