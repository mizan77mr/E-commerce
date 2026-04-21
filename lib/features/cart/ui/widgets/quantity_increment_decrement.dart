import 'package:crafty_bay/app/app_colors.dart';
import 'package:flutter/material.dart';

class QuantityIncrementDecrement extends StatefulWidget {
  const QuantityIncrementDecrement({super.key, required this.onChange, required this.initialValue});

  final Function(int) onChange;
  final int initialValue;

  @override
  State<QuantityIncrementDecrement> createState() =>
      _QuantityIncrementDecrementState();
}

class _QuantityIncrementDecrementState extends State<QuantityIncrementDecrement> {
  late int value;

@override
  void initState() {
   value=widget.initialValue;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        buildButtonIncrementDecrement(
          onTap: () {
            if (value <= 1) return;
            value--;
            setState(() {});
            widget.onChange(value);
          },
          icon: Icons.remove,
          color: value == 1
              ? AppColors.themeColor.withOpacity(0.4)
              : AppColors.themeColor,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text('${value}', style: TextStyle(fontSize: 18)),
        ),
        buildButtonIncrementDecrement(
          onTap: () {
            if (value >= 20) return;
            value++;
            setState(() {});
            widget.onChange(value);
          },
          icon: Icons.add,
          color: value == 20
              ? AppColors.themeColor.withOpacity(0.4)
              : AppColors.themeColor,
        ),
      ],
    );
  }

  Widget buildButtonIncrementDecrement({
    required VoidCallback onTap,
    required IconData icon,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}
