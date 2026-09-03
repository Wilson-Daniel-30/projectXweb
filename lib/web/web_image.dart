import 'package:flutter/material.dart';

import 'package:projectx/constants.dart';

String resolveWebImageUrl(String url) {
  if (url.isEmpty) return url;

  final driveId = RegExp(r'(?:[?&]id=|/d/)([a-zA-Z0-9_-]+)')
      .firstMatch(url)
      ?.group(1);
  if (url.contains('drive.google.com') && driveId != null) {
    return 'https://lh3.googleusercontent.com/d/$driveId=w1000';
  }
  return url;
}

String formatInr(num value) {
  if (value == value.roundToDouble()) {
    return value.toStringAsFixed(0);
  }
  return value.toStringAsFixed(2);
}

class WebFillNetworkImage extends StatelessWidget {
  const WebFillNetworkImage({
    super.key,
    required this.url,
    this.iconSize = 36,
    this.fit = BoxFit.fill,
  });

  final String url;
  final double iconSize;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;

        return ColoredBox(
          color: lightGreyColor,
          child: ClipRect(
            child: FittedBox(
              fit: fit,
              clipBehavior: Clip.hardEdge,
              child: Image.network(
                resolveWebImageUrl(url),
                filterQuality: FilterQuality.medium,
                gaplessPlayback: true,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return SizedBox(width: width, height: height);
                },
                errorBuilder: (context, error, stackTrace) {
                  return Image.network(
                    url,
                    errorBuilder: (context, error, stackTrace) {
                      return SizedBox(
                        width: width,
                        height: height,
                        child: Center(
                          child: Icon(
                            Icons.image_outlined,
                            color: greyColor,
                            size: iconSize,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
