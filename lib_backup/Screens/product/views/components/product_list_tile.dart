import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductListTile extends StatelessWidget {
  const ProductListTile({
    super.key,
    required this.svgSrc,
    required this.title,
    this.isShowBottomBorder = false,
    required this.press,
    this.asSliver = true,
  });

  final String svgSrc, title;
  final bool isShowBottomBorder;
  final VoidCallback press;
  final bool asSliver;

  @override
  Widget build(BuildContext context) {
    final tile = Column(
      children: [
        const Divider(height: 1),
        ListTile(
          onTap: press,
          minLeadingWidth: 24,
          leading: SvgPicture.asset(
            svgSrc,
            height: 24,
            color: Theme.of(context).textTheme.bodyLarge!.color,
          ),
          title: Text(title),
          trailing: SvgPicture.asset(
            "assets/icons/miniRight.svg",
            color: Theme.of(context).textTheme.bodyMedium!.color,
          ),
        ),
        if (isShowBottomBorder) const Divider(height: 1),
      ],
    );

    if (!asSliver) {
      return tile;
    }
    return SliverToBoxAdapter(child: tile);
  }
}
