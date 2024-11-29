import 'package:flutter/material.dart';

Color kDarkGrey = Color(0xFF26252F);
Color kGrey = Color(0xFFD9D9D9);
Color kText = Color(0xFF5C5C5C);

class AddHabitScreen extends StatefulWidget {
  final Function(String, int) onAddHabit;

  AddHabitScreen({required this.onAddHabit});

  @override
  State<AddHabitScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _xpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkGrey,
      appBar: AppBar(
        backgroundColor: kDarkGrey,
        title: Text(
          "Add New Habit",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Habit Name",
              style: TextStyle(
                color: kGrey,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                filled: true,
                fillColor: kGrey,
                hintText: "Enter habit name",
                hintStyle: TextStyle(color: kText),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
              ),
              style: TextStyle(color: kText),
            ),
            SizedBox(height: 16),
            Text(
              "XP Per Completion",
              style: TextStyle(
                color: kGrey,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _xpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: kGrey,
                hintText: "Enter XP amount",
                hintStyle: TextStyle(color: kText),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
              ),
              style: TextStyle(color: kText),
            ),
            SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  String name = _nameController.text.trim();
                  int xp = int.tryParse(_xpController.text.trim()) ?? 0;

                  if (name.isNotEmpty && xp > 0 && xp <= 100) {
                    widget.onAddHabit(name, xp);
                    Navigator.pop(context);
                  } else if (xp <= 0 || xp > 100) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "XP must be between 1 and 100.",
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Please enter a valid habit name and XP.",
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: Text("Save Habit"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                  textStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
