import 'package:crafty_bay/app/app_colors.dart';
import 'package:flutter/material.dart';

class ProductColorPicker extends StatefulWidget {
  const ProductColorPicker({
    super.key,
    required this.color,
    required this.onSelected,
  });

  final List<String> color;
  final Function(String) onSelected;

  @override
  State<ProductColorPicker> createState() => _ProductColorPickerState();
}

class _ProductColorPickerState extends State<ProductColorPicker> {
  String? _selectedColor;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (String color in widget.color)
            GestureDetector(
              onTap: () {
                _selectedColor = color;
                setState(() {});
                widget.onSelected(_selectedColor!);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Container(
                  padding: EdgeInsets.all(4),
                  margin: EdgeInsets.only(right: 4),
                  decoration: BoxDecoration(
                    color: _selectedColor == color ? AppColors.themeColor : null,
                    border: Border.all(
                      color: _selectedColor == color
                          ? AppColors.themeColor
                          : Colors.black54,
                    ),

                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    color,
                    style: TextStyle(
                      fontSize: 18,
                      color: _selectedColor == color ? Colors.white : null,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
