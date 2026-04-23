class VisitModel {
  final String id;
  final String taskId;
  final String agentId;
  final String status; // <-- NEW FIELD
  String notes;
  String? mockAiInsight;

  VisitModel({
    required this.id,
    required this.taskId,
    required this.agentId,
    required this.status, // <-- NEW FIELD
    required this.notes,
    this.mockAiInsight,
  });

  factory VisitModel.fromJson(Map<String, dynamic> json) {
    return VisitModel(
      id: json['id'],
      taskId: json['taskId'],
      agentId: json['agentId'],
      status: json['status'] ?? 'Completed', // <-- Default fallback
      notes: json['notes'],
      mockAiInsight: json['mockAiInsight'],
    );
  }
}
