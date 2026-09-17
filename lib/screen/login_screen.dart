import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //CONTROL PARA MOSTRAR/OCULTAR CONTRASEÑA
  bool _obscureText = true;

  //CREAR EL CEREBRO DE LAS ANIMACIONES
  StateMachineController? _controller;
  //SMI: State Machine Input
  SMIBool? _isChecking;
  SMIBool? _isHandsUp;
  //SMITrigger? _trigSuccess;
  //MITrigger? _trigFail;

  //1.1 PASO crear variables para focusNode
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    //1.2 agregar listener a los focusNode
    _emailFocusNode.addListener(() {
      if (_emailFocusNode.hasFocus) {
        if (_isHandsUp != null) {
          //No se tapa los ojos
          _isHandsUp?.change(false);
        }
      }
    });
    _passwordFocusNode.addListener(() {
      _isHandsUp?.change(_passwordFocusNode.hasFocus);
    });
  }

  @override
  Widget build(BuildContext context) {
    //PARA OBTENER EL TAMAÑO DE LA PANTALLA
    final Size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: 200,
                width: Size.width,
                child: RiveAnimation.asset(
                  'corto.riv',
                  stateMachines: ['Login Machine'],
                  //al iniciar la animación, se ejecuta el callback onInit
                  onInit: (artboard) {
                    _controller = StateMachineController.fromArtboard(
                      artboard,
                      'Login Machine',
                    );
                    //verificar que todo inicio correctamente
                    if (_controller == null) return;
                    //agregar el controlador al tablero de animación
                    artboard.addController(_controller!);
                    //VINCULA VARIABLES
                    _isChecking = _controller!.findSMI('isChecking');
                    _isHandsUp = _controller!.findSMI('isHandsUp');
                    //_trigSuccess = _controller!.findSMI('trigSuccess');
                    //_trigFail = _controller!.findSMI('trigFail');
                  },
                ),
              ),

              //PARA SEPARAR WIDGETS
              SizedBox(height: 20),
              //campo de texto para email
              TextField(
                //1.3 ASIGNAR EL FOCUS AL TEXFIELD
                focusNode: _emailFocusNode,
                onChanged: (value) {
                  if (_isHandsUp != null) {
                    //No se tapa los ojos
                    //_isHandsUp?.change(false);
                  }
                  //si isChecking es nulo
                  if (_isChecking == null) return;
                  //modo chismoso
                  _isChecking?.change(true);
                },
                //PARA MSTRAR UN TIPO DE TECLADO
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),

              SizedBox(height: 10),
              //campo de texto para contraseña
              TextField(
                focusNode: _passwordFocusNode,
                onChanged: (value) {
                  if (_isHandsUp != null) {
                    //No se tapa los ojos
                    //_isHandsUp?.change(true);
                  }
                  //si isChecking es nulo
                  if (_isChecking == null) return;
                  //modo chismoso
                  _isChecking?.change(true);
                },
                //PARA MSTRAR UN TIPO DE TECLADO
                obscureText: _obscureText,
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    //Liberar memoria/ recursos al salir de la pantalla
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }
}
