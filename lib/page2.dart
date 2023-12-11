import 'package:flutter/material.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Congratulations!!',
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          centerTitle: true,
          backgroundColor: Color(0xff301e42),
        ),
        body: Center( child: Column(
          children: [
            Image.network(
              'https://thumbs.dreamstime.com/b/congratulations-sign-card-illustration-design-graphic-over-green-background-35178074.jpg',
              fit: BoxFit.cover,
              height: 400,
              width: 800,

            ),
            const SizedBox(height: 10),

            Text(' You guessed the correct number !!!',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color(0xff301e42),


              ),


            ),
            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Back To Game',style: TextStyle(fontSize: 30, color: Color(0xff301e42)),),
              style: ElevatedButton.styleFrom(primary: Colors.green, minimumSize: Size(60, 60)),
            ),
          ],
        ),
        )
    );
  }
}