// ignore_for_file: unnecessary_this, prefer_collection_literals

class AppUser {
  String? uid;
  String? firstName;

  String? email;

  String? password;
  String? confirmPassword;

  AppUser(
      {
        this.uid,
        this.firstName,

        this.email,
        this.password,
        this.confirmPassword,
      });

  AppUser.fromJson(Map<String, dynamic> json, id) {
    uid = id;
    firstName = json['first_name'];
    email = json['email'];

    password = json['password'];
    confirmPassword = json['confirm_password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['confirm_password'] = this.confirmPassword;
    return data;
  }
}