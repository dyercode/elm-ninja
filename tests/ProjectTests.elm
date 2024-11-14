module ProjectTests exposing (projectSuite)

import Expect
import ProjectData exposing (Project)
import Projects exposing (projectsSection)
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector


projectSuite : Test
projectSuite =
    let
        exampleData : Project
        exampleData =
            { title = "ttl", links = [], description = [ "fish", "stew", "pizza" ] }
    in
    describe "projecst"
        [ describe "project item"
            ((test "shows project title" <|
                \() ->
                    projectsSection [ exampleData ]
                        |> Query.fromHtml
                        |> Query.find [ Selector.tag "dt" ]
                        |> Query.has [ Selector.text "ttl" ]
             )
                :: (let
                        ps : Query.Multiple msg
                        ps =
                            projectsSection [ exampleData ]
                                |> Query.fromHtml
                                |> Query.find [ Selector.tag "dd" ]
                                |> Query.findAll [ Selector.tag "p" ]
                    in
                    (test "contains correct number of paragraphs" <|
                        \() -> ps |> Query.count (Expect.equal 3)
                    )
                        :: List.indexedMap
                            (\i expected ->
                                test ("shows description line `" ++ expected ++ "`") <|
                                    \() -> ps |> Query.index i |> Query.has [ Selector.text expected ]
                            )
                            exampleData.description
                   )
            )
        ]
