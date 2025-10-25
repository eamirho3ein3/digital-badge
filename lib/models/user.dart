class User {
  final String name;
  final String photo;
  final String linkedinUrl;

  User({required this.name, required this.photo, required this.linkedinUrl});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] as String,
      photo: json['photo'] as String,
      linkedinUrl: json['linkedinUrl'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {'name': name, 'photo': photo, 'linkedinUrl': linkedinUrl};
  }
}
