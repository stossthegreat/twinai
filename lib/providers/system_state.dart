import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../models/app_models.dart';

class SystemStateProvider extends ChangeNotifier {
  SystemMode _mode = SystemMode.calm;
  String _statusLabel = "HYPERAWARE FIELD ONLINE";
  double _cognitiveLoad = 52;
  double _neuralActivity = 45;
  double _emotionalValence = 0;
  double _consciousnessDepth = 3;
  bool _showGlitch = false;

  // Getters
  SystemMode get mode => _mode;
  String get statusLabel => _statusLabel;
  double get cognitiveLoad => _cognitiveLoad;
  double get neuralActivity => _neuralActivity;
  double get emotionalValence => _emotionalValence;
  double get consciousnessDepth => _consciousnessDepth;
  bool get showGlitch => _showGlitch;

  void startSystemUpdates() {
    _updateMetrics();
    _scheduleGlitch();
  }

  void _updateMetrics() {
    Future.delayed(const Duration(seconds: 2), () {
      final delta = math.Random().nextDouble() * 12 - 6;
      final next = math.max(0, math.min(100, _cognitiveLoad + delta));

      _cognitiveLoad = next.toDouble();

      // Update system mode based on cognitive load
      if (next > 92) {
        _mode = SystemMode.collapse;
        _statusLabel = "CRITICAL OVERLOAD • SYSTEM FRAGMENTATION";
      } else if (next > 82) {
        _mode = SystemMode.danger;
        _statusLabel = "CRITICAL PATTERN DENSITY";
      } else if (next > 65) {
        _mode = SystemMode.hyperfocus;
        _statusLabel = "FOCUSED OVERCLOCK";
      } else if (next > 55) {
        _mode = SystemMode.transcendent;
        _statusLabel = "ELEVATED CONSCIOUSNESS STATE";
      } else if (next < 30) {
        _mode = SystemMode.withdrawal;
        _statusLabel = "EMOTIONAL RETRACTION FIELD";
      } else {
        _mode = SystemMode.calm;
        _statusLabel = "HYPERAWARE FIELD ONLINE";
      }

      // Update other metrics
      _neuralActivity = math.max(0, 
        math.min(100, _neuralActivity + (math.Random().nextDouble() * 16 - 8)));
      _emotionalValence = math.max(-10, 
        math.min(10, _emotionalValence + (math.Random().nextDouble() * 2 - 1)));
      _consciousnessDepth = math.max(1, 
        math.min(7, _consciousnessDepth + (math.Random().nextBool() ? 1 : -1) * 0.1));

      notifyListeners();
      _updateMetrics();
    });
  }

  void _scheduleGlitch() {
    Future.delayed(const Duration(seconds: 3), () {
      if (math.Random().nextDouble() > 0.92) {
        _showGlitch = true;
        notifyListeners();
        
        Future.delayed(const Duration(milliseconds: 150), () {
          _showGlitch = false;
          notifyListeners();
        });
      }
      _scheduleGlitch();
    });
  }

  void setSystemMode(SystemMode mode) {
    _mode = mode;
    notifyListeners();
  }

  String getModeString() {
    switch (_mode) {
      case SystemMode.calm:
        return "CALM";
      case SystemMode.hyperfocus:
        return "HYPERFOCUS";
      case SystemMode.danger:
        return "DANGER";
      case SystemMode.withdrawal:
        return "WITHDRAWAL";
      case SystemMode.transcendent:
        return "TRANSCENDENT";
      case SystemMode.collapse:
        return "COLLAPSE";
    }
  }
}
