import 'package:flutter/material.dart';
import '../models/course_cart.dart';
import '../models/course_model.dart';

class BrowseCoursesPage extends StatefulWidget {
  const BrowseCoursesPage({super.key});

  @override
  State<BrowseCoursesPage> createState() => _BrowseCoursesPageState();
}

class _BrowseCoursesPageState extends State<BrowseCoursesPage> with TickerProviderStateMixin {
  final List<String> categories = [
    'All',
    'Programming',
    'Design',
    'Business',
    'Health',
    'Marketing',
    'Photography',
    'Music',
    'Language'
  ];

  String selectedCategory = 'All';
  String searchQuery = '';
  bool showOnlyFree = false;
  String sortBy = 'rating'; // rating, price, duration, popularity
  bool isGridView = true;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<Course> allCourses = [
    Course(
      title: 'Flutter for Beginners',
      instructor: 'John Doe',
      rating: 4.8,
      durationMinutes: 300,
      imageUrl: 'https://images.unsplash.com/photo-1555949963-aa79dcee981c?w=400&h=250&fit=crop',
      price: 0,
      category: 'Programming',
      isFree: true,
      description: 'Learn Flutter from scratch and build beautiful mobile apps',
      studentsEnrolled: 15420,
      tags: ['Flutter', 'Mobile Development', 'Dart', 'Cross-platform'],
    ),
    Course(
      title: 'UX Design Essentials',
      instructor: 'Jane Smith',
      rating: 4.5,
      durationMinutes: 240,
      imageUrl: 'https://images.unsplash.com/photo-1561070791-2526d30994b5?w=400&h=250&fit=crop',
      price: 29.99,
      category: 'Design',
      isFree: false,
      description: 'Master the fundamentals of UX design and user research',
      studentsEnrolled: 8932,
      tags: ['UX Design', 'User Research', 'Wireframing', 'Prototyping'],
    ),
    Course(
      title: 'Digital Marketing Mastery',
      instructor: 'Mike Johnson',
      rating: 4.7,
      durationMinutes: 450,
      imageUrl: 'https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=400&h=250&fit=crop',
      price: 49.99,
      category: 'Marketing',
      isFree: false,
      description: 'Complete guide to digital marketing strategies and tools',
      studentsEnrolled: 12350,
      tags: ['Digital Marketing', 'SEO', 'Social Media', 'Analytics'],
    ),
    Course(
      title: 'React Native Development',
      instructor: 'Sarah Wilson',
      rating: 4.6,
      durationMinutes: 380,
      imageUrl: 'https://images.unsplash.com/photo-1551650975-87deedd944c3?w=400&h=250&fit=crop',
      price: 0,
      category: 'Programming',
      isFree: true,
      description: 'Build cross-platform mobile apps with React Native',
      studentsEnrolled: 9876,
      tags: ['React Native', 'JavaScript', 'Mobile Apps', 'Cross-platform'],
    ),
    Course(
      title: 'Graphic Design Fundamentals',
      instructor: 'Alex Brown',
      rating: 4.4,
      durationMinutes: 320,
      imageUrl: 'https://images.unsplash.com/photo-1626785774573-4b799315345d?w=400&h=250&fit=crop',
      price: 39.99,
      category: 'Design',
      isFree: false,
      description: 'Learn the principles of effective graphic design',
      studentsEnrolled: 6754,
      tags: ['Graphic Design', 'Adobe Creative', 'Typography', 'Branding'],
    ),
    Course(
      title: 'Business Strategy 101',
      instructor: 'Robert Taylor',
      rating: 4.3,
      durationMinutes: 280,
      imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&h=250&fit=crop',
      price: 35.00,
      category: 'Business',
      isFree: false,
      description: 'Essential business strategies for entrepreneurs',
      studentsEnrolled: 4523,
      tags: ['Business Strategy', 'Entrepreneurship', 'Leadership', 'Planning'],
    ),
    Course(
      title: 'Yoga for Beginners',
      instructor: 'Emma Davis',
      rating: 4.9,
      durationMinutes: 180,
      imageUrl: 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=400&h=250&fit=crop',
      price: 0,
      category: 'Health',
      isFree: true,
      description: 'Start your yoga journey with gentle poses and breathing',
      studentsEnrolled: 11234,
      tags: ['Yoga', 'Fitness', 'Mindfulness', 'Health'],
    ),
    Course(
      title: 'Photography Basics',
      instructor: 'Tom Wilson',
      rating: 4.5,
      durationMinutes: 220,
      imageUrl: 'https://images.unsplash.com/photo-1606983340126-99ab4feaa64a?w=400&h=250&fit=crop',
      price: 25.99,
      category: 'Photography',
      isFree: false,
      description: 'Master the basics of digital photography',
      studentsEnrolled: 7865,
      tags: ['Photography', 'Camera Settings', 'Composition', 'Editing'],
    ),
    Course(
      title: 'Spanish for Beginners',
      instructor: 'Carlos Rodriguez',
      rating: 4.6,
      durationMinutes: 360,
      imageUrl: 'https://images.unsplash.com/photo-1434030216411-0b793f4b4173?w=400&h=250&fit=crop',
      price: 19.99,
      category: 'Language',
      isFree: false,
      description: 'Learn Spanish from basics to conversational level',
      studentsEnrolled: 13450,
      tags: ['Spanish', 'Language Learning', 'Conversation', 'Grammar'],
    ),
    Course(
      title: 'Piano Fundamentals',
      instructor: 'Lisa Chen',
      rating: 4.7,
      durationMinutes: 420,
      imageUrl: 'https://images.unsplash.com/photo-1520523839897-bd0b52f945a0?w=400&h=250&fit=crop',
      price: 0,
      category: 'Music',
      isFree: true,
      description: 'Learn piano basics and start playing your favorite songs',
      studentsEnrolled: 8765,
      tags: ['Piano', 'Music Theory', 'Practice', 'Technique'],
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
    var courses = allCourses.where((course) {
      final matchesCategory = selectedCategory == 'All' || course.category == selectedCategory;
      final matchesSearch = course.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
          course.instructor.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesFreeFilter = !showOnlyFree || course.isFree;
      return matchesCategory && matchesSearch && matchesFreeFilter;
    }).toList();

    // Sort courses
    switch (sortBy) {
      case 'rating':
        courses.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'price':
        courses.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'duration':
        courses.sort((a, b) => a.durationMinutes.compareTo(b.durationMinutes));
        break;
      case 'popularity':
        courses.sort((a, b) => b.studentsEnrolled.compareTo(a.studentsEnrolled));
        break;
    }

    return courses;
  }

  String formatDuration(int minutes) {
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

  String _formatStudentCount(int count) {
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(0)}k';
    }
    return count.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Browse Courses',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isGridView = !isGridView;
              });
            },
            icon: Icon(isGridView ? Icons.list : Icons.grid_view),
          ),
          IconButton(
            onPressed: () => _showFilterBottomSheet(),
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Search Bar
              Container(
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
                    hintText: 'Search courses, instructors...',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(16),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 16),

              // Category Chips - Fixed overflow
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final isSelected = category == selectedCategory;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Text(
                          category,
                          style: TextStyle(
                            fontSize: 13, // Reduced font size
                          ),
                        ),
                        selected: isSelected,
                        onSelected: (_) {
                          setState(() {
                            selectedCategory = category;
                          });
                        },
                        backgroundColor: Colors.white,
                        selectedColor: Theme.of(context).primaryColor.withOpacity(0.2),
                        checkmarkColor: Theme.of(context).primaryColor,
                        labelStyle: TextStyle(
                          color: isSelected ? Theme.of(context).primaryColor : Colors.grey[700],
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                        side: BorderSide(
                          color: isSelected ? Theme.of(context).primaryColor : Colors.grey[300]!,
                        ),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),

              // Results count and view toggle - Fixed overflow
              Row(
                children: [
                  Flexible(
                    child: Text(
                      '${filteredCourses.length} courses found',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (showOnlyFree)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Free only',
                        style: TextStyle(
                          color: Colors.green[700],
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),

              // Course List
              Expanded(
                child: filteredCourses.isEmpty
                    ? _buildEmptyState()
                    : AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: isGridView
                      ? _buildGridView()
                      : _buildListView(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridView() {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate optimal cross axis count based on screen width
        int crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;

        return GridView.builder(
          key: const ValueKey('grid'),
          itemCount: filteredCourses.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            return CourseGridCard(course: filteredCourses[index]);
          },
        );
      },
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      key: const ValueKey('list'),
      itemCount: filteredCourses.length,
      itemBuilder: (context, index) {
        return CourseListCard(
          course: filteredCourses[index],
          formatStudentCount: _formatStudentCount,
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
            'Try adjusting your search or filters',
            style: TextStyle(
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
        ],
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
                children: [
                  const Expanded(
                    child: Text(
                      'Filters & Sort',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
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

              // Free courses toggle
              SwitchListTile(
                title: const Text('Show only free courses'),
                value: showOnlyFree,
                onChanged: (value) {
                  setState(() {
                    showOnlyFree = value;
                  });
                  setModalState(() {});
                },
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: 20),

              // Sort options
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
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Apply Filters'),
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

// Grid Card Widget - Fixed overflow issues
class CourseGridCard extends StatelessWidget {
  final Course course;

  const CourseGridCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Course Image
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                image: DecorationImage(
                  image: NetworkImage(course.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.3),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    if (course.isFree)
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'FREE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          CourseCart().isInCart(course)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.red,
                          size: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Course Info - Fixed overflow
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      course.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Flexible(
                    child: Text(
                      course.instructor,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 10,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star, color: Colors.orange, size: 12),
                            const SizedBox(width: 2),
                            Text(
                              course.rating.toString(),
                              style: const TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        child: Text(
                          course.isFree ? 'Free' : '\$${course.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: course.isFree ? Colors.green : Colors.blue,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// List Card Widget - Fixed overflow issues
class CourseListCard extends StatelessWidget {
  final Course course;
  final String Function(int) formatStudentCount;

  const CourseListCard({
    super.key,
    required this.course,
    required this.formatStudentCount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: IntrinsicHeight(
          child: Row(
            children: [
              // Course Image
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(course.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                child: course.isFree
                    ? Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                            colors: [Colors.transparent, Colors.black.withOpacity(0.3)],
                          ),
                        ),
                      ),
                    ),
                    const Positioned(
                      top: 4,
                      left: 4,
                      child: Text(
                        'FREE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 7,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
                    : null,
              ),
              const SizedBox(width: 12),

              // Course Info - Fixed overflow
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          course.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          course.instructor,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.orange, size: 14),
                        const SizedBox(width: 2),
                        Text(
                          course.rating.toString(),
                          style: const TextStyle(fontSize: 12),
                        ),
                        const SizedBox(width: 12),
                        Icon(Icons.people, color: Colors.grey[600], size: 14),
                        const SizedBox(width: 2),
                        Text(
                          formatStudentCount(course.studentsEnrolled),
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Price and Action
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    course.isFree ? 'Free' : '\$${course.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: course.isFree ? Colors.green : Colors.blue,
                      fontSize: 14,
                    ),
                  ),
                  IconButton(
                    constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      // Add to cart or favorites logic
                      CourseCart().isInCart(course)
                          ? CourseCart().removeFromCart(course)
                          : CourseCart().addToCart(course);
                    },
                    icon: Icon(
                      CourseCart().isInCart(course)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.red,
                      size: 20,
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
}