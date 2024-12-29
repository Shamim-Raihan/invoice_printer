// import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
// import 'package:flutter/material.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             // await SunmiDrawer.openDrawer();
//             // await SunmiPrinter.printText('text');
//             // await SunmiPrinter.printText('text');
//             // await SunmiPrinter.cutPaper();
//             testTicket();
//           },
//           child: const Text('Print invoice'),
//         ),
//       ),
//     );
//   }

//   Future<List<int>> testTicket() async {
//     // final List<int> bytes = [];
//     // Using default profile
//     final profile = await CapabilityProfile.load();
//     final available = await CapabilityProfile.getAvailableProfiles();
//     final generator = Generator(PaperSize.mm80, profile);
//     List<int> bytes = [];

//     bytes += generator.text(
//         'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
//     bytes += generator.text('Bold text', styles: PosStyles(bold: true));
//     bytes += generator.text('Reverse text', styles: PosStyles(reverse: true));
//     bytes += generator.text('Underlined text',
//         styles: PosStyles(underline: true), linesAfter: 1);
//     bytes +=
//         generator.text('Align left', styles: PosStyles(align: PosAlign.left));
//     bytes += generator.text('Align center',
//         styles: PosStyles(align: PosAlign.center));
//     bytes += generator.text('Align right',
//         styles: PosStyles(align: PosAlign.right), linesAfter: 1);

//     bytes += generator.text('Text size 200%',
//         styles: PosStyles(
//           height: PosTextSize.size2,
//           width: PosTextSize.size2,
//         ));

//     bytes += generator.feed(2);
//     bytes += generator.cut();
//     return bytes;
//   }
// }
