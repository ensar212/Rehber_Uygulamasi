import '../db/DatabaseHelper.dart';
import '../model/kisi.dart';


class KisiDAO {
  
  Future<List<Kisi>> tumKisiler() async {
    var db = await VeritabaniYardimcisi.databaseErisim();
    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * from kisiler");
    
    return List.generate(maps.length, (index){

    var satir = maps[index];
    var id = satir["ID"];
    var ad = satir["AD"];
    var soyad = satir["SOYAD"];
    var telefon_numarasi = satir["TELEFON_NUMARASI"];
    var resim_url = satir["RESIM_URL"];

    return Kisi(id, ad, soyad, telefon_numarasi, resim_url);
    });
  }
  
  Future<List<Kisi>> kisiAra(String aranacakKisi) async {
    var db = await VeritabaniYardimcisi.databaseErisim();
    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * from kisiler WHERE AD LIKE '%$aranacakKisi%' or SOYAD LIKE '%$aranacakKisi%'");

    return List.generate(maps.length, (index){

    var satir = maps[index];
    var id = satir["ID"];
    var ad = satir["AD"];
    var soyad = satir["SOYAD"];
    var telefon_numarasi = satir["TELEFON_NUMARASI"];
    var resim_url = satir["RESIM_URL"];

    return Kisi(id, ad, soyad, telefon_numarasi, resim_url);
    });
  }

  Future<void> kisiEkle(Kisi kisiNesnesi) async{
    var db = await VeritabaniYardimcisi.databaseErisim();
    db.rawInsert("INSERT INTO kisiler(AD, SOYAD, TELEFON_NUMARASI, RESIM_URL) VALUES(?,?,?,?)",
    [kisiNesnesi.AD, kisiNesnesi.SOYAD, kisiNesnesi.TELEFON_NUMARASI, kisiNesnesi.RESIM_URL]
    );
    
  }

  Future<void> kisiSil(int silID) async {
    var db = await VeritabaniYardimcisi.databaseErisim();
    await db.rawQuery("DELETE FROM kisiler WHERE ID =$silID");
  }

}