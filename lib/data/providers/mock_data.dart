class MockData {
  // Demo Credentials / Users
  static final List<Map<String, dynamic>> usersJson = [
    {'id': 'u1', 'name': 'Alice Admin', 'role': 'admin'},
    {'id': 'u2', 'name': 'Bob Manager', 'role': 'regionalManager'},
    {'id': 'u3', 'name': 'Charlie Lead', 'role': 'teamLead'},
    {
      'id': 'u4',
      'name': 'Dave Agent',
      'role': 'fieldAgent',
    }, // Use Dave for testing agent flows!
    {'id': 'u5', 'name': 'Eve Auditor', 'role': 'auditor'},
  ];

  // Seeded Tasks
  static final List<Map<String, dynamic>> tasksJson = [
    {
      'id': 't1',
      'title': 'Store Inspection - Downtown',
      'description': 'Check inventory levels and display units.',
      'assignedToId': 'u4', // Assigned to Dave Agent
      'status': 'pending',
      'dueDate': DateTime.now().add(const Duration(days: 1)).toIso8601String(),
    },
    {
      'id': 't2',
      'title': 'Client Meeting - TechCorp',
      'description': 'Discuss renewal of service contract.',
      'assignedToId': 'u4',
      'status': 'inProgress',
      'dueDate': DateTime.now().toIso8601String(),
    },
  ];

  // Seeded Visits
  static final List<Map<String, dynamic>> visitsJson = [
    {
      'id': 'v1',
      'taskId': 't2',
      'agentId': 'u4',
      'notes': 'Client was very upset about recent downtime.',
      'mockAiInsight':
          '⚠️ Warning Flag: High churn risk detected. Recommend immediate follow-up by Team Lead.',
    },
  ];
}
