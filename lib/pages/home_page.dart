


import 'package:fit_food_app/business/provider.dart';
import 'package:fit_food_app/pages/calori_tracker_page.dart';
import 'package:fit_food_app/pages/tarifler_page.dart';
import 'package:fit_food_app/widgets/sabit_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(

      children: [

        SizedBox(height: 60,),

        Container(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 2, color: Colors.grey.withAlpha(60)))
          ),
          child: const Giris()
        ),

        SizedBox(height: 20,),

        const Expanded(child: SingleChildScrollView(child: KategoriArea()))

      ],
    );
  }
}



class Giris extends ConsumerWidget {
  const Giris({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("GİRİS TETIKLENDİ");

    var theme = ref.watch(themeModeProvider);
    var mode = theme == ThemeMode.light;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
      
          const SizedBox(height: 60,),
      
          Text("Fit Kitchen", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 24),),
      
          const Spacer(),
      
          Switch(
            value: mode, 
            onChanged: (val) {
              ref.read(themeModeProvider.notifier).state = val ? ThemeMode.light : ThemeMode.dark;
              //ref.read(isProProvider.notifier).state = !ref.read(isProProvider);
            },
            activeColor: Colors.green,        
          ),

          const Icon(Icons.light_mode),
        ],
      ),
    );
  }
}




class KategoriArea extends ConsumerWidget {
  const KategoriArea({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("KATEGORİ TETİKLENDİ");

    var kategoriList = ref.watch(kategoriListesiProvider);
    var kaloriyeGoreKategori = ref.watch(kaloriyeGoreKategoriList);

    //return kategoriList == kategoriList.isEmpty ? CircularProgressIndicator() : 

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
    
        
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Container(
              //width: 50,
              //color: Colors.amber,
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text("Category", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.bold, fontSize: 19),),
              ),
            ),

            SizedBox(
              height: 300,
              width: double.maxFinite,
    
              child: Container(
      
               child: kategoriList.isEmpty ? Center(child: SizedBox(height: 50, width: 50, child: CircularProgressIndicator(color: Colors.green,))) : ListView.builder(
        
                  scrollDirection: Axis.horizontal,
                  itemCount: kategoriList.length,
                  itemBuilder: (context, index) {
                    var item = kategoriList[index];
                    return GestureDetector(
                     onTap: () {
                        print("TIKALYICI TETIKLENDİ");
                        ref.read(dataControlProvider).tarifJsonOku(item.veri_url, ref, item.title);
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => TariflerPage()));
                      },
                      child: kategoriContainer(
                        title: item.title, 
                        image: item.image
                      ),
                    );
                  }
                ),
              ),
            ),
          ],
        ),

        
        SizedBox(height: 70,),



        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          
              Text("Calorie Tracking", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontWeight:  FontWeight.bold, fontSize: 19),),

              SizedBox(height: 10,),
          
              Container(
                width: MediaQuery.of(context).size.width * 1 > 390 ? 390 : MediaQuery.of(context).size.width * 1,
                height: 250,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Theme.of(context).colorScheme.outline, width: 2)
                ),
                          
                child: Center(
                  child: Container(
                    width: 220,
                    height: 220,
                    //color: Colors.amber,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => CaloriTakipPage()));
                        //ref.read(alinanProtein.notifier).state = 10;
                      },
                      child: MyProgressIndicator(yukseklik: 210, genislik: 210, fontSize_1: 43, fontSize_2: 21,),
                      
                    )
                  ),
                )
              ),
            ],
          ),
        ),


        SizedBox(height: 70,),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              //width: 50,
              //color: Colors.amber,
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text("Recipes by calories", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.bold, fontSize: 19),),
              ),
            ),

            SizedBox(
              height: 300,
              width: double.maxFinite,
    
              child: Container(
    
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: kaloriyeGoreKategori.length,
                  itemBuilder: (context, index) {
                    var item = kaloriyeGoreKategori[index];
          
                    return GestureDetector(
                      onTap: () {
                        ref.read(dataControlProvider).tarifJsonOku(item.veri_url, ref, item.title);
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => TariflerPage()));
                      },
                      child: kategoriContainer(
                        title: item.title, 
                        image: item.image
                      ) ,
                    );
                  }
                ),
              ),
            ),
          ],
        ),
    
        SizedBox(height: 300,)


      ],
    );
  }
}




