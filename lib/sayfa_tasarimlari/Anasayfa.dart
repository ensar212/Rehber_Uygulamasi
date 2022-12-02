import 'package:flutter/material.dart';

import '../dao/KisiDAO.dart';
import '../model/kisi.dart';
import 'KisiDetay.dart';
import 'KisiKayit.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  
  Future<List<Kisi>> KisileriListele() async {
    var KisiListesi = await KisiDAO().tumKisiler();
    return KisiListesi;
  }
  Future<List<Kisi>> kisiAra(String aramaMetni) async{
    var aramaSonucuGelenListe = await KisiDAO().kisiAra(aramaMetni);
    return aramaSonucuGelenListe;
  } 

  

  @override
  void initState() {
   super.initState();
   KisileriListele();
  }
  
  bool aramaYapiliyorMu = false;
  String aramaKelimesi = "";
  
 
  @override
  Widget build(BuildContext context) { 
    return  Scaffold(
      appBar: AppBar(
        title: aramaYapiliyorMu ? SizedBox(height: 50,
          child: TextField(
          onChanged: (aramaMetni){
            setState(() {
              aramaKelimesi = aramaMetni;
            });
            print("aranan isim: $aramaMetni");
          },
          style: TextStyle(color: Colors.white),
            decoration: InputDecoration(border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0)), 
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)),),
                hintText: "Ara",
                hintStyle: TextStyle(color: Colors.lightGreen[100], fontSize: 16),
               icon: Icon(Icons.perm_contact_calendar_sharp,color: Colors.lightGreen[100]),
              
              ),
              
          ),
        ) : Text("Rehber", style: TextStyle(color: Colors.lightGreen[100]),),
        actions: [
          IconButton(onPressed: (){
            setState(() {
              aramaYapiliyorMu = !aramaYapiliyorMu;
            });
          }, icon:aramaYapiliyorMu ? Icon(Icons.cancel, color: Colors.lightGreen[100],) : Icon(Icons.search, color: Colors.lightGreen[100],)),
        ],
        ),
        body:Container(
          child: FutureBuilder<List<Kisi>>(
          future: aramaYapiliyorMu ? kisiAra(aramaKelimesi) : KisileriListele(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              var rehberListesi = snapshot.data;
              
              
              return ListView.builder(
                itemCount: rehberListesi!.length,
                itemBuilder: (context, index) {
                  var kisi = rehberListesi[index];
                  return CardKisi(kisi); 
                },
                );
            } else {
              return Center();
            }
          }),
          ),
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder:(context) => KisiKayit()));
        }, 
        child:Icon(Icons.person_add) ,
        ),
    );
  }
}

class CardKisi extends StatelessWidget {
  Kisi kisi;
  CardKisi(this.kisi);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){ 
        Navigator.push(context, MaterialPageRoute(builder:  (context) => KisiDetay(kisi)));
      },
      
      child: Card(
                    elevation: 1,
                    child:Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Text(kisi.AD,style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                          Text(" ${kisi.SOYAD}",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                  ),
    );
  }
}