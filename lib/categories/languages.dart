import 'package:flutter/material.dart';
import '../models/course_model.dart';
class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});
  @override
  State<LanguagePage> createState() => _LanguagePageState();
}
class _LanguagePageState extends State<LanguagePage> with TickerProviderStateMixin {
  String searchQuery = '';
  String sortBy = 'rating';
  bool showOnlyFree = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final Color primaryColor = const Color(0xFF6A1B9A);
  final IconData categoryIcon = Icons.language;
  final String categoryName = 'Languages';
  final List<Course> courses = [
    Course(
      title: 'Spanish for Beginners',
      instructor: 'Maria González',
      rating: 4.8,
      durationMinutes: 480,
      imageUrl: 'https://via.placeholder.com/300x200/6A1B9A/FFFFFF?text=Spanish',
      price: 69.99,
      category: 'Languages',
      isFree: false,
      description: 'Learn conversational Spanish from native speakers with interactive lessons',
      studentsEnrolled: 28450,
      tags: ['Spanish', 'Conversation', 'Grammar', 'Cultural Context'],
      specialTag: 'BESTSELLER',
    ),
    Course(
      title: 'French Essentials',
      instructor: 'Pierre Dubois',
      rating: 4.7,
      durationMinutes: 360,
      imageUrl: 'https://via.placeholder.com/300x200/4A90E2/FFFFFF?text=French',
      price: 0,
      category: 'Languages',
      isFree: true,
      description: 'Master French basics with pronunciation, vocabulary, and everyday phrases',
      studentsEnrolled: 32180,
      tags: ['French', 'Pronunciation', 'Vocabulary', 'Basic Grammar'],
      specialTag: 'FREE',
    ),
    Course(
      title: 'Mandarin Chinese Complete',
      instructor: 'Li Wei',
      rating: 4.9,
      durationMinutes: 600,
      imageUrl: 'https://via.placeholder.com/300x200/DC143C/FFFFFF?text=Mandarin',
      price: 89.99,
      category: 'Languages',
      isFree: false,
      description: 'Comprehensive Mandarin course covering speaking, writing, and Chinese characters',
      studentsEnrolled: 19760,
      tags: ['Mandarin', 'Chinese Characters', 'Tones', 'Business Chinese'],
      specialTag: 'TRENDING',
    ),
    Course(
      title: 'German Language Mastery',
      instructor: 'Hans Mueller',
      rating: 4.6,
      durationMinutes: 540,
      imageUrl: 'https://via.placeholder.com/300x200/000000/FFD700?text=German',
      price: 74.99,
      category: 'Languages',
      isFree: false,
      description: 'Learn German grammar, vocabulary, and cultural nuances for fluent communication',
      studentsEnrolled: 22340,
      tags: ['German', 'Grammar', 'Business German', 'Culture'],
    ),
    Course(
      title: 'Italian Conversation',
      instructor: 'Giulia Rossi',
      rating: 4.5,
      durationMinutes: 420,
      imageUrl: 'https://via.placeholder.com/300x200/009246/FFFFFF?text=Italian',
      price: 59.99,
      category: 'Languages',
      isFree: false,
      description: 'Focus on speaking Italian confidently in real-world situations',
      studentsEnrolled: 16890,
      tags: ['Italian', 'Conversation', 'Travel Italian', 'Pronunciation'],
    ),
    Course(
      title: 'Japanese for Beginners',
      instructor: 'Tanaka Hiroshi',
      rating: 4.8,
      durationMinutes: 480,
      imageUrl: 'https://via.placeholder.com/300x200/BC002D/FFFFFF?text=Japanese',
      price: 0,
      category: 'Languages',
      isFree: true,
      description: 'Start your Japanese journey with hiragana, katakana, and basic conversation',
      studentsEnrolled: 35620,
      tags: ['Japanese', 'Hiragana', 'Katakana', 'Basic Kanji'],
      specialTag: 'FREE',
    ),
    Course(
      title: 'Portuguese Essentials',
      instructor: 'Carlos Santos',
      rating: 4.4,
      durationMinutes: 360,
      imageUrl: 'https://via.placeholder.com/300x200/009639/FFFFFF?text=Portuguese',
      price: 54.99,
      category: 'Languages',
      isFree: false,
      description: 'Learn Brazilian Portuguese with cultural insights and practical phrases',
      studentsEnrolled: 14720,
      tags: ['Portuguese', 'Brazilian Culture', 'Travel Phrases', 'Grammar'],
    ),
    Course(
      title: 'Korean Language Course',
      instructor: 'Park Min-jung',
      rating: 4.7,
      durationMinutes: 450,
      imageUrl: 'https://via.placeholder.com/300x200/CD212A/FFFFFF?text=Korean',
      price: 69.99,
      category: 'Languages',
      isFree: false,
      description: 'Learn Korean alphabet, grammar, and K-culture expressions',
      studentsEnrolled: 26840,
      tags: ['Korean', 'Hangul', 'K-Culture', 'Conversational Korean'],
      specialTag: 'NEW',
    ),
    Course(
      title: 'Arabic Fundamentals',
      instructor: 'Ahmed Hassan',
      rating: 4.5,
      durationMinutes: 420,
      imageUrl: 'https://via.placeholder.com/300x200/006233/FFFFFF?text=Arabic',
      price: 64.99,
      category: 'Languages',
      isFree: false,
      description: 'Master Modern Standard Arabic with script, grammar, and cultural context',
      studentsEnrolled: 12680,
      tags: ['Arabic', 'Arabic Script', 'Modern Standard', 'Culture'],
    ),
    Course(
      title: 'Russian Language Basics',
      instructor: 'Natasha Volkov',
      rating: 4.3,
      durationMinutes: 360,
      imageUrl: 'https://via.placeholder.com/300x200/0039A6/FFFFFF?text=Russian',
      price: 0,
      category: 'Languages',
      isFree: true,
      description: 'Learn Russian alphabet, basic grammar, and essential vocabulary',
      studentsEnrolled: 18940,
      tags: ['Russian', 'Cyrillic Script', 'Grammar', 'Vocabulary'],
      specialTag: 'FREE',
    ),
  ];
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward();
  }
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  List<Course> get filteredCourses {
    var filtered = courses.where((course) {
      final matchesSearch = course.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
          course.instructor.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesFree = !showOnlyFree || course.isFree;
      return matchesSearch && matchesFree;
    }).toList();
    switch (sortBy) {
      case 'rating':
        filtered.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'price':
        filtered.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'duration':
        filtered.sort((a, b) => a.durationMinutes.compareTo(b.durationMinutes));
        break;
      case 'popularity':
        filtered.sort((a, b) => b.studentsEnrolled.compareTo(a.studentsEnrolled));
        break;
    }
    return filtered;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Row(
          children: [
            Icon(categoryIcon, color: primaryColor),
            const SizedBox(width: 8),
            Text(
              categoryName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => _showFilterBottomSheet(),
            icon: const Icon(Icons.tune),
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchBar(),
              const SizedBox(height: 20),
              _buildPopularLanguagesSection(),
              const SizedBox(height: 24),
              _buildCoursesSection(),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search $categoryName courses...',
          hintStyle: TextStyle(color: Colors.grey[400]),
          prefixIcon: Icon(Icons.search, color: primaryColor),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
        onChanged: (value) {
          setState(() {
            searchQuery = value;
          });
        },
      ),
    );
  }
  Widget _buildPopularLanguagesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Popular Languages',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 110,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildLanguageCard('Spanish', Icons.flag, '28k+'),
              _buildLanguageCard('French', Icons.location_city, '32k+'),
              _buildLanguageCard('Mandarin', Icons.business, '20k+'),
              _buildLanguageCard('German', Icons.engineering, '22k+'),
              _buildLanguageCard('Japanese', Icons.art_track, '36k+'),
              _buildLanguageCard('Korean', Icons.music_note, '27k+'),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                primaryColor.withOpacity(0.1),
                primaryColor.withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: primaryColor.withOpacity(0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.school, color: primaryColor),
                  const SizedBox(width: 8),
                  const Flexible(
                    child: Text(
                      'Language Learning Success Tips',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                '• Practice speaking daily, even just for 10 minutes\n'
                    '• Watch movies and listen to music in the target language\n'
                    '• Don\'t fear mistakes - they\'re part of learning\n'
                    '• Focus on practical vocabulary you\'ll use daily\n'
                    '• Find conversation partners for real practice\n'
                    '• Celebrate small wins to stay motivated',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
            ],
          ),
        ),
      ],
    );
  }
  Widget _buildLanguageCard(String name, IconData icon, String subtitle) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: primaryColor.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            searchQuery = name;
          });
        },
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: primaryColor, size: 20),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                color: primaryColor,
                fontSize: 9,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildCoursesSection() {
    final filteredList = filteredCourses;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                'All Courses (${filteredList.length})',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (filteredList.isNotEmpty)
              TextButton.icon(
                onPressed: () => _showFilterBottomSheet(),
                icon: const Icon(Icons.sort, size: 18),
                label: const Text('Sort'),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                ),
              ),
          ],
        ),
        const SizedBox(height: 16),
        if (filteredList.isEmpty)
          _buildEmptyState()
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              return CourseCard(
                course: filteredList[index],
                primaryColor: primaryColor,
              );
            },
          ),
      ],
    );
  }
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Icon(
              Icons.search_off,
              size: 80,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 16),
            Text(
              'No courses found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try adjusting your filters',
              style: TextStyle(
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Filters & Sort',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        showOnlyFree = false;
                        sortBy = 'rating';
                      });
                      setModalState(() {});
                    },
                    child: const Text('Reset'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SwitchListTile(
                title: const Text('Show only free courses'),
                value: showOnlyFree,
                activeColor: primaryColor,
                onChanged: (value) {
                  setState(() {
                    showOnlyFree = value;
                  });
                  setModalState(() {});
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Sort by',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              ...['rating', 'price', 'duration', 'popularity'].map((option) {
                return RadioListTile<String>(
                  title: Text(_getSortOptionLabel(option)),
                  value: option,
                  groupValue: sortBy,
                  activeColor: primaryColor,
                  onChanged: (value) {
                    setState(() {
                      sortBy = value!;
                    });
                    setModalState(() {});
                  },
                  contentPadding: EdgeInsets.zero,
                );
              }),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Apply Filters',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  String _getSortOptionLabel(String option) {
    switch (option) {
      case 'rating':
        return 'Highest Rated';
      case 'price':
        return 'Price (Low to High)';
      case 'duration':
        return 'Duration (Short to Long)';
      case 'popularity':
        return 'Most Popular';
      default:
        return option;
    }
  }
}
class CourseCard extends StatelessWidget {
  final Course course;
  final Color primaryColor;

  const CourseCard({
    super.key,
    required this.course,
    required this.primaryColor,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          _showCourseDetails(context);
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(course.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    if (course.specialTag != null)
                      Positioned(
                        top: 4,
                        left: 4,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getTagColor(course.specialTag!),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            course.specialTag!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 7,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      course.instructor,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      course.description,
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: course.tags.take(2).map((tag) {
                          return Container(
                            margin: const EdgeInsets.only(right: 4),
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              tag,
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Icon(Icons.star, color: Colors.orange, size: 14),
                          const SizedBox(width: 2),
                          Text(
                            course.rating.toString(),
                            style: const TextStyle(fontSize: 12),
                          ),
                          const SizedBox(width: 12),
                          Icon(Icons.access_time, color: Colors.grey[600], size: 14),
                          const SizedBox(width: 2),
                          Text(
                            _formatDuration(course.durationMinutes),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Icon(Icons.people, color: Colors.grey[600], size: 14),
                          const SizedBox(width: 2),
                          Text(
                            '${(course.studentsEnrolled / 1000).toStringAsFixed(0)}k',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    course.isFree ? 'Free' : '\$${course.price.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: course.isFree ? Colors.green : primaryColor,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      _showEnrollDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      minimumSize: const Size(60, 28),
                    ),
                    child: Text(
                      course.isFree ? 'Start' : 'Enroll',
                      style: const TextStyle(fontSize: 11),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  Color _getTagColor(String tag) {
    switch (tag) {
      case 'FREE':
        return Colors.green;
      case 'BESTSELLER':
        return Colors.orange;
      case 'TRENDING':
        return Colors.red;
      case 'NEW':
        return Colors.blue;
      default:
        return primaryColor;
    }
  }
  String _formatDuration(int minutes) {
    if (minutes < 60) {
      return '${minutes}min';
    } else {
      final hours = minutes ~/ 60;
      final remainingMinutes = minutes % 60;
      if (remainingMinutes == 0) {
        return '${hours}h';
      }
      return '${hours}h ${remainingMinutes}min';
    }
  }
  void _showCourseDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: NetworkImage(course.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                child: course.specialTag != null
                    ? Stack(
                  children: [
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: _getTagColor(course.specialTag!),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          course.specialTag!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
                    : null,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'By ${course.instructor}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 16),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Icon(Icons.star, color: Colors.orange, size: 20),
                            const SizedBox(width: 4),
                            Text('${course.rating}'),
                            const SizedBox(width: 16),
                            Icon(Icons.people, color: Colors.grey[600], size: 20),
                            const SizedBox(width: 4),
                            Text('${course.studentsEnrolled} students'),
                            const SizedBox(width: 16),
                            Icon(Icons.access_time, color: Colors.grey[600], size: 20),
                            const SizedBox(width: 4),
                            Text(_formatDuration(course.durationMinutes)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'What you\'ll learn',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        course.description,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),

                      // Key Topics
                      const Text(
                        'Language Skills Covered',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: course.tags.map((tag) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: primaryColor.withOpacity(0.3)),
                            ),
                            child: Text(
                              tag,
                              style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 24),
                      if (course.category == 'Languages')
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                primaryColor.withOpacity(0.1),
                                primaryColor.withOpacity(0.05),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: primaryColor.withOpacity(0.3)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.public, color: primaryColor),
                                  const SizedBox(width: 8),
                                  const Flexible(
                                    child: Text(
                                      'Learning Benefits',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                '• Communicate confidently with native speakers\n'
                                    '• Expand career opportunities globally\n'
                                    '• Experience cultures authentically\n'
                                    '• Improve cognitive abilities and memory\n'
                                    '• Travel with greater confidence\n'
                                    '• Build lasting international friendships',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            course.isFree ? 'Free Course' : 'Course Price',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            course.isFree ? 'Free' : '\${course.price.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: course.isFree ? Colors.green : primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _showEnrollDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        course.isFree ? 'Start Learning' : 'Enroll Now',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _showEnrollDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(course.isFree ? Icons.play_circle : Icons.school, color: primaryColor),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                course.isFree ? 'Start Learning' : 'Enroll in Course',
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              course.isFree
                  ? 'You\'re about to start learning "${course.title}" for free!'
                  : 'You\'re about to enroll in "${course.title}" for \${course.price.toStringAsFixed(2)}',
            ),
            const SizedBox(height: 16),
            if (!course.isFree) ...[
              const Text(
                'This course includes:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('• Lifetime access to course materials'),
              const Text('• Interactive speaking exercises'),
              const Text('• Native speaker audio recordings'),
              const Text('• Cultural context lessons'),
              const Text('• Certificate of completion'),
            ] else ...[
              const Text(
                'Free course includes:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('• Complete beginner-friendly lessons'),
              const Text('• Basic vocabulary and phrases'),
              const Text('• Pronunciation guides'),
              const Text('• Cultural insights'),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      Icon(
                        course.isFree ? Icons.play_circle : Icons.school,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          course.isFree
                              ? 'Started learning ${course.title}!'
                              : 'Successfully enrolled in ${course.title}!',
                        ),
                      ),
                    ],
                  ),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(course.isFree ? 'Start Learning' : 'Enroll'),
          ),
        ],
      ),
    );
  }
}