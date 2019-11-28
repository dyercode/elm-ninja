module Example exposing (..)

import Components exposing (..)
import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)
import Test.Html.Query as Query
import Test.Html.Selector as Selector


suite : Test
suite =
    describe "homepage"
        [ describe "jumbotron"
            [ test "shows title as main header" <|
                \() ->
                    jumbotron { title = "ttl", subTitle = "subby" }
                        |> Query.fromHtml
                        |> Query.find [ Selector.tag "h1" ]
                        |> Query.has [ Selector.text "ttl" ]
            , test "shows subtitle" <|
                \() ->
                    jumbotron { title = "ttl", subTitle = "subby" }
                        |> Query.fromHtml
                        |> Query.find [ Selector.tag "p" ]
                        |> Query.has [ Selector.text "subby" ]
            ]
        ]
