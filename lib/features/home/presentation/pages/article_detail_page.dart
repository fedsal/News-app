import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:news_app/core/resources/colors.dart';
import 'package:news_app/features/home/domain/entities/article.dart';

class ArticleDetailPage extends StatelessWidget {
  final ArticleEntity article;

  const ArticleDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        body: _buildBody(context),
      );

  Widget _buildBody(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double containerHeight = screenHeight;

    return Stack(
      children: [
        article.urlToImage != null && article.urlToImage!.isNotEmpty
            ? Image.network(
                article.urlToImage!,
                height: containerHeight * 0.5,
                width: double.infinity,
                fit: BoxFit.cover,
              )
            : Image(
                height: containerHeight * 0.5,
                width: double.infinity,
                fit: BoxFit.cover,
                image: const AssetImage(
                    'assets/images/new_background_placeholder.png'),
              ),
        SafeArea(child: _buildArticleSection(containerHeight * 0.4)),
        SafeArea(child: _buildHeaderButtons(context)),
      ],
    );
  }

  Widget _buildHeaderButtons(BuildContext context) => Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Row(
        children: [
          _navButton(Iconsax.arrow_left_24, () {
            Navigator.pop(context);
          }),
          const Spacer(),
          _navButton(Iconsax.save_24, () {})
        ],
      ));

  Widget _navButton(IconData icon, VoidCallback callback) => GestureDetector(
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
              color: Colors.white,
            ),
          ),
        ),
      );

  Widget _buildArticleSection(double firstElementSpace) =>
      SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: firstElementSpace,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        article.title ?? 'Unravel mysteries of the Maldives',
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 32),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    height: 54,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: CustomColors.grayTextColor.withOpacity(.5)),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${article.author} · ${article.source?.name} · ${article.publishedAt}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black.withOpacity(.6),
                              fontSize: 13),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    article.content ??
                        "Just say anything, George, say what ever's natural, the first thing that comes to your mind. Take that you mutated son-of-a-bitch. My pine, why you. You space bastard, you killed a pine. You do? Yeah, it's 8:00. Hey, McFly, I thought I told you never ",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            )
          ],
        ),
      );
}
