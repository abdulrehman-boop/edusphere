import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});
  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}
class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _emailSent = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: Duration(seconds: 3),
      ),
    );
  }
  bool _validateEmail() {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      _showSnackBar("Please enter your email", isError: true);
      return false;
    }
    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    if (!emailRegex.hasMatch(email)) {
      _showSnackBar("Please enter a valid email address", isError: true);
      return false;
    }
    return true;
  }
  Future<void> _resetPassword() async {
    if (!_validateEmail()) return;
    setState(() => _isLoading = true);
    try {
      await _auth.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );
      setState(() => _emailSent = true);
      _showSnackBar("Password reset email sent successfully!");
    } on FirebaseAuthException catch (e) {
      String errorMessage = "Failed to send reset email";
      if (e.code == 'user-not-found') {
        errorMessage = "No user found for that email address.";
      } else if (e.code == 'invalid-email') {
        errorMessage = "The email address is not valid.";
      } else {
        errorMessage = e.message ?? errorMessage;
      }
      _showSnackBar(errorMessage, isError: true);
    } catch (e) {
      _showSnackBar("An unexpected error occurred.", isError: true);
    } finally {
      setState(() => _isLoading = false);
    }
  }
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.deepPurple),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Icon(
                    _emailSent ? Icons.mark_email_read : Icons.lock_reset,
                    size: 80,
                    color: Colors.deepPurple,
                  ),
                  SizedBox(height: 10),
                  Text(
                    _emailSent ? 'Check Your Email' : 'Reset Password',
                    style: GoogleFonts.montserrat(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    _emailSent
                        ? 'We\'ve sent a password reset link to your email address.'
                        : 'Enter your email address and we\'ll send you a link to reset your password.',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  if (!_emailSent) ...[
                    _buildTextField(_emailController, Icons.email, "Email"),
                    SizedBox(height: 28),
                    _isLoading
                        ? CircularProgressIndicator()
                        : _buildResetButton(),
                    SizedBox(height: 20),
                  ] else ...[
                    _buildResendButton(),
                    SizedBox(height: 20),
                    _buildBackToLoginButton(),
                    SizedBox(height: 20),
                  ],
                  if (!_emailSent)
                    RichText(
                      text: TextSpan(
                        text: "Remember your password? ",
                        style: GoogleFonts.poppins(color: Colors.black87),
                        children: [
                          TextSpan(
                            text: 'Back to Login',
                            style: GoogleFonts.poppins(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).pop();
                              },
                          ),
                        ],
                      ),
                    ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildTextField(
      TextEditingController controller,
      IconData icon,
      String hint,
      ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(2, 4),
          )
        ],
      ),
      child: TextField(
        controller: controller,
        style: GoogleFonts.poppins(color: Colors.black87),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.deepPurple),
          hintText: hint,
          hintStyle: GoogleFonts.poppins(color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(18),
        ),
      ),
    );
  }
  Widget _buildResetButton() {
    return GestureDetector(
      onTap: _resetPassword,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: LinearGradient(
            colors: [Color(0xFF7E57C2), Color(0xFF512DA8)],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 10,
              offset: Offset(0, 5),
            )
          ],
        ),
        child: Center(
          child: Text(
            'Send Reset Link',
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
  Widget _buildResendButton() {
    return GestureDetector(
      onTap: _isLoading ? null : _resetPassword,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: _isLoading
              ? LinearGradient(
            colors: [Colors.grey[400]!, Colors.grey[500]!],
          )
              : LinearGradient(
            colors: [Color(0xFF7E57C2), Color(0xFF512DA8)],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 10,
              offset: Offset(0, 5),
            )
          ],
        ),
        child: Center(
          child: _isLoading
              ? SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
          )
              : Text(
            'Resend Email',
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
  Widget _buildBackToLoginButton() {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: Colors.deepPurple, width: 2),
          color: Colors.transparent,
        ),
        child: Center(
          child: Text(
            'Back to Login',
            style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}