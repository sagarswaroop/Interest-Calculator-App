import "package:flutter/material.dart";

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Intrest Calculator",
    home: SICalc(),
    theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent),
  ));
}

class SICalc extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SICalcSate();
  }
}

class _SICalcSate extends State<SICalc> {
  var _formPadding = 5.0;
  var _currencies = ["Rupees", "Dollars", "Ponds", "other"];
  var _defaultValue = "";
  @override
  void initState() {
    super.initState();
    _defaultValue = _currencies[0];
  }

  TextEditingController principal = TextEditingController();
  TextEditingController roi = TextEditingController();
  TextEditingController term = TextEditingController();

  var _displayResult = "";

  @override
  Widget build(BuildContext context) {
    // theme.of(context): inherit the closest property.
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Simple Intrest Calculator"),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            getImage(),
            Padding(
                padding: EdgeInsets.all(_formPadding),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: principal,
                  decoration: InputDecoration(
                      labelText: 'Prinicipal',
                      hintText: 'Enter Principal e.g. 1200',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                )),
            Padding(
              padding: EdgeInsets.all(_formPadding),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: roi,
                decoration: InputDecoration(
                    labelText: 'Rate of Intrest',
                    hintText: 'Enter in Percentage',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
                padding: EdgeInsets.all(_formPadding),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: TextField(
                      keyboardType: TextInputType.phone,
                      controller: term,
                      decoration: InputDecoration(
                          labelText: 'Term',
                          hintText: 'Time in Years',
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),
                    Padding(
                      padding: EdgeInsets.all(_formPadding),
                    ),
                    Expanded(
                      child: DropdownButton<String>(
                        items: _currencies.map((String currency) {
                          return DropdownMenuItem<String>(
                            value: currency,
                            child: Text(
                              currency,
                              style: textStyle,
                            ),
                          );
                        }).toList(),
                        value: _defaultValue,
                        onChanged: (String value) {
                          setState(() {
                            this._defaultValue = value;
                          });
                        },
                      ),
                    ),
                  ],
                )),
            Padding(
              padding: EdgeInsets.all(_formPadding),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).accentColor,
                      textColor: Theme.of(context).primaryColorDark,
                      child: Text(
                        "Calculate",
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          _displayResult = _getResult();
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        "Reset",
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          _resetAllFileds();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(_formPadding),
              child: Text('$_displayResult'),
            )
          ],
        ),
      ),
    );
  }

  Widget getImage() {
    AssetImage assestImage = AssetImage('images/money.png');
    Image image = Image(
      image: assestImage,
      width: 200,
      height: 200,
    );
    return Container(
      margin: EdgeInsets.all(50.0),
      child: image,
    );
  }

  String _getResult() {
    double principalAmount = double.parse(principal.text);
    double reateOfIntrest = double.parse(roi.text);
    double terms = double.parse(term.text);
    double amount =
        principalAmount + (principalAmount * reateOfIntrest / terms) / 100;
    return 'After $terms years, your investment will be worth $amount $_defaultValue';
  }

  void _resetAllFileds() {
    principal.text = "";
    roi.text = "";
    term.text = "";
    _displayResult = "";
    _defaultValue = _currencies[0];
  }
}
