class UserModel {
  final int? id;
  final String? name;
  final String? email;
  final String? token;
  final String? message;

  UserModel({this.id, this.name, this.email, this.token, this.message});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? json['userID'],
      name: json['name'],
      email: json['email'],
      token: json['token'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'token': token,
      'message': message,
    };
  }
}
