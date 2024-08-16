import 'package:flutter/material.dart';
import 'package:news_app/features/home/domain/entities/article.dart';
import 'package:news_app/features/home/presentation/pages/article_detail/article_detail_page.dart';
import 'package:news_app/features/home/presentation/widgets/article.dart';

class ArticleList extends StatelessWidget {
  final List<ArticleEntity> articles;

  const ArticleList({required this.articles, super.key});

  @override
  Widget build(BuildContext context) => Expanded(
      child: Container(
          margin: const EdgeInsets.only(right: 20, left: 20, top: 10),
          width: 360,
          child: ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) => const SizedBox(
                    height: 20,
                  ),
              scrollDirection: Axis.vertical,
              itemCount: articles.length,
              itemBuilder: (context, index) {
                var padding = articles.length - 1 == index ? 20 : 0;
                return GestureDetector(
                    onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ArticleDetailPage(
                                      article: articles[index])))
                        },
                    child: Container(
                        margin: EdgeInsets.only(bottom: padding.toDouble()),
                        child: Article(
                          title: articles[index].title,
                          imageSrc: articles[index].urlToImage,
                          author: articles[index].author,
                          publishedDate: articles[index].publishedAt,
                          url: articles[index].url,
                        )));
              })));
}
