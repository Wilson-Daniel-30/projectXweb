import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:projectx/components/skleton/skelton.dart';
import 'package:flutter/src/foundation/constants.dart';
import 'package:projectx/web/web_image.dart';
import '../constants.dart';

class NetworkImageWithLoader extends StatelessWidget {
  final BoxFit fit;

  const NetworkImageWithLoader(
    this.src, {
    super.key,
    this.fit = BoxFit.cover,
    this.radius = defaultPadding,
  });

  final String src;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: kIsWeb? SizedBox.expand(
        child: Image.network(
          resolveWebImageUrl(src),
          fit: fit,
          width: double.infinity,
          height: double.infinity,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Skeleton();
          },
          errorBuilder: (context, error, stackTrace) {
            return Image.network(
              src,
              fit: fit,
              width: double.infinity,
              height: double.infinity,
              errorBuilder: (context, error, stackTrace) {
                return const ColoredBox(
                  color: lightGreyColor,
                  child: Center(
                    child: Icon(Icons.image_outlined, color: greyColor),
                  ),
                );
              },
            );
          },
        ),
      ) : CachedNetworkImage(
        fit: fit,
        imageUrl: src,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: fit,
            ),
          ),
        ),
        placeholder: (context, url) => const Skeleton(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
