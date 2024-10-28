import 'package:flutter/material.dart';
import 'package:prueba_tecnica_kb/ui/features/auth/controllers/auth_controller.dart';
import 'package:prueba_tecnica_kb/ui/features/auth/local_widgets/text_form_field_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final AuthController authController = AuthController.instance;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    authController.init();

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            // Envolver los campos de texto en un Form
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Iniciar sesión',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                TextFormFieldWidget(
                  labelText: 'Usuario',
                  controller: authController.usernameController,
                  counterText: '',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El nombre de usuario es requerido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16), // Espacio entre los campos
                TextFormFieldWidget(
                  labelText: 'Contraseña',
                  controller: authController.passwordController,
                  obscureText: true, // Para ocultar la contraseña
                  counterText: '',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'La contraseña es requerida';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32), // Espacio antes del botón
                ElevatedButton(
                  onPressed: () {
                    // Validar el formulario
                    if (formKey.currentState?.validate() ?? false) {
                      authController.login();
                    }
                  },
                  child: StreamBuilder<bool>(
                      stream: authController.isLoading,
                      builder: (context, snapshot) {
                        if (snapshot.data ?? false) {
                          return const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          );
                        }
                        return const Text('Login');
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
