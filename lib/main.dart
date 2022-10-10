
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Şifreleme Algoritması'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var tfControl= TextEditingController();
  String metin='';

  Future<void> Sifreleme() async{
   var asciiList= metin.codeUnits;

   var reverse =asciiList.reversed;
   String bos="";

   const liste="abcdefghijklmnoprstuvyz";
   Random rnd=Random();
   String getRandomString(int length) =>
       String.fromCharCodes(Iterable.generate(length, (_) => liste.codeUnitAt(rnd.nextInt(liste.length))));

   for(var don in reverse){
     var random= getRandomString(1);  //rastgele 1 harf ekleme işlemi
     var deger=don.toString(); //her bir elemanın yanına rastgele harf ekleyip birleştirdim.
     bos=bos + deger+random;
   }

   sifrelenmis =bos;

  }

  Future<void> SifreCoz() async{
    var cozumList=<int>[];
    var ilk=tfControl.text;
    var words = ilk.split(RegExp(r"(?<=[a-z])"));
    for(var i in words){
      var sonuc=(i.substring(0, i.length - 1));
      var cozum=int.parse(sonuc);
      cozumList.add(cozum);
    }
    var reverse=cozumList.reversed;
    var cozum= String.fromCharCodes(reverse);
    cozumlenmis=cozum;

  }
  String cozumlenmis='';
  String sifrelenmis='';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width *0.9,
                child: TextField(
                  onChanged: (value){
                    setState((){
                      metin = value;
                    });
                  },
                  controller: tfControl,
                  style: const TextStyle(
                    fontSize: 20
                  ),
                  decoration: InputDecoration(
                    hintText: "Şifrelemek istediğiniz yazıyı giriniz:",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    )
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.lock),
                      Text("Şifrele",style: TextStyle(
                          fontSize: 20))
                    ],
                  ),
                  onPressed:(){
                    setState(() {
                      tfControl.text="";
                      Sifreleme();
                    });
                  },
                ),
              ), //Buton

              const SizedBox(
                height: 30,
              ),
          SizedBox(
          width: 200,
          height: 50,
          child: ElevatedButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.remove_red_eye),
                Text("Şifreyi Göster",style: TextStyle(
                    fontSize: 20))
              ],
            ),
            onPressed:(){
              setState(() {
                tfControl.text=sifrelenmis;
              });
            },
          ),
          ),
              const SizedBox(
                height: 30,
              ),

              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.lock_open),
                      Text("Şifreyi çöz", style: TextStyle(
                        fontSize: 20
                      ),)
                    ],
                  ),
                  onPressed:(){
                    setState(() {
                      SifreCoz();
                      tfControl.text="";
                    });
                    showDialog(
                        context: context,
                        builder: (BuildContext context){
                        return AlertDialog(
                          title: const Text("Şifreniz"),
                          content: Text(cozumlenmis),
                          actions: [
                            TextButton(
                              child: const Text("Tamam"),
                              onPressed:(){
                                setState(() {
                                  Navigator.pop(context);

                                });
                              },
                            )
                          ],
                        );
                    });
                  }
                ),
              ), // // Buton
            ],
          ),
        ),
      ),

    );
  }
}

