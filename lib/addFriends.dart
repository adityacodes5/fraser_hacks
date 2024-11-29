import 'package:flutter/material.dart';
import 'package:fraser_hacks/homeScreen.dart';

// Adding friends to race.
class AddFriendsModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkGrey,
      appBar: AppBar(
        backgroundColor: kDarkGrey,
        title: Text(
          "Add Friends",
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search bar.
            Container(
              decoration: BoxDecoration(
                color: kGrey,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: kText),
                  hintText: "Search for friends...",
                  hintStyle: TextStyle(color: kText),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ),
            SizedBox(height: 20),
            // fake friends list.
            Expanded(
              child: ListView(
                children: [
                  _buildFriendTile(context, "John Doe", "@johndoe"),
                  _buildFriendTile(context, "Jane Smith", "@janesmith"),
                  _buildFriendTile(context, "Alice Johnson", "@alicej"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFriendTile(BuildContext context, String name, String username) {
    return Card(
      color: kGrey,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: kDarkGrey,
          child: Text(
            name[0],
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(name,
            style: TextStyle(color: kText, fontWeight: FontWeight.bold)),
        subtitle: Text(username, style: TextStyle(color: kText)),
        trailing: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Friend added: $name")),
            );
          },
          child: Text(
            "Quick Add",
            style: TextStyle(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkGrey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}
