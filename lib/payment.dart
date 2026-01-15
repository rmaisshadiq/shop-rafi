import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebviewPage extends StatefulWidget {
  final String url;
  const PaymentWebviewPage({super.key, required this.url});

  @override
  State<PaymentWebviewPage> createState() => _PaymentWebviewPageState();
}

class _PaymentWebviewPageState extends State<PaymentWebviewPage> {
  late final WebViewController controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            setState(() => _isLoading = false);

            if (url.contains('status_code=200') ||
                url.contains('transaction_status=settlement')) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("Pembayaran Berhasil!")));
              Navigator.pop(context);
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bayar Sekarang")),
      body: Stack(
        children: [
          WebViewWidget(controller: controller),
          if (_isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
