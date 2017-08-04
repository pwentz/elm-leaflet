module Main exposing (main)

import Html exposing (..)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (type_, value, style, id)
import Json.Encode exposing (Value)
import Json.Decode as Json
import Leaflet as L


main =
    program
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }


type alias Model =
    { lat : Float
    , lng : Float
    }


mapboxToken : String
mapboxToken =
    "pk.eyJ1IjoicHdlbnR6IiwiYSI6ImNpdHp1bWNwdzBmeWUybm82czM5dXJrbmgifQ.9VjnHsAL0MgpDCDPrJou0A"


mapData : L.MapData
mapData =
    { divId = "map"
    , lat = 41.876548
    , lng = -87.633755
    , zoom = 13
    , tileLayer = "https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=" ++ mapboxToken
    , tileLayerOptions =
        { attribution = ""
        , maxZoom = 18
        , id = "mapbox.streets"
        , accessToken = mapboxToken
        }
    }


init : ( Model, Cmd Msg )
init =
    ( { lat = 0.0
      , lng = 0.0
      }
    , Cmd.none
    )



-- VIEW


view : Model -> Html Msg
view model =
    div
        []
        [ input
            [ type_ "text"
            , onInput UpdateLat
            , value (toString model.lat)
            ]
            []
        , input
            [ type_ "text"
            , onInput UpdateLng
            , value (toString model.lng)
            ]
            []
        , button
            [ onClick InitMap ]
            [ text "Create Map" ]
        , br [] []
        , button
            [ onClick AddMarker ]
            [ text "Add Marker" ]
        , div
            [ id "map"
            , style [ ( "height", "500px" ) ]
            ]
            []
        ]



-- UPDATE


type Msg
    = UpdateLat String
    | UpdateLng String
    | InitMap
    | AddMarker


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateLat str ->
            case String.toFloat str of
                Ok lat ->
                    ( { model | lat = lat }, Cmd.none )

                Err _ ->
                    ( model, Cmd.none )

        UpdateLng str ->
            case String.toFloat str of
                Ok lng ->
                    ( { model | lng = lng }, Cmd.none )

                Err _ ->
                    ( model, Cmd.none )

        InitMap ->
            ( model, L.initMap mapData )

        AddMarker ->
            ( model
            , L.addMarker model
            )
