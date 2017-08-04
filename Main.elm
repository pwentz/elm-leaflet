port module Main exposing (main)

import Html exposing (..)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (type_, value, style, id)
import Json.Encode exposing (Value)
import Json.Decode as Json


main =
    program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


type alias Model =
    { message : String
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


mapboxToken : String
mapboxToken =
    "pk.eyJ1IjoicHdlbnR6IiwiYSI6ImNpdHp1bWNwdzBmeWUybm82czM5dXJrbmgifQ.9VjnHsAL0MgpDCDPrJou0A"


mapData : MapData
mapData =
    { divId = "map"
    , lat = 51.505
    , lng = -0.09
    , zoom = 13
    , tileLayer = "https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=" ++ mapboxToken
    , tileLayerOptions =
        { attribution = ""
        , maxZoom = 18
        , id = "mapbox.streets"
        , accessToken = mapboxToken
        }
    }


port initMap : MapData -> Cmd msg


port toElm : (Value -> msg) -> Sub msg


init : ( Model, Cmd Msg )
init =
    ( { message = "Good things" }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div
        []
        [ input
            [ type_ "text"
            , onInput UpdateStr
            , value model.message
            ]
            []
        , button
            [ onClick InitMap ]
            [ text "Click to Submit" ]
        , div
            [ id "map"
            , style [ ( "height", "180px" ) ]
            ]
            []
        ]



-- UPDATE


type Msg
    = UpdateStr String
    | InitMap


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateStr str ->
            ( { model | message = str }, Cmd.none )

        InitMap ->
            ( model, initMap mapData )



-- SUBS


decodeValue : Value -> Msg
decodeValue val =
    let
        result =
            Json.decodeValue Json.string val
    in
        case result of
            Ok str ->
                UpdateStr str

            Err _ ->
                UpdateStr "Something went wrong"


subscriptions : Model -> Sub Msg
subscriptions model =
    toElm decodeValue
