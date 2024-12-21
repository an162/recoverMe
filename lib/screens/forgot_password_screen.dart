import 'package:flutter/material.dart';
import 'package:emailjs/emailjs.dart';  // Import emailjs package

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;

  // Initialize EmailJS service
  final EmailJS _emailJS = EmailJS(serviceID: 'service_1fao86p', userID: 'TzIiy8GD4R8dKYkuZ', templateID: 'template_nsquauf');

  // Send password reset email via EmailJS
  Future<void> _sendPasswordResetEmail(String email) async {
    setState(() {
      _isSubmitting = true;
    });

    try {
      final response = await _emailJS.send(
        email,
        {
          'reset_link': 'https://your-app.com/reset-password?email=$email', // The reset link to be included in the email
        },
      );

      setState(() {
        _isSubmitting = false;
      });

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Password reset email sent! Please check your inbox."),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.pop(context);
      } else {
        throw Exception('Failed to send email');
      }
    } catch (e) {
      setState(() {
        _isSubmitting = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: ${e.toString()}"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Forgot Password"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                const Text(
                  "Reset Your Password",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Enter your email to receive a password reset link.",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: "Email Address",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your email";
                      }
                      if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value)) {
                        return "Please enter a valid email address";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 30),
                _isSubmitting
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            String email = _emailController.text.trim();
                            _sendPasswordResetEmail(email);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text("Send Reset Link", style: TextStyle(color: Colors.white)),
                      ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Back to Login", style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
