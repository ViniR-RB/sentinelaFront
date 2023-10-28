import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/ui/colors.dart';

class OnBoardPage extends StatefulWidget {
  const OnBoardPage({super.key});

  @override
  State<OnBoardPage> createState() => _OnBoardPageState();
}

class _OnBoardPageState extends State<OnBoardPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.maybeSizeOf(context)!;
    PageController controller = PageController(initialPage: 0);
    int curr = 0;
    void goToPage(int page) {
      controller.animateToPage(page,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    }

    List<Widget> pages = <Widget>[
      DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fitWidth,
            image: AssetImage('assets/images/background/1.jpg'),
          ),
        ),
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Ajude o Planeta Denunciando',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColor.green,
                      fontSize: 24,
                      letterSpacing: 1,
                      height: 2),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Assim você ajuda você colabora com a sua Comunidade e com a Sociedade',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColor.grey, fontSize: 14, letterSpacing: 0.1),
                ),
                const SizedBox(
                  height: 8,
                ),
                ElevatedButton(
                  onPressed: () {
                    goToPage(1);
                  },
                  child: const Text('Veja Mais'),
                ),
                TextButton(
                    onPressed: () => goToPage(2),
                    child: const Text('Ir Para o Final'))
              ],
            ),
          ),
        ),
      ),
      DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fitWidth,
            image: AssetImage('assets/images/background/1.jpg'),
          ),
        ),
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  flex: 1,
                  child: Text(
                    'Tire uma foto e envie sua Denuncia',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColor.green, fontSize: 24, letterSpacing: 1),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Flexible(
                  flex: 1,
                  child: Text.rich(
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColor.grey, fontSize: 14, letterSpacing: 0.1),
                    const TextSpan(
                      children: [
                        TextSpan(
                            text:
                                'Assim Você ajuda a indetificar problemas como: '),
                        TextSpan(
                          text: 'Lixo,Desmatamento e Queimadas',
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Flexible(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      goToPage(2);
                    },
                    child: const Text('Continuar'),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: TextButton(
                    onPressed: () => goToPage(2),
                    child: const Text('Ir Para o Final'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fitWidth,
            image: AssetImage('assets/images/background/1.jpg'),
          ),
        ),
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Text(
                    'Rápido,Fácil e Anônimo',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColor.green,
                        fontSize: 24,
                        letterSpacing: 1,
                        height: 2),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Flexible(
                  child: Text(
                    'Com Apenas uma Foto, você já pode começar a mudar o Mundo',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColor.grey, fontSize: 14, letterSpacing: 0.1),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Flexible(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () => Modular.to.pushReplacementNamed('/home'),
                    child: const Text('Continuar'),
                  ),
                ),
                const SizedBox(height: 52)
              ],
            ),
          ),
        ),
      ),
    ];

    return Scaffold(
      body: PageView(
        scrollDirection: Axis.horizontal,
        controller: controller,
        physics: const BouncingScrollPhysics(),
        children: pages,
        onPageChanged: (value) {
          setState(() {
            curr = value;
            log('$curr');
          });
        },
      ),
    );
  }
}
