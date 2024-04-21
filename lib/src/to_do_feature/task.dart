class Task {
  const Task({
    this.id,
    required this.name,
    required this.dateTime,
    required this.priority,
    this.isCompleted = false,
  });

  final String? id;
  final String name;
  final DateTime dateTime;
  final String priority;
  final bool isCompleted;

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      name: json['name'],
      dateTime: DateTime.parse(json['dateTime']),
      priority: json['priority'],
      isCompleted: json['isCompleted'],
    );
  }

  Map<String, dynamic> toJson({bool retrieveId = false}) {
    final Map<String, dynamic> json = {
      'name': name,
      'dateTime': dateTime.toIso8601String(),
      'priority': priority,
      'isCompleted': isCompleted,
      if (retrieveId) 'id': id,
    };
    return json;
  }

  Task copyWith({
    String? id,
    String? name,
    DateTime? dateTime,
    String? priority,
    bool? isCompleted,
  }) {
    return Task(
      id: id ?? this.id,
      name: name ?? this.name,
      dateTime: dateTime ?? this.dateTime,
      priority: priority ?? this.priority,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
