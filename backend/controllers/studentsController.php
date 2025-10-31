<?php
/**
*    File        : backend/controllers/studentsController.php
*    Project     : CRUD PHP
*    Author      : Tecnologías Informáticas B - Facultad de Ingeniería - UNMdP
*    License     : http://www.gnu.org/licenses/gpl.txt  GNU GPL 3.0
*    Date        : Mayo 2025
*    Status      : Prototype
*    Iteration   : 2.0 ( prototype )
*/

require_once("./repositories/students.php");
require_once("./repositories/studentsSubjects.php");


// Para GET (usamos la variable superglobal $_GET):
//https://www.php.net/manual/es/language.variables.superglobals.php
function handleGet($conn) 
{
    $input = json_decode(file_get_contents("php://input"), true);
    if (isset($_GET['id'])) 
    {
        $student = getStudentById($conn, $_GET['id']);
        echo json_encode($student);
    } 
    //2.0
    else if (isset($_GET['page']) && isset($_GET['limit'])) 
    {
        $page = (int)$_GET['page'];
        $limit = (int)$_GET['limit'];
        $offset = ($page - 1) * $limit;

        $students = getPaginatedStudents($conn, $limit, $offset);
        $total = getTotalStudents($conn);

        echo json_encode([
            'students' => $students, // ya es array
            'total' => $total        // ya es entero
        ]);
    }
    else
    {
        $students = getAllStudents($conn); // ya es array
        echo json_encode($students);
    }
}

function handlePost($conn) 
{
    $input = json_decode(file_get_contents("php://input"), true);
    
    $email = $input['email'] ?? null;
    
    //Valido la existencia del email
    $existingEmail = getStudentByEmail($conn, $email);

    if ($existingEmail) {
        //El email ya existe
        http_response_code(409);
        echo json_encode(["error" => "El email ya está registrado en la base de datos."]);
    }
    else
    {
        $result = createStudent($conn, $input['fullname'], $input['email'], $input['age']);
        if ($result['inserted'] > 0) 
        {
            echo json_encode(["message" => "Estudiante agregado correctamente"]);
        } 
        else 
        {
            http_response_code(500);
            echo json_encode(["error" => "No se pudo agregar"]);
        }
    }
}



function handlePut($conn) 
{
    $input = json_decode(file_get_contents("php://input"), true);

    $email = $input['email'] ?? null;
    
    //Valido la existencia del email
    if ($existingEmail) {
        //El email ya existe
        http_response_code(409);
        echo json_encode(["error" => "El email ya está registrado en la base de datos."]);
    }
    else
    {
        $result = updateStudent($conn, $input['id'], $input['fullname'], $input['email'], $input['age']);
        if ($result['updated'] > 0) 
        {
            echo json_encode(["message" => "Actualizado correctamente"]);
        } 
        else 
        {
            http_response_code(500);
            echo json_encode(["error" => "No se pudo actualizar"]);
        }
    }
}

function handleDelete($conn) 
{
    $input = json_decode(file_get_contents("php://input"), true);

    #pregunto por si tiene alguna materia asociada
    $hasSubjectsAssociated =  getSubjectsByStudent($conn,$input['id']);
    error_log("Datos recibidos: " . json_encode($hasSubjectsAssociated));
    #Array vacio -> elimino el estudiante o falla por error 500
    if(empty($hasSubjectsAssociated)){
      $result = deleteStudent($conn, $input['id']);
      if ($result['deleted'] > 0) 
      {
          echo json_encode(["message" => "Eliminado correctamente"]);
      } 
      else 
      {
          http_response_code(500);
          echo json_encode(["error" => "No se pudo eliminar"]);
      }
    }else {
        #Si el array no esta vacio 

        #Tomo la primer materia, puede tener muchas asociadas
        $firstSubjectName = $hasSubjectsAssociated[0]['name'];
        #Envio un 202, aceptado pero no lo dejo eliminar, no lo tomo como un error de la familia 400
        http_response_code(202);
        #Envio el "error" y la materia asociada
        echo json_encode(["error" => "No se puede eliminar estudiantes con materias",
                          "materia" => $firstSubjectName]);
    }
}
?>