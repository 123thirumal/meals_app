import 'package:flutter/material.dart';

class MetaDataWidget extends StatelessWidget {
  const MetaDataWidget(
      {super.key, required this.specificIcon, required this.specificText,required this.reqFontsize});

  final IconData specificIcon;
  final String specificText;
  final double reqFontsize;

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Icon(specificIcon),
          const SizedBox(
            width: 5,
          ),
          Text(
            specificText,
            style: TextStyle(
              fontSize: reqFontsize,
            ),
          ),
        ],
      ),
    );
  }
}
