class User {
  int? id;
  String? name;
  String? email;
  int? height;
  int? weight;
  int? age;
  String? bio;

  User({
    this.id,
    this.name,
    this.email,
    this.height,
    this.weight,
    this.age,
    this.bio,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      height: json['height'],
      weight: json['weight'],
      age: json['age'],
      bio: json['bio'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'height': height,
      'weight': weight,
      'age': age,
      'bio': bio,
    };
  }
}