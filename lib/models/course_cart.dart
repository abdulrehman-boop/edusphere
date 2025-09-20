import 'course_model.dart';
class CourseCart {
  static final CourseCart _instance = CourseCart._internal();
  factory CourseCart() => _instance;
  CourseCart._internal();
  final List<Course> _cartItems = [];
  List<Course> get cartItems => _cartItems;
  void addToCart(Course course) {
    if (!_cartItems.contains(course)) {
      _cartItems.add(course);
    }
  }
  void removeFromCart(Course course) {
    _cartItems.remove(course);
  }
  bool isInCart(Course course) {
    return _cartItems.contains(course);
  }
  void clearCart() {
    _cartItems.clear();
  }
}
