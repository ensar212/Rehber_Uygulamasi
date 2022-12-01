import 'package:flutter/material.dart';
import 'package:rehber_project/sayfa_tasarimlari/Anasayfa.dart';

import '../dao/KisiDAO.dart';
import '../model/kisi.dart';

class KisiKayit extends StatefulWidget {
  const KisiKayit({super.key});

  @override
  State<KisiKayit> createState() => _KisiKayitState();
}

class _KisiKayitState extends State<KisiKayit> {
 
 var tfcName = TextEditingController();
 var tfcSurname = TextEditingController();
 var tfcPhoneNumber = TextEditingController();
 var tfcProfilUrl = TextEditingController();

 Future<void> kisiEkle(Kisi eklenecekKisi) async {
    
    await KisiDAO().kisiEkle(eklenecekKisi);
    Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => Anasayfa()));
    
    
  }
 
  @override
  Widget build(BuildContext context) {
    var ekranBilgisi = MediaQuery.of(context).size;
    final double ekranGenisligi = ekranBilgisi.width;
    final double ekranYuksekligi = ekranBilgisi.height;
    return Scaffold(
      appBar: AppBar(title: Text("Kişi Kayıt")),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              _TfcKisiEkle(tfcName: tfcName, name: "İsim"),
              _TfcKisiEkle(tfcName: tfcSurname, name: "Soyisim"),
              _TfcKisiEkle(tfcName: tfcPhoneNumber, name: "Telefon Numarası"),
              _TfcKisiEkle(tfcName: tfcProfilUrl, name: "Profil Url Adres"),
              SizedBox(width: ekranGenisligi/1.2,
              child: ElevatedButton(onPressed: (){
                var ad = tfcName.text.toString().trim();
                var soyad = tfcSurname.text.toString().trim();
                var numara = tfcPhoneNumber.text.toString().trim();
                var url = tfcProfilUrl.text.toString().trim();
      
                Kisi kisi = Kisi(0, ad, soyad, numara, url);
                kisiEkle(kisi);
                
              }, child: Text("Kaydet"))),
      
            ],
          ),
        ),
      ),
    );
  }
}

class _TfcKisiEkle extends StatelessWidget {
  const _TfcKisiEkle({Key? key,required this.tfcName, required this.name}) : super(key: key);

  final TextEditingController tfcName;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
       controller: tfcName,
       decoration: InputDecoration(
        hintText: name,
        hintStyle: TextStyle(fontWeight: FontWeight.normal, fontStyle: FontStyle.italic),
        border:OutlineInputBorder(), 
       ),
       style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }
}