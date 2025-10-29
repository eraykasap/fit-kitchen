import 'dart:io';

import 'package:fit_food_app/business/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ProPlanPage extends ConsumerStatefulWidget {
  const ProPlanPage({super.key});

  @override
  ConsumerState<ProPlanPage> createState() => _ProPlanPageState();
}

class _ProPlanPageState extends ConsumerState<ProPlanPage> {

  bool isPro = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //initializeRevenueCat();
  }

  /* Future<void> initializeRevenueCat() async {
    final apiKey = Platform.isAndroid
        ? 'goog_TGUnOCYiqLGGgOjjXzxnWQnJkVf' // <- Buraya Android anahtarını yaz
        : 'YOUR_REVENUECAT_IOS_API_KEY';    // <- Buraya iOS anahtarını yaz

    await Purchases.configure(PurchasesConfiguration(apiKey));
    kontrolEtProAktifMi();
  } */

  /* Future<void> kontrolEtProAktifMi() async {
    CustomerInfo info = await Purchases.getCustomerInfo();
    bool aktifMi = info.entitlements.all["myabonelik"]?.isActive ?? false;
    print("AKTIFMI PRO ABONE : $aktifMi");

    setState(() {
      isPro = aktifMi;
    });
  } */

  Future<void> satinAlProPlanAndroid() async {
    try {
      Offerings offerings = await Purchases.getOfferings();
      Offering? proplan = offerings.getOffering("myabonelik");

      

      if (proplan != null && proplan.availablePackages.isNotEmpty) {
        Package paket = proplan.availablePackages.first;

        CustomerInfo info = await Purchases.purchasePackage(paket);

        bool aktifMi = info.entitlements.all["myabonelik"]?.isActive ?? false;
        print("UYELIK AKTIF OLDUMU : $aktifMi");

        ref.read(isProProvider.notifier).state = aktifMi;

        /* if (aktifMi) {
          setState(() {
            isPro = true;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("🎉 Pro Plan aktif!")),
          );
        } */
      
      } else {
        print("proplan bulunamadı.");
      }
    } catch (e) {
      print("Satın alma hatası: $e");
    }
  }

  Future<void> satinAlProPlanIos () async {

    try {
      Offerings offerings = await Purchases.getOfferings();
      Offering? proplan = offerings.getOffering("pro_monthly");

      if (proplan != null && proplan.availablePackages.isNotEmpty) {

        Package paket = proplan.availablePackages.first;
        CustomerInfo info = await Purchases.purchasePackage(paket);
        bool aktifMi = info.entitlements.all["pro-month"]?.isActive ?? false;
        print("UYELIK AKTIF OLDUMU : $aktifMi");
        ref.read(isProProvider.notifier).state = aktifMi;

      }
      else {
        print("proplan bulunamadı.");
      }

    } catch (e) {
      print("Satın alma hatası: $e");
    }
  } 






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        width: double.maxFinite,

        child: Column(
          children: [

            Stack(

              children: [

                Container(
                  width: double.maxFinite,
                  
                  child: Stack(
                    children: [
                      Image.asset(
                        "assets/icons/premium_photo.jpg",
                        width: double.infinity,
                        height: 380,
                        fit: BoxFit.cover,
                      ),
                      Align(
                        //alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 380, // Gölgenin yüksekliği
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black, // Alt kısım koyu
                                Colors.transparent, // Üst kısım saydam
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 15, top: 40),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Icon(Icons.arrow_back, size: 30),
                  ),
                ),
              
              ],
            ),
          
            Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                
                children: [
                  
                  TextSpan(
                    text: "Go Premium\n", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)
                  ),

                  

                  TextSpan(
                    text: "No commitment. Cancel anytime.", style: TextStyle(color: Colors.white, fontSize: 18)
                  ),

                  
                ] 
              )
            ),

            SizedBox(height: 30,),

            Expanded(
              child: Container(
                //color: Colors.amber,
                
                child: Column(
                  children: [

                    SizedBox(height: 40,),
                
                    Padding(
                      padding: const EdgeInsets.only(left: 55, right: 55),
                      child: Container(
                        //width: 250,
                        
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white, width: 2)
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            //textBaseline: TextBaseline.alphabetic,
                            children: [
                          
                              Text("•", style: TextStyle(color: Colors.green, fontSize: 65),),
                          
                              SizedBox(width: 10,),
                          
                              Padding(
                                padding: EdgeInsets.only(bottom: 2),
                                child: Text("Premium Recipes", style: TextStyle(color: Colors.white, fontSize: 18),),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                
                    SizedBox(height: 15,),
                
                
                    /* Padding(
                      padding: const EdgeInsets.only(left: 55, right: 55),
                      child: Container(
                        //width: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white, width: 2)
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            //textBaseline: TextBaseline.alphabetic,
                            children: [
                          
                              Text("•", style: TextStyle(color: Colors.green, fontSize: 65),),
                          
                              SizedBox(width: 10,),
                          
                              Padding(
                                padding: EdgeInsets.only(bottom: 2),
                                child: Text("Calorie Tracking", style: TextStyle(color: Colors.white, fontSize: 18),),
                              )
                            ],
                          ),
                        ),
                      ),
                    ), */
                
                    Spacer(),
                
                    
              
                    //! ELEVATED BUTTON SUB
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: SizedBox(
                        height: 50,
                        width: 300,
                        child: ElevatedButton(onPressed: () {
                          if (ref.read(isProProvider) == false) {
                            if (Platform.isAndroid) {

                              satinAlProPlanAndroid();
                            }
                            else {
                              satinAlProPlanIos();
                            }
                            
                            //showMesaj("FALSE");
                          }
                          else {
                            showMesaj("you are already subscribed");
                          }
                          
                        }, child: Text("Subscribe / \$5,99", style: TextStyle(fontSize: 21),))
                      ),
                    ),

                    Center(
                      child: SizedBox(
                        width: 350,
                        child: Center(
                          child: Text(
                            "The subscription will be renewed every month.",
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ),
                      )
                    ),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        TextButton(onPressed: () async {

                          final url = Uri.parse("https://sites.google.com/view/gravitydash/ana-sayfa");
                          await launchUrl(url, mode: LaunchMode.externalNonBrowserApplication);

                        }, child: Text("Privacy Policy", style: TextStyle(color: Colors.white),)),

                        SizedBox(width: 25,),

                        TextButton(onPressed: () async {

                          final url = Uri.parse("https://www.apple.com/legal/internet-services/itunes/dev/stdeula/");
                          await launchUrl(url, mode: LaunchMode.externalNonBrowserApplication);

                        }, child: Text("User License Agreement", style: TextStyle(color: Colors.white),)),

                      ],
                    ),

                    SizedBox(
                      height: 30,
                    )

                
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );

  }

  showMesaj (String mesaj) {
    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: Text("$mesaj"),

          actions: [
            TextButton(onPressed: () {
              Navigator.of(context).pop();
            }, child: Text("OK"))
          ],
        );
      }
    );
  }

}
