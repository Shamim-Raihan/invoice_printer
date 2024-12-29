// import 'package:flutter/material.dart';
// import 'package:printer_test_app/home_screen.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const HomeScreen()
//     );
//   }
// }

// First, add this to pubspec.yaml
/*
dependencies:
  flutter:
    sdk: flutter
  esc_pos_utils_plus: ^2.0.1+6
  image: ^3.0.2
  path_provider: ^2.0.15
  bluetooth_print: ^4.3.0  // For Bluetooth printing
*/

// import 'dart:io';

// import 'package:bluetooth_print/bluetooth_print.dart';
// import 'package:bluetooth_print/bluetooth_print_model.dart';
// // main.dart
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Thermal Printer Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const PrinterPage(),
//     );
//   }
// }

// class PrinterPage extends StatefulWidget {
//   const PrinterPage({Key? key}) : super(key: key);

//   @override
//   State<PrinterPage> createState() => _PrinterPageState();
// }

// class _PrinterPageState extends State<PrinterPage> {
//   BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
//   bool _connected = false;
//   BluetoothDevice? _device;
//   String tips = 'No device connected';

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) => initBluetooth());
//   }

//   Future<void> requestBluetoothPermission() async {
//     // Request Bluetooth permission
//     if (Platform.isAndroid) {
//       Map<Permission, PermissionStatus> statuses = await [
//         Permission.bluetooth,
//         Permission.bluetoothConnect,
//         Permission.bluetoothScan,
//         Permission.bluetoothAdvertise,
//         Permission.location,
//       ].request();

//       print(statuses);
//     }
//   }

//   // Initialize Bluetooth
//   Future<void> initBluetooth() async {
//     bluetoothPrint.startScan(timeout: const Duration(seconds: 4));

//     bool isConnected = await bluetoothPrint.isConnected ?? false;

//     bluetoothPrint.state.listen((state) {
//       switch (state) {
//         case BluetoothPrint.CONNECTED:
//           setState(() {
//             _connected = true;
//             tips = 'Connected';
//           });
//           break;
//         case BluetoothPrint.DISCONNECTED:
//           setState(() {
//             _connected = false;
//             tips = 'Disconnected';
//           });
//           break;
//         default:
//           break;
//       }
//     });

//     if (!mounted) return;

//     if (isConnected) {
//       setState(() {
//         _connected = true;
//       });
//     }
//   }

//   // Generate test receipt
//   Future<List<LineText>> generateReceipt() async {
//     List<LineText> list = [];

//     // Store Header
//     list.add(LineText(
//       type: LineText.TYPE_TEXT,
//       content: 'MY STORE',
//       weight: 2,
//       width: 2,
//       height: 2,
//       align: LineText.ALIGN_CENTER,
//       linefeed: 1,
//     ));

//     list.add(LineText(
//       type: LineText.TYPE_TEXT,
//       content: '123 Main Street\nNew York, NY 10001',
//       align: LineText.ALIGN_CENTER,
//       linefeed: 1,
//     ));

//     list.add(LineText(
//       type: LineText.TYPE_TEXT,
//       content: 'Tel: (555) 123-4567',
//       align: LineText.ALIGN_CENTER,
//       linefeed: 1,
//     ));

//     list.add(LineText(
//       type: LineText.TYPE_TEXT,
//       content: '--------------------------------',
//       linefeed: 1,
//     ));

//     // Date
//     list.add(LineText(
//       type: LineText.TYPE_TEXT,
//       content: DateTime.now().toString().substring(0, 19),
//       linefeed: 1,
//     ));

//     list.add(LineText(
//       type: LineText.TYPE_TEXT,
//       content: '--------------------------------',
//       linefeed: 1,
//     ));

//     // Items Header
//     list.add(LineText(
//       type: LineText.TYPE_TEXT,
//       content: 'Item          Price',
//       weight: 1,
//       linefeed: 1,
//     ));

//     // Items
//     list.add(LineText(
//       type: LineText.TYPE_TEXT,
//       content: 'Product 1     \$10.00',
//       linefeed: 1,
//     ));

//     list.add(LineText(
//       type: LineText.TYPE_TEXT,
//       content: 'Product 2     \$20.00',
//       linefeed: 1,
//     ));

//     list.add(LineText(
//       type: LineText.TYPE_TEXT,
//       content: '--------------------------------',
//       linefeed: 1,
//     ));

//     // Total
//     list.add(LineText(
//       type: LineText.TYPE_TEXT,
//       content: 'TOTAL:        \$30.00',
//       weight: 1,
//       linefeed: 1,
//     ));

//     list.add(LineText(
//       type: LineText.TYPE_TEXT,
//       content: '--------------------------------',
//       linefeed: 1,
//     ));

//     // Footer
//     list.add(LineText(
//       type: LineText.TYPE_TEXT,
//       content: 'Thank you for your purchase!',
//       align: LineText.ALIGN_CENTER,
//       weight: 1,
//       linefeed: 3,
//     ));

//     return list;
//   }

//   // Print receipt
//   void printReceipt() async {
//     try {
//       if (!_connected) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Please connect to a printer first'),
//             backgroundColor: Colors.red,
//           ),
//         );
//         return;
//       }

//       // Double check if we're really connected
//       bool? isConnected = await bluetoothPrint.isConnected;
//       if (isConnected == true) {
//         Map<String, dynamic> config = {};
//         List<LineText> data = await generateReceipt();

//         await bluetoothPrint.printReceipt(config, data).catchError((error) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('Print error: $error'),
//               backgroundColor: Colors.red,
//             ),
//           );
//         });
//       } else {
//         // Try to reconnect if the connection was lost
//         if (_device != null) {
//           await bluetoothPrint.connect(_device!);
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('Trying to reconnect...'),
//               backgroundColor: Colors.orange,
//             ),
//           );
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('No printer selected'),
//               backgroundColor: Colors.red,
//             ),
//           );
//         }
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error: $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Thermal Printer Demo'),
//       ),
//       body: RefreshIndicator(
//         onRefresh: () async {
//           await initBluetooth();
//         },
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(tips),
//                   ],
//                 ),
//               ),
//               StreamBuilder<List<BluetoothDevice>>(
//                 stream: bluetoothPrint.scanResults,
//                 initialData: const [],
//                 builder: (context, snapshot) {
//                   if (snapshot.hasData) {
//                     return Column(
//                       children: snapshot.data!.map((device) {
//                         return ListTile(
//                           title: Text(device.name ?? ''),
//                           subtitle: Text(device.address ?? ''),
//                           onTap: () async {
//                             try {
//                               setState(() {
//                                 _device = device;
//                               });
//                               await bluetoothPrint.connect(device);

//                               // Wait a bit to ensure connection is established
//                               await Future.delayed(const Duration(seconds: 1));

//                               // Verify connection
//                               bool? isConnected =
//                                   await bluetoothPrint.isConnected;
//                               if (isConnected == true) {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(
//                                     content: Text('Connected successfully'),
//                                     backgroundColor: Colors.green,
//                                   ),
//                                 );
//                               } else {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(
//                                     content: Text('Failed to connect'),
//                                     backgroundColor: Colors.red,
//                                   ),
//                                 );
//                               }
//                             } catch (e) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                   content: Text('Connection error: $e'),
//                                   backgroundColor: Colors.red,
//                                 ),
//                               );
//                             }
//                           },
//                           trailing: _device?.address == device.address
//                               ? const Icon(
//                                   Icons.check,
//                                   color: Colors.green,
//                                 )
//                               : null,
//                         );
//                       }).toList(),
//                     );
//                   } else {
//                     return const Center(child: Text('No devices found'));
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _connected ? printReceipt : null,
//         child: const Icon(Icons.print),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     bluetoothPrint.disconnect();
//     super.dispose();
//   }
// }

import 'dart:async';
import 'dart:developer';
import 'dart:io';

// import 'package:esc_pos_utils_plus/esc_pos_utils.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos_printer_platform_image_3/flutter_pos_printer_platform_image_3.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Printer Type [bluetooth, usb, network]
  var defaultPrinterType = PrinterType.bluetooth;
  var _isBle = false;
  var _reconnect = false;
  var _isConnected = false;
  var printerManager = PrinterManager.instance;
  var devices = <BluetoothPrinter>[];
  StreamSubscription<PrinterDevice>? _subscription;
  StreamSubscription<BTStatus>? _subscriptionBtStatus;
  StreamSubscription<USBStatus>? _subscriptionUsbStatus;
  BTStatus _currentStatus = BTStatus.none;
  // _currentUsbStatus is only supports on Android
  // ignore: unused_field
  USBStatus _currentUsbStatus = USBStatus.none;
  List<int>? pendingTask;
  String _ipAddress = '';
  String _port = '9100';
  final _ipController = TextEditingController();
  final _portController = TextEditingController();
  BluetoothPrinter? selectedPrinter;

  @override
  void initState() {
    if (Platform.isWindows) defaultPrinterType = PrinterType.usb;
    super.initState();
    _portController.text = _port;
    _scan();

    // subscription to listen change status of bluetooth connection
    _subscriptionBtStatus =
        PrinterManager.instance.stateBluetooth.listen((status) {
      log(' ----------------- status bt $status ------------------ ');
      _currentStatus = status;
      if (status == BTStatus.connected) {
        setState(() {
          _isConnected = true;
        });
      }
      if (status == BTStatus.none) {
        setState(() {
          _isConnected = false;
        });
      }
      if (status == BTStatus.connected && pendingTask != null) {
        if (Platform.isAndroid) {
          Future.delayed(const Duration(milliseconds: 1000), () {
            PrinterManager.instance
                .send(type: PrinterType.bluetooth, bytes: pendingTask!);
            pendingTask = null;
          });
        } else if (Platform.isIOS) {
          PrinterManager.instance
              .send(type: PrinterType.bluetooth, bytes: pendingTask!);
          pendingTask = null;
        }
      }
    });
    //  PrinterManager.instance.stateUSB is only supports on Android
    _subscriptionUsbStatus = PrinterManager.instance.stateUSB.listen((status) {
      log(' ----------------- status usb $status ------------------ ');
      _currentUsbStatus = status;
      if (Platform.isAndroid) {
        if (status == USBStatus.connected && pendingTask != null) {
          Future.delayed(const Duration(milliseconds: 1000), () {
            PrinterManager.instance
                .send(type: PrinterType.usb, bytes: pendingTask!);
            pendingTask = null;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _subscriptionBtStatus?.cancel();
    _subscriptionUsbStatus?.cancel();
    _portController.dispose();
    _ipController.dispose();
    super.dispose();
  }

  // method to scan devices according PrinterType
  void _scan() {
    devices.clear();
    _subscription = printerManager
        .discovery(type: defaultPrinterType, isBle: _isBle)
        .listen((device) {
      devices.add(BluetoothPrinter(
        deviceName: device.name,
        address: device.address,
        isBle: _isBle,
        vendorId: device.vendorId,
        productId: device.productId,
        typePrinter: defaultPrinterType,
      ));
      setState(() {});
    });
  }

  void setPort(String value) {
    if (value.isEmpty) value = '9100';
    _port = value;
    var device = BluetoothPrinter(
      deviceName: value,
      address: _ipAddress,
      port: _port,
      typePrinter: PrinterType.network,
      state: false,
    );
    selectDevice(device);
  }

  void setIpAddress(String value) {
    _ipAddress = value;
    var device = BluetoothPrinter(
      deviceName: value,
      address: _ipAddress,
      port: _port,
      typePrinter: PrinterType.network,
      state: false,
    );
    selectDevice(device);
  }

  void selectDevice(BluetoothPrinter device) async {
    if (selectedPrinter != null) {
      if ((device.address != selectedPrinter!.address) ||
          (device.typePrinter == PrinterType.usb &&
              selectedPrinter!.vendorId != device.vendorId)) {
        await PrinterManager.instance
            .disconnect(type: selectedPrinter!.typePrinter);
      }
    }

    selectedPrinter = device;
    setState(() {});
  }

  Future _printReceiveTest() async {
    List<int> bytes = [];

    // Xprinter XP-N160I
    final profile = await CapabilityProfile.load(name: 'XP-N160I');
    // PaperSize.mm80 or PaperSize.mm58
    final generator = Generator(PaperSize.mm80, profile);
    bytes += generator.setGlobalCodeTable('CP1252');
    bytes += generator.text('Test Print',
        styles: const PosStyles(align: PosAlign.center));
    bytes += generator.text('Product 1');
    bytes += generator.text('Product 2');

    _printEscPos(bytes, generator);
  }

  /// print ticket
  void _printEscPos(List<int> bytes, Generator generator) async {
    if (selectedPrinter == null) return;
    var bluetoothPrinter = selectedPrinter!;

    switch (bluetoothPrinter.typePrinter) {
      case PrinterType.usb:
        bytes += generator.feed(2);
        bytes += generator.cut();
        await printerManager.connect(
            type: bluetoothPrinter.typePrinter,
            model: UsbPrinterInput(
                name: bluetoothPrinter.deviceName,
                productId: bluetoothPrinter.productId,
                vendorId: bluetoothPrinter.vendorId));
        pendingTask = null;
        break;
      case PrinterType.bluetooth:
        bytes += generator.cut();
        await printerManager.connect(
            type: bluetoothPrinter.typePrinter,
            model: BluetoothPrinterInput(
                name: bluetoothPrinter.deviceName,
                address: bluetoothPrinter.address!,
                isBle: bluetoothPrinter.isBle ?? false,
                autoConnect: _reconnect));
        pendingTask = null;
        if (Platform.isAndroid) pendingTask = bytes;
        break;
      case PrinterType.network:
        bytes += generator.feed(2);
        bytes += generator.cut();
        await printerManager.connect(
            type: bluetoothPrinter.typePrinter,
            model: TcpPrinterInput(ipAddress: bluetoothPrinter.address!));
        break;
      default:
    }
    if (bluetoothPrinter.typePrinter == PrinterType.bluetooth &&
        Platform.isAndroid) {
      if (_currentStatus == BTStatus.connected) {
        printerManager.send(type: bluetoothPrinter.typePrinter, bytes: bytes);
        pendingTask = null;
      }
    } else {
      printerManager.send(type: bluetoothPrinter.typePrinter, bytes: bytes);
    }
  }

  // conectar dispositivo
  _connectDevice() async {
    _isConnected = false;
    if (selectedPrinter == null) return;
    switch (selectedPrinter!.typePrinter) {
      case PrinterType.usb:
        await printerManager.connect(
            type: selectedPrinter!.typePrinter,
            model: UsbPrinterInput(
                name: selectedPrinter!.deviceName,
                productId: selectedPrinter!.productId,
                vendorId: selectedPrinter!.vendorId));
        _isConnected = true;
        break;
      case PrinterType.bluetooth:
        await printerManager.connect(
            type: selectedPrinter!.typePrinter,
            model: BluetoothPrinterInput(
                name: selectedPrinter!.deviceName,
                address: selectedPrinter!.address!,
                isBle: selectedPrinter!.isBle ?? false,
                autoConnect: _reconnect));
        break;
      case PrinterType.network:
        await printerManager.connect(
            type: selectedPrinter!.typePrinter,
            model: TcpPrinterInput(ipAddress: selectedPrinter!.address!));
        _isConnected = true;
        break;
      default:
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Pos Plugin Platform example app'),
        ),
        body: Center(
          child: Container(
            height: double.infinity,
            constraints: const BoxConstraints(maxWidth: 400),
            child: SingleChildScrollView(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: selectedPrinter == null || _isConnected
                                ? null
                                : () {
                                    _connectDevice();
                                  },
                            child: const Text("Connect",
                                textAlign: TextAlign.center),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: selectedPrinter == null || !_isConnected
                                ? null
                                : () {
                                    if (selectedPrinter != null)
                                      printerManager.disconnect(
                                          type: selectedPrinter!.typePrinter);
                                    setState(() {
                                      _isConnected = false;
                                    });
                                  },
                            child: const Text("Disconnect",
                                textAlign: TextAlign.center),
                          ),
                        ),
                      ],
                    ),
                  ),
                  DropdownButtonFormField<PrinterType>(
                    value: defaultPrinterType,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.print,
                        size: 24,
                      ),
                      labelText: "Type Printer Device",
                      labelStyle: TextStyle(fontSize: 18.0),
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                    items: <DropdownMenuItem<PrinterType>>[
                      if (Platform.isAndroid || Platform.isIOS)
                        const DropdownMenuItem(
                          value: PrinterType.bluetooth,
                          child: Text("bluetooth"),
                        ),
                      if (Platform.isAndroid || Platform.isWindows)
                        const DropdownMenuItem(
                          value: PrinterType.usb,
                          child: Text("usb"),
                        ),
                      const DropdownMenuItem(
                        value: PrinterType.network,
                        child: Text("Wifi"),
                      ),
                    ],
                    onChanged: (PrinterType? value) {
                      setState(() {
                        if (value != null) {
                          setState(() {
                            defaultPrinterType = value;
                            selectedPrinter = null;
                            _isBle = false;
                            _isConnected = false;
                            _scan();
                          });
                        }
                      });
                    },
                  ),
                  Visibility(
                    visible: defaultPrinterType == PrinterType.bluetooth &&
                        Platform.isAndroid,
                    child: SwitchListTile.adaptive(
                      contentPadding:
                          const EdgeInsets.only(bottom: 20.0, left: 20),
                      title: const Text(
                        "This device supports ble (low energy)",
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 19.0),
                      ),
                      value: _isBle,
                      onChanged: (bool? value) {
                        setState(() {
                          _isBle = value ?? false;
                          _isConnected = false;
                          selectedPrinter = null;
                          _scan();
                        });
                      },
                    ),
                  ),
                  Visibility(
                    visible: defaultPrinterType == PrinterType.bluetooth &&
                        Platform.isAndroid,
                    child: SwitchListTile.adaptive(
                      contentPadding:
                          const EdgeInsets.only(bottom: 20.0, left: 20),
                      title: const Text(
                        "reconnect",
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 19.0),
                      ),
                      value: _reconnect,
                      onChanged: (bool? value) {
                        setState(() {
                          _reconnect = value ?? false;
                        });
                      },
                    ),
                  ),
                  Column(
                      children: devices
                          .map(
                            (device) => ListTile(
                              title: Text('${device.deviceName}'),
                              subtitle: Platform.isAndroid &&
                                      defaultPrinterType == PrinterType.usb
                                  ? null
                                  : Visibility(
                                      visible: !Platform.isWindows,
                                      child: Text("${device.address}")),
                              onTap: () {
                                // do something
                                selectDevice(device);
                              },
                              leading: selectedPrinter != null &&
                                      ((device.typePrinter == PrinterType.usb &&
                                                  Platform.isWindows
                                              ? device.deviceName ==
                                                  selectedPrinter!.deviceName
                                              : device.vendorId != null &&
                                                  selectedPrinter!.vendorId ==
                                                      device.vendorId) ||
                                          (device.address != null &&
                                              selectedPrinter!.address ==
                                                  device.address))
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    )
                                  : null,
                              trailing: OutlinedButton(
                                onPressed: selectedPrinter == null ||
                                        device.deviceName !=
                                            selectedPrinter?.deviceName
                                    ? null
                                    : () async {
                                        _printReceiveTest();
                                      },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 20),
                                  child: Text("Print test ticket",
                                      textAlign: TextAlign.center),
                                ),
                              ),
                            ),
                          )
                          .toList()),
                  Visibility(
                    visible: defaultPrinterType == PrinterType.network &&
                        Platform.isWindows,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: TextFormField(
                        controller: _ipController,
                        keyboardType:
                            const TextInputType.numberWithOptions(signed: true),
                        decoration: const InputDecoration(
                          label: Text("Ip Address"),
                          prefixIcon: Icon(Icons.wifi, size: 24),
                        ),
                        onChanged: setIpAddress,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: defaultPrinterType == PrinterType.network &&
                        Platform.isWindows,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: TextFormField(
                        controller: _portController,
                        keyboardType:
                            const TextInputType.numberWithOptions(signed: true),
                        decoration: const InputDecoration(
                          label: Text("Port"),
                          prefixIcon: Icon(Icons.numbers_outlined, size: 24),
                        ),
                        onChanged: setPort,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: defaultPrinterType == PrinterType.network &&
                        Platform.isWindows,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: OutlinedButton(
                        onPressed: () async {
                          if (_ipController.text.isNotEmpty)
                            setIpAddress(_ipController.text);
                          _printReceiveTest();
                        },
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 50),
                          child: Text("Print test ticket",
                              textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BluetoothPrinter {
  int? id;
  String? deviceName;
  String? address;
  String? port;
  String? vendorId;
  String? productId;
  bool? isBle;

  PrinterType typePrinter;
  bool? state;

  BluetoothPrinter(
      {this.deviceName,
      this.address,
      this.port,
      this.state,
      this.vendorId,
      this.productId,
      this.typePrinter = PrinterType.bluetooth,
      this.isBle = false});
}
