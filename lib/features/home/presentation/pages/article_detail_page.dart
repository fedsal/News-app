import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:news_app/features/home/domain/entities/article.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleDetailPage extends StatelessWidget {
  final ArticleEntity article;

  const ArticleDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            leading: _navButton(Iconsax.arrow_left_24, Colors.black, () {
          Navigator.pop(context);
        })),
        body: WebView(url: article.url ?? ''),
      );

  Widget _navButton(IconData icon, Color color, VoidCallback callback) =>
      GestureDetector(
        onTap: callback,
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white),
          ),
          child: Center(
            child: Icon(
              icon,
              color: color,
            ),
          ),
        ),
      );
}

class WebView extends StatefulWidget {
  final String url;
  const WebView({super.key, required this.url});

  @override
  WebViewState createState() => WebViewState();
}

class WebViewState extends State<WebView> {
  late final WebViewController _controller;
  late final String url;

  @override
  void initState() {
    super.initState();
    url = widget.url; // Initialize the URL from the widget

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) => WebViewWidget(
        controller: _controller,
      );
}
