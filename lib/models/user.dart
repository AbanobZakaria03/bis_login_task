class User {
  String email;
  String password;

  User({required this.email, required this.password});

  static List<User> users = [
    User(email: "a@email.com", password: "12345"),
    User(email: "b@email.com", password: "12345"),
    User(email: "c@email.com", password: "12345"),
    User(email: "d@email.com", password: "12345"),
    User(email: "e@email.com", password: "12345"),
  ];

}
