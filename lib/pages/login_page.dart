import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:justdoit/components/mybutton.dart';
import 'package:justdoit/components/mytextfield.dart';
import 'package:justdoit/components/square_tile.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  //sign user in method
  void signUserIn() async{
    //show loading circle
    showDialog(context: context, 
    builder:(context){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    );
    

   
    //try sign in
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text, 
        password: passwordController.text,
        );
        //pop the loading circle
        Navigator.pop(context);
    } on FirebaseAuthException catch (e){
      Navigator.pop(context);
      if(e.code == 'user-not-found'){
        //show error to user
        wrongEmailMessage();
      }
      //wrong password
      else if(e.code == 'wrong-password'){
        //show error
        wrongPasswordMessage();
      }
    }
  }

  //wrong email message popup
  void wrongEmailMessage(){
    showDialog(
      context:context,
      builder:(context){
        return const AlertDialog(
          title:Text('Incorrect Email'),
        );
      }
    );
  }
  //wrong password message popup
  void wrongPasswordMessage(){
    showDialog(
      context:context,
      builder:(context){
        return const AlertDialog(
          title:Text('Incorrect password')
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                const SizedBox(height:50),
                //logo
                const Icon(
                  Icons.lock, 
                  size:100
                ),
                const SizedBox(height: 50,),        
              
                //welcome back, you've been missed
                Text('Welcome back you\'ve been missed',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16
                  ),
                ),
          
                const SizedBox(height:25),
                //username textfield
                MyTextField(
                  controller: emailController,
                  obscureText: false,
                  hintText: "Enter username",
                ),
                const SizedBox(height:25),
                //password textfield
                MyTextField(
                  controller: passwordController,
                  obscureText: true,
                  hintText: "Enter password",
                ),  
                const SizedBox(height:10),
          
                //forgot password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Forgot Password?',
                      style: TextStyle(color:Colors.grey[600])),
                    ],
                  ),
                ),
          
                const SizedBox(height: 20,),
                //sign in button
                MyButton(
                  onTap: signUserIn,
                ),
                const SizedBox(height:25),
          
                //or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child:Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      const Text('Or continue with'),
                      Expanded(
                        child:Divider(
                          thickness: 0.5,
                          color:Colors.grey[400],
                        )
                      )
                    ],
                  ),
                ),
                const SizedBox(height:25),
          
                //google + apple sign in buttons
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    SquareTile(imagePath: "lib/assets/google_logo.png"),
                   
          
                  ]
                ),
                const SizedBox(height:15),
          
                //not a member? register now
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Not a member?"),
                  SizedBox(width: 4,),
                  Text("Register now",
                  style: TextStyle(
                    color:Colors.blue, fontWeight:FontWeight.bold
                  ),
                  ),
                ],
              )
          
              ]),
          ),
        ),
      )
    );
  }
}
