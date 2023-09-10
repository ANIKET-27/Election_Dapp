import 'package:election_dapp/Provider/election_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CandidateList extends StatefulWidget {
  const CandidateList({super.key});

  @override
  State<CandidateList> createState() => _CandidateListState();
}

class _CandidateListState extends State<CandidateList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LifeMeaningProvider>(builder: (context, value, child) {
      return Scaffold(
          body: Column(children: [
        const Text("Candidate List",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
        SizedBox(height: 20),
        FutureBuilder<int>(
            future: value.numberOfCandidate(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(
                  child: CircularProgressIndicator(),
                );
              return Expanded(
                  child: ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!,
                itemBuilder: (context, idx) {
                  return FutureBuilder<List>(
                    future: value.candidateAt(idx),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else {
                       
                        BigInt temp = snapshot.data![4];
                        return Container(
                            margin: EdgeInsets.all(10),
                            height: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                 Text((idx+1).toString()+".",style: TextStyle(fontSize: 20,),),
                                 Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                     ClipRRect(
                                  child: Image.network(
                                  snapshot.data![3],
                                  fit: BoxFit.cover,
                                  width: 75,
                                  height: 75,
                                ),
                                borderRadius: BorderRadius.circular(10),
                                ),
                                    Text(snapshot.data![2]),
                                ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                     ClipRRect(
                                  child: Image.network(
                                  snapshot.data![1],
                                  fit: BoxFit.cover,
                                  width: 75,
                                  height: 75,
                                ),
                                borderRadius: BorderRadius.circular(10),
                                ),
                                    Text(snapshot.data![0]),
                                ],
                                ),
                                SizedBox(width: 10,),
                               
                                Column(
                                 
                                  children: [
                                    Text("Votes"),
                                    Text(temp.toInt().toString(),style: TextStyle(fontSize:30,fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              ],
                            )
                        );
                      }
                    },
                  );
                },
              )
              );
            }
            )
      ]));
    });
  }
}
