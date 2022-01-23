import 'package:counter_bloc_example/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<CounterCubit>(
        create: (context) => CounterCubit(),
        child: MyHomePage(title: 'Flutter Bloc Example'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            BlocConsumer<CounterCubit, CounterState>(
              listener: (context, state) {
                if (state.wasIncremented==true){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Incremented'),duration: Duration(milliseconds: 300),));
                }
                else if (state.wasIncremented==false){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Decremented'),duration: Duration(milliseconds: 300),));
                }
              },
              builder: (context, state) {
                if (state.counterValue<0){
                  return Text(
                  'BRR, Negative' + state.counterValue.toString(),
                  style: Theme.of(context).textTheme.headline4,
                );
              
                }
                else if(state.counterValue>0){
                  return Text(
                  'Sup, Positive'+ state.counterValue.toString(),
                  style: Theme.of(context).textTheme.headline4,
                );
                }
                else {
                  return Text(
                  state.counterValue.toString(),
                  style: Theme.of(context).textTheme.headline4,
                );
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: BlocProvider.of<CounterCubit>(context).increment,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: (){
              BlocProvider.of<CounterCubit>(context).decrement();
            },
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
