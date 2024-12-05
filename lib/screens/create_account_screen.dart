import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateAccountScreen extends StatefulWidget {
  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  String? _selectedGender;

  Future<void> _saveUserDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', _emailController.text);
    await prefs.setString('password', _passwordController.text);
    await prefs.setString('name', _nameController.text);
    await prefs.setString('surname', _surnameController.text);
    await prefs.setString('birthdate', _birthdateController.text);
    await prefs.setString('gender', _selectedGender ?? '');
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
        title: const Text(
          "Create Account",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    "Join Us!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Create your account to get started",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 40),
                  _buildTextField(_nameController, "Name", "Please enter your name", Icons.person),
                  const SizedBox(height: 20),
                  _buildTextField(_surnameController, "Surname", "Please enter your surname", Icons.person_outline),
                  const SizedBox(height: 20),
                  _buildTextField(_emailController, "Email", "Please enter your email", Icons.email, isEmail: true),
                  const SizedBox(height: 20),
                  _buildTextField(_passwordController, "Password", "Password must be at least 6 characters", Icons.lock, isPassword: true),
                  const SizedBox(height: 20),
                  _buildTextField(_confirmPasswordController, "Confirm Password", "Passwords do not match", Icons.lock_outline, isPassword: true, confirmPassword: true),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      _showGenderDialog(context);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: "Gender",
                        border: UnderlineInputBorder(),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _selectedGender ?? "Select Gender",
                            style: TextStyle(
                              color: _selectedGender == null ? Colors.grey : Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (_selectedGender == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Please select a gender")),
                          );
                        } else {
                          await _saveUserDetails();
                          Navigator.pushNamed(context, '/chooseAddiction');
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade700,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Next", style: TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: const Text(
                          "Sign in",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Function to build a TextFormField with icon
  Widget _buildTextField(TextEditingController controller, String label, String errorMessage, IconData icon, {bool isPassword = false, bool isEmail = false, bool confirmPassword = false}) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword || confirmPassword,
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.blue.shade700),
        border: const UnderlineInputBorder(),
        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorMessage;
        }
        if (isEmail && !RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value)) {
          return "Please enter a valid email";
        }
        if (isPassword && value.length < 6) {
          return "Password must be at least 6 characters";
        }
        if (confirmPassword && value != _passwordController.text) {
          return "Passwords do not match";
        }
        return null;
      },
    );
  }

  // Gender selection dialog
  void _showGenderDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text("Male"),
              onTap: () {
                setState(() {
                  _selectedGender = "Male";
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("Female"),
              onTap: () {
                setState(() {
                  _selectedGender = "Female";
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("Other"),
              onTap: () {
                setState(() {
                  _selectedGender = "Other";
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
