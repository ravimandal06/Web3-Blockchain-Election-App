// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:web3dart/web3dart.dart' as web3;

// class Connect extends StatefulWidget {
//   @override
//   _ConnectState createState() => _ConnectState();
// }

// class _ConnectState extends State<Connect> {
//   final http.Client _httpClient = http.Client();

//   final String ganacheUrl =
//       "http://127.0.0.1:7545"; // Replace with your Ganache URL
//   final String infuraUrl =
//       "https://mainnet.infura.io/v3/YOUR_INFURA_API_KEY"; // Replace with your Infura URL
//   final String sepoliaUrl =
//       "https://sepolia.com/api"; // Replace with your Sepolia URL

//   final String privateKey = "YOUR_PRIVATE_KEY"; // Replace with your private key
//   final web3.EthereumAddress contractAddress = web3.EthereumAddress.fromHex(
//       "CONTRACT_ADDRESS"); // Replace with your contract address
//   final String contractABI = "CONTRACT_ABI"; // Replace with your contract ABI

 
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter App'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Account Address: $_accountAddress'),
//           ],
//         ),
//       ),
//     );
//   }
// }
