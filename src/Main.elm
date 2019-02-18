module Main exposing (main)

import Bootstrap.Button as Button
import Bootstrap.ButtonGroup as ButtonGroup
import Bootstrap.Grid exposing (..)
import Browser
import Html exposing (Html, h1, header, p, text)
import Html.Attributes exposing (attribute, class)
import Html.Events exposing (onClick)
import Random exposing (Generator)
import Random.List exposing (choose)


type alias Model =
    { count : Int
    , title : String
    , subTitle : String
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { count = 0
      , title = "Jon Dyer"
      , subTitle = ""
      }
    , rlist subtitles
    )


subtitles =
    [ "(A reasonable subtitle) => text"
    , "(idea) => code"
    , "idea -> code -> webpage"
    ]


type Msg
    = Increment
    | Decrement
    | MyString String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            ( { model | count = model.count + 1 }
            , Cmd.none
            )

        Decrement ->
            ( { model | count = model.count - 1 }
            , Cmd.none
            )

        MyString string ->
            ( { model | subTitle = string }
            , Cmd.none
            )


rlist : List String -> Cmd Msg
rlist l =
    Random.generate myGeneration (choose l)


myGeneration : ( Maybe String, List String ) -> Msg
myGeneration tup =
    case Tuple.first tup of
        Just str ->
            MyString str

        Nothing ->
            MyString ""


view model =
    container [ attribute "id" "container" ]
        --        [ CDN.stylesheet
        [ row []
            [ col []
                [ header [ class "jumbotron" ]
                    [ h1 [ class "display-4" ] [ text model.title ]
                    , p [ class "lead" ] [ text model.subTitle ]
                    ]
                ]
            ]
        , ButtonGroup.buttonGroup []
            [ ButtonGroup.button [ Button.primary, Button.attrs [ onClick Increment ] ] [ text "+1" ]
            , ButtonGroup.button [] [ text <| String.fromInt model.count ]
            , ButtonGroup.button [ Button.danger, Button.attrs [ onClick Decrement ] ] [ text "-1" ]
            ]
        ]


main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }
