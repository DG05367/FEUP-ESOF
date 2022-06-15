import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  final Function onChange;
  final bool isChecked;
  final double size;
  final double iconSize;
  final Color selectedColor;
  final Color notSelectedColor;
  final Color selectedIconColor;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final EdgeInsets padding;

  const CustomCheckbox({
    Key? key,
    this.isChecked = false,
    required this.onChange,
    this.size = 18,
    this.iconSize = 14,
    this.selectedColor = Colors.blue,
    this.notSelectedColor = Colors.transparent,
    this.selectedIconColor = Colors.white,
    this.borderRadius = 3.0,
    this.borderColor = Colors.black,
    this.borderWidth = 1.5,
    this.padding = const EdgeInsets.all(4),
  }) : super(key: key);

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool _isSelected = false;

  @override
  void initState() {
    _isSelected = widget.isChecked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
          widget.onChange(_isSelected);
        });
      },
      child: AnimatedContainer(
        margin: widget.padding,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn,
        decoration: BoxDecoration(
            color: _isSelected ? widget.selectedColor : widget.notSelectedColor,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(
              color: widget.borderColor,
              width: widget.borderWidth,
            )),
        width: widget.size,
        height: widget.size,
        child: _isSelected
            ? Icon(
                Icons.check,
                color: widget.selectedIconColor,
                size: widget.iconSize,
              )
            : null,
      ),
    );
  }
}
