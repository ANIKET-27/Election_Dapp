import 'package:election_dapp/Provider/election_provider.dart';
import 'package:election_dapp/Viwes/Authority/auth_uii.dart';
import 'package:flutter/material.dart';
//import 'package:election_dapp/Provider/election_provider.dart';

class AuthVerification extends StatefulWidget {
 const AuthVerification({super.key});

  @override
  State<AuthVerification> createState() => _AuthVerificationState();
}

class _AuthVerificationState extends State<AuthVerification> {
  TextEditingController tec = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Authority Verification"),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Enter Your Private Key Below",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
          SizedBox(height: 30,),
        TextFormField(
            decoration: InputDecoration(hintText: "Private Key",),
            controller: tec,
            maxLines:2,
            autofocus: true,
           ),
           SizedBox(height: 30,),
           ElevatedButton(
            onPressed: () {
              if (tec.text==LifeMeaningProvider.privateKey) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AuthUI()));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('You are Not Authorized'),
                  backgroundColor: Colors.redAccent,
                )
                );
              }
            },
            child: const Text("Click Here To Verify",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),))
      ],
      )),
    );
  }
}
