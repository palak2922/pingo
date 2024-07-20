import 'package:flutter/material.dart';
import 'package:pingo/Provider/AuthProvider.dart';
import 'package:pingo/Screens/SplashScreen.dart';
import 'package:pingo/Widgets/custom_loader.dart';
import 'package:pingo/models/NewsModel.dart';
import 'package:provider/provider.dart';
import '../Consts/Consts.dart';
import '../Services/NewsService.dart';

class NewsFeedScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        leading: const Icon(null),
        backgroundColor: Colors.grey[300],
        centerTitle: true,
        title: const Text(
          'News',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        actions: [
          InkWell(
            onTap: () async {
              await Provider.of<AuthProvider>(context, listen: false).signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => SplashScreen()));
            },
            child: const Icon(Icons.logout_outlined),
          ),
          const SizedBox(width: 16,),
        ],
      ),
      body: FutureBuilder<News>(
        future: Provider.of<NewsService>(context, listen: false)
            .fetchTopHeadlines(
                WidgetsBinding.instance.window.locale.countryCode!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              News articles = snapshot.data!;
              return ListView.builder(
                itemCount:
                    articles.articles.isEmpty ? 0 : articles.articles.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 120,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: 50,
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                image: DecorationImage(
                                    image: AssetImage('assets/img.png'),
                                  fit: BoxFit.fill
                                ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: ListTile(
                            dense: false,
                            title: Text(
                              articles.articles[index].title,
                              maxLines: 2,
                              style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                newFormat.format(DateTime.parse('${articles.articles[index].publishedAt}')),
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          } else {
            return Center(
                child: CustomLoader(
              color: Colors.black,
              size: 50,
            ));
          }
        },
      ),
    );
  }
}
