import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tezda/core/extensions/context_extensions.dart';
import 'package:tezda/core/extensions/widget_extensions.dart';
import 'package:tezda/core/widgets/custom_button.dart';

class SuccessfulWidget extends StatefulWidget {
  const SuccessfulWidget({
    super.key,
    required this.onTap,
    required this.text,
  });
  final VoidCallback onTap;
  final String text;
  @override
  State<SuccessfulWidget> createState() => _SuccessfulWidgetState();
}

class _SuccessfulWidgetState extends State<SuccessfulWidget> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      child: Container(
        height: context.screenHeight,
        width: context.screenWidth * 1.2,
        color: Colors.black.withOpacity(.7),
        child: Container(
          padding: EdgeInsets.all(8),
          height: context.screenHeight * .28,
          width: context.screenWidth * .8,
          decoration: BoxDecoration(
            color: context.colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Assets.application.assets.svgs.vector.svg(),
              AutoSizeText(
                widget.text,
                textAlign: TextAlign.center,
                style: context.textTheme.displayMedium,
              ),
              CustomButton(label: "Continue", onPressed: widget.onTap)
            ],
          ),
        ).toCenter(),
      ),
    );
  }
}
