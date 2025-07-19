
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class detayPage extends StatelessWidget {

  final String image;
  final String title;
  final List<String> besinDegerleri;
  final List<String> malzemeler;
  final List<String> talimatlar;

  const detayPage({
    super.key,
    required this.image,
    required this.title,
    required this.besinDegerleri,
    required this.malzemeler,
    required this.talimatlar
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:[ 

          Container(
            color: Theme.of(context).colorScheme.primaryContainer,
            width: double.maxFinite,
            height: double.maxFinite,
          ),
          
          Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            SizedBox(height: 50),
        
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Container(
                //color: Colors.amber,
                child: IconButton(onPressed: () {
                  Navigator.of(context).pop();
                }, icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onPrimary, size: 29,)),
              ),
            ),
        
        
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                
                    Image(image: image, besinDegerleri: besinDegerleri,),
                
                    Malzemeler(baslik: title, malzemeler: malzemeler,),
        
                    Talimatlar(talimatlar: talimatlar)
                
                  ],
                ),
              ),
            )
        
          ],
        ),]
      ),
    );
  }
}




class Image extends StatelessWidget {

  final String image;
  final List<String> besinDegerleri;

  const Image({
    super.key,
    required this.image,
    required this.besinDegerleri
  });

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [

        Container(
          height: MediaQuery.of(context).size.height * 0.3,
          width: double.maxFinite,
      
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: image,
            placeholder: (context, url) => Center(
              child: SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(color: Colors.green,),
              ),
            ),
            errorWidget: (context, url, error) => Icon(Icons.broken_image),
          ),
        ),


        Container(
          //color: Colors.amber,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: besinDegerleri.length,
              itemBuilder: (context, index) {
                var item = besinDegerleri[index];
                return Align(
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
                );
              }
            ),
          ),
        ),

      ],
    );
  }
}




class Malzemeler extends StatelessWidget {

  final String baslik;
  final List<String> malzemeler;

  const Malzemeler({
    super.key,
    required this.baslik,
    required this.malzemeler
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            //color: Colors.amber,
            width: double.maxFinite,
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.green, width: 2))
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Center(child: Text(baslik, style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.bold, fontSize: 18),)),
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.green, width: 2)),
            ),
            child: Column(
              children: [
          
                SizedBox(height: 15,),
          
                Text("Ingredients", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.bold, fontSize: 18),),
          
                SizedBox(height: 15,),
          
                Container(
                  width: double.maxFinite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: malzemeler.map((item) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 3),
                        child: Text("• $item", style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onPrimary)),
                      );
                    }).toList(),
                  ),
                ),
          
                SizedBox(height: 10,),
          
              ],
            ),
          ),
        ),

        SizedBox(height: 20,)

      ],
    );
  }
}



class Talimatlar extends StatelessWidget {

  final List<String> talimatlar;

  const Talimatlar({
    super.key,
    required this.talimatlar
    });

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.green, width: 2))
            ),
            child: Column(
              children: [
          
                SizedBox(height: 15,),
          
                Text("Instructions", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.bold, fontSize: 18),),
          
                SizedBox(height: 15,),
          
                Container(
                  width: double.maxFinite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: talimatlar.map((item) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 3),
                        child: Text("• $item", style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onPrimary)),
                      );
                    }).toList(),
                  ),
                ),
          
                SizedBox(height: 10,),
        
              ],
            ),
          ),
        ),

        SizedBox(height: 50,)
      ],
    );
  }
}



