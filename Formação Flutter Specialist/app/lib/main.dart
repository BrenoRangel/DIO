import 'package:drop_shadow_image/drop_shadow_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';

void main() {
  runApp(const MyApp());
}

const seedColor = Color(0xFF1e192c);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var themeData = ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.dark(
        brightness: Brightness.dark,
        //inversePrimary: Color(0xFF121212),
        inversePrimary: seedColor,
        background: seedColor,
      ),
    );
    return MaterialApp(
      title: 'Formação Flutter Specialist',
      theme: themeData.copyWith(
        textTheme: GoogleFonts.notoSerifTextTheme(themeData.textTheme),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: const Image(
          image: AssetImage("assets/3a52d6e3-a58c-4755-89c9-fbc093a8868f.png"),
          height: kMinInteractiveDimension - 8,
        ),
      ),
      body: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          centerTitle: true,
          title: const SelectableText(" Formação Flutter Specialist"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Builder(builder: (context) {
                final size = MediaQuery.of(context).size.shortestSide / 2;
                return TextButton(
                  onPressed: () async {
                    if (await canLaunchUrlString("https://www.dio.me/bootcamp/formacao-flutter-specialist")) {
                      launchUrlString("https://www.dio.me/bootcamp/formacao-flutter-specialist");
                    }
                  },
                  child: DropShadowImage(
                    scale: 1,
                    blurRadius: 16,
                    borderRadius: 0,
                    image: Image(
                      height: size <= 256 ? size : 256,
                      image: const AssetImage(
                        "assets/6d21f240-a85a-4570-a217-c3b9a37d1924.png",
                      ),
                    ),
                  ),
                );
              }),
              SelectableText(
                "        Aprenda a desenvolver Aplicativos completos com Flutter, desde a base com Dart até como o fluxo de Persistência de dados com Hive e SQLite. Além disso, você irá dominar como consumir APIs direto no seu APP, conhecer os componentes e widgets para construção de uma aplicação rica em interatividade com o usuário. Por fim, explore o funcionamento de gerenciamento de estado com MobX e Provider, além de conhecer boas práticas na hora de codificar seus APPs com os principais padrões de mercado.",
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
