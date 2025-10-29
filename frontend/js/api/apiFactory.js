/**
*    File        : frontend/js/api/apiFactory.js
*    Project     : CRUD PHP
*    Author      : Tecnologías Informáticas B - Facultad de Ingeniería - UNMdP
*    License     : http://www.gnu.org/licenses/gpl.txt  GNU GPL 3.0
*    Date        : Mayo 2025
*    Status      : Prototype
*    Iteration   : 2.0 ( prototype )
*/

import { ApiError } from "../exceptions/apiError.js";

export function createAPI(moduleName, config = {}) {
    const API_URL = config.urlOverride ?? `../../backend/server.php?module=${moduleName}`;

    async function sendJSON(method, data) {
        const res = await fetch(API_URL,
            {
                method,
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(data)
            });
        let datos;
        try {
            datos = await res.json();
        } catch (error) {
            //Caso json invalido o cuerpo de json vacio(no content)
            datos = {}
        }
        // Contrato API ERROR
        /*
         Tiene 3 parametros:
         primer parametro : El mensaje por defecto que existia previamente -> Error en ${method}
         segundo parametro: codigo de respuesta, puede servir para algun tipo de validacion
         tercer parametro:  Un mensaje personalizado recibido por el backend , que deberan llamar messageError en el back
         Si no se recibe un  messageError del backend se envia un string vacio
         cuarto parametros :  envia un dato que en el backend deben llamar como errorData -> asignan lo que necesitan mostrar en el front
         Ej: echo json_encode([
            'errorData' => $datoQueDeseoEnviar, 
                ...
            ]);
         Si no se recibe un  errorData del backend se envia un string vacio
        */
        if (!res.ok) throw new ApiError(`Error en ${method}`, res.status, datos.messageError ?? "", datos.errorData ?? "");

        return datos;
    }

    return {
        async fetchAll() {
            const res = await fetch(API_URL);
            if (!res.ok) throw new Error("No se pudieron obtener los datos");
            return await res.json();
        },
        //2.0
        async fetchPaginated(page = 1, limit = 10) {
            const url = `${API_URL}&page=${page}&limit=${limit}`;
            const res = await fetch(url);
            if (!res.ok)
                throw new Error("Error al obtener datos paginados");
            return await res.json();
        },
        async create(data) {
            return await sendJSON('POST', data);
        },
        async update(data) {
            return await sendJSON('PUT', data);
        },
        async remove(id) {
            return await sendJSON('DELETE', { id });
        }
    };
}
