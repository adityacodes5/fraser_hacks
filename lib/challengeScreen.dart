import 'package:flutter/material.dart';

Color kDarkGrey = Color(0xFF26252F);
Color kGrey = Color(0xFFD9D9D9);
Color kText = Color(0xFF5C5C5C);

// Progress Display.
class ChallengeProgressScreen extends StatelessWidget {
  final Map<String, int> progress;

  final String currentUser;

  // Creates a new screen.
  ChallengeProgressScreen({required this.progress, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    // Descending order for progress.
    List<MapEntry<String, int>> sortedProgress = progress.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Scaffold(
      backgroundColor: kDarkGrey,
      appBar: AppBar(
        backgroundColor: kDarkGrey,
        title: Text(
          "Challenge Progress",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: sortedProgress.length,
          itemBuilder: (context, index) {
            final entry = sortedProgress[index];

            return Card(
              color: entry.key == currentUser ? Colors.green : kGrey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              margin: EdgeInsets.only(bottom: 16),
              child: ListTile(
                // Rank num.
                leading: CircleAvatar(
                  backgroundColor:
                      entry.key == currentUser ? Colors.white : Colors.orange,
                  child: Text(
                    "#${index + 1}",
                    style: TextStyle(
                      color: entry.key == currentUser
                          ? Colors.green
                          : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(
                  entry.key,
                  style: TextStyle(
                    color: entry.key == currentUser ? Colors.white : kText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // player's XP.
                trailing: Text(
                  "${entry.value} XP",
                  style: TextStyle(
                    color: entry.key == currentUser ? Colors.white : kText,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
