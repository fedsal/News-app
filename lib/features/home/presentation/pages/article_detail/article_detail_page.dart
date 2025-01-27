import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:news_app/features/home/domain/entities/article.dart';
import 'package:news_app/features/home/presentation/pages/article_detail/saved_item_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleDetailPage extends StatelessWidget {
  final ArticleEntity article;

  const ArticleDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    context.read<SavedItemBloc>().add(PersistInStateHolder(article));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_24),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          BlocBuilder<SavedItemBloc, SavedArticleState>(
              builder: (BuildContext context, SavedArticleState state) {
            var icon = (state is ArticleSaved)
                ? Icons.bookmark
                : Icons.bookmark_border_outlined;
            return IconButton(
                onPressed: () {
                  context
                      .read<SavedItemBloc>()
                      .add(ToggleSavedArticle(article));
                },
                icon: Icon(icon));
          })
        ],
      ),
      body: WebView(url: article.url ?? ''),
    );
  }
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
