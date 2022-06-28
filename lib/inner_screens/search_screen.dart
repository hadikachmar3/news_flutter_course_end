import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:news_app_flutter_course/models/news_model.dart';
import 'package:news_app_flutter_course/widgets/vertical_spacing.dart';
import 'package:provider/provider.dart';

import '../consts/vars.dart';
import '../providers/news_provider.dart';
import '../services/utils.dart';
import '../widgets/articles_widget.dart';
import '../widgets/empty_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _searchTextController;
  late final FocusNode focusNode;
  @override
  void initState() {
    super.initState();
    _searchTextController = TextEditingController();
    focusNode = FocusNode();
  }

  List<NewsModel>? searchList = [];
  bool isSearching = false;
  @override
  void dispose() {
    if (mounted) {
      _searchTextController.dispose();
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).getColor;
    final newsProvider = Provider.of<NewsProvider>(context);
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
            body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      focusNode.unfocus();
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      IconlyLight.arrowLeft2,
                    ),
                  ),
                  Flexible(
                      child: TextField(
                    focusNode: focusNode,
                    controller: _searchTextController,
                    style: TextStyle(color: color),
                    autofocus: true,
                    textInputAction: TextInputAction.search,
                    keyboardType: TextInputType.text,
                    onEditingComplete: () async {
                      searchList = await newsProvider.searchNewsProvider(
                          query: _searchTextController.text);
                      isSearching = true;
                      focusNode.unfocus();
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(
                        bottom: 8 / 5,
                      ),
                      hintText: "Search",
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      suffix: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: GestureDetector(
                          onTap: () {
                            _searchTextController.clear();
                            focusNode.unfocus();
                            isSearching = false;
                            // searchList =[];
                            searchList!.clear();
                            setState(() {});
                          },
                          child: const Icon(
                            Icons.close,
                            size: 18,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ))
                ],
              ),
            ),
            const VerticalSpacing(10),
            if (!isSearching && searchList!.isEmpty)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MasonryGridView.count(
                    itemCount: searchKeywords.length,
                    crossAxisCount: 4,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          searchList = await newsProvider.searchNewsProvider(
                              query: _searchTextController.text);
                          isSearching = true;
                          focusNode.unfocus();
                          _searchTextController.text = searchKeywords[index];
                          setState(() {});
                        },
                        child: Container(
                            margin: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: color),
                                borderRadius: BorderRadius.circular(30)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: FittedBox(
                                  child: Text(searchKeywords[index]),
                                ),
                              ),
                            )),
                      );
                    },
                  ),
                ),
              ),
            if (isSearching && searchList!.isEmpty)
              const Expanded(
                child: EmptyNewsWidget(
                  text: "Ops! No resuls found",
                  imagePath: 'assets/images/search.png',
                ),
              ),
            if (searchList != null && searchList!.isNotEmpty)
              Expanded(
                child: ListView.builder(
                    itemCount: searchList!.length,
                    itemBuilder: (ctx, index) {
                      return ChangeNotifierProvider.value(
                        value: searchList![index],
                        child: const ArticlesWidget(),
                      );
                    }),
              ),
          ],
        )),
      ),
    );
  }
}
