import 'package:fit_food_app/business/provider.dart';
import 'package:fit_food_app/pages/detay_page.dart';
import 'package:fit_food_app/pages/pro_plan_page.dart';
import 'package:fit_food_app/widgets/sabit_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriPage extends ConsumerWidget {
  FavoriPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var kahvaltiList = ref.watch(kahvaltiListProvider);
    var ogleList = ref.watch(ogleListProvider);
    var aksamList = ref.watch(aksamListProvider);
    var araList = ref.watch(araListProvider);

    return Scaffold(
      body: Stack(
        children: [
          MyContainerDesign(),

          Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  
                  SizedBox(height: 60),
            
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: Text(
                            "MY BREAKFASTS",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        //color: Colors.amber,
                        width: double.maxFinite,
                        height: 270,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: kahvaltiList.length,
                          itemBuilder: (context, index) {
                            var item = kahvaltiList[index];
                            return GestureDetector(
                              onTap: () {

                                if (ref.read(isProProvider) == true || item.isPro == false) {
                                  Navigator.of(context).push(MaterialPageRoute(builder:(context) => detayPage
                                    (
                                          image: item.image,
                                          title: item.title,
                                          besinDegerleri: item.besinDegerleri,
                                          malzemeler: item.besinDegerleri,
                                          talimatlar: item.talimatlar,
                                    ),
                                  ),
                                );
                                } 
                                else {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProPlanPage()));
                                }

                                


                              },
                              child: Container(
                                //color: Colors.blueAccent,
                                child: TarifContainer(
                                  image: item.image,
                                  title: item.title,
                                  isPro: item.isPro,
                                  proUye: ref.watch(isProProvider),
                                  besinDegerleri: item.besinDegerleri,
                                  isSave: true,
                                  onFavoritePressed: (isSaved, balue) {
                                    ref
                                        .read(kahvaltiListProvider.notifier)
                                        .update(
                                          (state) =>
                                              state
                                                  .where((t) => t.id != item.id)
                                                  .toList(),
                                        );
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
            
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: Text(
                            "MY LUNCHES",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        //color: Colors.amber,
                        width: double.maxFinite,
                        height: 270,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: ogleList.length,
                          itemBuilder: (context, index) {
                            var item = ogleList[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder:
                                        (context) => detayPage(
                                          image: item.image,
                                          title: item.title,
                                          besinDegerleri: item.besinDegerleri,
                                          malzemeler: item.malzemeler,
                                          talimatlar: item.talimatlar,
                                        ),
                                  ),
                                );
                              },
                              child: TarifContainer(
                                image: item.image,
                                title: item.title,
                                isPro: item.isPro,
                                proUye: ref.watch(isProProvider),
                                besinDegerleri: item.besinDegerleri,
                                isSave: true,
                                onFavoritePressed: (isSaved, balue) {
                                  ref
                                      .read(ogleListProvider.notifier)
                                      .update(
                                        (state) =>
                                            state
                                                .where((t) => t.id != item.id)
                                                .toList(),
                                      );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
            
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: Text(
                            "MY DİNNERS",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        //color: Colors.amber,
                        width: double.maxFinite,
                        height: 270,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: aksamList.length,
                          itemBuilder: (context, index) {
                            var item = aksamList[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder:
                                        (context) => detayPage(
                                          image: item.image,
                                          title: item.title,
                                          besinDegerleri: item.besinDegerleri,
                                          malzemeler: item.malzemeler,
                                          talimatlar: item.talimatlar,
                                        ),
                                  ),
                                );
                              },
                              child: TarifContainer(
                                image: item.image,
                                title: item.title,
                                isPro: item.isPro,
                                proUye: ref.watch(isProProvider),
                                besinDegerleri: item.besinDegerleri,
                                isSave: true,
                                onFavoritePressed: (isSaved, balue) {
                                  ref
                                      .read(aksamListProvider.notifier)
                                      .update(
                                        (state) =>
                                            state
                                                .where((t) => t.id != item.id)
                                                .toList(),
                                      );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
            
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: Text(
                            "MY SNACKS",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        //color: Colors.amber,
                        width: double.maxFinite,
                        height: 270,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: araList.length,
                          itemBuilder: (context, index) {
                            var item = araList[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder:
                                        (context) => detayPage(
                                          image: item.image,
                                          title: item.title,
                                          besinDegerleri: item.besinDegerleri,
                                          malzemeler: item.malzemeler,
                                          talimatlar: item.talimatlar,
                                        ),
                                  ),
                                );
                              },
                              child: TarifContainer(
                                image: item.image,
                                title: item.title,
                                isPro: item.isPro,
                                proUye: ref.watch(isProProvider),
                                besinDegerleri: item.besinDegerleri,
                                isSave: true,
                                onFavoritePressed: (isSaved, balue) {
                                  ref
                                      .read(araListProvider.notifier)
                                      .update(
                                        (state) =>
                                            state
                                                .where((t) => t.id != item.id)
                                                .toList(),
                                      );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
