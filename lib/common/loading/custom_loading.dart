
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

extension FutureExtension<T> on Future<T> {
  Future<T> wrapLoading(String? message) {
    final context = CustomLoadingContext().context!;

    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) =>
          CustomLoading(message: message),
    );

    overlay.insert(overlayEntry);

    return whenComplete(() => overlayEntry.remove());
  }
}

class CustomLoadingContext {
  static final CustomLoadingContext _instance = CustomLoadingContext._internal();

  factory CustomLoadingContext() {
    return _instance;
  }

  CustomLoadingContext._internal();

  BuildContext? _context;

  void setContext(BuildContext context) {
    _context = context;
  }

  BuildContext? get context => _context;
}

class CustomLoading extends StatelessWidget {
  final String? message;

  const CustomLoading({
    super.key,
    this.message
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SpinKitFadingCircle(
              color: Colors.white,
              size: 40.0,
              duration: Duration(seconds: 2),
            ),
            if (message != null) ...[
              const SizedBox(height: 15),
              Text(
                message!,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ],
        ),
      ),
    );
  }
}