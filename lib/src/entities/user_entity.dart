class UserEntity {
  int? id;
  String email;
  String password;
  UserEntity({
    this.id,
    required this.email,
    required this.password,
  });

  UserEntity copyWith({
    int? id,
    String? email,
    String? password,
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'password': password,
    };
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      id: map['id'] != null ? map['id'] as int : null,
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }
}
