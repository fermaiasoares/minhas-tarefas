import 'package:flutter/material.dart';

enum MessageType {
  success,
  info,
  error,
  warning;

  Color get color => switch (this) {
        success => Colors.green,
        info => Colors.blueAccent,
        error => Colors.redAccent,
        warning => Colors.amberAccent,
      };

  Icon get icon => switch (this) {
        success => const Icon(
            Icons.check_circle,
            size: 32,
            color: Colors.white,
          ),
        info => const Icon(
            Icons.info,
            size: 32,
            color: Colors.white,
          ),
        error => const Icon(
            Icons.error,
            size: 32,
            color: Colors.white,
          ),
        warning => const Icon(
            Icons.warning,
            size: 32,
            color: Colors.white,
          )
      };
}
