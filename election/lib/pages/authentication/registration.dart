import 'package:election/pages/dashboard.dart';
import 'package:election/services/auth.dart';
import 'package:election/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart' as web3;

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _email = '';
  String _name = '';
  String _password = '';
  final Color _textColor = Colors.black; // Initial text color
  final OutlineInputBorder _focusedBorder = const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue), // Set the focused border color
  );

  //

  // final String infuraUrl = 'https://mainnet.infura.io/v3/YOUR_INFURA_API_KEY';
// final String contractAddress = '0xYourContractAddress';
// final String privateKey = '0xYourPrivateKey';

  final client = web3.Web3Client(infura_url, http.Client());
  Future<String?> func() async {
    try {
      final credentials =
          await client.credentialsFromPrivateKey(owner_private_key);

      debugPrint("credentials----> ${credentials.toString()}");
      String randomAddress =
          '0x${List.generate(40, (index) => index.isEven ? '1' : '2').join()}';
      final blockchainAuth = BlockchainAuth(
        web3.EthereumAddress.fromHex(contractAddress1),
        web3.EthereumAddress.fromHex(randomAddress),
        credentials,
        client,
      );
      debugPrint("blochainAuth ----> ${blockchainAuth.toString()}");
      await blockchainAuth.registerUser(
          nameController.text, emailController.text, passwordController.text);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Dashboard()),
      );
    } catch (e) {
      debugPrint("print error here -----> $e");
    }
    return null;
  }

  Future<bool> authenticateUser(String username, String password) async {
    String abi = await rootBundle.loadString('assets/auth.json');
    final http.Client httpClient = http.Client();
    const String ganacheUrl =
        "http://190.190.2.30:7545"; // Replace with your Ganache URL
    String privateKey = owner_private_key; // Replace with your private key
    final web3.EthereumAddress contractAddress = web3.EthereumAddress.fromHex(
        "0x901A2fDe250183d1CEC01fc4FC9B5F1D114129eE"); // Replace with your contract address
    // String contractABI = abi; // Replace with your contract ABI

    final credentials = web3.EthPrivateKey.fromHex(privateKey);

    try {
      final ethClient = web3.Web3Client(ganacheUrl, httpClient);

      final contract = web3.DeployedContract(
        web3.ContractAbi.fromJson(
            abi, "AuthContract"), // Replace with your contract name
        contractAddress,
      );

      final function = contract.function('authenticateUser');

      final result = await ethClient.call(
        contract: contract,
        function: function,
        params: [username, password],
        sender: web3.EthereumAddress.fromHex(owner_private_key),
        // from: credentials.address,
        // ga: web3.EtherAmount.inWei(BigInt.from(1000000000)),
      );

      if (result.isNotEmpty && result[0] == true) {
        // Authentication successful
        debugPrint("hello");
        return true;
      } else {
        // Authentication failed or result is empty
        debugPrint("false hello");
        return false;
      }
    } catch (e) {
      debugPrint("Error authenticating user: $e");
      return false;
    } finally {
      httpClient.close();
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   func();
  // }

  ///
  ///
  ///

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[300],
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(Icons.arrow_back_ios_new_sharp),
                ),
                Container(
                  height: 180,
                ),
                Container(
                  height: 530,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 54),
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 14),
                            child: SizedBox(
                              height: 20,
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  "Create New Account",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: TextFormField(
                              controller: emailController,
                              style: const TextStyle(
                                  color: Colors
                                      .black), // Set input text color here
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                hintText: 'Enter your email',
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon: Icon(Icons.person),
                                contentPadding: EdgeInsets.all(12.0),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your email';
                                }
                                // Email validation using regex pattern
                                final emailRegex = RegExp(
                                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
                                );
                                if (!emailRegex.hasMatch(value)) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (value) {
                                _email = value!;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: TextFormField(
                              controller: nameController,
                              style: const TextStyle(
                                  color: Colors
                                      .black), // Set input text color here
                              decoration: const InputDecoration(
                                labelText: 'Name',
                                hintText: 'Enter your name',
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon: Icon(Icons.person),
                                contentPadding: EdgeInsets.all(12.0),
                              ),
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _name = value!;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: TextFormField(
                              controller: passwordController,
                              style: const TextStyle(
                                  color: Colors
                                      .black), // Set input text color here
                              decoration: const InputDecoration(
                                labelText: 'Password',
                                hintText: 'Enter your password',
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon: Icon(Icons.lock),
                                contentPadding: EdgeInsets.all(12.0),
                              ),
                              obscureText: true, // Hide the password characters
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your password';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _password = value!;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          FilledButton.tonal(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.green[300])),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  // Perform some action with _name
                                  // For example, display a snackbar
                                  // _scaffoldKey.currentState.showSnackBar(
                                  //   SnackBar(
                                  //     content: Text('Name: $_name'),
                                  //   ),
                                  // );
                                  // func();
                                  // try {
                                  //   client.makeRPCCall(contractAddress1);
                                  // } catch (e) {
                                  //   debugPrint("debug here ---> $e");
                                  // }
                                  await authenticateUser(emailController.text,
                                      passwordController.text);
                                }
                              },
                              child: const Text(
                                "REGISTER",
                                style: TextStyle(color: Colors.black),
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          RichText(
                            text: TextSpan(children: [
                              const TextSpan(
                                  text: "Already have an account? ",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w400,
                                  )),
                              TextSpan(
                                  text: "Login here",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.green[300],
                                    fontWeight: FontWeight.w400,
                                  )),
                            ]),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
