import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

Future<dynamic> customModalBottomSheet(
  BuildContext context, {
  bool isDismissible = true,
  double? height,
  required Widget child,
}) {
  return showModalBottomSheet(
    context: context,
    clipBehavior: Clip.hardEdge,
    isScrollControlled: true,
    isDismissible: isDismissible,
    enableDrag: isDismissible,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(defaultBorderRadious * 2),
        topRight: Radius.circular(defaultBorderRadious * 2),
      ),
    ),
    builder: (context) {
      Widget sheet = SizedBox(
        height: height ?? MediaQuery.of(context).size.height * 0.75,
        child: child,
      );
      // Nested Scaffolds share MaterialApp's messenger, so a snackbar
      // would paint on every sheet underneath. Scope it to this sheet.
      if (kIsWeb) {
        sheet = ScaffoldMessenger(child: sheet);
      }
      return sheet;
    },
  );
}
