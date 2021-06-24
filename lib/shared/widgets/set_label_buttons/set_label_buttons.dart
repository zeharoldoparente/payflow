import 'package:flutter/material.dart';
import 'package:playflow/shared/themes/app_colors.dart';
import 'package:playflow/shared/themes/app_text_styles.dart';

import 'package:playflow/shared/widgets/divider_vertical/divider_vertical_widget.dart';
import 'package:playflow/shared/widgets/label_button/label_button.dart';

class SetLabelButtons extends StatelessWidget {
  final String label;
  final VoidCallback onPressedLabel;
  final String label2;
  final VoidCallback onPressedLabel2;
  final bool enablePrimaryColor;
  const SetLabelButtons({
    Key? key,
    required this.label,
    required this.onPressedLabel,
    required this.label2,
    required this.onPressedLabel2,
    this.enablePrimaryColor = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.shape,
      height: 56,
      child: Row(
        children: [
          Expanded(
              child: LabelButton(
            label: label,
            onPressed: onPressedLabel,
            style: enablePrimaryColor ? TextStyles.buttonPrimary : null,
          )),
          DividerVerticalWidget(),
          Expanded(
              child: LabelButton(label: label2, onPressed: onPressedLabel2)),
        ],
      ),
    );
  }
}
