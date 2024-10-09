class favorite  {
  final int id;
  final String name;
  final String email;

  favorite({
    required this.id,
    required this.name,
    required this.email,
  });

  factory favorite.fromJson(Map<String, dynamic> json) {
    return favorite(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}