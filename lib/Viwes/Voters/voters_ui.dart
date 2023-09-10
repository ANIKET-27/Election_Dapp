import 'package:election_dapp/Provider/election_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VotersUI extends StatefulWidget {
  String eAdd;
  VotersUI({super.key, required this.eAdd});

  @override
  State<VotersUI> createState() => _VotersUIState();
}

class _VotersUIState extends State<VotersUI> {
  var idx = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cast Your Vote"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              hintText: "Candidate Index You Choose To Vote",
            ),
            controller: idx,
            maxLines: 1,
            autofocus: false,
          ),
          Consumer<LifeMeaningProvider>(
            builder: (context, value, child) {
              return ElevatedButton(
                  onPressed: () {
                    try {
                      value.vote(widget.eAdd, int.parse(idx.text));
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Voted  Successfull")));
                      Navigator.pop(context);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text("Some Erro Occured , Please Try Again")));
                    }
                  },
                  child: Text("Submit Vote"));
            },
          ),
          SizedBox(height: 30,),
          Expanded(child:
          Consumer<LifeMeaningProvider>(builder: (context, value, child) {
            return Column(children: [
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
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else {
                             
                              return Container(
                                margin: EdgeInsets.all(10),
                                  //color: Colors.red,
                                  height: 100,
                                  child: Row(
                                    children: [
                                      Text((idx+1).toString(),style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                                      Image.network(snapshot.data![3],width: 90,height: 90,fit:BoxFit.cover,),
                                      Image.network(snapshot.data![1],width: 90,height: 90,fit:BoxFit.cover,),
                                      Expanded(child:Column(
                                            mainAxisAlignment: MainAxisAlignment.center,

                                            children: [
                                             Text(snapshot.data![2],style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),), Text(snapshot.data![0])
                                            ],
                                          ),
                                      )
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
            ]
            );
          }
          )
          )
        ],
      ),
    );
  }
}
