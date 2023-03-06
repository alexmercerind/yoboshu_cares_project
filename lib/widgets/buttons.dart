import 'package:flutter/material.dart';

// NOTE: Ideally all style e.g. dimensions, colors, text-styles parameters should be exposed in the constructor.

class PrimaryButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  const PrimaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool tapped = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (e) {
        setState(() {
          tapped = true;
        });
      },
      onTapUp: (e) {
        setState(() {
          tapped = false;
        });
        widget.onPressed.call();
      },
      child: Stack(
        children: [
          Container(
            height: 64.0,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF90C1A0),
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          TweenAnimationBuilder<double>(
            tween: Tween<double>(
              begin: -6.0,
              end: tapped ? 0.0 : -6.0,
            ),
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeInOut,
            builder: (context, value, _) => Transform.translate(
              offset: Offset(
                0.0,
                value,
              ),
              child: Container(
                height: 64.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFCEECDA),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                alignment: Alignment.center,
                child: Text(
                  widget.text,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const SecondaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        height: 64.0,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFF9692AC),
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
