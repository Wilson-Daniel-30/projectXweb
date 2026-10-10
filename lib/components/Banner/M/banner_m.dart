import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../network_image_with_loader.dart';

bool isWideWebBanner(BuildContext context) =>
    kIsWeb && MediaQuery.sizeOf(context).width >= kWebWideBreakpoint;

class BannerM extends StatelessWidget {
  const BannerM(
      {super.key,
      required this.image,
      required this.press,
      required this.children});

  final String image;
  final VoidCallback press;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.87,
      child: GestureDetector(
        onTap: press,
        child: Stack(
          fit: StackFit.expand,
          children: [
            NetworkImageWithLoader(image, radius: 0),
            const ColoredBox(color: Colors.black45),
            ...children,
          ],
        ),
      ),
    );
  }
}
