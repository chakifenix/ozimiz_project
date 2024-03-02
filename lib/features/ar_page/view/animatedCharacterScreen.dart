import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class AnimatedCharacterScreen extends StatefulWidget {
  const AnimatedCharacterScreen(
      {super.key, required this.arModel, required this.size});
  final String arModel;
  final double size;

  @override
  State<AnimatedCharacterScreen> createState() =>
      _AnimatedCharacterScreenState();
}

class _AnimatedCharacterScreenState extends State<AnimatedCharacterScreen> {
  ARKitController? _arKitController;
  ARKitReferenceNode? _arKitReferenceNode;
  String? anchorId;
  bool idle = true;

  @override
  void dispose() {
    super.dispose();
    _arKitController?.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          child: ARKitSceneView(
            showFeaturePoints: true,
            planeDetection: ARPlaneDetection.horizontal,
            onARKitViewCreated: createARKitView,
          ),
        ),
      );

  void createARKitView(ARKitController arKitController) {
    this._arKitController = arKitController;
    this._arKitController!.onAddNodeForAnchor = handleAddAnchor;
  }

  void handleAddAnchor(ARKitAnchor anchor) {
    if (!(anchor is ARKitPlaneAnchor)) {
      return;
    }

    addPlane(_arKitController!, anchor);
  }

  void addPlane(ARKitController controller, ARKitPlaneAnchor planeAnchor) {
    anchorId = planeAnchor.identifier;
    if (_arKitReferenceNode != null) {
      controller.remove(_arKitReferenceNode!.name);
    }
    _arKitReferenceNode = ARKitReferenceNode(
        url: widget.arModel,
        position: vector.Vector3(0, 0, 0),
        scale: vector.Vector3(widget.size, widget.size, widget.size));

    controller.add(_arKitReferenceNode!, parentNodeName: planeAnchor.nodeName);
  }
}
