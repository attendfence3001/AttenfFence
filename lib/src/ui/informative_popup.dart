import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class InformativePopup extends StatefulWidget {
  const InformativePopup({
    super.key,
    this.isSuccess = true,
    required this.title,
  });

  final bool isSuccess;
  final String title;

  @override
  State<InformativePopup> createState() => _InformativePopupState();
}

class _InformativePopupState extends State<InformativePopup> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Center(
        child: Material(
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
          color: Colors.white,
          child: SizedBox(
              height: 250,
              width: MediaQuery.of(context).size.width - 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    widget.isSuccess
                        ? 'assets/lotties/success.json'
                        : 'assets/lotties/failure.json',
                    height: 100,
                    width: 100,
                    repeat: false,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.isSuccess ? 'Successful!' : 'Failure!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: widget.isSuccess
                          ? Color(0xFF0A3161)
                          : Color(0xFFFF3B30),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: SingleChildScrollView(
                      child: Text(
                        widget.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF7B7B7B),
                        ),
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
