import 'package:flutter/material.dart';
import 'package:rehber_project/dao/KisiDAO.dart';
import 'package:rehber_project/sayfa_tasarimlari/Anasayfa.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/kisi.dart';

class KisiDetay extends StatefulWidget { 
 Kisi kisi;
 KisiDetay(this.kisi);

  

  @override
  State<KisiDetay> createState() => _KisiDetayState();
}

class _KisiDetayState extends State<KisiDetay> {
  Future<void> kisiSil(int silID) async {
    await KisiDAO().kisiSil(silID);
    Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => Anasayfa()));
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.kisi.AD), actions: [
        IconButton(onPressed: (){
          kisiSil(widget.kisi.ID);
        }, icon: Icon(Icons.delete))
      ],),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           ClipRRect(borderRadius: BorderRadius.circular(150.0),
           child: FadeInImage.assetNetwork(placeholder: "resimler/image.png", image: widget.kisi.RESIM_URL,fit: BoxFit.cover, width: 300, height: 300,) ,
           ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.kisi.AD,style: TextStyle(fontSize: 20),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.kisi.SOYAD,style: TextStyle(fontSize: 20)),
            ),
            Text(widget.kisi.TELEFON_NUMARASI,style: TextStyle(fontSize: 18,
            fontWeight: FontWeight.bold)),
            SizedBox(child: ElevatedButton(onPressed: () async {
              final call = Uri.parse('tel:${widget.kisi.TELEFON_NUMARASI}');
              if (await canLaunchUrl(call)) {
            launchUrl(call);
              }else{
            throw 'Could not launch $call';
              }
            }, child:Text("Ara"))),
            
          ],
        ),
      ),
    
    );
  }
}