import 'package:converter_app/bloc/converter_bloc.dart';
import 'package:converter_app/bloc/converter_event.dart';
import 'package:converter_app/bloc/converter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Converter',
    theme: ThemeData(
      primarySwatch: Colors.blueGrey,
    ),
    home: BlocProvider<ConverterBloc>(
      create: (context) => ConverterBloc(),
      child: const MyHomePage(),
    ),
  ));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController kgTextController;
  late TextEditingController poundTextController;
  @override
  void initState() {
    kgTextController = TextEditingController();
    poundTextController = TextEditingController();
    kgTextController.text = "1";
    poundTextController.text = "2.2";
    super.initState();
  }

  @override
  void dispose() {
    kgTextController.dispose();
    poundTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConverterBloc, ConverterState>(
      listener: (context, state) {
        if (state is ConvertedToKgState) {
          kgTextController.text = state.value;
        } else if (state is ConvertedToPoundState) {
          poundTextController.text = state.value;
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Converter"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                TextField(
                  controller: kgTextController,
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    suffixIcon: const Padding(
                      padding: EdgeInsets.only(top: 15, bottom: 15),
                      child: Text("kg"),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: ((state is ConverterInvalidState)
                                ? Colors.red
                                : Colors.blueGrey),
                            style: BorderStyle.solid)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: ((state is ConverterInvalidState)
                                ? const Color.fromARGB(255, 255, 17, 0)
                                : Colors.blueGrey),
                            style: BorderStyle.solid)),
                  ),
                  onChanged: (value) {
                    if (value.isEmpty) {
                      poundTextController.text = "";
                    }

                    // poundTextController.text =
                    //     (double.parse(value) * 2.205).toStringAsFixed(1);
                    context
                        .read<ConverterBloc>()
                        .add(ConvertValueToPoundEvent(convertValue: value));
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                Visibility(
                  visible: (state is ConverterInvalidState),
                  replacement: const SizedBox(height: 16),
                  child: const Center(
                      child: Text(
                    "Kindly Input Only Numbers",
                    style: TextStyle(
                        color: Color.fromARGB(226, 255, 17, 0), fontSize: 16),
                  )),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: poundTextController,
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    suffixIcon: const Padding(
                      padding: EdgeInsets.only(top: 15, bottom: 15),
                      child: Text("lb"),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: ((state is ConverterInvalidState)
                                ? Colors.red
                                : Colors.blueGrey),
                            style: BorderStyle.solid)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: ((state is ConverterInvalidState)
                                ? const Color.fromARGB(255, 255, 17, 0)
                                : Colors.blueGrey),
                            style: BorderStyle.solid)),
                  ),
                  onChanged: (value) {
                    if (value.isEmpty) {
                      kgTextController.text = "";
                    }
                    context
                        .read<ConverterBloc>()
                        .add(ConvertValueToKgEvent(convertValue: value));
                    // kgTextController.text =
                    //     (double.parse(value) / 2.205).toStringAsFixed(1);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
