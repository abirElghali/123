import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CoffeeShopMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Coordonnées centrées sur la Tunisie
    double tunisiaLatitude = 34.0;
    double tunisiaLongitude = 9.0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Carte de la Tunisie'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          // Positionner la caméra au centre de la Tunisie
          target: LatLng(tunisiaLatitude, tunisiaLongitude),
          zoom: 6, // Niveau de zoom
        ),
        markers: _getTunisiaMarker(), // Ajouter un marqueur pour la Tunisie
      ),
    );
  }

  Set<Marker> _getTunisiaMarker() {
    Set<Marker> markers = {};

    // Ajouter un marqueur pour la Tunisie
    markers.add(
      Marker(
        markerId: MarkerId('tunisia_location'),
        position: LatLng(34.0, 9.0), // Coordonnées du centre de la Tunisie
        infoWindow: InfoWindow(
          title: 'Tunisie',
        ),
      ),
    );

    return markers;
  }
}
