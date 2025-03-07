class UserModel {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String profilePicture;
  final String job;
  final String country;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profilePicture,
    required this.job,
    required this.country,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      profilePicture: json['profile_picture'],
      job: json['job'],
      country: json['country'],
    );
  }
}
