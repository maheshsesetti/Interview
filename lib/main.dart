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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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

  final formKey = GlobalKey<FormState>();
  final focusNode = FocusNode();
  final controller = TextEditingController();
  List output = [];
  int number = 0;

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void executeCode(int value) {
    for(int i =0; i< value; i++){
     output.add("Number values are enter");
     controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  TextFormField(
                    focusNode: focusNode,
                    controller: controller,
                    keyboardType: TextInputType.number,
                   validator: (value){
                      if(value!.isEmpty){
                        return "Please Enter value";
                      }
                      return null;
                   },
                  ),
                  ElevatedButton(onPressed: () async{
                    debugPrint(controller.text);
                    focusNode.unfocus();
                    if(formKey.currentState!.validate()){
                      setState(() {
                        number = int.tryParse(controller.text) ?? 0;
                      });
                        executeCode(number);
                    }

                  }, child: const Text("Execute"))
                ],
              ),
            ),
            Expanded(
              flex: 4,
                child: output.length == [] || output.isEmpty ?
                const Center(child: Text("No Data Found"),):
                ListView.builder(
                shrinkWrap: true,
                itemCount: output.length,
                itemBuilder: (context,index) {
              return Text("${output[index]} - $index");
            }))
          ],
        ),
      ),

    );
  }
}
