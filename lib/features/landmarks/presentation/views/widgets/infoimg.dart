import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class infoimg extends StatelessWidget {
  const infoimg({
    super.key,
    this.imageslink,
  });

  final List<dynamic>? imageslink;

  @override
  Widget build(BuildContext context) {
      return SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * .38,
        child: CarouselSlider(
            items: imageslink!.map((image) {
              return Image.network(
                image,
                fit: BoxFit.fill,
                width: double.infinity,
              );
            }).toList(),
            options: CarouselOptions(
                height: MediaQuery.of(context).size.height,
                    autoPlay: true,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    viewportFraction: 1.05,
                    enlargeCenterPage: true,
                    enlargeFactor: .2,
                    enlargeStrategy:
                        CenterPageEnlargeStrategy.scale, // استخدم هذه الخاصية لعمل تأثير الزووم
                    pageSnapping: true,

                    autoPlayInterval: Duration(seconds: 5),
                    autoPlayCurve: Curves.easeInOutCubicEmphasized,
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 5000),
            )),
      );
    } 

}