class UserEntity {
  final String uid;
  final String name;
  final String email;
  final DateTime createdAt;

  UserEntity({
    required this.uid,
    required this.name,
    required this.email,
    required this.createdAt,
  });

  String get userId => uid;
  String get userName => name;
  String get userEmail => email;
  DateTime get userCreatedAt => createdAt;
}
