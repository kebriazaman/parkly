class UserModel {
  final String uid;
  final bool? isAdmin;
  final String? email;
  final String? name;

  UserModel({required this.uid, required this.email, this.name, this.isAdmin});

  // Factory constructor to create a UserModel instance from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      email: json['email'],
      name: json['name'],
    );
  }

  // Method to convert a UserModel instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'isAdmin': isAdmin,
    };
  }
}