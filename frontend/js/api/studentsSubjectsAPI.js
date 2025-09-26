/**
*    File        : frontend/js/api/studentsSubjectsAPI.js
*    Project     : CRUD PHP
*    Author      : Tecnologías Informáticas B - Facultad de Ingeniería - UNMdP
*    License     : http://www.gnu.org/licenses/gpl.txt  GNU GPL 3.0
*    Date        : Mayo 2025
*    Status      : Prototype
*    Iteration   : 3.0 ( prototype )
*/

import { createAPI } from './apiFactory.js';
export const studentsSubjectsAPI = createAPI('studentsSubjects');

/**
 * Ejemplo de extensión de la API:
*/
// import { createAPI } from './apiFactory.js';
// const baseAPI = createAPI('studentsSubjects');

// export const studentsSubjectsAPI = 
// {
//     ...baseAPI, // hereda fetchAll, create, update, remove

//     // método adicional personalizado
//     async fetchByStudentId(id) 
//     {
//         const res = await fetch(`../../backend/server.php?module=studentsSubjects&studentId=${id}`);
//         if (!res.ok) throw new Error("No se pudieron obtener asignaciones del estudiante");
//         return await res.json();
//     }
// };

/**
 * También permite url personalizadas ahora:
*/
// const customAPI = createAPI('custom', 
// {
//     urlOverride: '../../backend/misRutas/personalizadas.php'
// });
