class UserModel {
  String name;
  String email;
  String? imageUrl;

  UserModel({
    required this.name,
    required this.email,
    this.imageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
    };
  }

  //empty
  static UserModel empty() {
    return UserModel(
      name: '',
      email: '',
      imageUrl: '',
    );
  }
}
