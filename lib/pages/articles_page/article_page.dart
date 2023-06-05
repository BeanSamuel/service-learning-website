import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_learning_website/pages/page_skeleton.dart';
import 'package:service_learning_website/providers/articles_provider.dart';
import 'package:service_learning_website/widgets/my_markdown.dart';
import 'package:service_learning_website/widgets/title_text_box.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({
    required this.articleId,
    super.key,
  });

  final String articleId;

  @override
  State<ArticlePage> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<ArticlePage> {
  @override
  Widget build(BuildContext context) {
    final articlesProvider = Provider.of<ArticlesProvider>(context);
    if (articlesProvider.articlesData[widget.articleId] == null) {
      return const Scaffold(body: Center(child: Text("Loading")));
    }

    return PageSkeleton(
      body: Consumer<ArticlesProvider>(
        builder: (context, articlesProvider, child) {
          final articleData = articlesProvider.articlesData[widget.articleId]!;
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleTextBox(articleData.title),
              const SizedBox(height: 60),
              MyMarkdown(articleData.mdContent)
            ],
          );
        },
      ),
    );
  }
}
