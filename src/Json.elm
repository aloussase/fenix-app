module Json exposing (decodeApiResponse)

import Json.Decode exposing (Decoder, andThen, field, list, map, map3, map5, string)
import Types exposing (..)


decodeHorarioCorte : Decoder HorarioCorte
decodeHorarioCorte =
    map3 HorarioCorte
        (field "fechaCorte" string)
        (field "horaDesde" string)
        (field "horaHasta" string)


decodeInformacionCorteLuz : Decoder InformacionCorteLuz
decodeInformacionCorteLuz =
    map5 InformacionCorteLuz
        (field "alimentador" string)
        (field "cuentaContrato" string)
        (field "cuen" string)
        (field "direccion" string)
        (field "detallePlanificacion" (list decodeHorarioCorte))


decodeHorariosCorte : Decoder (List InformacionCorteLuz)
decodeHorariosCorte =
    field "notificaciones" (list decodeInformacionCorteLuz)


decodeErrorResponse : Decoder ErrorResponse
decodeErrorResponse =
    map ErrorResponse (field "mensaje" string)


decodeApiResponse : Decoder ApiResponse
decodeApiResponse =
    field "resp" string
        |> andThen
            (\s ->
                case s of
                    "ERROR" ->
                        decodeErrorResponse |> map Err

                    _ ->
                        decodeHorariosCorte |> map Ok
            )
