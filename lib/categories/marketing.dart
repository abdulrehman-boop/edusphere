import 'package:flutter/material.dart';
import '../models/course_model.dart';
class MarketingPage extends StatefulWidget {
  const MarketingPage({super.key});
  @override
  State<MarketingPage> createState() => _MarketingPageState();
}
class _MarketingPageState extends State<MarketingPage> with TickerProviderStateMixin {
  String searchQuery = '';
  String sortBy = 'rating';
  bool showOnlyFree = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final Color primaryColor = const Color(0xFF9C27B0);
  final IconData categoryIcon = Icons.campaign;
  final String categoryName = 'Marketing';
  final List<Course> courses = [
    Course(
      title: 'Digital Marketing Complete Guide',
      instructor: 'Robert Johnson',
      rating: 4.8,
      durationMinutes: 540,
      imageUrl: 'https://via.placeholder.com/300x200/9C27B0/FFFFFF?text=Digital+Marketing',
      price: 89.99,
      category: 'Marketing',
      isFree: false,
      description: 'Master all aspects of digital marketing from SEO to social media advertising',
      studentsEnrolled: 32140,
      tags: ['Digital Marketing', 'SEO', 'Social Media', 'Analytics'],
      specialTag: 'BESTSELLER',
    ),
    Course(
      title: 'Social Media Marketing Strategy',
      instructor: 'Jessica Brown',
      rating: 4.7,
      durationMinutes: 300,
      imageUrl: 'https://via.placeholder.com/300x200/7B1FA2/FFFFFF?text=Social+Media',
      price: 0,
      category: 'Marketing',
      isFree: true,
      description: 'Create effective social media campaigns that drive engagement and sales',
      studentsEnrolled: 24580,
      tags: ['Social Media', 'Instagram', 'Facebook', 'Content Strategy'],
      specialTag: 'FREE',
    ),
    Course(
      title: 'Google Ads Mastery',
      instructor: 'Michael Davis',
      rating: 4.9,
      durationMinutes: 420,
      imageUrl: 'https://via.placeholder.com/300x200/8E24AA/FFFFFF?text=Google+Ads',
      price: 79.99,
      category: 'Marketing',
      isFree: false,
      description: 'Master Google Ads campaigns for maximum ROI and conversions',
      studentsEnrolled: 18760,
      tags: ['Google Ads', 'PPC', 'Advertising', 'Conversion Optimization'],
      specialTag: 'TRENDING',
    ),
    Course(
      title: 'Content Marketing Strategy',
      instructor: 'Amanda Wilson',
      rating: 4.6,
      durationMinutes: 360,
      imageUrl: 'https://via.placeholder.com/300x200/AB47BC/FFFFFF?text=Content+Marketing',
      price: 59.99,
      category: 'Marketing',
      isFree: false,
      description: 'Create compelling content that converts visitors into customers',
      studentsEnrolled: 15230,
      tags: ['Content Marketing', 'Copywriting', 'SEO', 'Brand Storytelling'],
    ),
    Course(
      title: 'Email Marketing Automation',
      instructor: 'Daniel Lee',
      rating: 4.5,
      durationMinutes: 240,
      imageUrl: 'https://via.placeholder.com/300x200/BA68C8/FFFFFF?text=Email+Marketing',
      price: 49.99,
      category: 'Marketing',
      isFree: false,
      description: 'Automate your email marketing campaigns for better engagement',
      studentsEnrolled: 11890,
      tags: ['Email Marketing', 'Automation', 'CRM', 'Lead Nurturing'],
    ),
    Course(
      title: 'SEO Fundamentals 2024',
      instructor: 'Sarah Chen',
      rating: 4.7,
      durationMinutes: 380,
      imageUrl: 'https://via.placeholder.com/300x200/CE93D8/FFFFFF?text=SEO',
      price: 0,
      category: 'Marketing',
      isFree: true,
      description: 'Learn modern SEO techniques to rank higher in search results',
      studentsEnrolled: 28450,
      tags: ['SEO', 'Search Marketing', 'Google', 'Keyword Research'],
      specialTag: 'FREE',
    ),
    Course(
      title: 'Facebook Ads Mastery',
      instructor: 'Carlos Rodriguez',
      rating: 4.6,
      durationMinutes: 340,
      imageUrl: 'https://via.placeholder.com/300x200/E1BEE7/FFFFFF?text=Facebook+Ads',
      price: 69.99,
      category: 'Marketing',
      isFree: false,
      description: 'Master Facebook and Instagram advertising for better results',
      studentsEnrolled: 19350,
      tags: ['Facebook Ads', 'Instagram Ads', 'Social Advertising', 'Targeting'],
    ),
    Course(
      title: 'Influencer Marketing Strategy',
      instructor: 'Emma Taylor',
      rating: 4.4,
      durationMinutes: 280,
      imageUrl: 'https://via.placeholder.com/300x200/9575CD/FFFFFF?text=Influencer+Marketing',
      price: 55.99,
      category: 'Marketing',
      isFree: false,
      description: 'Build successful influencer marketing campaigns',
      studentsEnrolled: 12670,
      tags: ['Influencer Marketing', 'Brand Partnerships', 'Social Media'],
      specialTag: 'NEW',
    ),
    Course(
      title: 'Marketing Analytics & Data',
      instructor: 'David Kumar',
      rating: 4.8,
      durationMinutes: 460,
      imageUrl: 'https://via.placeholder.com/300x200/B39DDB/FFFFFF?text=Marketing+Analytics',
      price: 85.99,
      category: 'Marketing',
      isFree: false,
      description: 'Master marketing analytics to make data-driven decisions',
      studentsEnrolled: 14320,
      tags: ['Analytics', 'Data Analysis', 'Google Analytics', 'ROI Tracking'],
    ),
    Course(
      title: 'Affiliate Marketing Bootcamp',
      instructor: 'Lisa Martinez',
      rating: 4.5,
      durationMinutes: 320,
      imageUrl: 'https://via.placeholder.com/300x200/673AB7/FFFFFF?text=Affiliate+Marketing',
      price: 0,
      category: 'Marketing',
      isFree: true,
      description: 'Learn how to build a successful affiliate marketing business',
      studentsEnrolled: 16780,
      tags: ['Affiliate Marketing', 'Passive Income', 'Commission Sales'],
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
              _buildMarketingChannelsSection(),
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
  Widget _buildMarketingChannelsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Marketing Channels',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildChannelCard('SEO', Icons.search, '32k+ students', 'Search Engine Optimization'),
              _buildChannelCard('Social Media', Icons.share, '28k+ students', 'Social Marketing'),
              _buildChannelCard('Email', Icons.email, '24k+ students', 'Email Campaigns'),
              _buildChannelCard('PPC', Icons.ads_click, '19k+ students', 'Pay-Per-Click Ads'),
              _buildChannelCard('Content', Icons.article, '22k+ students', 'Content Strategy'),
              _buildChannelCard('Analytics', Icons.analytics, '18k+ students', 'Data & Metrics'),
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
                  Icon(Icons.lightbulb, color: primaryColor),
                  const SizedBox(width: 8),
                  const Text(
                    'Marketing Success Tips',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                '• Know your target audience inside and out\n'
                    '• Test everything - A/B test your campaigns regularly\n'
                    '• Focus on metrics that matter to your business goals\n'
                    '• Create valuable content that solves real problems\n'
                    '• Stay updated with the latest marketing trends and tools\n'
                    '• Build authentic relationships, not just transactions',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
            ],
          ),
        ),
      ],
    );
  }
  Widget _buildChannelCard(String name, IconData icon, String subtitle, String description) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
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
          // Filter by channel
          setState(() {
            searchQuery = name;
          });
        },
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: primaryColor, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 9,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                color: primaryColor,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
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
            Expanded(
              child: Text(
                'All Courses (${filteredList.length})',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
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
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getTagColor(course.specialTag!),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            course.specialTag!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 8,
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
                    Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: course.tags.take(2).map((tag) {
                        return Container(
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
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 12,
                      runSpacing: 4,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star, color: Colors.orange, size: 14),
                            const SizedBox(width: 2),
                            Text(
                              course.rating.toString(),
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.access_time, color: Colors.grey[600], size: 14),
                            const SizedBox(width: 2),
                            Text(
                              _formatDuration(course.durationMinutes),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.people, color: Colors.grey[600], size: 14),
                            const SizedBox(width: 2),
                            Text(
                              '${course.studentsEnrolled}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    course.isFree ? 'Free' : '\$${course.price.toStringAsFixed(2)}',
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
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      minimumSize: const Size(80, 32),
                    ),
                    child: Text(
                      course.isFree ? 'Start Free' : 'Enroll',
                      style: const TextStyle(fontSize: 12),
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

              // Course Image
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
                      Row(
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
                      const Text(
                        'Key Topics Covered',
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
                      if (course.category == 'Marketing')
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
                                  Icon(Icons.trending_up, color: primaryColor),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'Expected Outcomes',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                '• Increase conversion rates by 25-40%\n'
                                    '• Improve ROI on marketing spend\n'
                                    '• Build sustainable marketing systems\n'
                                    '• Generate more qualified leads',
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
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
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
            Expanded(
              child: Text(
                course.isFree ? 'Start Learning' : 'Enroll in Course',
                overflow: TextOverflow.ellipsis,
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
                  ? 'You\'re about to start "${course.title}" for free!'
                  : 'You\'re about to enroll in "${course.title}" for \${course.price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            if (!course.isFree) ...[
              const Text(
                'This course includes:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('• Lifetime access to course materials'),
              const Text('• Certificate of completion'),
              const Text('• Direct instructor support'),
              const Text('• 30-day money-back guarantee'),
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
            child: Text(course.isFree ? 'Start' : 'Enroll'),
          ),
        ],
      ),
    );
  }
}