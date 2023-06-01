class AllUsers {
  final String phoneNumber;
  final String userEmail;
  final String userId;
  final String userNme;

  AllUsers({
    required this.phoneNumber,
    required this.userEmail,
    required this.userId,
    required this.userNme,
  });

  Map<String, dynamic> toJson() => {
        "phoneNumber": phoneNumber,
        "userEmail": userEmail,
        "userId": userId,
        "userNme": userNme,
      };

  static AllUsers fromJson(Map<String, dynamic> json) => AllUsers(
      phoneNumber: json['phoneNumber'],
      userEmail: json['userEmail'],
      userId: json['userId'],
      userNme: json["userNme"]);
}
