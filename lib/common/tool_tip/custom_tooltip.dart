import 'dart:async';

import 'package:flutter/material.dart';

class CustomTooltip extends StatefulWidget {
  final String message;
  final int duration;
  final double iconSize;
  final Color iconColor;

  const CustomTooltip({
    super.key,
    required this.message,
    this.duration = 0,
    this.iconSize = 14,
    this.iconColor = Colors.grey,
  });

  @override
  CustomTooltipState createState() => CustomTooltipState();
}

class CustomTooltipState extends State<CustomTooltip>
    with SingleTickerProviderStateMixin {
  OverlayEntry? _overlayEntry;
  Timer? _hideTimer;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // 애니메이션 컨트롤러 초기화
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300), // fade in/out 시간
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  void _showTooltip(BuildContext context) {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final targetPosition = renderBox.localToGlobal(Offset.zero);
    final targetSize = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Listener(
            behavior: HitTestBehavior.translucent,
            onPointerDown: (event) {
              _hideTooltip();
            },
            child: const SizedBox(
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Positioned(
            top: targetPosition.dy + targetSize.height + 5,
            left: targetPosition.dx,
            child: FadeTransition(
              opacity: _fadeAnimation, // fade 애니메이션 추가
              child: Material(
                color: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.9,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    widget.message,
                    style: const TextStyle(color: Colors.white),
                    softWrap: true,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    overlay.insert(_overlayEntry!);
    _animationController.forward(); // fade in 효과 시작

    if (widget.duration > 0) {
      _hideTimer?.cancel();
      _hideTimer = Timer(Duration(seconds: widget.duration), () {
        _hideTooltip();
      });
    }
  }

  void _hideTooltip() {
    _hideTimer?.cancel();
    _animationController.reverse(); // fade out 효과 시작
    Future.delayed(const Duration(milliseconds: 300), () {
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_overlayEntry == null) {
          _showTooltip(context);
        } else {
          _hideTooltip();
        }
      },
      child: Icon(
        Icons.info_outline,
        size: widget.iconSize,
        color: widget.iconColor,
      ),
    );
  }
}