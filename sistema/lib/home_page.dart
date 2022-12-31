import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sistema/checagem_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _firebaseAuth = FirebaseAuth.instance;

  String nome = '';
  String email = '';

  @override
  void initState() {
    // TODO: implement initState
    pegarUsuario();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(nome),
              accountEmail: Text(email),
            ),
            ListTile(
              dense: true,
              title: Text('Sair'),
              trailing: Icon(Icons.exit_to_app),
              onTap: () {
                sair();
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            nome,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  pegarUsuario() async {
    User? usuario = _firebaseAuth.currentUser;
    if (usuario != null) {
      setState(() {
        nome = usuario.displayName!;
        email = usuario.email!;
      });
    }
  }

  sair() async {
    await _firebaseAuth.signOut().then(
          (user) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ChecagemPage(),
            ),
          ),
        );
  }
}
