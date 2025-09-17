import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../screens/frontpage.dart';
import 'loginpage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _obscureText = true;
  bool _isLoading = false;

  void _showToast(String message, {bool success = false}) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: success ? Colors.green : Colors.red,
      textColor: Colors.white,
    );
  }

  void _handleSignUp() {
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      _showToast("Please fill all fields");
      return;
    }

    _createAccount(email, password);
  }

  Future<void> _createAccount(String email, String password) async {
    setState(() => _isLoading = true);
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      _showToast("Account Created Successfully", success: true);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const CourseFrontPage()),
      );
    } on FirebaseAuthException catch (e) {
      _showToast(e.message ?? "Signup failed");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 26),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Icon(Icons.school, size: 80, color: Colors.deepPurple),
                const SizedBox(height: 10),
                Text(
                  'Join EduSphere',
                  style: GoogleFonts.montserrat(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Create your account to start learning!',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 30),

                // Input Fields
                _buildTextField(_nameController, Icons.person, "Full Name"),
                const SizedBox(height: 16),
                _buildTextField(_emailController, Icons.email, "Email"),
                const SizedBox(height: 16),
                _buildTextField(
                  _passwordController,
                  Icons.lock,
                  "Password",
                  obscure: _obscureText,
                  isPassword: true,
                ),
                const SizedBox(height: 28),

                // Sign Up Button
                _isLoading
                    ? const CircularProgressIndicator()
                    : _buildPrimaryButton("Sign Up", _handleSignUp),

                const SizedBox(height: 20),

                // Redirect to Login
                RichText(
                  text: TextSpan(
                    text: "Already have an account? ",
                    style: GoogleFonts.poppins(color: Colors.black87),
                    children: [
                      TextSpan(
                        text: "Login",
                        style: GoogleFonts.poppins(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const LoginPage()),
                            );
                          },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Custom TextField
  Widget _buildTextField(
      TextEditingController controller,
      IconData icon,
      String hint, {
        bool obscure = false,
        bool isPassword = false,
      }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: GoogleFonts.poppins(color: Colors.black87),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.deepPurple),
          suffixIcon: isPassword
              ? IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: Colors.deepPurple,
            ),
            onPressed: () =>
                setState(() => _obscureText = !_obscureText),
          )
              : null,
          hintText: hint,
          hintStyle: GoogleFonts.poppins(color: Colors.grey),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(18),
        ),
      ),
    );
  }

  /// Primary Gradient Button
  Widget _buildPrimaryButton(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: const LinearGradient(
            colors: [Color(0xFF7E57C2), Color(0xFF512DA8)],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}
