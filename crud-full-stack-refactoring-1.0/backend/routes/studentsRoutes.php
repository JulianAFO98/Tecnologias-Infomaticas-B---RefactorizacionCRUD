<?php
/**
*    File        : backend/routes/studentsRoutes.php
*    Project     : CRUD PHP
*    Author      : Tecnologías Informáticas B - Facultad de Ingeniería - UNMdP
*    License     : http://www.gnu.org/licenses/gpl.txt  GNU GPL 3.0
*    Date        : Mayo 2025
*    Status      : Prototype
*    Iteration   : 3.0 ( prototype )
*/
require_once("./config/databaseConfig.php");
require_once("./routes/routesFactory.php");
require_once("./controllers/studentsController.php");

routeRequest($conn);

/**
 * Ejemplo de como se extiende un archivo de rutas 
 * para casos particulares
 * o validaciones:
 */
// routeRequest($conn, [
//     'POST' => function($conn) 
//     {
//         // Validación o lógica extendida
//         $input = json_decode(file_get_contents("php://input"), true);
//         if (empty($input['fullname'])) 
//         {
//             http_response_code(400);
//             echo json_encode(["error" => "Falta el nombre"]);
//             return;
//         }
//         handlePost($conn);
//     }
// ]);