
import 'package:fit_food_app/business/provider.dart';
import 'package:fit_food_app/pages/detay_page.dart';
import 'package:fit_food_app/pages/pro_plan_page.dart';
import 'package:fit_food_app/widgets/sabit_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TariflerPage extends ConsumerWidget {
  const TariflerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    var tarifListesi = ref.watch(tarifListesiProvider);

    var kahvaltiList = ref.watch(kahvaltiListProvider);
    var ogleList = ref.watch(ogleListProvider);
    var aksamList = ref.watch(aksamListProvider);
    var araList = ref.watch(araListProvider);

    var kategoriListMap = {
      "My Breakfasts" : kahvaltiListProvider,
      "My Lunches" : ogleListProvider,
      "My Dinners" : aksamListProvider,
      "My Snacks" : araListProvider
    };


    return Scaffold(
      body: Stack(
        children:[ 

          MyContainerDesign(),

          Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            SizedBox(height: 55,),
        
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Icon(Icons.arrow_back, size: 30,)
              ),
            ),
        
            Expanded(
              child: Container(
                //color: Colors.red,
                child: ListView.builder(
                  itemCount: tarifListesi.length,
                  itemBuilder: (context, index) {
                    
                    var item = tarifListesi[index];
                    
                    var isSaved = [
                      kahvaltiList,
                      ogleList,
                      aksamList,
                      araList,
                    ].expand((liste) => liste).any((t) => t.id == item.id ? true : false);
        
                    return GestureDetector(
                      onTap: () {
                        print("TILANILDI");
                        if (ref.read(isProProvider) == true || item.isPro == false) {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => detayPage(
                            image: item.image, 
                            title: item.title, 
                            besinDegerleri: item.besinDegerleri, 
                            malzemeler: item.malzemeler, 
                            talimatlar: item.talimatlar
                          )));
                        }
                        else {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProPlanPage()));
                        }
                        
                      },
                      child: TarifContainer(
                        
                        image: item.image,
                        title: item.title,
                        isPro: item.isPro,
                        proUye: ref.watch(isProProvider),
                        besinDegerleri: item.besinDegerleri,
                        
                        isSave: isSaved,  //item.id %2 == 0 ? true : false, 
                        onFavoritePressed: (onsave, value) {
                      
                          var provider = kategoriListMap[value];
                      
                          if (provider == null) {
                            print("HATALI İŞLEM");
                          }
                      
                          if (onsave) {
                            ref.read(provider!.notifier).update((state) => [...state, item]);
                            print("${item.title} : ID : ${item.id} : $value tariflerine eklendi");
                          }
                          else {
        
                            for (var entry in kategoriListMap.entries) {
                              final provider = entry.value;
                              final list = ref.read(provider);
        
                              final contains = list.any((t) => t.id == item.id);
                              if (contains) {
                                ref.read(provider.notifier).update((state) => state.where((t) => t.id != item.id).toList());
                                print("${item.title} çıkarıldı: ${entry.key}");
                                break;
                              }
                            }
                          } 
                        },
                      ),
                    );
                  }
                ),
              ),
            ),
          ],
        ),]
      ),
    );
  }
}