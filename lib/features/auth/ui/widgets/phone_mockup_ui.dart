import 'package:fashion/app/app_colors.dart';
import 'package:flutter/material.dart';

class PhoneMockUi extends StatelessWidget {
  const PhoneMockUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 160.0),
            child: Column(
              children: [
                Container(
                  height: 20,
                  width: 4,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 50,
                  width: 4,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 50,
                  width: 4,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
            child: Stack(
              children: [
                Positioned(
                  top: 12,
                  left: 95,
                  child: Container(
                    height: 17,
                    width: 65,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Positioned(
                  top: 200,
                  left: 100,
                  child: Container(
                    child: Column(
                      children: [
                        Icon(
                          Icons.apple_outlined,
                          size: 70,
                          color: AppColors.themeColor,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 500,
                  width: 250,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 6),
                    borderRadius: BorderRadius.circular(35),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Container(
              height: 50,
              width: 4,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
