import 'package:flutter/material.dart';
import 'package:gigglio/model/utils/string.dart';
import 'package:gigglio/view/widgets/base_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      appBar: AppBar(
        title: const Text(StringRes.settings),
        centerTitle: true,
      ),
      child: const Column(),
    );
  }
}