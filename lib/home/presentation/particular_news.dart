import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_news/global/global_colors.dart';
import 'package:my_news/home/models/news_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ParticularNews extends StatelessWidget {
  const ParticularNews({super.key, required this.newsArticle});
  final Articles newsArticle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        title: Text(
          newsArticle.author ?? "News Author",
          style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 14.spMin,
              fontWeight: FontWeight.w700,
              color: Colors.white),
        ),
        leading: const BackButton(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        child: Column(
          children: [
            newsArticle.urlToImage == null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Image.asset(
                      "assets/icons/breakingNews.png",
                      height: 360.h,
                      width: double.maxFinite,
                      fit: BoxFit.cover,
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Image.network(
                      newsArticle.urlToImage ?? "",
                      height: 360.h,
                      width: double.maxFinite,
                      fit: BoxFit.cover,
                    ),
                  ),
            SizedBox(
              height: 14.h,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      newsArticle.title ?? "News Title",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 8,
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14.spMin,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    Text(
                      newsArticle.description ?? "Description NA",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 6,
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14.spMin,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                    
                    InkWell(
                      onTap: () async {
                        if (!await launchUrl(
                            Uri.parse(newsArticle.url ?? ""))) {
                          throw Exception('Could not launch ');
                        }
                      },
                      child: Text(
                        "Click to read more",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 6,
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14.spMin,
                            fontWeight: FontWeight.w600,
                            color: kPrimaryColor),
                      ),
                    ),

                    SizedBox(height: 20.h,),

                    Row(children: [
                      Text(
                      "Published At: ",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 6,
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14.spMin,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                      Text(
                      newsArticle.publishedAt.toString().split("T")[0],
                      overflow: TextOverflow.ellipsis,
                      maxLines: 6,
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14.spMin,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    ],)
                    
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
