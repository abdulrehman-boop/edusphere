class Course {
  final String title;
  final String instructor;
  final double rating;
  final int durationMinutes;
  final String imageUrl;
  final double price;
  final String category;
  final bool isFree;
  final String description;
  final int studentsEnrolled;
  String? level;
  String? specialTag;
  List<String> tags = [];

  Course({
    required this.title,
    required this.instructor,
    required this.rating,
    required this.durationMinutes,
    required this.imageUrl,
    required this.price,
    required this.category,
    required this.isFree,
    this.description = '',
    this.studentsEnrolled = 0,
    this.level,
    this.specialTag,
    this.tags = const [],

  });
}