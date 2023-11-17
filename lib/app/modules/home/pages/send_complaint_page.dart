import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sentinela/app/core/ui/colors.dart';
import 'package:sentinela/app/modules/home/states/send_complaint_state.dart';
import 'package:sentinela/app/modules/home/store/send_complaint_store.dart';

class SendComplaintPage extends StatefulWidget {
  final SendComplaintStore store;
  const SendComplaintPage({super.key, required this.store});

  @override
  State<SendComplaintPage> createState() => _SendComplaintPageState();
}

class _SendComplaintPageState extends State<SendComplaintPage> {
  List<bool> selectedGps = <bool>[true, false];
  final formKey = GlobalKey<FormState>();
  final _titleEC = TextEditingController();
  final _addressEC = TextEditingController();
  final _descriptionEC = TextEditingController();

  List<String> dropdownItems = ['Opção 1', 'Opção 2', 'Opção 3'];
  String selectedDropdownItem = 'Opção 1';
  late File _imageFile = File('');
  List<Widget> icons = <Widget>[
    const Icon(Icons.location_on),
    const Icon(Icons.location_off),
  ];

  Future<void> getImage() async {
    File imageFile = await widget.store.getImage();
    setState(() {
      _imageFile = imageFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.maybeSizeOf(context)!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Envie sua Denúncia'),
      ),
      body: ValueListenableBuilder(
        valueListenable: widget.store.sendComplaintState,
        builder: (context, value, child) {
          return switch (value) {
            SendComplaintInitialState() => SingleChildScrollView(
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
                          switch (_imageFile.path.isEmpty) {
                            true => CircleAvatar(
                                radius: 50,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      tileMode: TileMode.clamp,
                                      colors: [
                                        Colors.black.withOpacity(0.5),
                                        Colors.black.withOpacity(0.0),
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      stops: const [0.0, 0.8],
                                    ),
                                  ),
                                  child: IconButton(
                                    icon: const Icon(Icons.camera_alt),
                                    onPressed: () async => getImage(),
                                  ),
                                )),
                            false => GestureDetector(
                                onTap: () async => await getImage(),
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage: FileImage(_imageFile),
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                        tileMode: TileMode.clamp,
                                        colors: [
                                          Colors.black.withOpacity(0.5),
                                          Colors.black.withOpacity(0.0),
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        stops: const [0.0, 0.8],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          },
                          const SizedBox(height: 16),
                          const Text('Enviar Agora Sua Denuncia'),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _titleEC,
                            decoration: const InputDecoration(
                              labelText: 'Titulo',
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextField(
                            maxLines: null,
                            minLines: 3,
                            controller: _descriptionEC,
                            keyboardType: TextInputType.multiline,
                            decoration: const InputDecoration(
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
                              hint: const Text(
                                  'Selecione uma Categoria de Denuncia'),
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
                                setState(() {
                                  selectedDropdownItem = value!;
                                });
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
                                child: TextFormField(
                                  controller: _addressEC,
                                  enabled: selectedGps[1] == true,
                                  decoration: const InputDecoration(
                                    labelText: 'Insira um Endereço com Cep',
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
                                  for (int i = 0; i < selectedGps.length; i++) {
                                    selectedGps[i] = i == index;
                                  }
                                  setState(() {});
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
                            onPressed: () async {
                              await widget.store.sendComplaint(
                                  _titleEC.text,
                                  _descriptionEC.text,
                                  selectedGps[0],
                                  _addressEC.text);
                            },
                            child: const Text('Enviar'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            SendComplaintLoadingState() => const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            SendComplaintSendState() => Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Denuncia Enviada com Sucesso"),
                      ElevatedButton(
                          onPressed: () => Modular.to.pop(),
                          child:
                              const Text("Voltar para a Pagina de Denúncias"))
                    ],
                  ),
                ),
              ),
            SendComplaintErrorState() => Center(
                child: Column(
                  children: [
                    Text(value.e.message),
                    ElevatedButton(
                        onPressed: () => Modular.to.pop(),
                        child: const Text("Voltar para a Pagina de Denúncias"))
                  ],
                ),
              )
          };
        },
      ),
    );
  }
}
