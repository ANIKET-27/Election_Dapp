import 'package:election_dapp/Provider/election_provider.dart';
import 'package:election_dapp/Viwes/Authority/auth_uii.dart';
import 'package:election_dapp/Viwes/Authority/auth_verification.dart';
//import 'package:election_dapp/Viwes/Voters/voters_ui.dart';
import 'package:election_dapp/Viwes/Voters/voters_verification_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextStyle eleName = new TextStyle(fontSize: 30,fontWeight: FontWeight.bold);
  late bool started=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Welcome To The Elections"),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Consumer<LifeMeaningProvider>(
                builder: (context, value, child) {
                  return FutureBuilder<bool>(
                    future: value.getElectionStatus(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child :CircularProgressIndicator());
                      } else {
                       if(snapshot.data==null) Text("Couldn't Connect Please Try Again");
                        started=snapshot.data!;
                        if(!started) return Text("Elections Have Not Started",style: eleName,);
                        return FutureBuilder<String>(
                          future: value.getElectionName(),
                          builder: (context, snapshot) {
                            if(snapshot.connectionState == ConnectionState.waiting)
                              return Text("Getting Status !! ",style: eleName,);
                            return Text(snapshot.data.toString(),style: eleName,);
                          },
                        );
                      }
                    },
                  );
                },
              ),
              SizedBox(height: 30,),

              Text("Login As ?"),
              Container(
                width: double.maxFinite,
                height: 60,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: InkWell(
                  child: Center(
                    child: Text("Authority",style: TextStyle(fontSize: 20),),
                  ),
                  onTap: (){
                    Navigator.push(context,
                     MaterialPageRoute(builder: (context) => AuthVerification()));
                    },

                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                width:  double.maxFinite,
                height: 60,
                decoration: BoxDecoration(
                  color:started? Colors.lightGreen: Colors.red,
                  borderRadius : BorderRadius.circular(30),
                ),
                child: InkWell(
                  child: Center(
                    child: Text("Voter",style: TextStyle(fontSize: 20),),
                  ),
                  onTap: (){
                    if(!started)
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Election has not started  Please try after sometime")));
                    else
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> VotersVerification()));

                  },
                ),
              )
            ],
          )),
    );
  }
}
