import 'package:flutter/material.dart';

// Theme colors.
Color kDarkGrey = Color(0xFF26252F);
Color kGrey = Color(0xFFD9D9D9);
Color kText = Color(0xFF5C5C5C);

// Challenge screen.
class StartChallengeScreen extends StatefulWidget {
  final List<String> friends;

  StartChallengeScreen({required this.friends});

  @override
  _StartChallengeScreenState createState() => _StartChallengeScreenState();
}

// State for challenge screen.
class _StartChallengeScreenState extends State<StartChallengeScreen> {
  final Set<String> _selectedFriends = {};

  // Friend toggle.
  void _toggleSelection(String friend) {
    setState(() {
      if (_selectedFriends.contains(friend)) {
        _selectedFriends.remove(friend);
      } else {
        _selectedFriends.add(friend);
      }
    });
  }

  // Start challenge.
  void _startChallenge() {
    if (_selectedFriends.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Please select at least one friend to start a challenge.",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Navigator.pop(context, _selectedFriends);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkGrey,
      appBar: AppBar(
        backgroundColor: kDarkGrey,
        title: Text(
          "Start a Challenge",
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
              "Select Friends",
              style: TextStyle(
                color: kGrey,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: widget.friends.length,
                itemBuilder: (context, index) {
                  final friend = widget.friends[index];
                  final isSelected = _selectedFriends.contains(friend);
                  return Card(
                    color: isSelected ? Colors.green : kGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: isSelected ? Colors.white : kDarkGrey,
                        child: Text(
                          friend[0],
                          style: TextStyle(
                            color: isSelected ? Colors.green : Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(
                        friend,
                        style: TextStyle(
                          color: isSelected ? Colors.white : kText,
                          fontSize: 18,
                        ),
                      ),
                      trailing: Icon(
                        isSelected ? Icons.check_circle : Icons.circle_outlined,
                        color: isSelected ? Colors.white : kText,
                      ),
                      onTap: () => _toggleSelection(friend),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: _startChallenge,
                child: Text("Start Challenge"),
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
