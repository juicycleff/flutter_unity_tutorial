import 'dart:convert';

import 'package:flutter_unity_widget/flutter_unity_widget.dart';

class UnityEvent {
  UnityEvent({required this.type, this.data});

  final String type;
  final dynamic data;

  static UnityEvent fromMap(dynamic message) {
    final map = json.decode(message);
    return UnityEvent(type: map['type'], data: map['data']);
  }
}

/// Really stupid store
class UnityStore {
  static UnityWidgetController? unityController;
  static bool isRotating = false;

  static void turnOnOffRotation() {
    if (unityController == null) return;

    unityController!
        .postMessage('Cube', 'SetRotationSpeed', isRotating ? '0' : '2');
    isRotating = !isRotating;
  }

  static void switchScene(String sceneName) {
    if (unityController == null) return;
    unityController!.postMessage('GameManager', 'SwitchScene', sceneName);
  }
}
