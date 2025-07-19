
import 'package:fit_food_app/business/provider.dart';
import 'package:fit_food_app/pages/hedefbelirleme_page.dart';
import 'package:fit_food_app/pages/macroguncelle_page.dart';
import 'package:fit_food_app/widgets/sabit_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class CaloriTakipPage extends StatelessWidget {
  const CaloriTakipPage({super.key});

  @override
  Widget build(BuildContext context) {

    //var genislik = MediaQuery.of(context).size.width;

    return Scaffold(
      
      body: Stack(
        children: [

          MyContainerDesign(),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 50,),

              //Text("${genislik.toInt()}"),

              Padding(
                padding: EdgeInsets.only(left: 15),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Icon(Icons.arrow_back, size: 30,)
                ),
              ),
            
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                                  
                      MakroAndCaloriesArea(),
                  
                      SizedBox(height: 20,),
                  
                      YemekContainerList()                        
                  
                    ],
                  ),
                ),
              ),

            ],
          ),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => MacroUpdatePage()));
          
        }, 
        backgroundColor: Colors.green,
        child: Icon(Icons.add, size: 38,),
      ),
    );
    
  }
}




class MakroAndCaloriesArea extends ConsumerWidget {
  const MakroAndCaloriesArea({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    var hedefprotein = ref.watch(proteinHedefi);
    var alinanprotein = ref.watch(mealListProvider).fold(0, (sum, meal) => sum + meal.proteinGR); //ref.watch(alinanProtein);

    var hedefcarb = ref.watch(carbHedefi);
    var alinancarb = ref.watch(mealListProvider).fold(0, (sum, meal) => sum + meal.karbGR); //ref.watch(alinanCarb);

    var hedefyag = ref.watch(yagHedefi);
    var alinanyag = ref.watch(mealListProvider).fold(0, (sum, meal) => sum + meal.fatGR); //ref.watch(alinanYag);

    var alinanToplamKalori = (alinanprotein * 4) + (alinancarb * 4) + (alinanyag * 9);
    var toplamHedefKalori = (hedefprotein * 4) + (hedefcarb * 4) + (hedefyag * 9);

    //var kalorihedefi = ref.watch(kaloriHedefi);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        
        children: [
      
          SizedBox(height: 30,),
      
          //! KALORİ CONTAİNER
          Container(
            //width: 380,
            //height: 100,
            
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withAlpha(100),
                  blurRadius: 7
                )
              ]
            ),
          
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                //mainAxisSize: MainAxisSize.min,
                children: [
              
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "${toplamHedefKalori - alinanToplamKalori} \n", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: Theme.of(context).colorScheme.onPrimary)
                        ),
              
                        TextSpan(
                          text: "Calories left", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 18)
                        )
                      ] 
                    )
                  ),
          
                  SizedBox(width: MediaQuery.of(context).size.width <= 500 ? MediaQuery.of(context).size.width * 0.22 : 120,),
          
              
                  MyProgressIndicator_2(
                    yukseklik: 110, 
                    genislik: 110, 
                    iconAssetName: "fire.png", 
                    iconScale: 15, 
                    strokewitdh: 15,
                    hedefMacro: (hedefprotein * 4) + (hedefcarb * 4) + (hedefyag * 9),
                    alinanMacro: (alinanprotein * 4) + (alinancarb * 4) + (alinanyag * 9),
                  )
              
                ],
              ),
            ),
          ),
      
          SizedBox(height: 20,),
      
          //! MACRO CONTAİNERLAR
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          
              MacroContainer(
                iconAssetName: "chicken.png", 
                macroname: "Protein",
                hedefMacro: hedefprotein,
                alinanMacro: alinanprotein,
              ),
          
              MacroContainer(
                iconAssetName: "wheat.png", 
                macroname: "Carbs",
                hedefMacro: hedefcarb,
                alinanMacro: alinancarb,
              ),
          
              MacroContainer(
                iconAssetName: "fat.png", 
                macroname: "Fat",
                hedefMacro: hedefyag,
                alinanMacro: alinanyag,
              )
            ],
          ),


          SizedBox(height: 20,),


          //! BUTONLAR
          Row(
            children: [

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  side: BorderSide(color: Colors.green, width: 2),
                  minimumSize: Size(20, 50)
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => HedefBelirlemePage()));
                }, 
                child: Text("Set Your Goal", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),)
              ),

              Spacer(),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  side: BorderSide(color: Colors.green, width: 2),
                  minimumSize: Size(20, 50)
                ),
                onPressed: () {
                  print("MACRO SIFIRLANDI");
                  alinanMacrolariSifirla(ref, context);
                  //Navigator.of(context).pop();
                }, 
                child: Text("Reset Macros", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),)
              ),
            ],
          ),

          

        ],
      ),
    );
  }

  alinanMacrolariSifirla (WidgetRef ref, BuildContext context) {
    print("AKTIF OLDU");
    showDialog(
      context: context, 
      builder: (BuildContext context) {

        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          content: Text("Are you sure you want to reset macros", style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onPrimary),),

          actions: [

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                ElevatedButton(onPressed: () {
                  Navigator.of(context).pop();
                }, child: Text("No")),

                SizedBox(width: 40,),

                ElevatedButton(onPressed: () {
                  ref.read(alinanProtein.notifier).state = 0;
                  ref.read(alinanCarb.notifier).state = 0;
                  ref.read(alinanYag.notifier).state = 0;
                  Navigator.of(context).pop();
                }, child: Text("Yes")),


              ],
            )
          ],
        );
      }
    );

  }

}



class YemekContainerList extends ConsumerStatefulWidget {
  const YemekContainerList({super.key});

  @override
  ConsumerState<YemekContainerList> createState() => _YemekContainerListState();
}

class _YemekContainerListState extends ConsumerState<YemekContainerList> {



  @override
  Widget build(BuildContext context) {

    var mealList = ref.watch(mealListProvider);

    return Column(
      children: [
        SizedBox(
          height: 500,
          width: 450,
          child: ListView.builder(
            itemCount: mealList.length,
            itemBuilder: (context, index) {
              var item = mealList[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                child: Container(
                  //color: Colors.red,
                  child: Stack(
                    children: [ 
                      
                      MealContainer(
                        mealName: item.mealName, 
                        protein: item.proteinGR.toString(), 
                        carb: item.karbGR.toString(), 
                        fat: item.fatGR.toString(),
                        saat: item.saat,
                        dakika: item.dakika,
                      ),
                  
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(onPressed: () {

                            mealdeletDialog(index);

                          }, icon: Icon(Icons.delete_rounded, size: 30, color: Theme.of(context).colorScheme.onPrimary,)),
                        ],
                      )
                  
                    ]
                  ),
                )


              );
            }),
        ),
      ],
    );
  }


  mealdeletDialog (int index) {

    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          title: Text("Are you sure you want to delete this meal?", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),),

          actions: [

            TextButton(onPressed: () {
              Navigator.of(context).pop();
            }, child: Text("No", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),)),

            TextButton(onPressed: () {

              ref.read(mealListProvider.notifier).update((state) {
                var newList = [...state];
                newList.removeAt(index);
                return newList;
              });
              Navigator.of(context).pop();

            }, child: Text("Yes", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),))

          ],
        );
      }
    );
  }


}



