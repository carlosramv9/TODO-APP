class UserData {
  String? id;
  String? email;
  String? firstName;
  String? lastName;
  String? createdAt;

  UserData({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.createdAt,
  });

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'created_at': createdAt,
    };
  }
}
