
import 'package:fit_food_app/business/provider.dart';
import 'package:fit_food_app/widgets/sabit_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class HedefBelirlemePage extends StatefulWidget {
  const HedefBelirlemePage({super.key});

  @override
  State<HedefBelirlemePage> createState() => _HedefBelirlemePageState();
}

class _HedefBelirlemePageState extends State<HedefBelirlemePage> {
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

              SizedBox(height: 50,),


              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [


                      KisiselBilgiler(),

                      SizedBox(height: 80,),
                      
                      HedeflerimArea()
                    ],
                  ),
                ),
              ),



            ] ,
          ),


        ],
      ),
    );
  }
}




class HedeflerimArea extends ConsumerStatefulWidget {
  const HedeflerimArea({super.key});

  @override
  ConsumerState<HedeflerimArea> createState() => _HedeflerimAreaState();
}

class _HedeflerimAreaState extends ConsumerState<HedeflerimArea> {

  String selectCinsiyet = "Woman";
  String selectAktivite = "less active";
  String selectHedef = "lose weight";

  final aktiviteKatsayilari = {
    "Sedentary": 1.2,
    "less active": 1.375,
    "Moderately Active": 1.55,
    "very active": 1.725,
    "super active": 1.9,
  };

  late TextEditingController kiloController;
  late TextEditingController boyController;
  late TextEditingController yasController;

  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var kiloo = ref.read(kilo);
    var boyy = ref.read(boy);
    var yass = ref.read(yas);

    kiloController = TextEditingController();
    boyController = TextEditingController();
    yasController = TextEditingController();

  }
  

  @override
  Widget build(BuildContext context) {

    /* final kiloWatch = ref.watch(kilo);
    final boyWatch = ref.watch(boy);
    final yasWatch = ref.watch(yas);

    kiloController.text = kiloWatch.toString();
    boyController.text = boyWatch.toString();
    yasController.text = yasWatch.toString(); */


    return Center(
      child: Column(
        
        children: [
      
      
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Weight",style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.bold, fontSize: 21),),
              MyTextField(tip: "kg", controller: kiloController,)
            ],
          ),

          SizedBox(height: 40,),
      
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Height",style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.bold, fontSize: 21),),
              MyTextField(tip: "cm", controller: boyController,)
            ],
          ),

          SizedBox(height: 40,),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Age",style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.bold, fontSize: 21),),
              MyTextField(tip: "", controller: yasController,)
            ],
          ),

          SizedBox(height: 40,),

          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Text("Gender",style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.bold, fontSize: 21),),

              MydropDownBtn(
                cinsiyet: selectCinsiyet,
                onPress: (i) {
                  setState(() {
                    selectCinsiyet = i!;
                  });
                
              }),
            ],
          ),

          SizedBox(height: 40,),


          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Text("Activity Level",style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.bold, fontSize: 21),),

              MydropdownBtn_2(
                secilenAktivite: selectAktivite, 
                katsayilar: aktiviteKatsayilari,
                onPress: (i) {
                  setState(() {
                    selectAktivite = i!;
                    print(selectAktivite);
                  });
                }
              ),
            ],
          ),


          SizedBox(height: 40,), 


          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text("Goal",style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.bold, fontSize: 21),),

              MydropDownBtn_3(
                onPress: (i) {
                  setState(() {
                    selectHedef = i!;
                  });
                }, 
                hedef: selectHedef
              )
            ],
          ),


          SizedBox(height: 50,),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)
              ),
              minimumSize: Size(40, 50)
            ),
            onPressed: () {

              if (kiloController.text.isEmpty || boyController.text.isEmpty || yasController.text.isEmpty) {
                print("CALISTI");
                uyariDialogu();
              }
              else {
                print("CALISMADI");
                showCheckDialog();

                ref.read(kilo.notifier).state = double.parse(kiloController.text);
                ref.read(yas.notifier).state = int.parse(yasController.text);
                ref.read(boy.notifier).state = double.parse(boyController.text);
              
                BMR_Hesapla(
                  double.parse(kiloController.text), 
                  double.parse(boyController.text), 
                  int.parse(yasController.text), 
                  selectCinsiyet, 
                  selectHedef, 
                  aktiviteKatsayilari[selectAktivite]!
                );
              }
              
            }, 
            child: Text("Update", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 18),)
          ),


          SizedBox(height: 120,)
      
      
          
        ],
      ),
    );
  }


  BMR_Hesapla (double kilo, double boy, int yas, String cinsiyet, String hedefim, double aktiviteKatsayisii) {

    var erkek_BMR = 0.0;
    var kadin_BMR = 0.0;
    var kaloriSonucu = 0;

    if (cinsiyet == "Man") {
      erkek_BMR = (10 * kilo) + (6.25 * boy) - (5 * yas) + 5; 
      var TDEE = erkek_BMR * aktiviteKatsayisii;
      if (hedefim == "lose weight") {                                                                        
        kaloriSonucu = (TDEE - 400).toInt();
        ref.read(proteinHedefi.notifier).state = ((kaloriSonucu * 0.35) / 4).toInt();                      
        ref.read(carbHedefi.notifier).state = ((kaloriSonucu * 0.40) / 4).toInt();                          
        ref.read(yagHedefi.notifier).state = ((kaloriSonucu * 0.25) / 9).toInt();                          
      }
      else if (hedefim == "gain weight") {
        kaloriSonucu = int.parse((TDEE + 350).toString());
        ref.read(proteinHedefi.notifier).state = ((kaloriSonucu * 0.25) / 4).toInt();
        ref.read(carbHedefi.notifier).state = ((kaloriSonucu * 0.50) / 4).toInt();
        ref.read(yagHedefi.notifier).state = ((kaloriSonucu * 0.25) / 9).toInt();
      }
      else {
        kaloriSonucu = int.parse(TDEE.toString()) ;
        ref.read(proteinHedefi.notifier).state = ((kaloriSonucu * 0.35) / 4).toInt();
        ref.read(carbHedefi.notifier).state = ((kaloriSonucu * 0.40) / 4).toInt();
        ref.read(yagHedefi.notifier).state = ((kaloriSonucu * 0.25) / 9).toInt();
      }
    }

    else if (cinsiyet == "Woman") {
      kadin_BMR = (10 * kilo) + (6.25 * boy) - (5 * yas) + -161;   
      var TDEE = kadin_BMR * aktiviteKatsayisii;
      if (hedefim == "lose weight") {
        kaloriSonucu = (TDEE - 400).toInt();
        ref.read(proteinHedefi.notifier).state = ((kaloriSonucu * 0.35) / 4).toInt();                      
        ref.read(carbHedefi.notifier).state = ((kaloriSonucu * 0.40) / 4).toInt();                          
        ref.read(yagHedefi.notifier).state = ((kaloriSonucu * 0.25) / 9).toInt();
      }     
      else if (hedefim == "gain weight") {
        kaloriSonucu = int.parse((TDEE + 350).toString());
        ref.read(proteinHedefi.notifier).state = ((kaloriSonucu * 0.25) / 4).toInt();
        ref.read(carbHedefi.notifier).state = ((kaloriSonucu * 0.50) / 4).toInt();
        ref.read(yagHedefi.notifier).state = ((kaloriSonucu * 0.25) / 9).toInt();
      }  
      else {
        kaloriSonucu = int.parse(TDEE.toString()) ;
        ref.read(proteinHedefi.notifier).state = ((kaloriSonucu * 0.35) / 4).toInt();
        ref.read(carbHedefi.notifier).state = ((kaloriSonucu * 0.40) / 4).toInt();
        ref.read(yagHedefi.notifier).state = ((kaloriSonucu * 0.25) / 9).toInt();
      }
    }



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
            
                Text("Information Updated", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),)
            
              ],
            ),
          ),
        );
      }
    );
  }


  uyariDialogu () {
    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          content: Text("Weight, height or age cannot be blank", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),),
          actions: [
            TextButton(onPressed: () {
              Navigator.of(context).pop();
            }, child: Text("OK", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),))
          ],
        );
      }
    );
  }


}



class KisiselBilgiler extends ConsumerWidget {
  const KisiselBilgiler({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    var Kilo = ref.watch(kilo);
    var Boy = ref.watch(boy);
    var Yas = ref.watch(yas);

    var Cinsiyet = ref.watch(cinsiyet);
    var Aktiflik = ref.watch(aktiviteDuzeyi);
    var Hedef = ref.watch(hedef);

    return Column(

      children: [

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            KisiselBilgilerContainer(Baslik: "Weight", value: Kilo,),

            KisiselBilgilerContainer(Baslik: "Height", value: Boy,),

            KisiselBilgilerContainer(Baslik: "Age", value: Yas,),


          ],
        ),

        SizedBox(height: 10,),

      ],

    );
  }
}





