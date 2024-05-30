import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:election/utils/constants.dart';
import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';

Future<DeployedContract> loadContract() async {
  String abi = await rootBundle.loadString('assets/abi.json');
  String contractAddress = contractAddress1;
  final contract = DeployedContract(ContractAbi.fromJson(abi, 'Vault'),
      EthereumAddress.fromHex(contractAddress));
  return contract;
}

Future<String> callFunction(String funcname, List<dynamic> args,
    Web3Client ethClient, String privateKey) async {
  EthPrivateKey credentials = EthPrivateKey.fromHex(privateKey);
  DeployedContract contract = await loadContract();
  final ethFunction = contract.function(funcname);
  final result = await ethClient.sendTransaction(
      credentials,
      Transaction.callContract(
        contract: contract,
        function: ethFunction,
        parameters: args,
      ),
      chainId: null,
      fetchChainIdFromNetworkId: true);
  return result;
}

Future<String> addCandidate(String name, Web3Client ethClient) async {
  var response =
      await callFunction('addCandidate', [name], ethClient, owner_private_key);
  print('Candidate added successfully');
  return response;
}

Future<String> authorizeVoter(String address, Web3Client ethClient) async {
  var response = await callFunction('authorizeVoter',
      [EthereumAddress.fromHex(address)], ethClient, owner_private_key);
  print('Voter Authorized successfully');
  return response;
}

Future<List> getCandidatesNum(Web3Client ethClient) async {
  List<dynamic> result = await ask('getNumCandidates', [], ethClient);
  return result;
}

Future<List> getTotalVotes(Web3Client ethClient) async {
  List<dynamic> result = await ask('getTotalVotes', [], ethClient);
  return result;
}

Future<List> candidateInfo(int index, Web3Client ethClient) async {
  List<dynamic> result =
      await ask('candidateInfo', [BigInt.from(index)], ethClient);
  return result;
}

Future<List<dynamic>> ask(
    String funcName, List<dynamic> args, Web3Client ethClient) async {
  final contract = await loadContract();
  final ethFunction = contract.function(funcName);
  final result =
      ethClient.call(contract: contract, function: ethFunction, params: args);
  return result;
}

Future<String> vote(int candidateIndex, Web3Client ethClient) async {
  var response = await callFunction(
      "vote", [BigInt.from(candidateIndex)], ethClient, voter_private_key);
  print("Vote counted successfully");
  return response;
}

///
///
///
///
///
///
///
//
////////////////// New Function for uploading img
///
///
///

String ipfsHash = '';

Future<void> storeHash(XFile? imageFile, Web3Client ethClient) async {
  try {
    const projectId = "2WRsye1nIQ6GEidRYbLagEWG9r6";
    const projectSecret = "3a66d510378cd6d6f8d0d55362fb2d7f";

    if (imageFile == null) {
      print("No image selected.");
      return;
    }

    final url = Uri.parse("https://ipfs.infura.io:5001/api/v0/add?pin=true");
    final authString = base64Encode(utf8.encode("$projectId:$projectSecret"));

    final headers = {
      'Authorization': 'Basic $authString',
    };

    final request = http.MultipartRequest('POST', url);
    request.headers.addAll(headers);

    request.files.add(
      http.MultipartFile.fromBytes(
        'path', // 'path' is the expected argument name for file upload
        await imageFile.readAsBytes(),

        filename: imageFile.name,
      ),
    );

    final response = await request.send();
    final responseJson = jsonDecode(await response.stream.bytesToString());
    print("byet::::: $responseJson");

    if (response.statusCode == 200) {
      final uploadedHash = responseJson['Hash'];
      await storeIPFSHash(uploadedHash, ethClient);

      ipfsHash = uploadedHash;
      //contract

      //
      print("Image uploaded to IPFS. IPFS Hash: $uploadedHash");
    } else {
      print(
          "Failed to upload image to IPFS. Status code: ${response.statusCode}");
      print("Response body: $responseJson");
    }
  } catch (e) {
    print("Error uploading image to IPFS: $e");
  }
}

///
///
///

Future<void> pickImage(Web3Client ethClient) async {}
bool isStoreIPFSHashExecuted = false; // Add this boolean variable

Future<String> storeIPFSHash(String ipfsHash, Web3Client ethClient) async {
  if (isStoreIPFSHashExecuted) {
    print('storeIPFSHash has already been executed. Skipping.');
    return "Already executed"; // Return an appropriate value or message
  }

  isStoreIPFSHashExecuted =
      true; // Set the flag to true to prevent future executions

  final picker = ImagePicker();
  final pickedImage = await picker.pickImage(source: ImageSource.gallery);
  if (pickedImage != null) {
    await storeHash(pickedImage, ethClient);
  }

  var response = await callFunction(
      'storeIPFSHash', [ipfsHash], ethClient, owner_private_key);
  print('storeIPFSHash stored successfully');
  return response;
}

Future<List> getIPFSHash(Web3Client ethClient) async {
  List<dynamic> result = await ask('getIPFSHash', [], ethClient);
  return result;
}
