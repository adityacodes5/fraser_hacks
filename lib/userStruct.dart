class User {
  String name;
  int age;
  int level;
  int xP;
  List<Friends> friendList;
  User({
    required this.name,
    required this.age,
    required this.level,
    required this.xP,
    required this.friendList,
  });
}

User user = User(name: "hey", age: 2, level: 0, xP: 0, friendList: []);

class Friends {
  String friendID;

  Friends({required this.friendID});
}

void main() {}
