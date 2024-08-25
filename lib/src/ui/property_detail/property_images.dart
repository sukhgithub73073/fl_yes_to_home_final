import 'package:flutter/material.dart';
import 'package:yestohome/src/core/network_image_with_loader.dart';
import 'package:yestohome/src/data/models/property_model.dart';

class PropertyImages extends StatefulWidget {
  const PropertyImages({
    super.key,
    required this.images,
  });

  final List<ImagesList> images;

  @override
  State<PropertyImages> createState() => _PropertyImagesState();
}

class _PropertyImagesState extends State<PropertyImages> {
  late PageController _controller;

  int _currentPage = 0;

  @override
  void initState() {
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
    return SliverToBoxAdapter(
      child: AspectRatio(
        aspectRatio: 1,
        child: Stack(
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
                padding: const EdgeInsets.only(right: 16.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12.0 * 2),
                  ),
                  child: NetworkImageWithLoader(widget.images[index].image_url),
                ),
              ),
            ),
            if (widget.images.length > 1)
              Positioned(
                height: 20,
                bottom: 24,
                right: MediaQuery.of(context).size.width * 0.15,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0 * 0.75,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                  ),
                  child: Row(
                    children: List.generate(
                      widget.images.length,
                      (index) => Padding(
                        padding: EdgeInsets.only(
                            right: index == (widget.images.length - 1)
                                ? 0
                                : 16.0 / 4),
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
        ),
      ),
    );
  }
}
