port module Leaflet exposing (..)


type alias Icon =
    { url : String
    , size : { height : Int, width : Int }
    }


type alias Marker =
    { lat : Float
    , lng : Float
    , icon : Maybe Icon
    , draggable : Bool
    , popup : Maybe String
    , events : Maybe (List ( String, String ))
    }


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


port addMarker : Marker -> Cmd msg
