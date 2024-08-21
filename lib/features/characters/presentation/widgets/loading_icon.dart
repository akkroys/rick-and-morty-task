import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomLoadingIcon extends StatefulWidget {
  final String assetPath;

  const CustomLoadingIcon({super.key, required this.assetPath});

  @override
  _CustomLoadingIconState createState() => _CustomLoadingIconState();
}

class _CustomLoadingIconState extends State<CustomLoadingIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor = theme.colorScheme.secondary;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2.0 * 3.141592653589793,
          child: child,
        );
      },
      child: SvgPicture.asset(
        widget.assetPath,
        width: 30,
        height: 30,
        colorFilter: ColorFilter.mode(
          iconColor,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
