// import 'package:flutter/material.dart';

// Rect? getWidgetBoundingBox(BuildContext context) {
//   // Find the RenderBox of the current context
//   RenderObject? renderObject = context.findRenderObject();
//   RenderBox? renderBox =
//       renderObject == null ? null : renderObject as RenderBox;

//   // Get the position and size of the RenderBox
//   Offset? offset = renderBox?.localToGlobal(Offset.zero);
//   Size? size = renderBox?.size;

//   // Create and return the bounding box
//   if ([offset, size].any((element) => element == null)) {
//     return null;
//   }

//   return Rect.fromPoints(offset!, offset!.translate(size!.width, size!.height));
// }
