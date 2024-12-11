import 'package:flutter/material.dart';
class ChooseAddictionScreen extends StatefulWidget {
  @override
  _ChooseAddictionScreenState createState() => _ChooseAddictionScreenState();
}
class _ChooseAddictionScreenState extends State<ChooseAddictionScreen> {
  String? _selectedAddiction; // Holds the selected addiction
  final List<Map<String, dynamic>> addictions = [
    {"label": "Drugs", "icon": Icons.medication, "iconColor": Colors.red},
    {"label": "Smoking", "icon": Icons.smoking_rooms, "iconColor": Colors.grey},
    {"label": "Social Media", "icon": Icons.phone_iphone, "iconColor": Colors.blue},
    {"label": "Alcohol", "icon": Icons.local_bar, "iconColor": Colors.brown},
    {"label": "Self Harm", "icon": Icons.eco, "iconColor": Colors.green},
    {"label": "Sleeping", "icon": Icons.nights_stay, "iconColor": Colors.blue},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
        title: const Text(
          "Choose Addiction",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white, // Set the background color to white
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            const Text(
              "What are you struggling with?",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.9,
                ),
                itemCount: addictions.length,
                itemBuilder: (context, index) {
                  final addiction = addictions[index];
                  final isSelected = _selectedAddiction == addiction['label'];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedAddiction = addiction['label'];
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue.shade50 : Colors.white,
                        border: Border.all(
                          color: isSelected ? Colors.blue : Colors.grey.shade300,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          if (isSelected)
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.2),
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            addiction['icon'],
                            size: 60,
                            color: addiction['iconColor'],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            addiction['label']!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.blue : Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_selectedAddiction == null) {
                  // Show error if no addiction is selected
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Please select an addiction before proceeding.",
                        textAlign: TextAlign.center,
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else {
                  // Proceed to the next screen or save the selection
                  Navigator.pushNamed(context, '/home', arguments: {
                    "selectedAddiction": _selectedAddiction, // Pass data
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _selectedAddiction != null ? Colors.blue : Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                "Next",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}