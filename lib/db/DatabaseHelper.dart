import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class VeritabaniYardimcisi {

static final String databaseName = "rehber.sqlite";
static Future<Database> databaseErisim() async {
  String databaseYolu = join(await getDatabasesPath(), databaseName);
  if(await databaseExists(databaseYolu)){
    print("DB zaten telefon hafızasında var, kopyalamaya gerek yok!");
  } else {
    ByteData data = await rootBundle.load("veritabani_dosya/$databaseName");
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(databaseYolu).writeAsBytes(bytes, flush: true);
    print("DB telefona kopyalandı. Artık kullanabilirsin");
  }
  return openDatabase(databaseYolu);
}  
}