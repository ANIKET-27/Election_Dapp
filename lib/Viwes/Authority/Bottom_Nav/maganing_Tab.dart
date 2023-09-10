import 'package:election_dapp/Provider/election_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManagingTab extends StatefulWidget {
  const ManagingTab({super.key});

  @override
  State<ManagingTab> createState() => _ManagingTabState();
}

class _ManagingTabState extends State<ManagingTab> {
  TextEditingController candiName = TextEditingController();
  TextEditingController candidatePhoto = TextEditingController();
  TextEditingController partyName = TextEditingController();
  TextEditingController partyLogo = TextEditingController();

  TextEditingController votersAddress = TextEditingController();
  TextEditingController votresUrl = TextEditingController();
  TextEditingController votersName = TextEditingController();

  TextStyle ts = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Consumer<LifeMeaningProvider>(
      builder: (context, value, child) {
        return Scaffold(
            body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text("To Start The Election Press Start",style: ts,),
                 SizedBox(
                        height: 10,
                      ),
                ElevatedButton(
                  onPressed: () {
                    value.startElection("Presidential Elections");
                  },
                  child: Text(
                    "Start Election",
                  ),
                ),
                SizedBox(height: 30,),

                // Add Candidate

                Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15)),
                  height: 300,
                  width: double.maxFinite,
                  child: Column(
                    children: [
                      Text(
                        "Add Candidate Details Below",
                        style: ts,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Enter Candidate Name",
                        ),
                        controller: candiName,
                        maxLines: 1,
                        autofocus: false,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Enter Candidate Image Url",
                        ),
                        controller: candidatePhoto,
                        maxLines: 1,
                        autofocus: false,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Enter Party Name",
                        ),
                        controller: partyName,
                        maxLines: 1,
                        autofocus: false,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Enter Party Logo Url",
                        ),
                        controller: partyLogo,
                        maxLines: 1,
                        autofocus: false,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            // Write Candidate Addition call
                            value.addCandidate(
                                candiName.text,
                                candidatePhoto.text,
                                partyName.text,
                                partyLogo.text);
                          },
                          child: Text("Add Candidate")),
                    ],
                  ),
                ),

                // Adding Voters

                SizedBox(height: 40,),

                Text("Add Voters Details Below",style: ts,),
                SizedBox(height: 10,),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter Voters Name",
                  ),
                  controller: votersName,
                  maxLines: 1,
                  autofocus: false,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter Voters Image Url",
                  ),
                  controller: votresUrl,
                  maxLines: 1,
                  autofocus: false,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter Etherium Address",
                  ),
                  controller: votersAddress,
                  maxLines: 1,
                  autofocus: false,
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                    onPressed: () {
                      value.addVotter(
                          votersAddress.text, votersName.text, votresUrl.text);
                    },
                    child: Text("Add  Voter")),

                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ));
      },
    );
  }
}
