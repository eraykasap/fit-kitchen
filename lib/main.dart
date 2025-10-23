import 'dart:io';

import 'package:fit_food_app/business/provider.dart';
import 'package:fit_food_app/pages/favori_page.dart';
import 'package:fit_food_app/pages/home_page.dart';
import 'package:fit_food_app/pages/pro_plan_page.dart';
import 'package:fit_food_app/theme.dart';
import 'package:fit_food_app/widgets/sabit_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {

  MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    print("KÖK TETİKLENDİ");
    final currentMode = ref.watch(themeModeProvider);
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      themeMode: currentMode,
      theme: lightTheme,
      darkTheme: darkTheme,

      home: const Navigation()
    ); 
  }
}



class Navigation extends ConsumerStatefulWidget {
  const Navigation({super.key});

  @override
  ConsumerState<Navigation> createState() => _NavigationState();
}

class _NavigationState extends ConsumerState<Navigation> with WidgetsBindingObserver {

  int selecteIndex = 0;
  bool? version;

  late HomePage homePage;
  late ProPlanPage proPlanPage;
  late FavoriPage favoriPage;
  late List<Widget> allPages;

  @override
  void initState() {
    print("NAVİGATİON İNİT TETIKLENDİ");
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    ref.read(dataControlProvider).kategorijsonOku(ref);
    ref.read(dataControlProvider).kaloriyeGoreKategoriJsonOku(ref);

    ref.read(dataControlProvider).favoriListesiniGetir(ref);

    ref.read(dataControlProvider).hedefVeAlinanMacroGetir(ref);

    favoriPage = FavoriPage();
    homePage = HomePage();
    proPlanPage = ProPlanPage();
    allPages = [homePage, proPlanPage, favoriPage];

    initializeRevenueCat();

    ref.read(dataControlProvider).abonelikontrol(ref);

    
    ref.read(dataControlProvider).mealListeGetir(ref);

    ref.read(dataControlProvider).getAndCheckVersion(ref);
    
  }

  

  


  Future<void> initializeRevenueCat() async {
    final apiKey = Platform.isAndroid
        ? 'goog_TGUnOCYiqLGGgOjjXzxnWQnJkVf' // <- Buraya Android anahtarını yaz
        : 'appl_TSQJbFRzILbATuUYZyEZZpoqrEu';    // <- Buraya iOS anahtarını yaz

    await Purchases.configure(PurchasesConfiguration(apiKey));
    
  }



  @override
  void dispose() {
    
    super.dispose();

    WidgetsBinding.instance.removeObserver(this);
  }



  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.inactive || state == AppLifecycleState.paused) {

      ref.read(dataControlProvider).favorileriKaydet(ref);

      ref.read(dataControlProvider).hedefVeAlinanMacroKaydet(ref);

      ref.read(dataControlProvider).mealListeKaydet(ref);
    }

  }




  @override
  Widget build(BuildContext context) {

    //bool isPremium = ref.watch(isProProvider);

    print("NAVİGATİON TETIKLENDİ");

    if (ref.watch(versionProvider) == false) {
      WidgetsBinding.instance.addPostFrameCallback((_){
        versionUyarisi(context);
      });
      return Scaffold();
    }
    else if (ref.watch(versionProvider) == null) {
      return Center(child: CircularProgressIndicator());
    }
    else {
      return Scaffold(
      
      body: Stack(
        children: [

          MyContainerDesign(),

          allPages[selecteIndex],
        ],
      ),
      bottomNavigationBar: bottomNavBar(
        selecteIndex, 
        
        (index) {
          setState(() {
            if (index != 1) {
              selecteIndex = index;
            }
            else {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProPlanPage()));
            }
          });
        },
        context,
        ref
      ),
    );
    }


    
  }


   versionUyarisi (BuildContext context) {
    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          title: Text("A new version of this app is available", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),),

          actions: [

            TextButton(onPressed: () async {
              final url_android = Uri.parse("https://play.google.com/store/apps/details?id=com.fit_food_app");
              final url_ios = Uri.parse("https://apps.apple.com/us/app/fit-kitchen/id6749202685");
              if (Platform.isAndroid) {
                await launchUrl(url_android, mode: LaunchMode.externalApplication);
              }
              else {
                await launchUrl(url_ios, mode: LaunchMode.externalApplication);
              }
              
            }, child: Text("Ok"))
          ],
        );
      }
    );
  }

}



Widget bottomNavBar (int selectionItem, Function(int) onSelect, BuildContext context, WidgetRef ref) {

  bool issub = false;
  bool proMu = ref.watch(isProProvider);

  return Container(
    decoration: BoxDecoration(
      
      boxShadow: [
        BoxShadow(
          color: Theme.of(context).colorScheme.shadow,
          blurRadius: 30,
          offset: Offset(0, 0)
        )
      ]
    ),
    child: BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home,), label: "Home"),

        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(bottom: 23),
            child: Column(
              children: [
                Image.asset(proMu == true ? "assets/icons/crown1.png" : "assets/icons/crown2.png", width: 45, height: 45,),
                
                SizedBox(height: 3,),
                Text("Pro", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),)
              ],
            ), 
          ),
          label: ""
        ),

        BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: "Saved"),
      ],
      currentIndex: selectionItem,
      onTap: (value) {
        onSelect(value);
      },
      backgroundColor: Theme.of(context).colorScheme.onTertiary,
    ),
  );
}











