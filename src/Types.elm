module Types exposing (..)


type alias ApiResponse =
    Result ErrorResponse (List InformacionCorteLuz)


type alias HorarioCorte =
    { fechaCorte : String
    , horaDesde : String
    , horaHasta : String
    }


type alias InformacionCorteLuz =
    { alimentador : String
    , cuentaContrato : String
    , cuenta : String
    , direccion : String
    , horarios : List HorarioCorte
    }


type alias ErrorResponse =
    { message : String
    }


type Criterio
    = CuentaContrato
    | Cuen
    | Identificacion


displayCriterio : Criterio -> String
displayCriterio c =
    case c of
        CuentaContrato ->
            "Cuenta contrato"

        Cuen ->
            "Código único (cuen)"

        Identificacion ->
            "Número de identificación"


getCriterioValue : Criterio -> String
getCriterioValue c =
    case c of
        CuentaContrato ->
            "CUENTA_CONTRATO"

        Cuen ->
            "CUEN"

        Identificacion ->
            "IDENTIFICACION"


parseCriterio : String -> Criterio
parseCriterio s =
    case s of
        "CUENTA_CONTRATO" ->
            CuentaContrato

        "CUEN" ->
            Cuen

        "IDENTIFICACION" ->
            Identificacion

        _ ->
            CuentaContrato
