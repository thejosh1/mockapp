class SignUpModel {
  String? email, name, address, password;

  SignUpModel({
    required this.email,
    required this.name,
    required this.address,
    required this.password
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['address'] = this.address;
    data["password"] = this.password;
    return data;
  }
}