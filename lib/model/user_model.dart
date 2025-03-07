class UserModel {
  final String firstName;
  final String lastName;
  final String profilePicture;
  final String job;
  final String city;
  final String country;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.profilePicture,
    required this.job,
    required this.city,
    required this.country,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['first_name'],
      lastName: json['last_name'],
      profilePicture: json['profile_picture'],
      job: json['job'],
      city: json['city'],
      country: json['country'],
    );
  }
}
