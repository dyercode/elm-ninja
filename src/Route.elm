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


toRoute : Url -> String -> Route
toRoute url basePath =
    let
        trimmedUrl =
            { url | path = String.replace basePath "" url.path }
    in
    case Parser.parse routeParser trimmedUrl of
        Just r ->
            r

        Nothing ->
            External url.path


isRoute : Url -> String -> Bool
isRoute url base =
    case toRoute url base of
        External _ ->
            False

        _ ->
            True


toFragment : Route -> String -> String
toFragment route basePath =
    case route of
        Home ->
            basePath ++ "/"

        Blog Lightning ->
            basePath ++ "/lightning/"

        External url ->
            url
