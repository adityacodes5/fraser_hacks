import 'package:flutter/material.dart';
import 'package:fraser_hacks/addHabits.dart';
import 'package:fraser_hacks/addFriends.dart';
import 'package:fraser_hacks/challengeScreen.dart';
import 'package:fraser_hacks/startChallenge.dart';

Color kDarkGrey = Color(0xFF26252F);
Color kGrey = Color(0xFFD9D9D9);
Color kText = Color(0xFF5C5C5C);

void main() => runApp(MaterialApp(home: HomeScreen()));

class Habit {
  String name;
  int counter; // number of times habbit was done today. NOTE: DEPRECATED
  int xp; // XP given per completion.

  Habit({required this.name, this.counter = 0, required this.xp});
}

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  List<Habit> habits = [
    Habit(name: "Finish English Assignment", xp: 10),
    Habit(name: "Reply to teacher email", xp: 5),
    Habit(name: "Prepare notebook for lesson", xp: 5),
    Habit(name: "Textbook Questions 1-5", xp: 20),
    Habit(name: "Workout", xp: 25),
    Habit(name: "Journal Writing", xp: 15),
    Habit(name: "Plan Tomorrow", xp: 10),
    Habit(name: "Healthy Snack", xp: 5),
  ];

  int currentLevel = 5;
  double currentXP = 30.0; // Current XP
  double xpRequired = 100.0; // XP required for the next level
  String userName = "Aditya"; // User's name
  bool challengeOngoing = false;
  Map<String, int> challengeProgress = {};

  void _incrementXP(int xp) {
    setState(() {
      currentXP += xp;
      if (currentXP >= xpRequired) {
        currentLevel++;
        currentXP -= xpRequired;
      }

      if (challengeOngoing) {
        challengeProgress[userName] = (challengeProgress[userName] ?? 0) + xp;
      }
    });
  }

  void _startChallenge(List<String> friends) {
    setState(() {
      challengeOngoing = true;
      challengeProgress = {for (var friend in friends) friend: 0};
      challengeProgress[userName] = 0;
    });
  }

  void _showModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: kDarkGrey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.person_add_alt_1, color: Colors.green),
                title: Text(
                  "Add a Friend",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddFriendsModal()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.edit, color: Colors.blue),
                title: Text(
                  "Add a New Habit",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddHabitScreen(
                        onAddHabit: (name, xp) {
                          setState(() {
                            habits.insert(0, Habit(name: name, xp: xp));
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.emoji_events, color: Colors.orange),
                title: Text(
                  "Start a Challenge",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StartChallengeScreen(
                        friends: [
                          "John Doe",
                          "Jane Smith",
                          "Alice Johnson",
                          "Bob Marley"
                        ],
                      ),
                    ),
                  ).then((selectedFriends) {
                    if (selectedFriends != null) {
                      _startChallenge(selectedFriends.toList());
                    }
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkGrey,
      appBar: AppBar(
        backgroundColor: kDarkGrey,
        elevation: 0,
        title: Text(
          'Productivity Race',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () => _showModal(context),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting section.
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Hello, $userName!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // XP and Level Header.
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Level $currentLevel',
                  style: TextStyle(
                    color: kGrey,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                // Progress Bar.
                Stack(
                  children: [
                    Container(
                      height: 10,
                      decoration: BoxDecoration(
                        color: kGrey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    Container(
                      height: 10,
                      width: (currentXP / xpRequired) *
                          MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  '${currentXP.toInt()} XP / ${xpRequired.toInt()} XP',
                  style: TextStyle(
                    color: kText,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          // Challenge Ongoing.
          if (challengeOngoing)
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChallengeProgressScreen(
                      progress: challengeProgress,
                      currentUser: userName,
                    ),
                  ),
                );
              },
              child: Card(
                color: Colors.orange,
                margin: const EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Challenge Ongoing!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ),
          // Scrollable List.
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: habits.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(habits[index].name),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    setState(() {
                      habits.removeAt(index);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('${habits[index].name} removed!')));
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  child: HabitWidget(
                    habit: habits[index],
                    onIncrement: (xp) => _incrementXP(xp),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class HabitWidget extends StatelessWidget {
  final Habit habit;
  final Function(int) onIncrement;

  HabitWidget({required this.habit, required this.onIncrement});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kGrey,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Habit Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    habit.name,
                    style: TextStyle(
                      color: kDarkGrey,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${habit.xp} XP per completion',
                    style: TextStyle(
                      color: kText,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            // Done button or checkmark
            if (habit.counter == 0)
              SizedBox(
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    habit.counter++;
                    onIncrement(habit.xp);
                  },
                  child: Text("Done"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              )
            else
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 32,
              ),
          ],
        ),
      ),
    );
  }
}
