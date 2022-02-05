module Lightning exposing (writeup)

import Html exposing (Html, a, div, h3, iframe, li, nav, ol, p, text)
import Html.Attributes exposing (attribute, class, height, href, src, title, width)


breadcrumb : Html msg
breadcrumb =
    nav [ attribute "aria-label" "breadcrumb" ]
        [ ol
            [ class "breadcrumb" ]
            [ li [ class "breadcrumb-item" ]
                [ a
                    [ href "/" ]
                    [ text "Home" ]
                ]
            , li [ class "breadcrumb-item", class "active", attribute "aria-current" "page" ] [ text "Lightning" ]
            ]
        ]


writeup : Html msg
writeup =
    div []
        ([ breadcrumb
         , h3 [] [ text "Summary" ]
         , p []
            [ text """
        A micocontroller project to dodge lightning in Final Fantasy X. Writeup, code and schematics coming sometime.
        """
            ]
         , h3 [] [ text "Background" ]
         , p [] [ text """
           In Final Fantasy X there is a "minigame" you have to complete to get a piece of Lulu's Celestial/Ultimate
           weapon. It requires the player to dodge 200 lightning strikes in a row.  The lightning generally
           strikes at random intervals, though there are ways to manipulate the timing.
           To dodge a lightning bolt you must press a button, 'A' in my case, quickly after the screen
           flashes. If you mash the button early you automatically get hit.
                   """ ]
         , p []
            [ text """
           I've taken a photoresistor, a microcontroller (Pi Pico), and an old 3rd party
           controller that's too mushy to be useful for actual gaming and made an auto-presser for to do it for me.
           The controller is connected to the Switch via a snes-wii adapter and a wii/gamecube-switch
           bluetooth adapter. This isn't ideal, but is what I had to work with on hand.
                   """ ]
         , h3 [] [ text "Hardware" ]
         , p [] [ text """
           The hardware setup is simple, and should be easy enough to replicate on any micro with an ADC. Schematic
           coming sometime in the future.
                   """ ]
         , h3 [] [ text "Logic Section" ]
         ]
            ++ List.map (\t -> p [] [ text t ])
                [ """
           I wired up just the photoresistor to one of the Pico's ADCs and loosely positioned it over the Switch's
           screen. To figure out what levels and timing would be needed, I wrote a loop to print out the ADC value
           above a certain threshold. This appeared to work like a charm and produced long blocks of apparent maxed
           readings.
           """
                , """
           There were, however, a few problems with this. The first and most obvious was the high values were
           reported for much longer than the flashes last. This could have been caused by something with the
           sensor, but watching the data stream in made it apparent that printing over serial on a tight loop was
           slowing things down significantly. To resolve this I throttled the loop to 60fps.
           """
                , """
           The sensor being maxed did seem a bit suspicious, too. So I rechecked my circuit and found I'd mistakenly
           wired it to the 5V source instead of the 3.3V of the Pico inputs. I resolved this issue at the same time
           as the loop speed and wasn't curious enough to risk damaging the micro to check if it was contributing to
           the residual high inputs.
           """
                , """
           With the voltage resolved it turned out I did need to find a sweet spot to look for. After a bit of trial
           and error I landed on 0xd00. From there all that was left was to code up tapping the button and tweaking the timings.
           """
                ]
            ++ -- , h3 [] [ text "Source Code" ]
               -- , a [ href "https://github.com/dyercode/" ] [ text "Github Repo with C code and Schematic coming soon" ]
               [ h3 [] [ text "In Action" ]
               , p [] [ text "A short video of the device in action" ]
               , iframe
                    [ width 560
                    , height 315
                    , src "https://www.youtube.com/embed/x8iWN6i7iMM"
                    , title "YouTube video player"
                    , attribute "frameborder" "0"
                    , attribute "allow" "accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                    , attribute "allowfullscreen" ""
                    ]
                    []
               ]
        )
