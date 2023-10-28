import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sentinela/app/core/ui/colors.dart';

class SendComplaintPage extends StatefulWidget {
  const SendComplaintPage({super.key});

  @override
  State<SendComplaintPage> createState() => _SendComplaintPageState();
}

class _SendComplaintPageState extends State<SendComplaintPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.maybeSizeOf(context)!;
    List<String> dropdownItems = ['Opção 1', 'Opção 2', 'Opção 3'];
    String selectedDropdownItem = 'Opção 1';
    const icons = <Widget>[
      Icon(Icons.location_on),
      Icon(Icons.location_off),
    ];
    final List<bool> selectedGps = <bool>[true, false];
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Denuncia'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
              height: size.height,
              width: size.width,
              child: Form(
                key: formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Enviar Agora Sua Denuncia'),
                      const TextField(
                        decoration: InputDecoration(
                          labelText: 'Titulo',
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const TextField(
                        maxLines: null,
                        minLines: 3,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          constraints: BoxConstraints(maxHeight: 300),
                          labelText: 'Descrição',
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        height: 64,
                        width: size.width,
                        child: DropdownButton<String>(
                          padding: const EdgeInsets.only(left: 8),
                          hint:
                              const Text('Selecione uma Categoria de Denuncia'),
                          items: dropdownItems.map((item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          value: selectedDropdownItem,
                          elevation: 16,
                          underline: Container(
                            height: 2,
                            decoration:
                                BoxDecoration(color: AppColor.greenLight),
                          ),
                          onChanged: (value) {
                            selectedDropdownItem = value!;
                            setState(() {});
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            width: size.width * 0.7,
                            child: TextField(
                              enabled: selectedGps[1] == true ? true : false,
                              decoration: const InputDecoration(
                                labelText: 'Insira o Endereço com Cep',
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          ToggleButtons(
                            direction: Axis.horizontal,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            onPressed: (int index) {
                              setState(() {
                                for (int i = 0; i < selectedGps.length; i++) {
                                  selectedGps[i] = i == index;
                                }
                              });
                            },
                            selectedBorderColor: Colors.blue[700],
                            selectedColor: Colors.white,
                            fillColor: AppColor.green,
                            color: AppColor.greenLight,
                            isSelected: selectedGps,
                            children: icons,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      ElevatedButton(
                          onPressed: () =>
                              Modular.to.pushNamed('/home/send-complaint'),
                          child: const Text('Enviar'))
                    ]),
              )),
        ),
      ),
    );
  }
}
