import 'package:flutter/material.dart';

class TweenAnimatedWidget extends StatefulWidget {
  const TweenAnimatedWidget(
      {Key? key, required this.child, required this.begin, required this.end})
      : super(key: key);

  final Widget child;
  final double begin;
  final double end;

  @override
  _TweenAnimatedWidgetState createState() => _TweenAnimatedWidgetState();
}

class _TweenAnimatedWidgetState extends State<TweenAnimatedWidget> {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: widget.begin, end: widget.end),
      duration: const Duration(milliseconds: 500),
      builder: (context, value, child) {
        return widget.child;
      },
    );
  }
}
