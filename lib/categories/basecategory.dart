import 'package:flutter/material.dart';
import '../models/course_model.dart';
abstract class BaseCategoryPage extends StatefulWidget {
  const BaseCategoryPage({super.key});
}
abstract class BaseCategoryPageState<T extends BaseCategoryPage>
    extends State<T> {
  String get categoryName;
  Color get primaryColor;

  IconData get categoryIcon;

  List<Course> get courses;
  Widget buildSpecialSection() => const SizedBox.shrink();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Row(
          children: [
            Icon(categoryIcon, color: Colors.white),
            const SizedBox(width: 8),
            Text(categoryName, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSpecialSection(),
            const SizedBox(height: 20),

            const Text(
              'Courses',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final course = courses[index];
                return _buildCourseCard(course);
              },
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildCourseCard(Course course) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                course.imageUrl,
                width: 100,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    course.instructor,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.star,
                          color: Colors.amber[600], size: 14),
                      const SizedBox(width: 4),
                      Text(
                        course.rating.toString(),
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '${course.studentsEnrolled} students',
                        style:
                        TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Text(
              course.isFree ? 'FREE' : '\$${course.price}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: course.isFree ? Colors.green : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


