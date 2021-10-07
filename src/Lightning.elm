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
        [ breadcrumb
        , h3 [] [ text "Summary" ]
        , p []
            [ text """
        A micocontroller project to dodge lightning in Final Fantasy X. Writeup, code and schematics coming sometime.
        """
            ]

        {-
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
           So what I've done is taken a photoresistor, a microcontroller (Pi Pico), and an old 3rd party
           controller that's too mushy to be useful for actual gaming and made an auto-presser for it.
           The controller is connected to the Switch via a snes-wii adapter and a wii/gamecube-switch
           bluetooth adapter. This isn't ideal, but is what I had to work with on hand, more at the end.
                   """ ]
                   , h3 [] [ text "Hardware" ]
                   , p [] [ text """
           The hardware setup is simple, and should be easy enough to
           replicate on any micro with an ADC.
                   """ ]
                   , h3 [] [ text "Logic Section" ]
                   , p [] [ text """
           Step 1 was to detect the flash. So I wired up just the photoresistor to one of the micro's ADC's
           and wrote a loop to print out the value above a certain threshold. On my first attempt the
           telegraphing flash maxed out the sensor. This was super convenient, but unfortunately a side
           effect of mis-wiring the photoresistor to 5V instead of the Pi Pico's rated 3.3V.
           """ ]
                   , p [] [ text """
           To avoid needing to sift through too much data I picked some arbitrary values above which to print at,
           somewhere above 0x9F. This worked pretty well in the poorly lit room. I did run into a few gotchas.
           The value printed was high for long after the flash had ended. I'm pretty sure this was partly from
           the 5V mistake, and partly from the tight loop going too fast and the serial printing being slow. So
           throttled the loop to 60fps (though the game only runs at 30fps on Switch)  so the So
           detecting lightning is simply checking that the light has stayed high for long enough, I went with 6
           frames. The Pi Pico runs pretty fast so I throttle the main loop to around 60fps
                   """ ]
        -}
        -- , h3 [] [ text "Source Code" ]
        -- , a [ href "https://github.com/dyercode/" ] [ text "Github Repo with C code and Schematic coming soon" ]
        , h3 [] [ text "In Action" ]
        , p [] [ text "A short vid of the device in action" ]
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
