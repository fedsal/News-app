import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_app/core/resources/colors.dart';
import 'package:news_app/features/home/data/models/categories.dart';
import 'package:news_app/features/home/data/models/countries.dart';
import 'package:news_app/features/home/presentation/headlines/bloc/headlines_bloc.dart';
import 'package:news_app/features/home/presentation/headlines/bloc/headlines_event.dart';
import 'package:news_app/features/home/presentation/headlines/bloc/headlines_state.dart';
import 'package:news_app/features/home/presentation/widgets/article_list.dart';

class Headlines extends StatelessWidget {
  const Headlines({super.key});

  void _showDialog(BuildContext context, Widget child) {
    final result = showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
          color: CupertinoColors.systemBackground.resolveFrom(context),
        ),
        height: 400,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
    result.then((_) {
      context.read<HeadlinesBloc>().add(const GetHeadlines());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        _buildCountrySelector(context),
        _buildWelcome(),
        _buildSearchBar(context),
        _buildCategoriesSection(context),
        _buildHeadlinesSection(),
      ],
    ));
  }

  Widget _buildCountrySelector(BuildContext context) => Padding(
      padding: const EdgeInsets.only(top: 18, right: 20),
      child: GestureDetector(
          onTap: () {
            const countries = Country.values;
            _showDialog(
                context,
                CupertinoPicker(
                  magnification: 1.22,
                  squeeze: 1.2,
                  useMagnifier: true,
                  itemExtent: 32,
                  // This sets the initial item.
                  scrollController: FixedExtentScrollController(
                    initialItem: 0,
                  ),
                  // This is called when selected item is changed.
                  onSelectedItemChanged: (int selectedItem) {
                    context
                        .read<HeadlinesBloc>()
                        .add(SelectCountry(country: countries[selectedItem]));
                  },
                  children:
                      List<Widget>.generate(countries.length, (int index) {
                    return Center(child: Text(countries[index].name));
                  }),
                ));
          },
          child: BlocBuilder<HeadlinesBloc, HeadlinesState>(
              builder: (context, state) => Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        state.country.code.toUpperCase(),
                        style: const TextStyle(
                            color: CustomColors.buttonColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                          color: CustomColors.buttonColor,
                        ),
                      ),
                    ],
                  ))));

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
                        color: (state.topic != null &&
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
      padding: EdgeInsets.only(left: 30, right: 30),
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
        if (state.isLoading) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        } else if (state.error != null) {
          return const Center(child: Icon(Icons.refresh));
        } else if (state.articles.isNotEmpty) {
          return ArticleList(articles: state.articles!);
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
