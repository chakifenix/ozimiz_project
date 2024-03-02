// import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
// import 'package:flutter/material.dart';
// // import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
// // import 'package:vector_math/vector_math_64.dart' as vector;
// // import 'package:flutter/services.dart';

// // class ARCorePage extends StatefulWidget {
// //   @override
// //   _ARCorePageState createState() => _ARCorePageState();
// // }

// // class _ARCorePageState extends State<ARCorePage> {
// //   ArCoreController? arCoreController;
// //   bool isModelLoaded = false;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('ARCore with Flutter'),
// //       ),
// //       body: ArCoreView(
// //         onArCoreViewCreated: _onArCoreViewCreated,
// //         enableTapRecognizer: true,
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: () {
// //           if (isModelLoaded) {
// //             arCoreController!.removeNode(nodeName: 'model');
// //           } else {
// //             _loadModel();
// //           }
// //         },
// //         child: isModelLoaded ? Icon(Icons.clear) : Icon(Icons.add),
// //       ),
// //     );
// //   }

// //   void _onArCoreViewCreated(ArCoreController controller) {
// //     arCoreController = controller;
// //     _loadModel();
// //   }

// //   void _loadModel() async {
// //     final ByteData data = await rootBundle.load('assets/model.obj');
// //     final List<int> bytes = data.buffer.asUint8List();

// //     ArCoreMaterial obj = ArCoreView(
// //       fileName: 'model.obj',
// //       object3DFileName: 'model.obj',
// //       position: Vector3(0, -1, -2),
// //       scale: Vector3(0.1, 0.1, 0.1),
// //       materials: [ArCoreMaterial(color: Colors.blue)],
// //     );

// //     arCoreController!.addArCoreNodeWithAnchor(obj);
// //     setState(() {
// //       isModelLoaded = true;
// //     });
// //   }

// //   @override
// //   void dispose() {
// //     arCoreController!.dispose();
// //     super.dispose();
// //   }
// // }

// class ARWidget extends StatefulWidget {
//   @override
//   _ARWidgetState createState() => _ARWidgetState();
// }

// class _ARWidgetState extends State<ARWidget> {
//   late ArCoreController arCoreController;
//   @override
//   void dispose() {
//     arCoreController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ArCoreView(
//       onArCoreViewCreated: _onARCoreViewCreated,
//     );
//   }

//   void _onARCoreViewCreated(ArCoreController controller) {
//     arCoreController = controller;
//     // Create an anchor at the origin (0, 0, 0)
//     // final anchor = Anchor(
//     //   pose: Pose.translation(
//     //     vector.Vector3(0, 0, 0),
//     //   ),
//     //   isTrackable: true,
//     // );
//     // Load a 3D model and attach it to the anchor
//     arCoreController.addArCoreNode(
//       ArCoreReferenceNode(
//           name: 'MyModel', object3DFileName: 'models/scene.gltf'),
//       // parentNodeName: anchor,
//     );
//   }
// }
