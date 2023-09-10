import 'package:election_dapp/Provider/election_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VotersList extends StatefulWidget {
  const VotersList({super.key});

  @override
  State<VotersList> createState() => _VotersListState();
}

class _VotersListState extends State<VotersList> {
 // TextStyle voted = TextStyle(fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Consumer<LifeMeaningProvider>(builder: (context, value, child) {
      return Scaffold(
          body: Column(children: [
        const Text("Voters List", style: TextStyle(fontSize: 25)),
        FutureBuilder<int>(
            future: value.numberOfVoter(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(
                  child: const CircularProgressIndicator(),
                );
              return Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data,
                      itemBuilder: (context, idx) {
                        return FutureBuilder<List>(
                            future: value.voterAt(idx),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting)
                                return Center(child: CircularProgressIndicator(),);

                              BigInt temp = snapshot.data![3];
                              if (snapshot.data![2]) {
                                return Container(
                                  margin: EdgeInsets.all(10),
                                  color: Colors.green,
                                  child: Row(
                                    children: [
                                      Image.network(
                                        snapshot.data![1],
                                        fit: BoxFit.cover,
                                        width: 90,
                                        height: 90,
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Index No. : " +
                                              (idx + 1).toString()),
                                              SizedBox(height: 7,),
                                          Text("Name : " + snapshot.data![0]),
                                          SizedBox(height: 7,),
                                          Text("Voted To : " +
                                              (temp.toInt()).toString()),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return Container(
                                 margin: EdgeInsets.all(10),
                                  height: 100,
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        child:  Image.network(
                                        snapshot.data![1],
                                        fit: BoxFit.cover,
                                        width: 90,
                                        height: 90,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Index No. : " +
                                              (idx + 1).toString()),
                                              SizedBox(height: 7,),
                                          Text("Name : " + snapshot.data![0]),
                                        
                                        ],
                                      ),
                                    ],
                                  ));
                            });
                      }));
            })
      ]));
    });
  }
}
