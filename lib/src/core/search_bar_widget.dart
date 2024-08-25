import 'package:flutter/material.dart';

import 'app_colors.dart';

class SearchBarWidget extends StatelessWidget {
  final String? hint;
  final Color hintColor;
  final TextEditingController? controller;
  final VoidCallback onClick;
  final bool isChangingHint;
  final String? hintType;
  final IconData? iconData;
  final ValueChanged<String>? onChanged;

  final Widget? leadingIcon;
  final Widget? trailingIcon;

  SearchBarWidget({
    Key? key,
    this.hint,
    this.controller,
    required this.hintColor,
    required this.onClick,
    required this.onChanged,
    this.isChangingHint = false,
    this.hintType,
    this.iconData,
    this.leadingIcon,
    this.trailingIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final hintStyle = textTheme.bodyLarge?.copyWith(
      color: hintColor,
      fontSize: 17,
    );
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        border: Border.fromBorderSide(
          BorderSide(color: colorMidGray.withOpacity(0.8), width: 1),
        ),
      ),
      margin: const EdgeInsets.only(top: 15, bottom: 10),
      child: Row(
        children: [
          if (leadingIcon != null) leadingIcon!,
          Expanded(
            child: controller == null
                ? GestureDetector(
                    onTap: onClick,
                    child: Text(
                      hint!,
                      style: hintStyle,
                    ),
                  )
                : TextField(
                    controller: controller,
                    onChanged: onChanged,
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: hintStyle,
                      border: InputBorder.none,
                    ),
                    style: textTheme.bodyLarge?.copyWith(
                      color: colorBlack,
                      fontSize: 17,
                    ),
                    onTap: onClick,
                  ),
          ),
          Container(
            width: 1,
            height: 30,
            padding: const EdgeInsets.symmetric(vertical: 2),
            color: colorMidGray,
          ),
          if (trailingIcon != null) trailingIcon!,
        ],
      ),
    );
  }
}
