import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:news_app/features/home/presentation/saved_articles/bloc/saved_articles_bloc.dart';
import 'package:news_app/features/home/presentation/saved_articles/bloc/saved_articles_event.dart';
import 'package:news_app/features/home/presentation/saved_articles/bloc/saved_articles_state.dart';
import 'package:news_app/features/home/presentation/widgets/article_list.dart';

class SavedArticles extends StatefulWidget {
  const SavedArticles({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SavedArticles createState() => _SavedArticles();
}

class _SavedArticles extends State<StatefulWidget> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<SavedArticlesBloc>().add(const FetchArticles());
    }
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<SavedArticlesBloc, SavedArticlesState>(
          builder: (context, state) {
        if (state is ArticlesLoading) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        } else if (state is ArticlesError) {
          return const Center(child: Icon(Icons.refresh));
        } else if (state is ArticlesSuccess) {
          return ArticleList(articles: state.articles!);
        } else if (state is ArticlesEmpty) {
          return const Center(
              child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Center children vertically
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Iconsax.shield_cross),
              SizedBox(
                height: 10,
              ),
              Text('There aren\'t saved articles!')
            ],
          ));
        } else {
          return const SizedBox();
        }
      });
}
