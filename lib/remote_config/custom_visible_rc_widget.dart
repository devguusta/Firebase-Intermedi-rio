import 'package:flutter/material.dart';
import 'package:trainning_firebase/remote_config/custom_remote_config.dart';

class CustomVisibleRCWidget extends StatefulWidget {
  final Widget child;
  final String rmKey;
  final dynamic defaultValue;
  const CustomVisibleRCWidget({
    Key? key,
    required this.child,
    required this.rmKey,
    required this.defaultValue,
  }) : super(key: key);

  @override
  State<CustomVisibleRCWidget> createState() => _CustomVisibleRCWidgetState();
}

class _CustomVisibleRCWidgetState extends State<CustomVisibleRCWidget> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      child: widget.child,
      visible: CustomRemoteConfig().getValueOrDefault(
        key: widget.rmKey,
        defaultValue: widget.defaultValue,
      ),
    );
  }
}
