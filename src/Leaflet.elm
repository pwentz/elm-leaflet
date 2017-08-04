port module Leaflet exposing (..)


type alias MapData =
    { divId : String
    , lat : Float
    , lng : Float
    , zoom : Int
    , tileLayer : String
    , tileLayerOptions :
        { attribution : String
        , maxZoom : Int
        , id : String
        , accessToken : String
        }
    }


port initMap : MapData -> Cmd msg


port addMarker : { lat : Float, lng : Float } -> Cmd msg
