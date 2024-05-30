import 'package:election/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';

class BlockchainAuth {
  final EthereumAddress contractAddress;
  final EthereumAddress userAddress;
  final Credentials credentials;
  final Web3Client client;

  BlockchainAuth(
      this.contractAddress, this.userAddress, this.credentials, this.client);

  Future<void> registerUser(
      String name, String email, String passwordHash) async {
    String abi = await rootBundle.loadString('assets/abi.json');
    final contract = DeployedContract(
      ContractAbi.fromJson(
          abi, 'registerUser'), // Provide the ABI of your smart contract
      contractAddress,
    );

    final ethFunction = contract.function('registerUser');
    final result = await client.sendTransaction(
      credentials,
      Transaction.callContract(
        contract: contract,
        function: ethFunction,
        parameters: [
          name,
          email,
          passwordHash,
        ],
      ),
      chainId: 1, // Mainnet
    );

    debugPrint('User registered: $result');
  }

  Future<bool> loginUser(String email, String passwordHash) async {
    String abi = await rootBundle.loadString('assets/abi.json');
    final contract = DeployedContract(
      ContractAbi.fromJson(
          abi, 'loginUser'), // Provide the ABI of your smart contract
      contractAddress,
    );

    final ethFunction = contract.function('loginUser');
    final result = await client.call(
      contract: contract,
      function: ethFunction,
      params: [
        email,
        passwordHash,
      ],
    );

    return result[0] as bool;
  }
}
