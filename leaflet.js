"use strict";

var myMap;

function initMap(data) {
  myMap = L.map(data.divId)
           .setView([data.lat, data.lng], data.zoom)

  L.tileLayer(data.tileLayer, data.tileLayerOptions)
   .addTo(myMap)
}


(function(window) {
  var node = document.getElementById("app");
  var app = Elm.Main.embed(node);

  app.ports.initMap.subscribe(initMap)
}(window));