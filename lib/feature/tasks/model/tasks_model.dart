class Task {
  int? id;
  String title;
  bool isCompleted;
  DateTime? reminder;

  Task({this.id, required this.title, this.isCompleted = false, this.reminder});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted ? 1 : 0,
      'reminder': reminder?.millisecondsSinceEpoch,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      isCompleted: map['isCompleted'] == 1,
      reminder: map['reminder'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['reminder'])
          : null,
    );
  }
}
