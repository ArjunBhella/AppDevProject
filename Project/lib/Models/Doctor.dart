class Doctor {
  final int id;
  final String name;
  final String specialization;
  final String location;
  final double rating;
  final int reviews;
  final String image;

  Doctor({
    required this.id,
    required this.name,
    required this.specialization,
    required this.location,
    required this.rating,
    required this.reviews,
    required this.image,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      name: json['name'],
      specialization: json['specialization'],
      location: json['location'],
      rating: json['rating'].toDouble(),
      reviews: json['reviews'],
      image: json['image'],
    );
  }
}
