import 'package:flutter/material.dart';

class AverageCalculator extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _AverageCalculatorState();
}

class _AverageCalculatorState extends State<AverageCalculator>{
  String name = "";
  String email = "";
  String grades = "";
  String average = "";

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  List<TextEditingController> gradesTextEditingController = [TextEditingController(), TextEditingController(), TextEditingController()];
  TextEditingController averageTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext buildContext){
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Calculadora de Média",
          style: TextStyle(
            color: Colors.white
          )
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _titleField("Calculadora de Média"),
              _textField("Nome", "Digite o seu nome (ex: Carlos)", textEditingController: nameTextEditingController),
              _textField("Email", "Digite o seu email (ex: carlos@email.com)", textEditingController: emailTextEditingController),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _textField("Nota 1", "Digite a nota 1 (ex: 10.0)", textInputType: TextInputType.number, expanded:  true, textEditingController: gradesTextEditingController[0]),
                  _textField("Nota 2", "Digite a nota 2 (ex: 10.0)", textInputType: TextInputType.number, expanded: true, textEditingController: gradesTextEditingController[1]),
                  _textField("Nota 3", "Digite a nota 3 (ex: 10.0)", textInputType: TextInputType.number, expanded: true, lastField: true, textEditingController: gradesTextEditingController[2]),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _button("Calcular", (){
                    setState(() {
                      name = nameTextEditingController.text;
                      email = emailTextEditingController.text;
                      grades = "${gradesTextEditingController[0].text} - ${gradesTextEditingController[1].text} - ${gradesTextEditingController[2].text}";
                      average = _calculateAverage(gradesTextEditingController.map((gradeTextField) => double.parse(gradeTextField.text)).toList()).toStringAsFixed(1);
                    });
                  }),
                  _button("Limpar", (){
                    setState(() {
                      name = "";
                      email = "";
                      grades = "";
                      average = "";
                      nameTextEditingController.text = "";
                      emailTextEditingController.text = "";
                      for(var i = 0; i < gradesTextEditingController.length; i++){
                        gradesTextEditingController[i].text = "";
                      }
                      averageTextEditingController.text = "";
                    });
                  },
                  backgroudColor: Colors.red),
                ],
              ),
              _titleField("Resultado:"),
              _resultField("Nome: ", value: name),
              _resultField("Email: ", value: email),
              _resultField("Notas: ", value: grades),
              _resultField("Média: ", value: average),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textField(String labelText, String hintText, {TextInputType textInputType = TextInputType.text, bool expanded = false, bool lastField = false, TextEditingController? textEditingController}) {
      var container = Container(
        margin: (!lastField && !expanded) ? EdgeInsets.only(bottom: 10.0) : (!lastField && expanded) ? EdgeInsets.only(right: 10.0) : null,
        child: TextField(
          controller: textEditingController,
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            floatingLabelStyle: TextStyle(color: Colors.blue),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.blue)
            ),
          ),
          keyboardType: textInputType,
        )
      );
      return (!expanded) ? container : Expanded(child: container,);
  }

  Widget _button(String text, void Function() onPressed, {MaterialColor backgroudColor = Colors.blue}){
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroudColor
            ),
            child: Text(
              text,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      )
    );
  }

  Widget _titleField(String title){
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child:  Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  Widget _resultField(String label, {String value = ""}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(label),
        Text(
          value,
          style: TextStyle(fontWeight: FontWeight.bold,)
        )
      ],
    );
  }

  double _calculateAverage(List<double> grades){
    return grades.reduce((sum, grade) => sum + grade) / grades.length;
  }
}