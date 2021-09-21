import 'package:flutter/material.dart';
void main(){
  runApp(MaterialApp(debugShowCheckedModeBanner: false,
      title:"SI CALCULATOR",
      theme: ThemeData(
        accentColor: Colors.yellowAccent,
            primaryColor: Colors.indigo,
          textSelectionTheme: TextSelectionThemeData(cursorColor:Colors.red ) ,
        brightness: Brightness.dark

      ),
       home: SIcalc()));
}
class SIcalc extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SIcalc();
  }
}
class _SIcalc extends State<SIcalc>{
  var _formKey = GlobalKey<FormState>();
  var _curr = ["USD","CAD","DHR","INR","PND","EUR"];
  String _currd = "USD";
  TextEditingController pController = TextEditingController();
  TextEditingController rController = TextEditingController();
  TextEditingController tController = TextEditingController();
  String dispmsg = '';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    TextStyle? textStyle= Theme.of(context).textTheme.headline6;
    return Scaffold(
        appBar: AppBar(
          title:Text("SIMPLE INTEREST CALCULATOR",
            style: textStyle,) ,
          centerTitle: true ,
          shadowColor: Colors.red,
          elevation:10.0,
          backgroundColor: Colors.indigo,
        ),
      body: Form(
        key: _formKey,
        child: Container(
          child: ListView(
            children: [
           get_image(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (String? _value){
                    if(_value!.isEmpty)
                    return err('Principle Amount');

                  },
                  style: textStyle,
                  controller: pController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      errorStyle: TextStyle(fontSize: 15.0,
                          color: Colors.blue
                      ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7.0)
                    ),
                    hintText: 'Enter principal amount. Eg-12000',
                    labelText: 'PRINCIPLE AMOUNT',
                    

                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: textStyle,
                  controller: rController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  validator: (String? _value){
                    if(_value!.isEmpty)
                      return err('RATE OF INTEREST');

                  },
                  decoration: InputDecoration(
                      errorStyle: TextStyle(
                        fontSize: 15.0,
                          color: Colors.blue
                      ),
                      border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0)
                        ),
                      hintText: 'Enter the rate of interest.Eg 15%',
                      labelText: 'RATE OF INTEREST'

                  ),
                ),
              ),
              Row(
                children: [
                       Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          style: textStyle,
                          controller: tController,
                          validator: (String? _value){
                            if(_value!.isEmpty)
                              return 'RATE OF INTEREST';

                          },
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7.0)
                              ),
                            //helperText: 'PRINCIPLE AMOUNT',
                              hintText: 'Enter time period',
                              labelText: 'TIME',
                            errorStyle: TextStyle(
                                fontSize: 15.0,
                                color: Colors.blue
                            ),

                          ),
                        ),
                      ),
                    ),
                 // ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 5.0),
                      padding: EdgeInsets.all(8.0),
                      child: DropdownButton(items: _curr.map((String curritem){
                        return DropdownMenuItem(child: Text(curritem),
                            value: curritem);
                      }).toList(),
                        onChanged: (String? newVal){
                          setState(() {
                            if(newVal!.isEmpty)
                                print('EMPTY VALUE');
                            this._currd=newVal;
                          }
                          );
                        },
                        value: _currd,),
                    )
                  ),
                ],
              ),
              Container(
                child: Row(children: [
                  Expanded(
                      child: Padding(
                          padding:EdgeInsets.only(left: 10.0,right: 10.0),
                          child: ElevatedButton(
                              onPressed: (){
                                setState(() {
                                  if(_formKey.currentState!.validate())
                                  this.dispmsg=calculateResult();
                                });
                              },
                              child: Text("CALCULATE",
                              style: textStyle,),
                            style: ElevatedButton.styleFrom(
                          primary: Colors.indigoAccent,
                          ),
                          )
                      )
                  ),
                  Expanded(
                      child: Padding(
                          padding:EdgeInsets.only(left: 10.0,right: 10.0),
                          child: ElevatedButton(
                              onPressed: (){
                                setState(() {
                                  resetFunc();
                                });
                              },
                              child: Text("RESET"
                              ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.grey,
                            ),

                          )
                      )
                  ),

                ],
                ),
              ),
              Container(child:Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(this.dispmsg)))

            ],
          ),
        ),
      ),
    );
  }
  String calculateResult(){
    double principal = double.parse(pController.text);
    double roi = double.parse(rController.text);
    double time = double.parse(tController.text);
    double si = principal+(principal*roi*time)/100;
    String Result= "After $roi years, the amount will be $si $_currd";
    return Result;
  }
  void resetFunc(){
    pController.text='';
    tController.text='';
    rController.text='';
    _currd=_curr[0];
    dispmsg='';
  }
  String err(String er){
    return 'Please enter valid $er';
  }
}
Widget get_image(){
  AssetImage img= AssetImage('images/img.png');
  Image image=Image(image: img,
    alignment: Alignment.center,
  height: 260.0,
  width: 260.0,);
  return Container(
    child: image,
  );
}
