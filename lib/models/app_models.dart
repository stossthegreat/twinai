enum TabType {
  twin,
  memory,
  patterns,
  future,
  dreams,
  shadow,
}

enum SystemMode {
  calm,
  hyperfocus,
  danger,
  withdrawal,
  transcendent,
  collapse,
}

enum TwinMessageType {
  user,
  twin,
  echo,
  warning,
  revelation,
}

enum MessageType {
  user,
  twin,
}

enum RiskLevel {
  critical,
  high,
  medium,
  positive,
  opportunity,
  criticalDecision,
}

class Message {
  final MessageType type;
  final String text;
  final DateTime timestamp;

  Message({
    required this.type,
    required this.text,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}

class TwinMessage {
  final TwinMessageType type;
  final String text;
  final int timestamp;
  final double? emotionalWeight;

  TwinMessage({
    required this.type,
    required this.text,
    required this.timestamp,
    this.emotionalWeight,
  });
}

class StatCard {
  final String label;
  final String value;
  final RiskLevel color;

  StatCard({
    required this.label,
    required this.value,
    required this.color,
  });
}

class MemoryEvent {
  final String date;
  final RiskLevel type;
  final String score;
  final String summary;
  final String details;

  MemoryEvent({
    required this.date,
    required this.type,
    required this.score,
    required this.summary,
    required this.details,
  });
}

class Pattern {
  final String name;
  final RiskLevel risk;
  final String frequency;
  final String trigger;
  final String signature;
  final String interventions;
  final List<String> connections;

  Pattern({
    required this.name,
    required this.risk,
    required this.frequency,
    required this.trigger,
    required this.signature,
    required this.interventions,
    required this.connections,
  });
}

class Prediction {
  final String timeframe;
  final RiskLevel risk;
  final String probability;
  final String event;
  final String description;
  final List<String> triggers;
  final List<String> outcomes;
  final String intervention;
  final double confidence;

  Prediction({
    required this.timeframe,
    required this.risk,
    required this.probability,
    required this.event,
    required this.description,
    required this.triggers,
    required this.outcomes,
    required this.intervention,
    required this.confidence,
  });
}

class Dream {
  final String date;
  final String type;
  final double intensity;
  final String title;
  final String narrative;
  final List<String> symbols;
  final String emotionalSignature;
  final String interpretation;
  final List<String> connections;

  Dream({
    required this.date,
    required this.type,
    required this.intensity,
    required this.title,
    required this.narrative,
    required this.symbols,
    required this.emotionalSignature,
    required this.interpretation,
    required this.connections,
  });
}

class Shadow {
  final String name;
  final double intensity;
  final String type;
  final String voice;
  final String origin;
  final String function;
  final String integration;
  final List<String> triggers;
  final String activity;

  Shadow({
    required this.name,
    required this.intensity,
    required this.type,
    required this.voice,
    required this.origin,
    required this.function,
    required this.integration,
    required this.triggers,
    required this.activity,
  });
}

class TabItem {
  final TabType id;
  final String label;
  final String icon;

  TabItem({
    required this.id,
    required this.label,
    required this.icon,
  });
}
