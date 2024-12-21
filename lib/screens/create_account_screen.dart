import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/create_account/create_account_bloc.dart';
import '../../blocs/create_account/create_account_event.dart';
import '../../blocs/create_account/create_account_state.dart';
import '../../database/database_helper.dart';


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
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateAccountBloc(dbHelper: DBHelper.instance),
      child: Scaffold(
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
        body: BlocListener<CreateAccountBloc, CreateAccountState>(
          listener: (context, state) {
            if (state is CreateAccountLoading) {
              setState(() {
                _isLoading = true;
              });
            } else {
              setState(() {
                _isLoading = false;
              });
            }

            if (state is CreateAccountSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                    "Account created successfully!",
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.blue,
                ),
              );
              Navigator.pushNamed(context, '/chooseAddiction', arguments: {'email': _emailController.text});
            } else if (state is CreateAccountFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.message,
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: Stack(
            children: [
              _buildForm(),
              if (_isLoading) _buildLoadingIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Container(
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
                _buildBirthdateField(context),
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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (_selectedGender == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Please select a gender")),
                        );
                      } else {
                        final name = _nameController.text.trim();
                        final surname = _surnameController.text.trim();
                        final email = _emailController.text.trim();
                        final password = _passwordController.text;
                        final birthdate = _birthdateController.text.trim();
                        final gender = _selectedGender!;
                        context.read<CreateAccountBloc>().add(
                          CreateAccountSubmitted(
                            name: name,
                            surname: surname,
                            email: email,
                            password: password,
                            birthdate: birthdate,
                            gender: gender,
                          ),
                        );
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
    );
  }

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

  Widget _buildBirthdateField(BuildContext context) {
    return TextFormField(
      controller: _birthdateController,
      readOnly: true,
      decoration: InputDecoration(
        labelText: "Birthdate",
        prefixIcon: Icon(Icons.calendar_today, color: Colors.blue.shade700),
        border: const UnderlineInputBorder(),
        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your birthdate";
        }
        return null;
      },
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (pickedDate != null) {
          setState(() {
            _birthdateController.text = "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
          });
        }
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void _showGenderDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Gender"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text("Male"),
                leading: Radio<String>(
                  value: "Male",
                  groupValue: _selectedGender,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedGender = value;
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
              ListTile(
                title: const Text("Female"),
                leading: Radio<String>(
                  value: "Female",
                  groupValue: _selectedGender,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedGender = value;
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
              ListTile(
                title: const Text("Other"),
                leading: Radio<String>(
                  value: "Other",
                  groupValue: _selectedGender,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedGender = value;
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
