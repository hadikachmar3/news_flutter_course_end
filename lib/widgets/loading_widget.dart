import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:news_app_flutter_course/services/utils.dart';
import 'package:news_app_flutter_course/widgets/vertical_spacing.dart';
import 'package:shimmer/shimmer.dart';

import '../consts/vars.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({Key? key, required this.newsType}) : super(key: key);
  final NewsType newsType;
  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  BorderRadius borderRadius = BorderRadius.circular(18);
  late Color baseShimmerColor, highlightShimmerColor, widgetShimmerColor;

  @override
  void didChangeDependencies() {
    var utils = Utils(context);
    baseShimmerColor = utils.baseShimmerColor;
    highlightShimmerColor = utils.highlightShimmerColor;
    widgetShimmerColor = utils.widgetShimmerColor;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    return widget.newsType == NewsType.topTrending
        ? Swiper(
            autoplayDelay: 8000,
            autoplay: true,
            itemWidth: size.width * 0.9,
            layout: SwiperLayout.STACK,
            viewportFraction: 0.9,
            itemCount: 5,
            itemBuilder: (context, index) {
              return TopTrendingLoadingWidget(
                  baseShimmerColor: baseShimmerColor,
                  highlightShimmerColor: highlightShimmerColor,
                  size: size,
                  widgetShimmerColor: widgetShimmerColor,
                  borderRadius: borderRadius);
            },
          )
        : Expanded(
            child: ListView.builder(
                // you can add these 2 lines for better performance
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 20,
                itemBuilder: (ctx, index) {
                  return ArticlesShimmerEffectWidget(
                      baseShimmerColor: baseShimmerColor,
                      highlightShimmerColor: highlightShimmerColor,
                      widgetShimmerColor: widgetShimmerColor,
                      size: size,
                      borderRadius: borderRadius);
                }),
          );
  }
}

class TopTrendingLoadingWidget extends StatelessWidget {
  const TopTrendingLoadingWidget({
    Key? key,
    required this.baseShimmerColor,
    required this.highlightShimmerColor,
    required this.size,
    required this.widgetShimmerColor,
    required this.borderRadius,
  }) : super(key: key);

  final Color baseShimmerColor;
  final Color highlightShimmerColor;
  final Size size;
  final Color widgetShimmerColor;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        // height: size.height * 0.45,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Shimmer.fromColors(
          baseColor: baseShimmerColor,
          highlightColor: highlightShimmerColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  height: size.height * 0.33,
                  width: double.infinity,
                  color: widgetShimmerColor,
                ),
              ),
              // Title
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    height: size.height * 0.06,
                    decoration: BoxDecoration(
                      borderRadius: borderRadius,
                      color: widgetShimmerColor,
                    ),
                  )),
              // Date
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    height: size.height * 0.025,
                    width: size.width * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: borderRadius,
                      color: widgetShimmerColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ArticlesShimmerEffectWidget extends StatelessWidget {
  const ArticlesShimmerEffectWidget({
    Key? key,
    required this.baseShimmerColor,
    required this.highlightShimmerColor,
    required this.widgetShimmerColor,
    required this.size,
    required this.borderRadius,
  }) : super(key: key);

  final Color baseShimmerColor;
  final Color highlightShimmerColor;
  final Color widgetShimmerColor;
  final Size size;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor,
        child: Stack(
          children: [
            Container(
              height: 60,
              width: 60,
              color: Theme.of(context).colorScheme.secondary,
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                height: 60,
                width: 60,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            Container(
              color: Theme.of(context).cardColor,
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(10.0),
              child: Shimmer.fromColors(
                baseColor: baseShimmerColor,
                highlightColor: highlightShimmerColor,
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        color: widgetShimmerColor,
                        height: size.height * 0.12,
                        width: size.height * 0.12,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: size.height * 0.06,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: borderRadius,
                              color: widgetShimmerColor,
                            ),
                          ),
                          const VerticalSpacing(5),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              height: size.height * 0.025,
                              width: size.width * 0.4,
                              decoration: BoxDecoration(
                                borderRadius: borderRadius,
                                color: widgetShimmerColor,
                              ),
                            ),
                          ),
                          FittedBox(
                            child: Row(
                              children: [
                                ClipOval(
                                  child: Container(
                                    height: 25,
                                    width: 25,
                                    color: widgetShimmerColor,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  height: size.height * 0.025,
                                  width: size.width * 0.4,
                                  decoration: BoxDecoration(
                                    borderRadius: borderRadius,
                                    color: widgetShimmerColor,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
