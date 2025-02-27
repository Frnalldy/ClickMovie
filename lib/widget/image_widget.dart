import 'package:clickmovie_app/app_constants.dart';
import 'package:flutter/material.dart';

enum TypeSrcImg { movieDb, external }

class ImageNetworkWidget extends StatelessWidget {
  const ImageNetworkWidget({
    this.imageSrc,
    this.type = TypeSrcImg.movieDb,
    this.height,
    this.width,
    this.radius = 0.0,
    this.onTap,
    super.key,
  });

  final String? imageSrc;
  final TypeSrcImg type;
  final double? height;
  final double? width;
  final double radius;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: Image.network(
            type == TypeSrcImg.movieDb
                ? '${AppConstants.imageUrlW500}$imageSrc'
                : imageSrc!,
            height: height,
            width: width,
            fit: BoxFit.cover,
            loadingBuilder: (
              context,
              child,
              loadingProgress,
            ) {
              return Container(
                height: height,
                width: width,
                color: Colors.black26,
                child: child,
              );
            },
            errorBuilder: (_, __, ___) {
              return SizedBox(
                height: height,
                width: width,
                child: const Icon(
                  Icons.broken_image_rounded,
                ),
              );
            },
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
            ),
          ),
        ),
      ],
    );
  }
}
