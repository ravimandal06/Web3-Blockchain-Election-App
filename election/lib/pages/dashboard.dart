import 'package:election/services/functions.dart';
import 'package:election/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Client? httpClient;
  Web3Client? ethClient;
  @override
  void initState() {
    httpClient = Client();
    ethClient = Web3Client(infura_url, httpClient!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ipfsHash != ''
                  ? Text(
                      "IPFS Hash: $ipfsHash",
                      style: const TextStyle(color: Colors.black),
                    )
                  : const Text(
                      "Pick an image from the gallery to upload.",
                      style: TextStyle(color: Colors.black),
                    ),
              const SizedBox(height: 20),
              SizedBox(
                child: Center(
                  child: FilledButton.tonal(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.green[300])),
                      onPressed: () {
                        storeIPFSHash(ipfsHash, ethClient!);
                      },
                      child: const Text(
                        "UPLOAD",
                        style: TextStyle(color: Colors.black),
                      )),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
