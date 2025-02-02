
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class SportsView extends StatefulWidget {
  const SportsView({super.key});

  @override
  State<SportsView> createState() => _SportsViewState();
}

class _SportsViewState extends State<SportsView> {
  final InAppLocalhostServer _localhostServer = InAppLocalhostServer();
  late InAppWebViewController _controller;

  bool isLoading = true;
  bool isError = false;

  @override
  void initState() {
    super.initState();

    _localhostServer.start();
  }

  @override
  void dispose() {
    _localhostServer.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InAppWebView(
          // initialUrlRequest: URLRequest(url: WebUri('http://localhost:8080/assets/html/daum_postcode.html')),
          initialUrlRequest: URLRequest(url: WebUri('https://m.naver.com/')),
          onWebViewCreated: (controller) {
            _controller = controller;
            _controller.addJavaScriptHandler(
              handlerName: 'onSelectAddress',
              callback: (args) {
                // Map<String, dynamic> fromMap = args.first;
                // DaumPostModel data = _dataSetting(fromMap);
                // Navigator.of(context).pop(data);
              }
            );
          },
          onLoadStop: (controller, url) {
            setState(() {
              if (_localhostServer.isRunning()) {
                isLoading = false;
              } else {
                _localhostServer.start().then((value) {
                  _controller.reload();
                });
              }
            });
          },
          keepAlive: InAppWebViewKeepAlive(),
        ),
        if (isLoading) ...[
          const SizedBox(
            child: Center(child: CircularProgressIndicator()),
          ),
        ],
        if (isError) ...[
          Container(
            color: const Color.fromRGBO(71, 71, 71, 1),
            child: const Center(
              child: Text('페이지를 찾을 수 없습니다', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ),
          ),
        ],
      ],
    );
  }
}
