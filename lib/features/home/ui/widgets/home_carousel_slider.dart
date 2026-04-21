import 'package:carousel_slider/carousel_slider.dart';
import 'package:crafty_bay/features/home/data/model/slider_model.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';

class HomeCarouselSlider extends StatefulWidget {
  const HomeCarouselSlider({super.key, required this.sliders});

  final List<SliderModel> sliders;

  @override
  State<HomeCarouselSlider> createState() => _HomeCarouselSliderState();
}

class _HomeCarouselSliderState extends State<HomeCarouselSlider> {
  ValueNotifier<int> _sliderNotifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 180.0,
            viewportFraction: 1,
            onPageChanged: (int currentIndex, _) {
              _sliderNotifier.value = currentIndex;
            },
          ),
          items: widget.sliders.map((slider) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 3.0),
                  decoration: BoxDecoration(
                    color: AppColors.themeColor,
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(slider.photoUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                  alignment: Alignment.center,

                  child: Center(
                    child: Text(
                      slider.description,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 8),
        ValueListenableBuilder(
          valueListenable: _sliderNotifier,
          builder: (context, index, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < widget.sliders.length; i++)
                  Container(
                    height: 13,
                    width: 13,
                    margin: EdgeInsets.only(left: 3),
                    decoration: BoxDecoration(
                      color: index == i ? AppColors.themeColor : null,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade400, width: 1),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
