import 'package:election_dapp/Provider/election_provider.dart';
import 'package:election_dapp/Viwes/Voters/voters_ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VotersVerification extends StatefulWidget  {

 const VotersVerification({super.key});

  @override
  State<VotersVerification> createState() => _VotersVerificationState();
}

class _VotersVerificationState extends State<VotersVerification> {

  var eAdd = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
        children: [
          SizedBox(height: 20,),
          Text("Verify Your Ethereum Address",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
          SizedBox(height: 20,),
          TextFormField(
            decoration: InputDecoration(
              hintText: "Enter Ethereum Address here ",
            ),
            controller: eAdd,
            maxLines: 1,
            autofocus: false,
          ),
          SizedBox(height: 30,),
          Consumer<LifeMeaningProvider>(
              builder: (context, value, child) {

                return InkWell(onTap:() =>get(value),
                    child:Container(
                      margin: EdgeInsets.all(10),
                    width: double.maxFinite,
                      height: 50,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child:Text("Verify",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    ),
                    )
                );
              },
          ),
          ],
        ),
      ),
    );
  }

  void get(LifeMeaningProvider value) async{
    try {
      bool temp = await value.eligible(eAdd.text);
      if(temp){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Verification Successfull"),backgroundColor: Colors.lightGreen,));
        Future.delayed(Duration(seconds: 2));
        Navigator.push(context, MaterialPageRoute(builder: (context)=>VotersUI(eAdd: eAdd.text)));
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Address is no more valid for voting"),backgroundColor: Colors.red,));
        Future.delayed(Duration(seconds: 2));
      }
    }
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Address Was Not Register")));
    }

  }


}
