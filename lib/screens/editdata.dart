import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import './constant.dart';

//edit page
class EditData extends StatefulWidget {
  final List list;
  final int index;

  EditData({required this.list, required this.index});

  @override
  _EditDataState createState() => new _EditDataState();
}

class _EditDataState extends State<EditData> {

  TextEditingController? controllerCode;
  TextEditingController? controllerName;
  TextEditingController? controllerPrice;
  TextEditingController? controllerStock;


  void editData() {
    var url="${Constant.url}/editdata.php";
    http.post(Uri.parse(url),body: {
      "id": widget.list[widget.index]['id'],
      "itemcode": controllerCode!.text,
      "itemname": controllerName!.text,
      "price": controllerPrice!.text,
      "stock": controllerStock!.text
    });
  }


  @override
  void initState() {
    controllerCode= new TextEditingController(text: widget.list[widget.index]['item_code'] );
    controllerName= new TextEditingController(text: widget.list[widget.index]['item_name'] );
    controllerPrice= new TextEditingController(text: widget.list[widget.index]['price'] );
    controllerStock= new TextEditingController(text: widget.list[widget.index]['stock'] );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("EDIT DATA"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            new Column(
              children: <Widget>[
                new TextField(
                  keyboardType: TextInputType.number,
                  controller: controllerCode,
                  decoration: new InputDecoration(
                      hintText: "Item Code", labelText: "Item Code"),
                ),
                new TextField(
                  controller: controllerName,
                  decoration: new InputDecoration(
                      hintText: "Item Name", labelText: "Item Name"),
                ),
                new TextField(
                  keyboardType: TextInputType.number,
                  controller: controllerPrice,
                  decoration: new InputDecoration(
                      hintText: "Price", labelText: "Price"),
                ),
                new TextField(
                  keyboardType: TextInputType.number,
                  controller: controllerStock,
                  decoration: new InputDecoration(
                      hintText: "Stock", labelText: "Stock"),
                ),
                new Padding(
                  padding: const EdgeInsets.all(10.0),
                ),

                new ElevatedButton(
                  child: new Text("EDIT DATA", style: TextStyle(color: Colors.white),),
                  //color: Colors.blueAccent,
                  onPressed: () {
                    editData();
                    Navigator.of(context).push(
                        new MaterialPageRoute(
                            builder: (BuildContext context)=>new MyApp()
                        )
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}