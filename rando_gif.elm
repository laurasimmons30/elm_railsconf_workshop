module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (src)
import Html.Events exposing (onClick)
import Http
import Json.Decode as JD

main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = (\model -> Sub.none)
        }


type alias Model =
    { url : Maybe String
    , error : Maybe String
    }


init : ( Model, Cmd Msg )
init =
    ( Model Nothing Nothing, Cmd.none ) --first nothing is url, 2nd is error


type Msg
    = Fetch
    | Display (Result Http.Error String) --sent to update method when http call is finished


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Fetch ] [ text "Fetch!" ]
        , text <| Maybe.withDefault "" model.error
        , imageView model.url
        ]


imageView : Maybe String -> Html Msg
imageView mString =
    case mString of
        Just url ->
            img [ src url ] []

        Nothing ->
            text "not fetched"


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Fetch ->
            ( model, doFetch )

        Display (Ok url) ->
            ( { model | url = Just url, error = Nothing }
            , Cmd.none
            )

        Display (Err err) ->
            ( { model | error = Just <| toString }
            , Cmd.none
            )


randomUrl : String
randomUrl =
    "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&rating=g"

doFetch : Cmd Msg
doFetch =
    let
        decoder =
            JD.at [ "data", "fixed_height_small_url" ] JD.string
    in
        Http.get randomUrl decoder
            |> Http.send Display
