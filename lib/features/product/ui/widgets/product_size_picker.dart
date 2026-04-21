import 'package:crafty_bay/app/app_colors.dart';
import 'package:flutter/material.dart';

class ProductSizePicker extends StatefulWidget {
  const ProductSizePicker({
    super.key,
    required this.Size,
    required this.onSelected,
  });

  final List<String> Size;
  final Function(String) onSelected;

  @override
  State<ProductSizePicker> createState() => _ProductSizePickerState();
}

class _ProductSizePickerState extends State<ProductSizePicker> {
  String? _selectedSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (String size in widget.Size)
          GestureDetector(
            onTap: () {
              _selectedSize = size;
              setState(() {});
              widget.onSelected(_selectedSize!);
            },
            child: Container(
              padding: EdgeInsets.all(6),
              margin: EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: _selectedSize == size ? AppColors.themeColor : null,
                border: Border.all(
                  color: _selectedSize == size
                      ? AppColors.themeColor
                      : Colors.black54,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                size,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: _selectedSize == size ? Colors.white : null,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
