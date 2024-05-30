// import 'package:election/pages/electionInfo.dart';
// import 'package:election/services/functions.dart';
// import 'package:election/utils/constants.dart';
// import 'package:http/http.dart';
// import 'package:web3dart/web3dart.dart';

// import 'package:flutter/material.dart';

// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);

//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   Client? httpClient;
//   Web3Client? ethClient;
//   TextEditingController controller = TextEditingController();

//   @override
//   void initState() {
//     httpClient = Client();
//     ethClient = Web3Client(infura_url, httpClient!);
//     super.initState();
//   }

//   // Future<void> user_() async {
//   //   // Example: Update user details
//   //   await updateUserDetails('Alice', 'alice@example.com', ethClient!);

//   //   // Example: Retrieve user details
//   //   final userAddress =
//   //       owner_private_key; // Replace with the user's Ethereum address
//   //   final userDetails = await getUserDetails(userAddress, ethClient!);
//   //   print('User Name: ${userDetails[0]}');
//   //   print('User Email: ${userDetails[1]}');

//   //   // ... Other interactions with the UserManagement contract ...
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Start Election'),
//       ),
//       body: Container(
//         padding: const EdgeInsets.all(14),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: controller,
//               decoration: const InputDecoration(
//                   filled: true, hintText: 'Enter election name'),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             SizedBox(
//                 width: double.infinity,
//                 height: 45,
//                 child: ElevatedButton(
//                     onPressed: () async {
//                       if (controller.text.isNotEmpty) {
//                         await startElection(controller.text, ethClient!);
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => ElectionInfo(
//                                     ethClient: ethClient!,
//                                     electionName: controller.text)));
//                       }
//                     },
//                     child: const Text('Start Election')))
//           ],
//         ),
//       ),
//     );
//   }
// }
