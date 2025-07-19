// ignore_for_file: public_member_api_docs, sort_constructors_first


class KategoriModel {
  
  final String image;
  final String title;
  final String veri_url;

  KategoriModel({required this.image, required this.title, required this.veri_url});

  factory KategoriModel.fromMap(Map<String, dynamic> json) => KategoriModel(
    image: json["image"], 
    title: json["baslik"],
    veri_url: json["tarif_url"],
  );

  @override
  String toString() {
    
    return "Kategori : $title, Ressim : $image";
  }
}




class TarifModel {
  
  final String image;
  final int id;
  final String title;
  final bool isPro;
  final List<String> malzemeler;
  final List<String> talimatlar;
  final List<String> besinDegerleri;

  TarifModel({required this.image, required this.id, required this.title, required this.isPro, required this.malzemeler, required this.talimatlar, required this.besinDegerleri});


  factory TarifModel.fromMap(Map<String, dynamic> json) => TarifModel(
    image: json["image"], 
    id : json["id"],
    title: json["baslik"], 
    isPro: json["pro"] == true,
    malzemeler: List<String>.from(json["malzemeler"] ?? []), 
    talimatlar: List<String>.from(json["talimatlar"] ?? []),
    besinDegerleri: List<String>.from(json["besin degerleri"] ?? [])
  );


  Map<String, dynamic> TariftoMap() => {
    "image" : image,
    "id" : id,
    "baslik" : title,
    "pro" : isPro,
    "malzemeler" : malzemeler,
    "talimatlar" : talimatlar,
    "besin degerleri" : besinDegerleri
  };


  @override
  String toString() {
    // TODO: implement toString
    return "baslık : $title -  id : $id  -  malzemeler : $malzemeler";
  }
}






class MealModel {
  
  final String mealName;
  final int proteinGR;
  final int karbGR;
  final int fatGR;
  final int saat;
  final int dakika;

  MealModel({
    required this.mealName,
    required this.proteinGR,
    required this.karbGR,
    required this.fatGR,
    required this.saat,
    required this.dakika
  });


  factory MealModel.fromMap (Map<dynamic, dynamic> json) => MealModel(
    mealName : json["mealname"], 
    proteinGR : json["proteingr"], 
    karbGR : json["karbgr"], 
    fatGR : json["fatgr"],
    saat : json["saat"] ?? 0,
    dakika : json["dakika"] ?? 0 
  );


  Map<String, dynamic> mealToMap () => {
    "mealname" : mealName,
    "proteingr" : proteinGR,
    "karbgr" : karbGR,
    "fatgr" : fatGR,
    "saat" : saat,
    "dakika" : dakika
  };

  
  
}


