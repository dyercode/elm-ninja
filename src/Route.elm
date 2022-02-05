module Route exposing (Blogs(..), Route(..), isRoute, toFragment)

import Url exposing (Url)
import Url.Parser as Parser exposing (Parser)


type Route
    = Home
    | Blog Blogs
    | External String


type Blogs
    = Lightning


routeParser : Parser (Route -> c) c
routeParser =
    Parser.oneOf
        [ Parser.map Home Parser.top
        , Parser.map (Blog Lightning) (Parser.s "lightning")
        ]


toRoute : Url -> Route
toRoute url =
    case Parser.parse routeParser url of
        Just r ->
            r

        Nothing ->
            External url.path


isRoute : Url -> Bool
isRoute url =
    case toRoute url of
        External _ ->
            False

        _ ->
            True


toFragment : Route -> String
toFragment route =
    case route of
        Home ->
            "/"

        Blog Lightning ->
            "/lightning/"

        External url ->
            url
