import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recover_me_bloc/cubits/habits_cubit.dart';

class AddHabitPage extends StatefulWidget {
  const AddHabitPage({Key? key}) : super(key: key);

  @override
  _AddHabitPageState createState() => _AddHabitPageState();
}

class _AddHabitPageState extends State<AddHabitPage> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  int _target = 1;
  bool _setReminder = false;

  void _saveHabit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      context.read<HabitsCubit>().addHabit(_name, _target);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Custom Habit'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: BlocListener<HabitsCubit, HabitsState>(
        listener: (context, state) {
          if (state is HabitsSuccess) {
            Navigator.pop(context); 
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is HabitsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade400, Colors.blue.shade700],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Name',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Enter habit name',
                      hintStyle: const TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: Colors.blue.shade800,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter a habit name' : null,
                    onSaved: (value) => _name = value!,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Goal',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'e.g., 1 time per day',
                      hintStyle: const TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: Colors.blue.shade800,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) => int.tryParse(value!) == null
                        ? 'Please enter a valid number'
                        : null,
                    onSaved: (value) => _target = int.parse(value!),
                  ),
                  const SizedBox(height: 24),
                  SwitchListTile(
                    value: _setReminder,
                    onChanged: (value) {
                      setState(() {
                        _setReminder = value;
                      });
                    },
                    title: const Text(
                      'Set a daily reminder',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    activeColor: Colors.lightBlueAccent,
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => _saveHabit(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlueAccent,
                      ),
                      child: BlocBuilder<HabitsCubit, HabitsState>(
                        builder: (context, state) {
                          if (state is HabitsLoading) {
                            return const CircularProgressIndicator(
                              color: Colors.white,
                            );
                          }
                          return const Text(
                            'Add Habit',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
