
// Contrato API ERROR
/*
 Tiene 4 parametros:
 -primer parametro : El mensaje por defecto que existia previamente -> Error en ${method}
 -segundo parametro: codigo de respuesta, puede servir para algun tipo de validacion
 -tercer parametro:  Un mensaje personalizado recibido por el backend , que deberan llamar messageError en el back
 si no se recibe un  messageError del backend se envia un string vacio
 -cuarto parametros :  envia un dato que en el backend deben llamar como errorData,asignan lo que necesitan mostrar en el front
 si no se recibe un  errorData del backend se envia un string vacio
 Ej: echo json_encode([
    'messageError' => "Solicitud erronea, ingrese los datos nuevamente",
    'errorData' => $datoQueDeseoEnviar, 
        ...
    ]);
*/

export class ApiError extends Error {
  constructor(defaultMessage, status,messageError,errorData = null) {
    super(defaultMessage);
    this.name = this.constructor.name;
    this.status = status;
    this.messageError = messageError;
    this.errorData = errorData;

    if (Error.captureStackTrace) {
      Error.captureStackTrace(this, this.constructor);
    }
  }
}