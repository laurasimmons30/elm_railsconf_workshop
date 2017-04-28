module Main exposing (main)

import Html exposing (..)
import Html.Events exposing (onClick)

type Msg
    = AddPoints Int
    
type alias Model = Int    

main =
    beginnerProgram
        { model = initialModel
        , view = view
        , update = update
      }

initialModel : Model
initialModel = 
    0

update : Msg -> Model -> Model
update msg model = 
    case msg of 
        AddPoints int ->
            model + int
    
view : Model -> Html Msg
view model =
    div
        []
        [ button [onClick (AddPoints 1) ] [ text "FreeThrow" ]
        , button [onClick (AddPoints 2) ] [ text "JumpShot" ]
        , button [onClick (AddPoints 3) ] [text "Three!!" ]
        , text (toString model)
        ]
