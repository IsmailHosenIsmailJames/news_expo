import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:news_expo/src/screens/cubit/home_cubit.dart';
import 'package:news_expo/src/screens/cubit/home_state.dart';
import 'package:news_expo/src/screens/models/saerch_res_model.dart';
import 'package:news_expo/src/theme/app_color.dart';
import 'package:news_expo/src/theme/shapes.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  final String initSearchKeyword;
  const HomePage({super.key, required this.initSearchKeyword});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController searchController = TextEditingController(
    text: widget.initSearchKeyword,
  );

  @override
  void initState() {
    var homeCubit = context.read<HomeCubit>();
    homeCubit.getNewsData(searchController.text.trim());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("News Explorer"), centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
              bottom: 2,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      color: AppColor.primaryMuted,
                      borderRadius: BorderRadius.circular(
                        AppShapes.roundedBorder,
                      ),
                    ),
                    child: TextFormField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: "Search...",
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Gap(10),
                SizedBox(
                  height: 50,
                  width: 50,
                  child: IconButton(
                    style: IconButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: AppColor.primaryMuted,
                    ),
                    onPressed: () async {
                      if (context.read<HomeCubit>().state.searchKeyword !=
                          searchController.text.trim()) {
                        context.read<HomeCubit>().getNewsData(
                          searchController.text.trim(),
                        );
                      }
                    },
                    icon: Icon(Icons.search),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state.loading == true) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state.searchResModel != null) {
                  SearchResModel searchResModel = state.searchResModel!;
                  int searchResLength = searchResModel.articles?.length ?? 0;
                  if (searchResLength == 0) {
                    return Center(child: Text("Search Result is empty"));
                  }
                  return ListView.builder(
                    itemCount: searchResLength,
                    padding: EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: 60,
                      top: 10,
                    ),
                    itemBuilder: (context, index) {
                      Article current = searchResModel.articles![index];
                      return getArticleCard(current);
                    },
                  );
                } else {
                  return Center(child: Text("Search and get news!"));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget getArticleCard(Article article) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                article.title ?? "",
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
              ),
              if (article.publishedAt != null) Gap(5),
              if (article.publishedAt != null)
                Text(
                  DateFormat(
                    DateFormat.ABBR_MONTH_WEEKDAY_DAY,
                  ).format(article.publishedAt!),
                ),
              if (article.publishedAt != null) Gap(5),
              if (article.urlToImage != null) Gap(10),
              if (article.urlToImage != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppShapes.roundedBorder),
                  child: CachedNetworkImage(
                    imageUrl: article.urlToImage!,
                    errorWidget: (context, url, error) {
                      return Icon(Icons.broken_image);
                    },
                  ),
                ),
              if (article.description != null) Gap(10),
              if (article.description != null)
                Text(article.description!.trim()),
              if (article.url != null) Gap(10),
              if (article.url != null)
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      launchUrl(Uri.parse(article.url!));
                    },
                    label: Text("Learn More"),
                    icon: Icon(Icons.link),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
