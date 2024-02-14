import 'package:service_provider/Global/selectImagePopUp.dart';
import 'package:service_provider/Models/Slider.dart' as s;
import 'package:service_provider/Shared/Globals.dart';
import 'package:flutter/material.dart';
import 'package:service_provider/Shared/NavMove.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeSingleSlider extends StatelessWidget {
  final s.Slider slider;
  const HomeSingleSlider(this.slider, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (slider.the_link.length > 0) {
          if (slider.the_link.contains('http')) {
            launchUrl(Uri.parse(slider.the_link));
          }
        } else {
          NavMove.goToPage(context, ImageShowPage(slider.image));
        }
      },
      child: Container(
        width: double.infinity,
        child: NetworkImagePlace(
          image: slider.image,
          fit: BoxFit.fill,
          all: 15,
        ),
      ),
    );
  }
}
