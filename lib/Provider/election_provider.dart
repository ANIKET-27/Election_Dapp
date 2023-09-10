import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class LifeMeaningProvider extends ChangeNotifier {
  static const String contractName = "Election";

  final String rpcURL = "HTTP PORT";
  final String wsURL = "WS PORT";

 static  String privateKey =
      "ETHEREUM PRIVATE KEY FOR THE AUTHORITY";


  late Web3Client client;
  late Credentials credentials;
  late DeployedContract contract;
  late ContractFunction contractStartElection;
  late ContractFunction contractAddCandidate;
  late ContractFunction contractAddVoter;
  late ContractFunction contractEligible;
  late ContractFunction contractVote;
  late ContractFunction contractNumberOfVoters;
  late ContractFunction contractNumberOfCandidate;
  late ContractFunction contractGetElectionName;
  late ContractFunction contractGetElectionStatus;
  late ContractFunction contractCandidateAt;
  late ContractFunction contractVoterAt;

  LifeMeaningProvider(context) {
    intialize(context);
  }

  intialize(context) async {
    try {
      client = Web3Client(
        rpcURL,
        Client(),
        socketConnector: () {
          return IOWebSocketChannel.connect(wsURL).cast<String>();
        },
      );

      final abiStringFile = await DefaultAssetBundle.of(context)
          .loadString("build/contracts/Election.json");
      final abiJson = jsonDecode(abiStringFile);
      final abi = jsonEncode(abiJson["abi"]);

      final contractAddress =
          EthereumAddress.fromHex(abiJson["networks"]["5777"]["address"]);

      credentials = EthPrivateKey.fromHex(privateKey);

      contract = DeployedContract(
          ContractAbi.fromJson(abi, contractName), contractAddress);

      contractStartElection = contract.function("startElection");
      contractAddCandidate = contract.function("addCandidate");
      contractAddVoter = contract.function("addVoter");
      contractEligible = contract.function("eligible");
      contractVote = contract.function("vote");
      contractNumberOfCandidate = contract.function("numberOfCandidate");
      contractNumberOfVoters = contract.function("numberOfVoters");
      contractGetElectionName = contract.function("getElectionName");
      contractGetElectionStatus = contract.function("getElectionSatus");
      contractCandidateAt = contract.function("getCandidateAt");
      contractVoterAt = contract.function("VotersAt");

      print("Success");
    } catch (e) {
      print("Connection Failed");
    }
  }

  Future<void> startElection(String value) async {
    await client.sendTransaction(
        credentials,
        Transaction.callContract(
            contract: contract,
            function: contractStartElection,
            parameters: [value]),
        fetchChainIdFromNetworkId: false,
        chainId: 1337);

    notifyListeners();
  }

  Future<void> addCandidate(
      String candiName, String candiurl, String ptyName, String ptyUrl) async {
    await client.sendTransaction(
        credentials,
        Transaction.callContract(
            contract: contract,
            function: contractAddCandidate,
            parameters: [candiName, candiurl, ptyName, ptyUrl]),
        fetchChainIdFromNetworkId: false,
        chainId: 1337);

    notifyListeners();
  }

  Future<void> addVotter(String addr, String name, String url) async {
    await client.sendTransaction(
        credentials,
        Transaction.callContract(
            contract: contract,
            function: contractAddVoter,
            parameters: [EthereumAddress.fromHex(addr), name, url]),
        fetchChainIdFromNetworkId: false,
        chainId: 1337);

    notifyListeners();
  }

  Future<void> vote(String addr,int idx) async {
    await client.sendTransaction(
      credentials,
      Transaction.callContract(
          contract: contract,
          function: contractVote,
          parameters: [EthereumAddress.fromHex(addr),BigInt.from(idx)]),
      fetchChainIdFromNetworkId: false,
      chainId: 1337, //1337
    );

    notifyListeners();
  }

  Future<bool> eligible(String s) async {
    final result = await client.call(
        contract: contract, function: contractEligible,
        params: [EthereumAddress.fromHex(s)]);
    
        return result[0];
  }

  Future<List> candidateAt(int idx) async {

    final result = await client.call(
        contract: contract,
        function: contractCandidateAt,
        params: [BigInt.from(idx)]);
   //  print(result);
    return result;
  }

  Future<List> voterAt(int idx) async {
    final result = await client.call(
        contract: contract,
        function: contractVoterAt,
        params: [BigInt.from(idx)]);
 //   print(result);
    return result;
  }

  Future<int> numberOfVoter() async {
    final result = await client
        .call(contract: contract, function: contractNumberOfVoters, params: []);

    BigInt temp = result[0];
    return temp.toInt();
  }

  Future<int> numberOfCandidate() async {
    final result = await client.call(
        contract: contract, function: contractNumberOfCandidate, params: []);

    BigInt temp = result[0];
    return temp.toInt();
  }

  Future<bool> getElectionStatus() async {
    final result = await client.call(
        contract: contract, function: contractGetElectionStatus, params: []);
    return result[0];
  }

  Future<String> getElectionName() async {
    final result = await client.call(
        contract: contract, function: contractGetElectionName, params: []);
    return result[0];
  }
}


// Candidate 1 - Blue  https://img.freepik.com/premium-vector/man-avatar-icon-flat-illustration-man-avatar-vector-icon-any-web-design_98396-3370.jpg?w=740
//               logo  https://img.freepik.com/free-vector/colorful-floral-logo_1025-262.jpg?size=626&ext=jpg&ga=GA1.2.1484278514.1693201160&semt=ais

// Candidate 2 - Orange  https://img.freepik.com/premium-vector/young-man-avatar-character_24877-9475.jpg?w=740
//               logo  https://img.freepik.com/free-vector/colourful-gradient-abstract-logo-template_23-2148298816.jpg?size=626&ext=jpg&ga=GA1.2.1484278514.1693201160&semt=ais
//
//
// Voter1 - Tucker https://img.freepik.com/free-psd/3d-illustration-person-with-glasses_23-2149436190.jpg?size=626&ext=jpg&ga=GA1.1.1484278514.1693201160&semt=ais
//        id  - 0xDF487f0D9200733f851500639EBb46d8d42f1658

//  Voter 2 - Alex https://img.freepik.com/premium-vector/people-saving-money_24908-51568.jpg?size=626&ext=jpg&ga=GA1.1.1484278514.1693201160&semt=ais
//          id - 0x91Cfd412D0b8Ab280a9f7Ca773EF874B53Cd46D5


// Voter 3 - Emma https://img.freepik.com/premium-vector/new-female-avatar-icon-flat-illustration-female-avatar-vector-icon-any-web-design_98396-3364.jpg?size=626&ext=jpg&ga=GA1.1.1484278514.1693201160&semt=ais
//          id- 0x673dE9C639CCC42e6aEeD7cBc2FB620dAea27785

// voter 4 - Bob https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg?size=626&ext=jpg&ga=GA1.1.1484278514.1693201160&semt=ais
//           id - 0xDbDFF2d4E2555e308856694Cb3b6Cce6a8c79720


// voter 5 - Phil https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436200.jpg?size=626&ext=jpg&ga=GA1.1.1484278514.1693201160&semt=ais
//           id - 0x0D93aD705d3056Ff769f200BC9d334756c25B6D4


// voter 6 - Jack https://img.freepik.com/premium-vector/people-saving-money_24908-51569.jpg?size=626&ext=jpg&ga=GA1.1.1484278514.1693201160&semt=ais
//            id- 0x21879a2cc3F8Eb04aED4850D0276a3134Cd81003

