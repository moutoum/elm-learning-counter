module Main exposing (..)

import Browser
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)


main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }


type alias Model =
    List Int


type Msg
    = Increment Int
    | Decrement Int
    | Remove Int
    | Add


init : Model
init =
    []


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment i ->
            List.indexedMap
                (\index value ->
                    if index == i then
                        value + 1

                    else
                        value
                )
                model

        Decrement i ->
            List.indexedMap
                (\index value ->
                    if index == i then
                        value - 1

                    else
                        value
                )
                model

        Remove i ->
            let
                before =
                    List.take i model

                after =
                    List.drop (i + 1) model
            in
            before ++ after

        Add ->
            model ++ [ 0 ]


view : Model -> Html Msg
view model =
    div []
        [ div [] <| List.indexedMap counterView model
        , button [ onClick <| Add ] [ text "Add counter" ]
        ]


counterView : Int -> Int -> Html Msg
counterView index value =
    div [ style "margin-bottom" "10px" ]
        [ button [ onClick <| Decrement index ] [ text "-" ]
        , div [ style "display" "inline-block", style "margin" "0 10px", style "min-width" "80px", style "text-align" "center" ] [ text <| String.fromInt value ]
        , button [ onClick <| Increment index ] [ text "+" ]
        , button [ onClick <| Remove index, style "color" "red", style "margin-left" "10px" ] [ text "Delete" ]
        ]
