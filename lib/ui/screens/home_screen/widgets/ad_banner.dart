import 'package:amazon_clone/constants/constants.dart';
import 'package:amazon_clone/services/services.dart';
import 'package:flutter/material.dart';

class AdBanner extends StatefulWidget {
  const AdBanner({Key? key}) : super(key: key);

  @override
  State<AdBanner> createState() => _AdBannerState();
}

class _AdBannerState extends State<AdBanner> {
  double height = 100;
  int currentAd = 0;

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utilities().screenSize;

    return GestureDetector(
      onHorizontalDragEnd: (_) {
        setState(() {
          currentAd = (currentAd + 1) % 5;
        });
      },
      child: Column(
        children: [
          // Large Ad Banner
          Stack(
            children: [
              Image.network(
                kLargeAds[currentAd],
                width: double.infinity,
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: screenSize.width,
                  height: height,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        kBackgroundColor,
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Small Ad Banner
          Container(
            color: kBackgroundColor,
            width: screenSize.width,
            height: height,
            child: ListView.builder(
              itemCount: kSmallAds.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return SmallAdBanner(
                  index: index,
                  height: height,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SmallAdBanner extends StatelessWidget {
  final int index;
  final double height;
  const SmallAdBanner({
    Key? key,
    required this.index,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: height,
        width: height,
        decoration: ShapeDecoration(
          color: Colors.white,
          shadows: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(kSmallAds[index]),
              const SizedBox(height: 5),
              Text(kAdItemNames[index]),
            ],
          ),
        ),
      ),
    );
  }
}
