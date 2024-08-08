import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_app/core/resources/colors.dart';
import 'package:news_app/features/home/data/models/categories.dart';
import 'package:news_app/features/home/presentation/headlines/bloc/headlines_bloc.dart';
import 'package:news_app/features/home/presentation/headlines/bloc/headlines_event.dart';
import 'package:news_app/features/home/presentation/headlines/bloc/headlines_state.dart';
import 'package:news_app/features/home/presentation/headlines/widgets/article.dart';
import 'package:news_app/features/home/presentation/pages/article_detail_page.dart';

class Headlines extends StatelessWidget {
  const Headlines({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildWelcome(),
        _buildSearchBar(context),
        _buildCategoriesSection(context),
        _buildHeadlinesSection(),
      ],
    );
  }

  Widget _buildCategoriesSection(BuildContext context) {
    const headlines = Topic.values;
    return BlocBuilder<HeadlinesBloc, HeadlinesState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(top: 20, left: 25, right: 25),
          height: 30,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: headlines.length,
            itemBuilder: (context, index) {
              final topic = headlines[index];
              return GestureDetector(
                  onTap: () {
                    context
                        .read<HeadlinesBloc>()
                        .add(GetTopicHeadlines(topic: topic));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      '#${topic.name[0].toUpperCase()}${topic.name.substring(1)}',
                      style: TextStyle(
                        color: (state is TopicHeadlinesSuccess &&
                                state.topic == headlines[index])
                            ? CustomColors.buttonColor
                            : CustomColors.grayTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ));
            },
          ),
        );
      },
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    String searchedText = '';
    return Container(
        margin: const EdgeInsets.only(top: 40.0, left: 20, right: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: SizedBox(
          height: 55,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            searchedText = value;
                          },
                          decoration: InputDecoration(
                            hintText: "Search for article...",
                            hintStyle: const TextStyle(
                                color: CustomColors.grayTextColor),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                  onTap: () {
                    context
                        .read<HeadlinesBloc>()
                        .add(SearchNews(query: searchedText));
                  },
                  child: Container(
                    width: 55, // Adjust width as needed
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: CustomColors.buttonColor,
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/images/search_icon.svg',
                        semanticsLabel: 'Search Icon',
                        width: 24,
                        height: 24,
                        colorFilter: const ColorFilter.mode(
                            Colors.white, BlendMode.srcIn),
                      ),
                    ),
                  )),
            ],
          ),
        ));
  }

  Widget _buildWelcome() => const Padding(
      padding: EdgeInsets.only(top: 70, left: 30, right: 30),
      child: Row(
        children: [
          Image(
            image: AssetImage('assets/images/profile_placeholder.png'),
            width: 50,
            height: 50,
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back!',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black),
                ),
                Text(
                  'Monday, 3 October',
                  style: TextStyle(
                      fontSize: 14, color: CustomColors.grayTextColor),
                )
              ],
            ),
          ))
        ],
      ));

  Widget _buildHeadlinesSection() {
    return BlocBuilder<HeadlinesBloc, HeadlinesState>(
      builder: (BuildContext context, HeadlinesState state) {
        if (state is HeadlinesLoading) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        } else if (state is HeadlinesError) {
          return const Center(child: Icon(Icons.refresh));
        } else if (state is HeadlinesSuccess ||
            state is TopicHeadlinesSuccess ||
            state is SearchNewsSuccess) {
          return Expanded(
              child: Container(
                  margin: const EdgeInsets.only(right: 20, left: 20, top: 10),
                  width: 360,
                  child: ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 20,
                          ),
                      scrollDirection: Axis.vertical,
                      itemCount: state.articles!.length,
                      itemBuilder: (context, index) {
                        var padding =
                            state.articles!.length - 1 == index ? 20 : 0;
                        return GestureDetector(
                            onTap: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ArticleDetailPage(
                                                  article:
                                                      state.articles![index])))
                                },
                            child: Container(
                                margin:
                                    EdgeInsets.only(bottom: padding.toDouble()),
                                child: Article(
                                  title: state.articles![index].title,
                                  imageSrc: state.articles![index].urlToImage,
                                  author: state.articles![index].author,
                                  publishedDate:
                                      state.articles![index].publishedAt,
                                )));
                      })));
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
