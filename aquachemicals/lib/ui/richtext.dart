import 'package:flutter/material.dart';
import 'package:aquachemicals/ui/color/appColor.dart';

class CommonRichText extends StatelessWidget {
  final String label;
  final dynamic value;

  const CommonRichText({Key? key, required this.label, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        text: '$label',
        style: TextStyle(color: AppColors.blues, fontWeight: FontWeight.w500, fontSize: 14),
        children: [
          TextSpan(
            text: value.toString(), // Convert value to string
            style: TextStyle(color: Colors.black87,fontWeight: FontWeight.normal,fontSize: 13),
          ),
        ],
      ),
    );
  }
}