class VisitModel {
  final String id;
  final String taskId;
  final String agentId;
  String notes;
  String? mockAiInsight; // To store the mock AI output

  VisitModel({
    required this.id,
    required this.taskId,
    required this.agentId,
    required this.notes,
    this.mockAiInsight,
  });

  factory VisitModel.fromJson(Map<String, dynamic> json) {
    return VisitModel(
      id: json['id'],
      taskId: json['taskId'],
      agentId: json['agentId'],
      notes: json['notes'],
      mockAiInsight: json['mockAiInsight'],
    );
  }
}
