
import 'package:fit_food_app/business/provider.dart';
import 'package:fit_food_app/model.dart';
import 'package:fit_food_app/widgets/sabit_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class MacroUpdatePage extends StatelessWidget {
  const MacroUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      
      body: Stack(
        children: [

          MyContainerDesign(),


          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          
              SizedBox(height: 50,),
          
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Icon(Icons.arrow_back, size: 30,)
                ),
              ),
          
              SizedBox(height: 75,),

              MacroGuncellemeContainer()
              
          
          
            ],
          
          )

        ],
      ),
    );
  }
}






class MacroGuncellemeContainer extends ConsumerStatefulWidget {
  const MacroGuncellemeContainer({super.key});

  @override
  ConsumerState<MacroGuncellemeContainer> createState() => _MacroGuncellemeContainerState();
}

class _MacroGuncellemeContainerState extends ConsumerState<MacroGuncellemeContainer> {

  TextEditingController txt_controller = TextEditingController();
  TextEditingController txtMealName = TextEditingController(text: "Meal 1");

  final FocusNode _focusNode = FocusNode();

  late int proteinMacro;
  late int carbMacro;
  late int yagMacro;

  @override
  void initState() {
    super.initState();

    proteinMacro = ref.read(alinanProtein);
    carbMacro = ref.read(alinanCarb);
    yagMacro = ref.read(alinanYag);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _focusNode.dispose();
  }


  @override
  Widget build(BuildContext context) {

    
    

    return Center(
      child: Column(
        children: [

          Container(
            width: 200,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Theme.of(context).colorScheme.outline, width: 2)
            ),
            
            child: TextField(
              
              controller: txtMealName,
              cursorColor: Colors.green,
            
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none
                )
              ),
            ),
          ),

          SizedBox(height: 40,),
      
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Material(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: InkWell(
                onTap: () {
                  macroDialogu(context, "Protein", ref);
                },
                splashColor: Colors.green,
                child: MacroGuncelleContainer(
                  iconImage: "chicken", 
                  macroName: "Protein", 
                  macroGram: proteinMacro.toString()
                ),
              ),
            ),
          ),

          SizedBox(height: 40,),

          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Material(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: InkWell(
                onTap: () {
                  macroDialogu(context, "Wheat", ref);
                },
                splashColor: Colors.green,
                child: MacroGuncelleContainer(
                  iconImage: "wheat", 
                  macroName: "Wheat", 
                  macroGram: carbMacro.toString()
                ),
              ),
            ),
          ),

          SizedBox(height: 40,),

          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Material(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: InkWell(
                onTap: () {
                  macroDialogu(context, "Fat", ref);
                },
                splashColor: Colors.green,
                child: MacroGuncelleContainer(
                  iconImage: "fat", 
                  macroName: "Fat", 
                  macroGram: yagMacro.toString()
                ),
              ),
            ),
          ),
      
          SizedBox(height: 100,),

          SizedBox(
            width: MediaQuery.of(context).size.width * 0.65,
            height: 60,
            child: ElevatedButton(onPressed: () {
            
              //ref.read(alinanProtein.notifier).state = proteinMacro + ref.read(alinanProtein);
              //ref.read(alinanCarb.notifier).state = carbMacro + ref.read(alinanCarb);
              //ref.read(alinanYag.notifier).state = yagMacro + ref.read(alinanYag);

              //howCheckDialog();

              DateTime now = DateTime.now();

              MealModel yeniMeal = MealModel(
                mealName: txtMealName.text, 
                proteinGR: proteinMacro, 
                karbGR: carbMacro, 
                fatGR: yagMacro,
                saat: now.hour,
                dakika: now.minute
              );

              ref.read(mealListProvider.notifier).update((state) => [...state , yeniMeal]);
              print("eklenen protein : $proteinMacro , eklenen carb : $carbMacro , eklenen fat : $yagMacro");
            
              showCheckDialog();

            }, child: Text("Save", style: TextStyle(fontSize: 21),)),
          )

        ],
      ),
    );
  }


  macroDialogu (BuildContext context, String macroname, WidgetRef ref) {

    showDialog(
      context: context, 
      builder: (BuildContext context) {

        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          title: Text(macroname),
          actions: [

            TextField(
              controller: txt_controller,
              keyboardType: TextInputType.numberWithOptions(),
              cursorColor: Colors.green,
              decoration: InputDecoration(
                /* border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2)
                ), */

                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 2)
                ),

                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 2)
                )
              ),

            ),

            SizedBox(height: 25,),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [


                /* ElevatedButton(onPressed: () {

                  if (macroname == "Protein") {
                    proteinMacro = -int.parse(txt_controller.text);
                    print("ALINAN PROTEİN : $proteinMacro");
                    setState(() {
                      
                    });
                  }
                  else if (macroname == "Wheat") {
                    carbMacro = -int.parse(txt_controller.text);
                    setState(() {
                      
                    });
                  }
                  else {
                    yagMacro = -int.parse(txt_controller.text);
                    setState(() {
                      
                    });
                  }

                  txt_controller.clear();

                  Navigator.of(context).pop();

                }, child: Text("Çıkar")), */


                SizedBox(width: 20,),


                ElevatedButton(onPressed: () {

                  if (macroname == "Protein") {
                    if (txt_controller.text.isNotEmpty) {

                      proteinMacro = int.parse(txt_controller.text);
                      print("ALINAN PROTEİN : $proteinMacro");
                      setState(() {
                      
                      });
                    }
                    else {
                      proteinMacro = 0;
                    }
                    
                  }
                  else if (macroname == "Wheat") {
                    if (txt_controller.text.isNotEmpty) {

                      carbMacro = int.parse(txt_controller.text);
                      setState(() {
                      
                      });

                    }
                    else {
                      carbMacro = 0;
                    }
                    
                  }
                  else {
                    if (txt_controller.text.isNotEmpty) {
                      yagMacro = int.parse(txt_controller.text);
                      setState(() {
                      
                      });
                    }
                    else {
                      yagMacro = 0;
                    }
                    
                  }

                  txt_controller.clear();

                  Navigator.of(context).pop();

                }, child: Text("Add")),

              ],
            ),

          ],
        );
      }
    );
  }


  showCheckDialog () {

    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          elevation: 0,
          child: Container(
            height: 200,
            child: Column(
              children: [
            
                Lottie.asset("assets/icons/checkAnim.json", width: 150, height: 150, repeat: false,
                  onLoaded: (composition) {
                    Future.delayed(composition.duration, () {
                      Navigator.of(context).pop();
                    });
                  },
                ),
            
                Text("Macros Updated", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),)
            
              ],
            ),
          ),
        );
      }
    );
  }


}