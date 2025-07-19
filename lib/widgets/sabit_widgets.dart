

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fit_food_app/business/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as paintingBinding;
import 'package:flutter_riverpod/flutter_riverpod.dart';


class kategoriContainer extends StatelessWidget {

  final String title;
  final String image;

  const kategoriContainer({
    super.key,
    required this.title,
    required this.image
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
      child: Container(

        width: 170,

        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Theme.of(context).colorScheme.outline, width: 2)
        ),
      
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: CachedNetworkImage(
                imageUrl: image,
                placeholder: (context, url) => CircularProgressIndicator(color: Colors.green,),
                errorWidget: (context, url, error) => Icon(Icons.broken_image),
              ),
            ),

            SizedBox(height: 15,),
            
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10,),
              child: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onPrimary), textAlign: TextAlign.center,),
            )
          ],
        ),
      ),
    );
  }
}



class TarifContainer extends ConsumerStatefulWidget {

  
  final String image;
  final String title;
  final bool isPro;
  final bool proUye;
  final bool isSave;
  final List<String> besinDegerleri;
 
  final void Function(bool, String?) onFavoritePressed;

  const TarifContainer({
    super.key, 
    
    required this.image, 
    required this.title,
    required this.isPro,
    required this.proUye,
    required this.isSave,
    required this.besinDegerleri,
    
    required this.onFavoritePressed
  });

  @override
  ConsumerState<TarifContainer> createState() => _TarifContainerState();
}

class _TarifContainerState extends ConsumerState<TarifContainer> {

  //final bool? proUye = ; 

  late bool isSaveTop;

  String? selectedValue;

  String? secondarySeectedValue;

  List<String> options = ['My Breakfasts', 'My Lunches', 'My Dinners', 'My Snacks'];

  @override
  void initState() {
    super.initState();
    isSaveTop = widget.isSave;
  }

  /* @override
  void didUpdateWidget(covariant TarifContainer oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (oldWidget.image != widget.image) {
      _clearImageCache(widget.image);
    }
  }

  Future<void> _clearImageCache(String url) async {
    // 1) Disk cache’i temizle
    await CachedNetworkImage.evictFromCache(url);
    // 2) Bellek cache’ini temizle (isteğe bağlı, Image.network kullanıyorsan mutlaka)
    PaintingBinding.instance.imageCache.clear();
    // 3) Ekranı yeniden çiz
    setState(() {});
  } */

  

  @override
  Widget build(BuildContext context) {

    //_clearCache();

    var proUye = ref.watch(isProProvider);
    
    print("TARŞFCONTAİNER TETIKLENDI");

    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 45),
      child: Container(

        height: 280,
        width: 220,

        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Theme.of(context).colorScheme.outline, width: 2)
        ),

        

        child: Column(
          children: [

            Stack(
              children: [

                //! RESSİM
                Container(
                  height: 200,
                  width: double.maxFinite,
                  //color: Colors.purple,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: CachedNetworkImage(
                      imageUrl: widget.image,
                      placeholder: (context, url) => Center(
                        child: SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(color: Colors.green,)
                          )
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.broken_image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),


                //! BESİN DEGERLERİ
                SizedBox(
                  height: 195,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                    var item = widget.besinDegerleri[0];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Center(
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(5, 0, 0, 10),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24)
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                child: Text(item, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                
                
                //! KAYDET İCON
                Container(
                  //color: Colors.red,
                  child: Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Row(
                      children: [
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: GestureDetector(
                            onTap: () async {
                              if (isSaveTop == false) {
                                showBottomSheet(context);
                              }
                              else {
                                final sonuc = await uyariDialogu(context);
                                if (sonuc == true) {
                                    setState(() {
                                    isSaveTop = !isSaveTop;
                                    widget.onFavoritePressed(isSaveTop, selectedValue);
                                  });
                                }
                                
                              }
                            },
                            
                            child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.green
                            ),
                            child: Icon(isSaveTop ? Icons.bookmark : Icons.bookmark_border, color: Colors.white, size: 30,),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //! PRO ETİKETİ
                Visibility(
                  visible: widget.isPro == true && proUye == false ? true : false,
                  child: Transform.translate(
                    offset: Offset(15, 15),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(24)
                      ),
                      width: 33,
                      height: 20,
                      
                      child: Center(child: Text("Pro", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 27,),

            Text(widget.title, style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.bold),)
          ],
        ),
       
      ),
    );
  }


  /* Future<void> _clearCache() async {
    await CachedNetworkImage.evictFromCache(widget.image);
    paintingBinding.imageCache.clear();
    setState(() {});
  } */


  Future<bool?> uyariDialogu (BuildContext context) async {

    return showDialog<bool>(
      
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          content: Text("Are you sure you want to delete from favorites?", style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onPrimary),),

          actions: [
            TextButton(onPressed: () {
              Navigator.of(context).pop(true);
              snacBarMessage(false);
            }, child: Text("Yes", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),)),

            TextButton(onPressed: () {
              Navigator.of(context).pop(false);
            }, child: Text("No", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),)),
          ],
        );
      }
    );
  }


  void showBottomSheet (BuildContext context) {
    showModalBottomSheet(context: context, builder: (BuildContext contex) {
      return StatefulBuilder(builder: (BuildContext context, StateSetter setModal) {
        return Container(
          height: 400,
          color: Theme.of(context).colorScheme.onSecondary,
          child: Column(
            children: [
          
              SizedBox(height: 25,),
          
              Column(
                children: options.map((options) {
          
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      decoration: BoxDecoration(
                        color: selectedValue == options ? Colors.green : Colors.transparent,
                        borderRadius: BorderRadius.circular(14)
                      ),
                    
                      child: RadioListTile(
                        activeColor: Colors.white,
                        
                        title: Text(options, style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),),
                        value: options, 
                        groupValue: selectedValue, 
                        onChanged: (String? value) {
                          setModal(() {
                            selectedValue = value;
                            secondarySeectedValue = value;
                          });
                        }
                      ),
                    ),
                  );
                }).toList(),
              ),
          
              SizedBox(height: 50,),
          
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(onPressed: () {
                      if (selectedValue != null) {
                        setState(() {
                          isSaveTop = !isSaveTop;
                          widget.onFavoritePressed(isSaveTop, selectedValue);
                          print(isSaveTop);
                          snacBarMessage(isSaveTop);
                          //selectedValue = null;
                        });
                        Navigator.of(context).pop();
                      }
                      else {
                        print("HATA LUTFEN BIR SECENEK SECINIZ");
                      }
                      
                    }, 
                    child: Text("Add", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),),
                    
                  ),
                ),
              )
            ],
          ),
        );
      });
    });
  }



  snacBarMessage (bool isSave) {

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: isSave == true ? Colors.green : Colors.red,
        content: isSave == true ? Text("added to favorite list",style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),) : Text("favori listesinden Cıkartıldı",style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),),
        duration: Duration(seconds: 1),
      )
    );

  }

}





class MyProgressIndicator extends ConsumerWidget {


  final double yukseklik;
  final double genislik;
  final double fontSize_1;
  final double fontSize_2;

  MyProgressIndicator({
    super.key,
    required this.yukseklik,
    required this.genislik,
    required this.fontSize_1,
    required this.fontSize_2
  });


  final double oran = 0.6;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final hedefkalori = ref.watch(kaloriHedefi);
    final alinankalori = ref.watch(alinanKalori);

    var hedefprotein = ref.watch(proteinHedefi);
    var alinanprotein = ref.watch(mealListProvider).fold(0, (sum, meal) => sum + meal.proteinGR); //ref.watch(alinanProtein);

    var hedefcarb = ref.watch(carbHedefi);
    var alinancarb = ref.watch(mealListProvider).fold(0, (sum, meal) => sum + meal.karbGR); //ref.watch(alinanCarb);

    var hedefyag = ref.watch(yagHedefi);
    var alinanyag = ref.watch(mealListProvider).fold(0, (sum, meal) => sum + meal.fatGR); //ref.watch(alinanYag);

    var alinanToplamKalori = (alinanprotein * 4) + (alinancarb * 4) + (alinanyag * 9);
    var toplamHedefKalori = (hedefprotein * 4) + (hedefcarb * 4) + (hedefyag * 9);

    

    final double oran = alinanToplamKalori / toplamHedefKalori;

    return Stack(
      alignment: Alignment.center,
      children: [
    
        SizedBox(
          width: genislik,
          height: yukseklik,
          child: CircularProgressIndicator(
            value: oran.clamp(0.0, 1.0),
            backgroundColor: Colors.grey.withAlpha(80),
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            strokeWidth: 15,
            strokeCap: StrokeCap.round,
          ),
        ),


        Container(
          //width: 100,
          //height: 100,
          //color: Colors.blue,
          child: Center(
            child: Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                
                children: [

                  TextSpan(
                    text: "${toplamHedefKalori - alinanToplamKalori}\n", style: TextStyle(fontSize: fontSize_1, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onPrimary),
                  ),

                  TextSpan(
                    text: "Calories", style: TextStyle(fontSize: fontSize_2, color: Theme.of(context).colorScheme.onPrimary)
                  )
                ]
              )
            )
          )
        )
    
    
        
      ],
    );
  }
}


class MyProgressIndicator_2 extends ConsumerWidget {


  final double yukseklik;
  final double genislik;
  final String iconAssetName;
  final double iconScale;
  final double strokewitdh;
  final int hedefMacro;
  final int alinanMacro;
  

  MyProgressIndicator_2({
    super.key,
    required this.yukseklik,
    required this.genislik,
    required this.iconAssetName,
    required this.iconScale,
    required this.strokewitdh,
    required this.hedefMacro,
    required this.alinanMacro
  });


  

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    
    final double oran = alinanMacro / hedefMacro;

    return Stack(
      alignment: Alignment.center,
      children: [
    
        SizedBox(
          width: genislik,
          height: yukseklik,
          child: CircularProgressIndicator(
            value: oran.clamp(0.0, 1.0),
            backgroundColor: Colors.grey.withAlpha(80),
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            strokeWidth: strokewitdh,
            strokeCap: StrokeCap.round,
          ),
        ),


        Container(
          //width: 100,
          //height: 100,
          //color: Colors.blue,
          child: Center(
            child: Image.asset("assets/icons/$iconAssetName", scale: iconScale,)
          )
        )
    
    
        
      ],
    );
  }
}


class MyContainerDesign extends StatelessWidget {
  MyContainerDesign({super.key});

  

  @override
  Widget build(BuildContext context) {

    var mycolorScheme = Theme.of(context).colorScheme.onPrimaryFixed;
    var mycolorSchem2 = Theme.of(context).colorScheme.onSecondaryFixed;
    
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            mycolorScheme,
            mycolorSchem2
          ],
        ),
      )
    );
  }
}



class MacroContainer extends StatelessWidget {

  final String iconAssetName;
  final String macroname;
  final int hedefMacro;
  final int alinanMacro;

  const MacroContainer({
    super.key,
    required this.iconAssetName,
    required this.macroname,
    required this.alinanMacro,
    required this.hedefMacro
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 122,
      height: 180,
      
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

      child: Column(
        children: [

          SizedBox(height: 10,),

          Text.rich(
            TextSpan(
              children: [

                TextSpan(
                  text: "${alinanMacro > hedefMacro ? hedefMacro : alinanMacro}/", style: TextStyle(fontSize: 25, color: Theme.of(context).colorScheme.onPrimary)
                ),

                TextSpan(
                  text: "$hedefMacro\n", style: TextStyle(fontSize: 17, color: Theme.of(context).colorScheme.onPrimary)
                ),

                TextSpan(
                  text: macroname, style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)
                )
              ]
            )
          ),

          SizedBox(height: 20,),

          MyProgressIndicator_2(
            yukseklik: 80, 
            genislik: 80, 
            iconAssetName: iconAssetName, 
            iconScale: 20, 
            strokewitdh: 10,
            hedefMacro: hedefMacro,
            alinanMacro: alinanMacro,
            
          )


        ],
      ),


    );
  }
}



class MyTextField extends StatelessWidget {

  final String tip;
  final TextEditingController controller;

  const MyTextField({
    super.key,
    required this.tip,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: 250,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.numberWithOptions(),
        cursorColor: Colors.green,
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).colorScheme.primaryContainer,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Color.fromRGBO(168, 172, 179, 1), width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.green, width: 2)
          ),
          suffix: Text(tip, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 21),)
        ),
        
      ),
    );
  }
}



class MydropDownBtn extends StatelessWidget {

  final Function(String?) onPress;
  final String cinsiyet;

  const MydropDownBtn({
    super.key,
    required this.onPress,
    required this.cinsiyet
  });

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: 150,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          border: Border.all(color: Theme.of(context).colorScheme.outline, width: 2),
          borderRadius: BorderRadius.circular(16)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
          child: DropdownButton<String>(
            isExpanded: true,
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 21),
            value: cinsiyet,
            items: ["Man", "Woman"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: onPress,
            underline: Container(),
          ),
        ),
      ),
    );
  }
}



class MydropdownBtn_2 extends StatelessWidget {

  final String secilenAktivite;
  final Function(String?) onPress;
  final Map<String, dynamic> katsayilar;

  const MydropdownBtn_2({
    super.key,
    required this.secilenAktivite,
    required this.onPress,
    required this.katsayilar
  });

  @override
  Widget build(BuildContext context) {

    

    return SizedBox(
      width: 200,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          border: Border.all(color: Theme.of(context).colorScheme.outline, width: 2),
          borderRadius: BorderRadius.circular(16)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
          child: DropdownButton<String>(
            isExpanded: true,
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 21),
            value: secilenAktivite,
            items: katsayilar.keys.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: onPress,
            underline: Container(),
          ),
        ),
      ),
    );
  }
}



class MydropDownBtn_3 extends StatelessWidget {

  final Function(String?) onPress;
  final String hedef;

  const MydropDownBtn_3({
    super.key,
    required this.onPress,
    required this.hedef
  });

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: 250,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          border: Border.all(color: Theme.of(context).colorScheme.outline, width: 2),
          borderRadius: BorderRadius.circular(16)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
          child: DropdownButton<String>(
            isExpanded: true,
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 21),
            value: hedef,
            items: ["lose weight", "maintain weight", "gain weight"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: onPress,
            underline: Container(),
          ),
        ),
      ),
    );
  }
}



class MacroGuncelleContainer extends StatelessWidget {

  final String iconImage;
  final String macroName;
  final String macroGram; 


  const MacroGuncelleContainer({
    super.key,
    required this.iconImage,
    required this.macroName,
    required this.macroGram
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 250,
      height: 100,
      
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).colorScheme.outline, width: 2)
      ),
    
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        
        
        children: [
    
          Image.asset("assets/icons/$iconImage.png", width: 45, height: 45,),
    
          Flexible(child: SizedBox(width: 30,)),
    
          Text.rich(
            TextSpan(
              children: [
    
                TextSpan(
                  text: "$macroName\n",
                  style: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.bold)
                ),
    
                TextSpan(
                  text: "${macroGram}g",
                  style: TextStyle(fontSize: 18, color: Theme.of(context).colorScheme.onPrimary)
                ),
    
              ] 
            )
          ),
    
          Flexible(child: SizedBox(width: 30,)),
    
    
          Icon(Icons.edit)
    
    
        ],
      ),
    
    );
  }
}


class KisiselBilgilerContainer extends StatelessWidget {

  final String Baslik;
  final dynamic value;


  const KisiselBilgilerContainer({
    super.key,
    required this.Baslik,
    required this.value
  });

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: 100,
        height: 100,
        //color: Colors.amber,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).colorScheme.primaryContainer
        ),

        child: Column(
          children: [

            Container(
              width: double.infinity,
              height: 50,
              
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                //color: Colors.green.withAlpha(200),
                border: Border.all(color: Colors.green, width: 2)
              ),

              child: Center(
                child: Text(
                  Baslik, 
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 21,
                    fontWeight: FontWeight.bold
                  ),
                )
              ),

            ),

            SizedBox(height: 10,),

            Text("$value", style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 16

            ),)
          ],
        ),
      ),
    );
  }
}



class MealContainer extends StatefulWidget {

  final String mealName;
  final String protein;
  final String carb;
  final String fat;
  final int saat;
  final int dakika;

  MealContainer({
    super.key,
    required this.mealName,
    required this.protein,
    required this.carb,
    required this.fat,
    required this.saat,
    required this.dakika
  });

  @override
  State<MealContainer> createState() => _MealContainerState();
}

class _MealContainerState extends State<MealContainer> {
  @override
  Widget build(BuildContext context) {

    return Container(
      //width: 100,
      height: 140,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withAlpha(100),
            blurRadius: 7
          )
        ],
      ),

      child: Row(
        children: [

          //! MEAL İCON
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Image.asset("assets/icons/meals2.png", width: 100, height: 100,),
          ),

          //! 
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            
                Text(widget.mealName, style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 18),),
            
                Text.rich(
                  TextSpan(
                    children: [
            
                      TextSpan(
                        text: "${widget.saat} : ${widget.dakika}", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 18)
                      ),
            
                      
                    ]
                  )
                ),
            
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
            
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
            
                        Image.asset("assets/icons/chicken.png", width: 25, height: 25,),

                        SizedBox(width: 2,),
            
                        Text("${widget.protein}g", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 18),)
            
                      ],
                    ),
            
                    SizedBox(width: MediaQuery.of(context).size.width * 0.05),
            
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
            
                        Image.asset("assets/icons/wheat.png", width: 25, height: 25,),

                        SizedBox(width: 2,),
            
                        Text("${widget.carb}g", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 18),)
            
                      ],
                    ),
            
                    SizedBox(width: MediaQuery.of(context).size.width * 0.05),
            
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
            
                        Image.asset("assets/icons/fat.png", width: 25, height: 25,),

                        SizedBox(width: 2,),
            
                        Text("${widget.fat}g", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 18),)
            
                      ],
                    ),
            
                  ],
                ),
            
                
            
                
            
              ],
            ),
          )

        ],
      ),
    );
  }
}
