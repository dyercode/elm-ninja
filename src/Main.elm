module Main exposing (Model, Msg(..), Page(..), jumbotron, main)

import Bootstrap.Grid exposing (col, container, row)
import Browser
import Browser.Dom as Dom
import Browser.Navigation as Nav
import Html exposing (Html, h1, header, p, span, text)
import Html.Attributes exposing (attribute, class)
import Html.Events exposing (onClick)
import Lightning exposing (writeup)
import ProjectData
import Projects exposing (projectsSection)
import Random
import Random.List exposing (choose)
import Route exposing (isRoute)
import Task
import Url


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    ( { title = "Jon Dyer"
      , subTitle = ""
      , key = key
      , url = url
      }
    , randomString subtitles
    )


subtitles : List String
subtitles =
    [ "(A reasonable subtitle) => text"
    , "(idea) => code"
    , "@wip"
    , "this is randomized"
    ]


type Msg
    = Subtitle String
    | LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | NoOp
    | ReRandomize


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Subtitle string ->
            ( { model | subTitle = string }
            , Cmd.none
            )

        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    if isRoute url then
                        ( model
                        , Cmd.batch
                            [ Nav.pushUrl model.key (Url.toString url)
                            , Task.perform (\_ -> NoOp) (Dom.setViewport 0 0)
                            ]
                        )

                    else
                        ( model, Nav.load (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            ( { model | url = url }, Cmd.none )

        NoOp ->
            ( model, Cmd.none )

        ReRandomize ->
            ( model, randomString subtitles )


randomString : List String -> Cmd Msg
randomString l =
    Random.generate myGeneration (choose l)


myGeneration : ( Maybe String, List String ) -> Msg
myGeneration tup =
    case Tuple.first tup of
        Just str ->
            Subtitle str

        Nothing ->
            Subtitle ""


view : Model -> Browser.Document Msg
view model =
    let
        page : Model -> Html Msg
        page =
            case urlToPage model.url of
                Main ->
                    projectsPage

                Lightning ->
                    lightningPage
    in
    { title = model.title
    , body =
        [ page model
        ]
    }


type Page
    = Main
    | Lightning


urlToPage : Url.Url -> Page
urlToPage url =
    case url.path of
        "/lightning/" ->
            Lightning

        _ ->
            Main


sectionWithHeader : Model -> Html Msg -> Html Msg
sectionWithHeader model section =
    container [ attribute "id" "container", class "col-lg-8" ]
        [ jumbotron model
        , section
        ]


projectsPage : Model -> Html Msg
projectsPage model =
    sectionWithHeader model (projectsSection ProjectData.projectsDefinitions)


lightningPage : Model -> Html Msg
lightningPage model =
    sectionWithHeader model writeup


type alias Model =
    { title : String
    , subTitle : String
    , key : Nav.Key
    , url : Url.Url
    }


rerandomize : Html Msg
rerandomize =
    span [ onClick ReRandomize, class "text-button" ] [ text "🗘" ]


jumbotron : { a | title : String, subTitle : String } -> Html Msg
jumbotron titles =
    row []
        [ col []
            [ header
                [ class "p-5"
                , class "mb-4"
                , class "mt-4"
                , class "border"
                , class "border-1"
                , class "border-dark"
                , class "rounded-3"
                , class "jumbotron"
                , class "shadow-sm"
                ]
                [ h1 [ class "display-4" ] [ text titles.title ]
                , p [ class "lead" ]
                    [ rerandomize
                    , text " "
                    , text titles.subTitle
                    ]
                ]
            ]
        ]
