module Components exposing (Model, jumbotron)

import Html exposing (Html, h1, header, p, text)
import Html.Attributes exposing (class)


type alias Model =
    { title : String
    , subTitle : String
    }


jumbotron : Model -> Html msg
jumbotron model =
    header [ class "jumbotron" ]
        [ h1 [ class "display-4" ] [ text model.title ]
        , p [ class "lead" ] [ text model.subTitle ]
        ]
