port module Main exposing (..)

import Api exposing (getHorariosCortes)
import Browser
import Html as H exposing (Html, text)
import Html.Attributes as HA
import Html.Events as HE
import Http exposing (Error(..))
import Msg exposing (Msg(..))
import Types exposing (Criterio(..), InformacionCorteLuz, displayCriterio, getCriterioValue, parseCriterio)
import Util


{-| To show a snackbar using Beer CSS
-}
port showSnackbar : String -> Cmd msg



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


type alias Model =
    { documento : String
    , errorDocumento : Maybe String
    , criterio : Criterio
    , informacionCortes : Maybe InformacionCorteLuz
    , errorServidor : Maybe String
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { documento = ""
      , errorDocumento = Nothing
      , criterio = CuentaContrato
      , informacionCortes = Nothing
      , errorServidor = Nothing
      }
    , Cmd.none
    )



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateDocumento documento ->
            ( { model | documento = documento }, Cmd.none )

        UpdateCriterio criterio ->
            ( { model | criterio = criterio }, Cmd.none )

        Submit ->
            if String.isEmpty model.documento then
                ( { model | errorDocumento = Just "Debe ingresar el número de documento" }, Cmd.none )

            else
                ( model, getHorariosCortes model.documento model.criterio )

        GotApiResponse (Ok apiResponse) ->
            case apiResponse of
                Err errorResponse ->
                    ( { model | errorServidor = Just errorResponse.message, errorDocumento = Nothing }, showSnackbar "#snackbar" )

                Ok informaciones ->
                    ( { model | informacionCortes = List.head informaciones, errorDocumento = Nothing }, Cmd.none )

        GotApiResponse (Err error) ->
            ( { model | errorServidor = Just <| getErrorMessage error, errorDocumento = Nothing }, showSnackbar "#snackbar" )


getErrorMessage : Http.Error -> String
getErrorMessage error =
    case error of
        BadBody msg ->
            msg

        BadUrl msg ->
            msg

        _ ->
            "Hubo un error al consultar el horario, por favor inténtalo más tarde"



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
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
        , viewErrorServidor model.errorServidor
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
viewForm model =
    H.fieldset []
        [ H.div [ HA.class "field border label", HA.classList [ ( "invalid", Util.isJust model.errorDocumento ) ] ]
            [ H.input [ HE.onInput UpdateDocumento ] []
            , H.label [] [ H.text "Documento" ]
            , viewErrorDocumento model.errorDocumento
            , H.div [ HA.class "small-space" ] []
            ]
        , H.div [ HA.class "right-align" ]
            [ H.button
                [ HA.class "border small no-margin" ]
                [ text "Cargar último documento usado" ]
            ]
        , H.div [ HA.class "small-space" ] []
        , H.div [ HA.class "field border label" ]
            [ H.select [ HA.value <| getCriterioValue model.criterio, HE.onInput (UpdateCriterio << parseCriterio) ]
                [ H.option [ HA.value <| getCriterioValue CuentaContrato ] [ text <| displayCriterio CuentaContrato ]
                , H.option [ HA.value <| getCriterioValue Cuen ] [ text <| displayCriterio Cuen ]
                , H.option [ HA.value <| getCriterioValue Identificacion ] [ text <| displayCriterio Identificacion ]
                ]
            , H.label [] [ H.text "Tipo de documento" ]
            ]
        , H.button [ HA.class "responsive", HE.onClick Submit ]
            [ H.i [] [ text "search" ]
            , text "Consultar"
            ]
        ]


viewErrorDocumento : Maybe String -> Html Msg
viewErrorDocumento error =
    error
        |> Maybe.map (\e -> H.span [ HA.class "error" ] [ text e ])
        |> Maybe.withDefault (text "")


viewErrorServidor : Maybe String -> Html Msg
viewErrorServidor error =
    error
        |> Maybe.map (\msg -> H.div [ HA.class "snackbar error", HA.id "snackbar" ] [ text msg ])
        |> Maybe.withDefault (text "")
