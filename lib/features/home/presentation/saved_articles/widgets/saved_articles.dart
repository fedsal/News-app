import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:news_app/features/home/presentation/saved_articles/bloc/saved_articles_bloc.dart';
import 'package:news_app/features/home/presentation/saved_articles/bloc/saved_articles_event.dart';
import 'package:news_app/features/home/presentation/saved_articles/bloc/saved_articles_state.dart';
import 'package:news_app/features/home/presentation/widgets/article_list.dart';

class SavedArticles extends StatelessWidget {
  const SavedArticles({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<SavedArticlesBloc, SavedArticlesState>(
          builder: (context, state) {
        context.read<SavedArticlesBloc>().add(const FetchArticles());
        if (state is ArticlesLoading) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        } else if (state is ArticlesError) {
          return const Center(child: Icon(Icons.refresh));
        } else if (state is ArticlesSuccess) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Text(
                    'Saved articles',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  )),
              ArticleList(articles: state.articles!)
            ],
          );
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
