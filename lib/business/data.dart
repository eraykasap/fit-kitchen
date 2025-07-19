
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fit_food_app/business/provider.dart';
import 'package:fit_food_app/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';




class DataKontrol {

  



  
  Future<void> kategorijsonOku (WidgetRef ref) async {

    print("OKUNDU");

    var response = await Dio().get("https://rpklstlvxpgezqpaynbq.supabase.co/storage/v1/object/public/jsondosyalarim/kategoriler/kategori.json");
                                    
    print("GELEN VERİ ${response.data}");

    try {
      if (response.statusCode == 200) {
        ref.read(kategoriListesiProvider.notifier).state = (response.data as List).map((e) => KategoriModel.fromMap(e)).toList();
        print("OKUNAN VERİ ${ref.read(kategoriListesiProvider)}");
      }
    } on DioException catch (e) {
      Future.error("HATA MESAJI ${e.message.toString()}");
    }
  }


  Future<void> tarifJsonOku (String tarifLink, WidgetRef ref, String fileName) async {

    /* final directory = await getApplicationDocumentsDirectory();
    final file = File("${directory.path}/$fileName.json");

    if (await file.exists()) {

      print("BOYLR BİR DOSYA VAR");

      final jsonString = await file.readAsString();
      var jsonObject = jsonDecode(jsonString);
      ref.read(tarifListesiProvider.notifier).state = (jsonObject as List).map((e) => TarifModel.fromMap(e)).toList();
    }
    else {

      print("DOSYA MEVCUT DEĞİL");
      var response = await Dio().get(tarifLink);
      try {
        if (response.statusCode == 200) {
          ref.read(tarifListesiProvider.notifier).state = (response.data as List).map((e) => TarifModel.fromMap(e)).toList();

          final jsonString = jsonEncode(response.data);
          await file.writeAsString(jsonString);
        }
      } on DioException catch (e) {
        Future.error("HATA MESAJI ${e.message.toString()}");
      }
    } */

   var response = await Dio().get(tarifLink);
      try {
        if (response.statusCode == 200) {
          ref.read(tarifListesiProvider.notifier).state = (response.data as List).map((e) => TarifModel.fromMap(e)).toList();

          final jsonString = jsonEncode(response.data);
          //await file.writeAsString(jsonString);
        }
      } on DioException catch (e) {
        Future.error("HATA MESAJI ${e.message.toString()}");
      }
    
  }


  Future<void> kaloriyeGoreKategoriJsonOku (WidgetRef ref) async {

    var response = await Dio().get("https://rpklstlvxpgezqpaynbq.supabase.co/storage/v1/object/public/jsondosyalarim/kaloriye_gore_kategori/kalori_kategori.json");

    try {
      if (response.statusCode == 200) {
        ref.read(kaloriyeGoreKategoriList.notifier).state = (response.data as List).map((e) => KategoriModel.fromMap(e)).toList();
      }
    } on DioException catch (e) {
      Future.error("HATA MESAJI ${e.message.toString()}");
    }
  }


  Future<void> favorileriKaydet(WidgetRef ref) async {
    print("FAVORİ LİSTESİNİ KAYDETME CALISTI");

    final dir = await getApplicationDocumentsDirectory();
    

    final favoriMap = <String, StateProvider<List<TarifModel>>>{
      "kahvalti": kahvaltiListProvider,
      "ogle": ogleListProvider,
      "aksam": aksamListProvider,
      "ara": araListProvider,
    };

    for (var entry in favoriMap.entries) {
      var kategoriAdi = entry.key;
      var provider = entry.value;

      final jsonList = ref.read(provider).map((e) => e.TariftoMap()).toList();
      final jsonString = jsonEncode(jsonList);

      final file = File("${dir.path}/$kategoriAdi.json");
      await file.writeAsString(jsonString);

      print("$kategoriAdi.json dosyası kaydedildi.");

    }
  
  }


  Future<void> favoriListesiniGetir (WidgetRef ref) async {

    print("FAVORİ LİSTESİNİ GETİRME CALISTI");

    final dir = await getApplicationDocumentsDirectory();

    final favoriMap = <String, StateProvider<List<TarifModel>>>{
      "kahvalti": kahvaltiListProvider,
      "ogle": ogleListProvider,
      "aksam": aksamListProvider,
      "ara": araListProvider,
    };

    for (var entry in favoriMap.entries) {
      var kategoriAdi = entry.key;
      var provider = entry.value;

      final file = File("${dir.path}/$kategoriAdi.json");

      if (await file.exists()) {
        final josnString = await file.readAsString();

        try {
          final List<dynamic> jsonList = jsonDecode(josnString);
          final tarifListesi = jsonList.map((e) =>TarifModel.fromMap(e)).toList();

          ref.read(provider.notifier).state = tarifListesi;
          print("Yüklendi: $kategoriAdi (${tarifListesi.length} adet tarif)");
        } catch (e) {
          print("Hata oluştu $kategoriAdi dosyasında: $e");
        }
      }
      else {
        print("$kategoriAdi.json dosyası bulunamadı.");
      }
    }

  }


  
  Future<void> hedefVeAlinanMacroKaydet (WidgetRef ref) async {

    print("KAYDETME CALISTI");

    final prefs = await SharedPreferences.getInstance();

    var proteinHedefMacro = ref.read(proteinHedefi.notifier).state;
    var carbHedefiMacro = ref.read(carbHedefi.notifier).state;
    var yagHedefiMacro = ref.read(yagHedefi.notifier).state;

    var alinanProteinMacro = ref.read(alinanProtein.notifier).state;
    print("ALINAN PROTEGIN : $alinanProteinMacro");
    var alinanCarbMacro = ref.read(alinanCarb.notifier).state;
    var alinanYagMacro = ref.read(alinanYag.notifier).state;

    var Kilo = ref.read(kilo);
    var Boy = ref.read(boy);
    var Yas = ref.read(yas);
    var Cinsiyet = ref.read(cinsiyet);
    var Aktiflik = ref.read(aktiviteDuzeyi);
    var Hedef = ref.read(hedef);

    await prefs.setInt("hedefProtein", proteinHedefMacro);
    await prefs.setInt("hedefCarb", carbHedefiMacro);
    await prefs.setInt("hedefYag", yagHedefiMacro);

    await prefs.setInt("alinanProtein", alinanProteinMacro);
    await prefs.setInt("alinanCarb", alinanCarbMacro);
    await prefs.setInt("alinanYag", alinanYagMacro);

    await prefs.setDouble("kilo", Kilo);
    await prefs.setDouble("boy", Boy);
    await prefs.setInt("yas", Yas);
    await prefs.setString("cinsiyet", Cinsiyet);
    await prefs.setDouble("aktiflik", Aktiflik);
    await prefs.setString("hedef", Hedef);




    ThemeMode mode = ref.read(themeModeProvider.notifier).state;
    await prefs.setString("themeMode", mode.toString());

  }


  Future<void> hedefVeAlinanMacroGetir (WidgetRef ref) async {
    
    print("GETİRME CALISTI");

    final prefs = await SharedPreferences.getInstance();

    ref.read(proteinHedefi.notifier).state = prefs.getInt("hedefProtein") ?? 0;
    ref.read(carbHedefi.notifier).state = prefs.getInt("hedefCarb") ?? 0;
    ref.read(yagHedefi.notifier).state = prefs.getInt("hedefYag") ?? 0;

    ref.read(alinanProtein.notifier).state = prefs.getInt("alinanProtein") ?? 0;
    ref.read(alinanCarb.notifier).state = prefs.getInt("alinanCarb") ?? 0;
    ref.read(alinanYag.notifier).state = prefs.getInt("alinanYag") ?? 0;

    ref.read(kilo.notifier).state = prefs.getDouble("kilo") ?? 0;
    ref.read(boy.notifier).state = prefs.getDouble("boy") ?? 0;
    ref.read(yas.notifier).state = prefs.getInt("yas") ?? 0;
    ref.read(cinsiyet.notifier).state = prefs.getString("cinsiyet") ?? "kadın";
    ref.read(aktiviteDuzeyi.notifier).state = prefs.getDouble("aktiflik") ?? 0;
    ref.read(hedef.notifier).state = prefs.getString("hedef") ?? "zayıflamak";




    final themeStr = prefs.getString("themeMode") == "ThemeMode.light" ? ThemeMode.light : ThemeMode.dark;
    ref.read(themeModeProvider.notifier).state = themeStr;

  }



  Future<void> abonelikontrol (WidgetRef ref) async {

    //await Purchases.invalidateCustomerInfoCache();

    CustomerInfo info = await Purchases.getCustomerInfo();
    bool aktifmi = info.entitlements.all["myabonelik"]?.isActive ?? false;

    print("ABONELİK : $aktifmi");

    ref.read(isProProvider.notifier).state = aktifmi;
  }


  Future<void> mealListeKaydet (WidgetRef ref) async {

    
    final dir = await getApplicationDocumentsDirectory();

    final jsonList = ref.read(mealListProvider).map((e) => e.mealToMap()).toList();
    final jsonString = jsonEncode(jsonList);

    final file = File("${dir.path}/mealList.json");
    await file.writeAsString(jsonString);

    print("mealList : json dosyası kaydedildi");

  }


  Future<void> mealListeGetir (WidgetRef ref) async {

    
    final dir = await getApplicationDocumentsDirectory();

    final file = File("${dir.path}/mealList.json");

    if (await file.exists()) {
      final jsonString = await file.readAsString();
      if (jsonString.isNotEmpty) {
        final List<dynamic> jsonList = jsonDecode(jsonString);
        final mealListesi = jsonList.map((e) => MealModel.fromMap(e)).toList();
        ref.read(mealListProvider.notifier).state = mealListesi;
      }
      
    }

  }


  Future<bool> getAndCheckVersion (WidgetRef ref) async {

    String currentVersion = "";
    String latestVersion = "";
    bool version;
    

    final response = await Dio().get("https://rpklstlvxpgezqpaynbq.supabase.co/storage/v1/object/public/jsondosyalarim/version/version.json");
    if (response.statusCode == 200) {
      
      latestVersion = response.data["version"];

      print("SON SURUM : $latestVersion");
    }
    else {
      throw Exception("VERSİYON ALINAMADI");
    }
    


    final info = await PackageInfo.fromPlatform();
    currentVersion = info.version;
    

    if (currentVersion != latestVersion) {
      version = false;
    }
    else {
      version = true;
    }

    return ref.read(versionProvider.notifier).state = version;

  }


}


