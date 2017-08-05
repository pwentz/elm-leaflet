"use strict";

var myMap;

function initMap(data) {
  myMap = L.map(data.divId)
           .setView([data.lat, data.lng], data.zoom);

  L.tileLayer(data.tileLayer, data.tileLayerOptions)
   .addTo(myMap);
};

function addMarker(options) {
  var icon = options.icon ? { iconUrl: options.icon.url ,
                              iconSize: [options.icon.size.height, options.icon.size.width] }
                          : null

  var markerOptions = icon ? { icon: L.icon(icon), draggable: options.draggable }
                           : { draggable: options.draggable }

  var marker = L.marker([options.lat, options.lng], markerOptions)

   marker.addTo(myMap);

  if (options.popup) {
    marker.bindPopup(options.popup)
  }

  if (options.events) {
    options.events.forEach(function(eventData) {
      var event = eventData[0];
      var action = eventData[1];

      marker.on(event, function() {
        marker[action];
      });
    });
  };

};


(function(window) {
  var node = document.getElementById("app");
  var app = Elm.Main.embed(node);

  app.ports.initMap.subscribe(initMap)
  app.ports.addMarker.subscribe(addMarker)
}(window));
