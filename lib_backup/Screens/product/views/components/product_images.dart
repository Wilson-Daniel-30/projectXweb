import 'package:flutter/material.dart';
import '/components/network_image_with_loader.dart';

import '../../../../constants.dart';
import 'package:flutter/foundation.dart';


class ProductImages extends StatefulWidget {
  bool fullScreen;
  final bool asSliver;
  final double? aspectRatio;

   ProductImages({
    super.key,
    required this.images,
     this.fullScreen = false,
     this.asSliver = true,
     this.aspectRatio,
  });

  final List<String> images;

  @override
  State<ProductImages> createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  late PageController _controller;

  int _currentPage = 0;

  @override
  void initState() {
    print("widget.images");
    print(widget.images);
    _controller =
        PageController(viewportFraction: 0.9, initialPage: _currentPage);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ratio = widget.aspectRatio ??
        (kIsWeb ? 2.0 : widget.fullScreen ? 0.8 : 1);

    final content = AspectRatio(
      aspectRatio: ratio,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              PageView.builder(
                controller: _controller,
                onPageChanged: (pageNum) {
                  setState(() {
                    _currentPage = pageNum;
                  });
                },
                itemCount: widget.images.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(right: defaultPadding),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(defaultBorderRadious * 2),
                    ),
                    child: kIsWeb
                        ? NetworkImageWithLoader(
                            widget.images[index],
                            fit: BoxFit.cover,
                            radius: defaultBorderRadious * 2,
                          )
                        : NetworkImageWithLoader(widget.images[index]),
                  ),
                ),
              ),
              if (widget.images.length > 1)
                Positioned(
                  height: 20,
                  bottom: 24,
                  right: constraints.maxWidth * 0.15,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding * 0.75,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(50)),
                    ),
                    child: Row(
                      children: List.generate(
                        widget.images.length,
                        (index) => Padding(
                          padding: EdgeInsets.only(
                              right: index == (widget.images.length - 1)
                                  ? 0
                                  : defaultPadding / 4),
                          child: CircleAvatar(
                            radius: 3,
                            backgroundColor: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .color!
                                .withOpacity(index == _currentPage ? 1 : 0.2),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
            ],
          );
        },
      ),
    );

    if (widget.asSliver) {
      return SliverToBoxAdapter(child: content);
    }
    return content;
  }
}
