import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_news/authentication/presentation/login_screen.dart';
import 'package:my_news/authentication/providers/auth_provider.dart';
import 'package:my_news/global/global_colors.dart';
import 'package:my_news/home/presentation/particular_news.dart';
import 'package:my_news/home/provider/home_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    final provider = Provider.of<HomeProvider>(context, listen: false);
    provider.getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        title: Text(
          "MyNews",
          style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 14.spMin,
              fontWeight: FontWeight.w700,
              color: Colors.white),
        ),
        actions: [
          Image.asset(
            "assets/icons/location.png",
            height: 15.h,
            width: 15.w,
          ),
          SizedBox(
            width: 4.w,
          ),
          Text(
            Provider.of<HomeProvider>(context, listen: true).remoteConfig.getString("country").toString().toUpperCase(),
            style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 14.spMin,
                fontWeight: FontWeight.w700,
                color: Colors.white),
          ),
          SizedBox(
            width: 10.w,
          ),
          IconButton(
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 10.w,
          )
        ],
      ),
      body: Consumer<HomeProvider>(
        builder: (context, homeProvider, child) {
          return homeProvider.newsModel != null
              ? const HomePage()
              : const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 17.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Top Headlines",
            style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 14.spMin,
                fontWeight: FontWeight.w700,
                color: Colors.black),
          ),
          SizedBox(
            height: 21.h,
          ),
          Consumer<HomeProvider>(builder: (context, homeProvider, child) {
            return Expanded(
              child: ListView.builder(
                  itemCount: homeProvider.newsModel?.articles?.length ?? 0,
                  itemBuilder: (context, index) {
                    var article = homeProvider.newsModel?.articles?[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ParticularNews(newsArticle: article!),
                          ),
                        );
                      },
                      child: Container(
                        height: 146.h,
                        margin: EdgeInsets.only(bottom: 15.h),
                        padding: EdgeInsets.symmetric(
                            horizontal: 14.w, vertical: 14.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    article?.author ?? "News Author $index",
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14.spMin,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black),
                                  ),
                                  Expanded(
                                    child: Text(
                                      article?.title ?? "News Title $index",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 6,
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14.spMin,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 14.w),
                            article?.urlToImage == null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10.r),
                                    child: Image.asset(
                                      "assets/icons/breakingNews.png",
                                      height: 119.h,
                                      width: 119.w,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(10.r),
                                    child: Image.network(
                                      article?.urlToImage ?? "",
                                      height: 119.h,
                                      width: 119.w,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    );
                  }),
            );
          }),
        ],
      ),
    );
  }
}
