import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../main.dart';

class InicioSesion extends StatefulWidget {
  InicioSesion({Key? key}) : super(key: key);

  @override
  State<InicioSesion> createState() => _InicioSesionState();
}

class _InicioSesionState extends State<InicioSesion> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Presiona el botón'),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: TextButton(
                child: const Text('Entrar'),
                style: TextButton.styleFrom(
                  padding:
                      const EdgeInsets.only(top: 10.0, bottom: 10, left: 30, right: 30),
                  backgroundColor: const Color(0xff2166E5),
                  textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  primary: Colors.white,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50.0))),
                ),
                onPressed: () async{
                  await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
                  try {
                    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                      // email: Login.usuario.text,
                      // password: Login.pass.text
                      email: 'cinda@ioscomunicaciones.com',
                      password: '12345678'
                    );
                  } on FirebaseAuthException catch (e) {
                      print(e);
                      if (e.code == 'user-not-found') {
                        Fluttertoast.showToast(
                            msg: 'Usuario no encontrado',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: const Color(0xFFDC3545),
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else if (e.code == 'wrong-password') {
                        Fluttertoast.showToast(
                          msg: 'Contraseña inválida',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: const Color(0xFFDC3545),
                          textColor: Colors.white,
                          fontSize: 16.0
                        );
                      }
                    }
                      print('listo');
                      // var user = FirebaseAuth.instance.currentUser;   /// PASAR INSTRUCCION A EMULADOR...
                      var user = FirebaseAuth.instance.currentUser;
                      // if (user != null) {
                      //   await user.reload();
                      // }

                      // var user = await FirebaseAuth.instance.currentUser;
                      // final String? uid = user?.uid.toString();

                      print('User: ' + user.toString());
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}