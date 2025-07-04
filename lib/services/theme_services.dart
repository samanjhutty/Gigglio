import 'package:flutter/material.dart';
import 'package:gigglio/services/box_services.dart';
import '../data/utils/color_resources.dart';

class _Themes extends InheritedWidget {
  final ThemeServiceState data;
  const _Themes({required super.child, required this.data});

  @override
  bool updateShouldNotify(covariant _Themes oldWidget) => true;
}

class ThemeServices extends StatefulWidget {
  final Widget child;
  const ThemeServices({super.key, required this.child});

  static ThemeServiceState? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_Themes>()?.data;
  }

  static ThemeServiceState of(BuildContext context) {
    assert(maybeOf(context) != null);
    return maybeOf(context)!;
  }

  @override
  State<ThemeServices> createState() => ThemeServiceState();
}

class ThemeServiceState extends State<ThemeServices> {
  final _box = BoxServices.instance;

  late String _text;
  late Color _primary;
  late Color _onPrimary;
  late Color _primaryContainer;
  late Color _onPrimaryContainer;
  late Brightness _brightness;
  late Color _background;
  late Color _backgroundDark;
  late Color _surface;
  late Color _textColor;
  late Color _textColorLight;
  late Color _disabled;

  String get text => _text;
  Color get primary => _primary;
  Color get onPrimary => _onPrimary;
  Color get primaryContainer => _primaryContainer;
  Color get onPrimaryContainer => _onPrimaryContainer;
  Brightness get brightness => _brightness;
  Color get background => _background;
  Color get backgroundDark => _backgroundDark;
  Color get surface => _surface;
  Color get textColor => _textColor;
  Color get textColorLight => _textColorLight;
  Color get disabled => _disabled;

  @override
  void initState() {
    final theme = _box.getTheme();
    _text = theme.title;
    _primary = theme.primary;
    _onPrimary = theme.onPrimary;
    _primaryContainer = theme.primaryContainer;
    _onPrimaryContainer = theme.onPrimaryContainer;
    _brightness = theme.brightness;
    _background = theme.background;
    _backgroundDark = theme.backgroundDark;
    _surface = theme.surface;
    _textColor = theme.textColor;
    _textColorLight = theme.textColorLight;
    _disabled = theme.disabled;

    super.initState();
  }

  void changeTheme(MyTheme? theme) {
    if (theme == null) return;

    _text = theme.title;
    _primary = theme.primary;
    _onPrimary = theme.onPrimary;
    _primaryContainer = theme.primaryContainer;
    _onPrimaryContainer = theme.onPrimaryContainer;
    _brightness = theme.brightness;
    _background = theme.background;
    _backgroundDark = theme.backgroundDark;
    _surface = theme.surface;
    _textColor = theme.textColor;
    _textColorLight = theme.textColorLight;
    _disabled = theme.disabled;
    setState(() {});
    _box.saveTheme(theme);
  }

  @override
  Widget build(BuildContext context) {
    return _Themes(data: this, child: widget.child);
  }
}
