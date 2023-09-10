import 'package:election_dapp/Viwes/Authority/Bottom_Nav/candidate.dart';
import 'package:election_dapp/Viwes/Authority/Bottom_Nav/maganing_Tab.dart';
import 'package:election_dapp/Viwes/Authority/Bottom_Nav/voters_list.dart';
import 'package:flutter/material.dart';

class AuthUI extends StatefulWidget {
 
  const AuthUI({super.key,});

  @override
  State<AuthUI> createState() => _AuthUIState();
}

class _AuthUIState extends State<AuthUI> {
  List<Widget> tabs = [];
  int curIdx = 0;

  @override
  void initState() {
    super.initState();

    tabs.add(ManagingTab());
    tabs.add(VotersList());
    tabs.add(CandidateList());
  }

  Future<bool> onPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Exit the App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: onPop,
      child:
      Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Election Control Room"),
          automaticallyImplyLeading: false,
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: curIdx,
            onTap: (value) {
              setState(() {
                curIdx = value;
              });
            },
            selectedItemColor: Colors.lightGreen,
            unselectedItemColor: Colors.grey,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "Managing Operations"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.list), label: "Voters List"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.leaderboard), label: "Candidates"),
            ]),
        body: tabs.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : tabs[curIdx],
      )
    );
  }
}
