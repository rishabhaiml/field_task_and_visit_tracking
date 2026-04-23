enum TaskStatus { pending, inProgress, completed }

class TaskModel {
  final String id;
  final String title;
  final String description;
  final String assignedToId; // ID of the Field Agent
  TaskStatus status;
  final DateTime dueDate;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.assignedToId,
    required this.status,
    required this.dueDate,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      assignedToId: json['assignedToId'],
      status: TaskStatus.values.firstWhere(
        (e) => e.toString() == 'TaskStatus.${json['status']}',
        orElse: () => TaskStatus.pending,
      ),
      dueDate: DateTime.parse(json['dueDate']),
    );
  }
}
