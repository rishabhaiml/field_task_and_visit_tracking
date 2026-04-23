enum UserRole { admin, regionalManager, teamLead, fieldAgent, auditor }

class UserModel {
  final String id;
  final String name;
  final UserRole role;

  UserModel({required this.id, required this.name, required this.role});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      role: UserRole.values.firstWhere(
        (e) => e.toString() == 'UserRole.${json['role']}',
        orElse: () => UserRole.fieldAgent,
      ),
    );
  }
}
