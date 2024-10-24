module Main exposing (..)

import Browser
import Html as H exposing (Html, input, pre, text)
import Html.Attributes as HA
import Http



-- MAIN


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- MODEL


type Model
    = Success


init : () -> ( Model, Cmd Msg )
init _ =
    ( Success
    , Cmd.none
    )



-- UPDATE


type Msg
    = GotText (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    H.div []
        [ viewAppBar
        , H.main_ [ HA.class "responsive" ]
            [ H.div [ HA.class "center-align" ] [ H.img [ HA.src "assets/lightbulb-off.png", HA.width 200 ] [] ]
            , H.h5 [ HA.class "small center-align" ] [ text "Consulta tu horario de corte de luz" ]
            , viewForm model
            ]
        ]


viewAppBar : Html Msg
viewAppBar =
    H.header []
        [ H.nav []
            [ H.h5 [ HA.class "max" ] [ text "Cortes de luz" ]
            , H.button [ HA.class "circle transparent" ] [ H.i [] [ text "more_vert" ] ]
            ]
        ]


viewForm : Model -> Html Msg
viewForm _ =
    H.fieldset []
        [ H.div [ HA.class "field border label" ]
            [ H.input [] []
            , H.label [] [ H.text "Documento" ]
            , H.div [ HA.class "small-space" ] []
            , H.div [ HA.class "right-align" ]
                [ H.button
                    [ HA.class "border small no-margin" ]
                    [ text "Cargar último documento usado" ]
                ]
            ]
        , H.div [ HA.class "small-space" ] []
        , H.div [ HA.class "field border label" ]
            [ H.select []
                [ H.option [] [ text "Cuenta contrato" ]
                , H.option [] [ text "Código único (cuen)" ]
                , H.option [] [ text "Número de identificación" ]
                ]
            , H.label [] [ H.text "Tipo de documento" ]
            ]
        , H.button [ HA.class "responsive" ]
            [ H.i [] [ text "search" ]
            , text "Consultar"
            ]
        ]
