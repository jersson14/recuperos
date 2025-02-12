//LISTAR TODOS
var tbl_paciente_practica;
function listar_practica_paciente_diario(){
  tbl_paciente_practica = $("#tabla_paciente_practica").DataTable({
      "ordering":false,   
      "bLengthChange":true,
      "searching": { "regex": false },
      "lengthMenu": [ [10, 25, 50, 100, -1], [10, 25, 50, 100, "All"] ],
      "pageLength": 10,
      pagingType: 'full_numbers',
      scrollCollapse: true,
      responsive: true,
      "destroy":true,
      "async": false ,
      "processing": true,
      "ajax":{
          "url":"../controller/practicas_paciente/controlador_listar_practicas_paciente_diario.php",
          type:'POST'
      },
      dom: 'Bfrtip', 
     
      buttons:[ 
        {
          extend: 'excelHtml5',
          text: '<i class="fas fa-file-excel"></i> Excel',
          titleAttr: 'Exportar a Excel',
          filename: function() {
            return "LISTA DE PRÁCTICAS - PACIENTE"
          },
          title: function() {
            return "LISTA DE PRÁCTICAS - PACIENTE"
          },
          className: 'btn btn-excel' // Clase personalizada para Excel
        },
        {
          extend: 'pdfHtml5',
          text: '<i class="fas fa-file-pdf"></i> PDF',
          titleAttr: 'Exportar a PDF',
          filename: function() {
            return "LISTA DE PRÁCTICAS - PACIENTE"
          },
          title: function() {
            return "LISTA DE PRÁCTICAS - PACIENTE"
          },
          className: 'btn btn-pdf' // Clase personalizada para PDF
        },
        {
          extend: 'print',
          text: '<i class="fa fa-print"></i> Imprimir',
          titleAttr: 'Imprimir',
          title: function() {
            return "LISTA DE PRÁCTICAS - PACIENTE"
          },
          className: 'btn btn-print' // Clase personalizada para Imprimir
        }
      ],
      "columns":[
        {"defaultContent":""},
        {"data":"obra_social"},
        {"data":"Dni"},
        {"data":"PACIENTE"},
        {
          "data": "total",
          "render": function (data, type, row) {
            return `<strong>$AR ${data}</strong>`;
          }
        },        
        {"data":"fecha_formateada"},
        {"data":"fecha_formateada2"},
        {"data":"USUARIO"},


        {
          "defaultContent": `
            <button class='mostrar btn btn-success btn-sm' title='Mostrar prácticas del paciente'>
              <i class='fa fa-eye'></i> Ver prácticas
            </button>
            <button class='editar btn btn-primary btn-sm' title='Editar datos de la práctica'>
              <i class='fa fa-edit'></i> Editar
            </button>
            <button class='eliminar btn btn-danger btn-sm' title='Eliminar práctica'>
              <i class='fa fa-trash'></i> Eliminar
            </button>
          `
        }
                
    ],

    "language":idioma_espanol,
    select: true
});
tbl_paciente_practica.on('draw.td',function(){
  var PageInfo = $("#tabla_paciente_practica").DataTable().page.info();
  tbl_paciente_practica.column(0, {page: 'current'}).nodes().each(function(cell, i){
    cell.innerHTML = i + 1 + PageInfo.start;
  });
});
}

function listar_practica_paciente(){
  Cargar_Select_Obras_Sociales();
  Cargar_Select_Usuarios();
  document.getElementById('txt_fecha_desde').value='';
  document.getElementById('txt_fecha_hasta').value='';
  tbl_paciente_practica = $("#tabla_paciente_practica").DataTable({
      "ordering":false,   
      "bLengthChange":true,
      "searching": { "regex": false },
      "lengthMenu": [ [10, 25, 50, 100, -1], [10, 25, 50, 100, "All"] ],
      "pageLength": 10,
      pagingType: 'full_numbers',
      scrollCollapse: true,
      responsive: true,
      "destroy":true,
      "async": false ,
      "processing": true,
      "ajax":{
          "url":"../controller/practicas_paciente/controlador_listar_practicas_paciente.php",
          type:'POST'
      },
      dom: 'Bfrtip', 
     
      buttons:[ 
        {
          extend: 'excelHtml5',
          text: '<i class="fas fa-file-excel"></i> Excel',
          titleAttr: 'Exportar a Excel',
          filename: function() {
            return "LISTA DE PRÁCTICAS - PACIENTE"
          },
          title: function() {
            return "LISTA DE PRÁCTICAS - PACIENTE"
          },
          className: 'btn btn-excel' // Clase personalizada para Excel
        },
        {
          extend: 'pdfHtml5',
          text: '<i class="fas fa-file-pdf"></i> PDF',
          titleAttr: 'Exportar a PDF',
          filename: function() {
            return "LISTA DE PRÁCTICAS - PACIENTE"
          },
          title: function() {
            return "LISTA DE PRÁCTICAS - PACIENTE"
          },
          className: 'btn btn-pdf' // Clase personalizada para PDF
        },
        {
          extend: 'print',
          text: '<i class="fa fa-print"></i> Imprimir',
          titleAttr: 'Imprimir',
          title: function() {
            return "LISTA DE PRÁCTICAS - PACIENTE"
          },
          className: 'btn btn-print' // Clase personalizada para Imprimir
        }
      ],
      "columns":[
        {"defaultContent":""},
        {"data":"obra_social"},
        {"data":"Dni"},
        {"data":"PACIENTE"},
        {
          "data": "total",
          "render": function (data, type, row) {
            return `<strong>$AR ${data}</strong>`;
          }
        },        
        {"data":"fecha_formateada"},
        {"data":"fecha_formateada2"},
        {"data":"USUARIO"},


        {
          "defaultContent": `
            <button class='mostrar btn btn-success btn-sm' title='Mostrar prácticas del paciente'>
              <i class='fa fa-eye'></i> Ver prácticas
            </button>
            <button class='editar btn btn-primary btn-sm' title='Editar datos de la práctica'>
              <i class='fa fa-edit'></i> Editar
            </button>
            <button class='eliminar btn btn-danger btn-sm' title='Eliminar práctica'>
              <i class='fa fa-trash'></i> Eliminar
            </button>
          `
        }
                
    ],

    "language":idioma_espanol,
    select: true
});
tbl_paciente_practica.on('draw.td',function(){
  var PageInfo = $("#tabla_paciente_practica").DataTable().page.info();
  tbl_paciente_practica.column(0, {page: 'current'}).nodes().each(function(cell, i){
    cell.innerHTML = i + 1 + PageInfo.start;
  });
});
}

//LISTAR POR OBRAS SOCIALES
function listar_practica_paciente_obras(){
  let obra = document.getElementById('select_obras_buscar').value;

  tbl_paciente_practica = $("#tabla_paciente_practica").DataTable({
      "ordering":false,   
      "bLengthChange":true,
      "searching": { "regex": false },
      "lengthMenu": [ [10, 25, 50, 100, -1], [10, 25, 50, 100, "All"] ],
      "pageLength": 10,
      pagingType: 'full_numbers',
      scrollCollapse: true,
      responsive: true,
      "destroy":true,
      "async": false ,
      "processing": true,
      "ajax":{
          "url":"../controller/practicas_paciente/controlador_listar_practicas_paciente_obras.php",
          type:'POST',
          data:{
            obra:obra
          }
      },
      dom: 'Bfrtip', 
      buttons:[ 
        {
          extend: 'excelHtml5',
          text: '<i class="fas fa-file-excel"></i> Excel',
          titleAttr: 'Exportar a Excel',
          filename: function() {
            return "LISTA DE PRÁCTICAS - PACIENTE"
          },
          title: function() {
            return "LISTA DE PRÁCTICAS - PACIENTE"
          },
          className: 'btn btn-excel' // Clase personalizada para Excel
        },
        {
          extend: 'pdfHtml5',
          text: '<i class="fas fa-file-pdf"></i> PDF',
          titleAttr: 'Exportar a PDF',
          filename: function() {
            return "LISTA DE PRÁCTICAS - PACIENTE"
          },
          title: function() {
            return "LISTA DE PRÁCTICAS - PACIENTE"
          },
          className: 'btn btn-pdf' // Clase personalizada para PDF
        },
        {
          extend: 'print',
          text: '<i class="fa fa-print"></i> Imprimir',
          titleAttr: 'Imprimir',
          title: function() {
            return "LISTA DE PRÁCTICAS - PACIENTE"
          },
          className: 'btn btn-print' // Clase personalizada para Imprimir
        }
      ],
      "columns":[
        {"defaultContent":""},
        {"data":"obra_social"},
        {"data":"Dni"},
        {"data":"PACIENTE"},
        {
          "data": "total",
          "render": function (data, type, row) {
            return `<strong>$AR ${data}</strong>`;
          }
        },        
        {"data":"fecha_formateada"},
        {"data":"fecha_formateada2"},
        {"data":"USUARIO"},


        {
          "defaultContent": `
            <button class='mostrar btn btn-success btn-sm' title='Mostrar prácticas del paciente'>
              <i class='fa fa-eye'></i> Ver prácticas
            </button>
            <button class='editar btn btn-primary btn-sm' title='Editar datos de la práctica'>
              <i class='fa fa-edit'></i> Editar
            </button>
            <button class='eliminar btn btn-danger btn-sm' title='Eliminar práctica'>
              <i class='fa fa-trash'></i> Eliminar
            </button>
          `
        }
                
    ],

    "language":idioma_espanol,
    select: true
});
tbl_paciente_practica.on('draw.td',function(){
  var PageInfo = $("#tabla_paciente_practica").DataTable().page.info();
  tbl_paciente_practica.column(0, {page: 'current'}).nodes().each(function(cell, i){
    cell.innerHTML = i + 1 + PageInfo.start;
  });
});
}

//LISTAR POR FECHAS Y USUARIO
function listar_practica_paciente_fecha_usu(){
  let fechaini = document.getElementById('txt_fecha_desde').value;
  let fechafin = document.getElementById('txt_fecha_hasta').value;
  let usu = document.getElementById('select_usuario').value;

  tbl_paciente_practica = $("#tabla_paciente_practica").DataTable({
      "ordering":false,   
      "bLengthChange":true,
      "searching": { "regex": false },
      "lengthMenu": [ [10, 25, 50, 100, -1], [10, 25, 50, 100, "All"] ],
      "pageLength": 10,
      pagingType: 'full_numbers',
      scrollCollapse: true,
      responsive: true,
      "destroy":true,
      "async": false ,
      "processing": true,
      "ajax":{
          "url":"../controller/practicas_paciente/controlador_listar_practicas_paciente_fecha_usu.php",
          type:'POST',
          data:{
            fechaini:fechaini,
            fechafin:fechafin,
            usu:usu
          }
      },
      dom: 'Bfrtip', 
     
      buttons:[ 
        {
          extend: 'excelHtml5',
          text: '<i class="fas fa-file-excel"></i> Excel',
          titleAttr: 'Exportar a Excel',
          filename: function() {
            return "LISTA DE PRÁCTICAS - PACIENTE"
          },
          title: function() {
            return "LISTA DE PRÁCTICAS - PACIENTE"
          },
          className: 'btn btn-excel' // Clase personalizada para Excel
        },
        {
          extend: 'pdfHtml5',
          text: '<i class="fas fa-file-pdf"></i> PDF',
          titleAttr: 'Exportar a PDF',
          filename: function() {
            return "LISTA DE PRÁCTICAS - PACIENTE"
          },
          title: function() {
            return "LISTA DE PRÁCTICAS - PACIENTE"
          },
          className: 'btn btn-pdf' // Clase personalizada para PDF
        },
        {
          extend: 'print',
          text: '<i class="fa fa-print"></i> Imprimir',
          titleAttr: 'Imprimir',
          title: function() {
            return "LISTA DE PRÁCTICAS - PACIENTE"
          },
          className: 'btn btn-print' // Clase personalizada para Imprimir
        }
      ],
      "columns":[
        {"defaultContent":""},
        {"data":"obra_social"},
        {"data":"Dni"},
        {"data":"PACIENTE"},
        {
          "data": "total",
          "render": function (data, type, row) {
            return `<strong>$AR ${data}</strong>`;
          }
        },        
        {"data":"fecha_formateada"},
        {"data":"fecha_formateada2"},
        {"data":"USUARIO"},


        {
          "defaultContent": `
            <button class='mostrar btn btn-success btn-sm' title='Mostrar prácticas del paciente'>
              <i class='fa fa-eye'></i> Ver prácticas
            </button>
            <button class='editar btn btn-primary btn-sm' title='Editar datos de la práctica'>
              <i class='fa fa-edit'></i> Editar
            </button>
            <button class='eliminar btn btn-danger btn-sm' title='Eliminar práctica'>
              <i class='fa fa-trash'></i> Eliminar
            </button>
          `
        }
                
    ],

    "language":idioma_espanol,
    select: true
});
tbl_paciente_practica.on('draw.td',function(){
  var PageInfo = $("#tabla_paciente_practica").DataTable().page.info();
  tbl_paciente_practica.column(0, {page: 'current'}).nodes().each(function(cell, i){
    cell.innerHTML = i + 1 + PageInfo.start;
  });
});
}



function AbrirRegistro(){
  $("#modal_registro").modal({backdrop:'static',keyboard:false})
  $("#modal_registro").modal('show');


}
function Cargar_Select_Usuarios() {
  $.ajax({
    url: "../controller/practicas_paciente/controlador_cargar_select_usuario.php",
    type: 'POST',
  }).done(function(resp) {
    let data = JSON.parse(resp);
    let cadena = "<option value=''>Seleccionar Usuario</option>";
    if (data.length > 0) {
      for (let i = 0; i < data.length; i++) {
        cadena += "<option value='" + data[i][0] + "'>DNI: " + data[i][1] + " - Usuario: " + data[i][2] + "</option>";
      }
    } else {
      cadena += "<option value=''>No hay usuarios disponibles</option>";
    }
    $('#select_usuario').html(cadena);


    // Inicializar Select2 después de cargar opciones
    $('#select_usuario').select2({
      placeholder: "Seleccionar Usuario",
      allowClear: true,
      width: '100%' // Asegura que use todo el ancho
    });
  });
}

function Cargar_Select_Areas() {
  $.ajax({
    url: "../controller/practicas_paciente/controlador_cargar_select_area.php",
    type: 'POST',
  }).done(function(resp) {
    let data = JSON.parse(resp);
    let cadena = "<option value=''>Seleccionar Área</option>";
    if (data.length > 0) {
      for (let i = 0; i < data.length; i++) {
        cadena += "<option value='" + data[i][0] + "'>" + data[i][1] + "</option>";
      }
    } else {
      cadena += "<option value=''>No hay áreas disponibles</option>";
    }
    $('#select_area').html(cadena);
    $('#select_area_editar').html(cadena);


    // Inicializar Select2 después de cargar opciones
    $('#select_area').select2({
      placeholder: "Seleccionar Área",
      allowClear: true,
      width: '100%' // Asegura que use todo el ancho
    });
  });
}

function Cargar_Select_Obras_Sociales() {
  $.ajax({
    url: "../controller/obras_sociales/controlador_cargar_select_obras_sociales.php",
    type: 'POST',
  }).done(function(resp) {
    let data = JSON.parse(resp);
    let cadena = "<option value=''>Seleccionar Obra Social</option>";
    if (data.length > 0) {
      for (let i = 0; i < data.length; i++) {
        cadena += "<option value='" + data[i][0] + "'>CUIT: " + data[i][1] + " - Nombre: " + data[i][2] + "</option>";
      }
    } else {
      cadena += "<option value=''>No hay obras disponibles</option>";
    }
    $('#select_obras_buscar').html(cadena);


    // Inicializar Select2 después de cargar opciones
    $('#select_obras_buscar').select2({
      placeholder: "Seleccionar Obra Social",
      allowClear: true,
      width: '100%' // Asegura que use todo el ancho
    });
  });
} 


function Cargar_Select_Obras_Sociales2() {
  $.ajax({
    url: "../controller/obras_sociales/controlador_cargar_select_obras_sociales.php",
    type: 'POST'
  }).done(function(resp) {
    let data = JSON.parse(resp);
    cadena = "<option value='' disabled selected>Seleccione Obra Social</option>"; // Placeholder por defecto
    if (data.length > 0) {
      for (let i = 0; i < data.length; i++) {
        cadena += "<option value='" + data[i][0] + "'>CUIT: " + data[i][1] + " - Nombre: " + data[i][2] + "</option>";
      }
      $('#select_obras, #select_obras_editar').html(cadena);
      
      // Cargar los pacientes correspondientes a la obra seleccionada por defecto
      var id_pacient = $("#select_paciente").val();
      Cargar_Select_Paciente(id_pacient, 'select_paciente');

   
      // Cargar las prácticas correspondientes a la obra seleccionada por defecto
      var id_practica = $("#select_practica").val();
      Cargar_Select_Practica(id_practica, 'select_practica');

      
    } else {
      $('#select_obras, #select_obras_editar').html(cadena);
    }
    $('#select_obras').select2({
      placeholder: "Seleccionar Obra Social",
      allowClear: true,
      width: '100%' // Asegura que use todo el ancho
    });
  });
}

function Cargar_Select_Paciente(id, id_paciente = null) {
  $.ajax({
    url: "../controller/practicas_paciente/controlador_cargar_select_paciente_practica.php",
    type: 'POST',
    data: {
      id: id
    },
  }).done(function(resp) {
    let data = JSON.parse(resp);
    let cadena = "<option value='' disabled selected>No hay datos disponibles</option>";

    if (data.length > 0) {
      cadena = "<option value='' disabled selected>Seleccione paciente</option>"; // Placeholder por defecto
      for (let i = 0; i < data.length; i++) {
        cadena += "<option value='" + data[i][0] + "'>DNI: " + data[i][1] + " - PACIENTE: " + data[i][2] + "</option>";

      }

      $('#select_paciente').html(cadena);

      // Selecciona automáticamente el curso si se pasa id_paciente (para edición)
      if (id_paciente) {
        $('#select_paciente_editar').val(id_paciente).trigger('change');
      }
    } else {
      cadena += "<option value=''>No se encontraron registros</option>";
      $('#select_paciente').html(cadena);
    }
    $('#select_paciente').select2({
      placeholder: "Seleccionar paciente",
      allowClear: true,
      width: '100%' // Asegura que use todo el ancho
    });
  }).fail(function() {
    console.log("Error al cargar los cursos.");
  });
}



function Cargar_Select_Practica(id2, id_practica = null) {
  $.ajax({
    url: "../controller/practicas_paciente/controlador_cargar_select_paciente_practica2.php",
    type: 'POST',
    data: { id2: id2 },
  }).done(function(resp) {
    let data = JSON.parse(resp);
    let cadena = "<option value='' disabled selected>No hay datos disponibles</option>";

    if (data.length > 0) {
      cadena = "<option value='' disabled selected>Seleccione práctica</option>"; // Placeholder
      for (let i = 0; i < data.length; i++) {
        cadena += "<option value='" + data[i][0] + "'>Código: " + data[i][1] + " - Práctica: " + data[i][2] + "</option>";

      }
    }

    // Actualizar los selects
    $('#select_practica').html(cadena);
    $('#select_practica_editar').html(cadena);
 
    // Si hay una práctica seleccionada para edición
    if (id_practica) {
      $('#select_practica_editar').val(id_practica).trigger('change');
    }

    // Inicializar select2
    $('#select_practica').select2({
      placeholder: "Seleccionar práctica",
      allowClear: true,
      width: '100%'
    });

    // Evento change para cargar el precio cuando se seleccione una práctica
    $('#select_practica').on('change', function() {
      var idSeleccionado = $(this).val();
      if (idSeleccionado) {
        Traerprecio(idSeleccionado);
      } else {
        $("#txt_precio").val(''); // Limpiar si no hay selección
      }
    });

  }).fail(function() {
    console.log("Error al cargar las prácticas.");
  });
}

function Traerprecio(id) {
  $.ajax({
    url: "../controller/practicas_paciente/controlador_traermonto.php",
    type: 'POST',
    data: { id: id }
  }).done(function(resp) {
    var data = JSON.parse(resp);
    if (data.length > 0) {
      $("#txt_precio").val(data[0].monto || data[0][1]); // Asegurar acceso correcto al dato
      $("#txt_precio_editar").val(data[0].monto || data[0][1]); // Asegurar acceso correcto al dato
    } else {
      $("#txt_precio").val('');
      $("#txt_precio_editar").val('');

    }
  }).fail(function() {
    console.log("Error al traer el precio.");
  });
}

/////



//ELIMINAR PRACTICA PACIENTE
function Eliminar_Practica_paciente(id){
  $.ajax({
    "url":"../controller/practicas_paciente/controlador_eliminar_practicas_paciente.php",
    type:'POST',
    data:{
      id:id
    }
  }).done(function(resp){
    if(resp>0){
        Swal.fire("Mensaje de Confirmación","Se la práctica del paciente con exito","success").then((value)=>{
          tbl_paciente_practica.ajax.reload();
        });
    }else{
      return Swal.fire("Mensaje de Advetencia","No se puede eliminar esta práctica por que esta siendo utilizado en las facturas, verifique por favor","warning");

    }
  })
}

//ENVIANDO AL BOTON DELETE
$('#tabla_paciente_practica').on('click','.eliminar',function(){
  var data = tbl_paciente_practica.row($(this).parents('tr')).data();

  if(tbl_paciente_practica.row(this).child.isShown()){
      var data = tbl_paciente_practica.row(this).data();
  }
  Swal.fire({
    title: 'Desea eliminar la práctica del paciente: <b style="color:blue">'+data.PACIENTE+'</b>?',
    text: "Una vez aceptado la práctica sera eliminada por completo!!!",
    icon: 'warning',
    showCancelButton: true,
    confirmButtonColor: '#3085d6',
    cancelButtonColor: '#d33',
    confirmButtonText: 'Si, Eliminar'
  }).then((result) => {
    if (result.isConfirmed) {
      Eliminar_Practica_paciente(data.id_paciente_practica);
    }
  })
})

//MODAL VER PRÁCTICAS
$('#tabla_paciente_practica').on('click','.mostrar',function(){
  var data = tbl_paciente_practica.row($(this).parents('tr')).data();

  if(tbl_paciente_practica.row(this).child.isShown()){
      var data = tbl_paciente_practica.row(this).data();
  }
$("#modal_ver_practicas").modal('show');

  document.getElementById('lb_titulo').innerHTML="<b>PRÁCTICAS DEL PACIENTE:</b> "+data.PACIENTE+"";
  document.getElementById('lb_titulo2').innerHTML="<b>OBRA SOCIAL:</b> "+data.obra_social+"";

  listar_practicas(data.id_paciente_practica);

})
// VISTA DE PRACTICAS
var tbl_practica;
function listar_practicas(id) {
  tbl_practica = $("#tabla_ver_practicas").DataTable({
      "ordering": false,
      "bLengthChange": true,
      "searching": false,  // Deshabilita la barra de búsqueda
      "lengthMenu": [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]],
      "pageLength": 5,
      "destroy": true,
      "pagingType": 'full_numbers',
      "scrollCollapse": true,
      "responsive": true,
      "async": false,
      "processing": true,
      "ajax": {
          "url": "../controller/practicas_paciente/controlador_listar_tabla_practicas_paciente.php",
          "type": "POST",
          "data": { id: id },
          "dataSrc": function(json) {
              console.log("Respuesta JSON:", json);
              return json.data;
          }
      },
      "columns": [
          { 
              "data": null, 
              "render": function(data, type, row, meta) {
                  return meta.row + 1; // Asigna un número correlativo
              }
          },
          { "data": "cod_practica" },
          { "data": "PRACTICA" },
          { 
              "data": "subtotal",
              "render": function(data) {
                  return `<strong>$AR ${parseFloat(data).toFixed(2)}</strong>`;  
              }
          }
      ],
      "language": idioma_espanol,
      "select": true
  });

  // Evento para calcular y mostrar el total con tamaño más grande
  tbl_practica.on('draw.dt', function() {
      var total = 0;

      // Sumar los valores de la columna "subtotal"
      tbl_practica.column(3, { page: 'current' }).data().each(function(value) {
          total += parseFloat(value) || 0;
      });

      // Mostrar el total con tamaño más grande
      $('#total_sub_total').html(`<span style="font-size: 20px; font-weight: bold; color: #0A5D86;">$AR ${total.toFixed(2)}</span>`);
  });

}




function Agregar_practica(){
  var id_practica=$("#select_practica").val();
  var practica=$("#select_practica option:selected").text();
  var precio=$("#txt_precio").val();




  if(verificarid(id_practica)){
   return Swal.fire("Mensaje de Advertencia","La práctica ya fue agregado a la tabla","warning");
  }

  var datos_agregar ="<tr>";

  datos_agregar+="<td for='id'>"+id_practica+"</td>";
  datos_agregar+="<td>"+practica+"</td>";
  datos_agregar+="<td>"+precio+"</td>";

  datos_agregar+="<td><button class='btn btn-danger' onclick='remove(this)'><i class='fas fa-trash'><i></button></td>";
  datos_agregar+="</tr>";
  $("#tabla_practica").append(datos_agregar);
  SumarTotal();

 
}
//BORRAR REGISTRO
function remove(t){
  var td =t.parentNode;
  var tr=td.parentNode;
  var table =tr.parentNode;
  table.removeChild(tr);
  SumarTotal();

}
//SUMAR TOTAL
// SUMAR TOTAL
function SumarTotal() {
  let total = 0;

  // Recorremos cada fila de la tabla
  $("#tabla_practica tbody tr").each(function () {
    let precio = $(this).find('td').eq(2).text().trim(); // Tomamos el precio de la columna correcta (índice 2)
    
    if (precio !== "") { // Aseguramos que el valor no esté vacío
      total += parseFloat(precio) || 0; // Convertimos a número y evitamos NaN con || 0
    }
  });

  // Mostramos el total en el label
  $("#lbl_totalneto").html("<b>Total: </b>$AR " + total.toFixed(2));
}

//VALIDACIÓN
function verificarid(id){
  let idverificar=document.querySelectorAll('#tabla_practica td[for="id"]');
  return [].filter.call(idverificar, td=>td.textContent ===id).length===1;
}


function Registrar_Practica() {
  let count = $("#tabla_practica tbody#tbody_tabla_practica tr").length;
  if (count === 0) {
      return Swal.fire("Mensaje de Advertencia", "La tabla de prácticas debe tener al menos un registro", "warning");
  }

  let area = $("#select_area").val();
  let paciente = $("#select_paciente").val();
  let practica = $("#select_practica").val();

  if (!area || !paciente || !practica) {
      return Swal.fire("Mensaje De Advertencia", "Debe llenar los datos de la práctica primero para guardar", "warning");
  }

  let total = parseFloat(document.getElementById('lbl_totalneto').textContent.replace(/[^0-9.]/g, '')) || 0;
  let idusu = document.getElementById('txtprincipalid').value;

  $.ajax({
      url: "../controller/practicas_paciente/controlador_registrar_practicas_docente.php",
      type: 'POST',
      data: {
          area2: area,
          paciente2: paciente,
          total: total,
          idusu: idusu
      }
  }).done(function (resp) {
      if (resp > 0) {
          Registrar_Detalle_practicas(parseInt(resp));
          Swal.fire("Mensaje de Confirmación", "Datos registrados correctamente", "success").then(() => {
              tbl_paciente_practica.ajax.reload();
              $('#tabla_practica').DataTable().clear().draw();
              $("#modal_registro").modal('hide');
          });
      } else {
          return Swal.fire("Mensaje De Advertencia", "Lo sentimos, no se pudo completar el registro", "warning");
      }
  });
}

// REGISTRO DETALLE PRACTICAS
function Registrar_Detalle_practicas(id) {
  let count = $("#tabla_practica tbody#tbody_tabla_practica tr").length;
  if (count === 0) {
      return Swal.fire("Mensaje de Advertencia", "El detalle de las prácticas debe tener al menos un registro", "warning");
  }

  let arreglo_practica = [];
  let arreglo_subtotal = [];

  $("#tabla_practica tbody#tbody_tabla_practica tr").each(function () {
      arreglo_practica.push($(this).find('td').eq(0).text().trim());
      arreglo_subtotal.push($(this).find('td').eq(2).text().trim());
  });

  let practicas = arreglo_practica.join(",");
  let subtotal = arreglo_subtotal.join(",");

  $.ajax({
      url: "../controller/practicas_paciente/controlador_detalle_practicas.php",
      type: 'POST',
      data: {
          id: id,
          practicas: practicas,
          subtotal:subtotal
      }
  }).done(function (resp) {
      if (resp > 0) {
          tbl_paciente_practica.ajax.reload();
          $("#modal_registro").modal('hide');
      } else {
          return Swal.fire("Mensaje De Advertencia", "Lo sentimos, no se pudo completar el registro", "warning");
      }
  });
}

//EDITAR PRACTICAS - PACIENTE

$('#tabla_paciente_practica').on('click','.editar',function(){
  var data = tbl_paciente_practica.row($(this).parents('tr')).data();

  if(tbl_paciente_practica.row(this).child.isShown()){
      var data = tbl_paciente_practica.row(this).data();
  }
  $("#modal_editar").modal('show');
  $("#select_obras_editar").val(data.id_cuit).trigger('change');
  document.getElementById('txt_id_detalle').value = data.id_paciente_practica;
  document.getElementById('txt_area').value = data.area_nombre;
  document.getElementById('txt_paciente').value = data.PACIENTE;
  document.getElementById('txt_profesional_editar').value = data.USUARIO;
  document.getElementById('txt_fecha_editar').value = data.fecha_formateada;

  listar_practicas_del_paciente(data.id_paciente_practica);

})
var tbl_traer_datos;
function listar_practicas_del_paciente(id) {

  tbl_traer_datos = $("#tabla_practica_editar").DataTable({
    "ordering": false,
    "bLengthChange": false,
    "searching": false,
    "lengthMenu": [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]],
    "pageLength": 10,
    "destroy": true,
    "pagingType": 'full_numbers',
    "scrollCollapse": false,
    "responsive": true,
    "processing": true,
   "ajax": {
    "url": "../controller/practicas_paciente/controlador_listar_detalle_practicas.php",
    "type": 'POST',
    "data": { id: id },
   
    },
    "columns": [
      {"data": "id_paciente_practica"},
      {"data": "id_practica"},
      {"data": "practica"},
      {"data": "subtotal"},
      {"defaultContent": "<button class='delete btn btn-danger btn-sm' title='Eliminar datos de especialidad'><i class='fa fa-trash'></i> Eliminar</button>"}
    ],
    "language": idioma_espanol,
    "select": true
  });
}

function Eliminar_detalle_practica_unico(id){
  $.ajax({
    "url":"../controller/practicas_paciente/controlador_eliminar_detalle_practica.php",
    type:'POST',
    data:{
      id:id
    }
  }).done(function(resp){
    if(resp>0){
        Swal.fire("Mensaje de Confirmación","Se elimino la práctica exitosamente","success").then((value)=>{
          tbl_traer_datos.ajax.reload();
        });
    }else{
      return Swal.fire("Mensaje de Advetencia","No se puede eliminar esta práctica por que esta siendo utilizado en otros formularios, verifique por favor","warning");

    }
  })
}

//ENVIANDO AL BOTON DELETE
$('#tabla_practica_editar').on('click','.delete',function(){
  var data = tbl_traer_datos.row($(this).parents('tr')).data();

  if(tbl_traer_datos.row(this).child.isShown()){
      var data = tbl_traer_datos.row(this).data();
  }
  Swal.fire({
    title: 'Desea eliminar la práctica: '+data.practica+' seleccionado?',
    text: "Una vez aceptado la práctica sera eliminada!!!",
    icon: 'warning',
    showCancelButton: true,
    confirmButtonColor: '#3085d6',
    cancelButtonColor: '#d33',
    confirmButtonText: 'Si, Eliminar'
  }).then((result) => {
    if (result.isConfirmed) {
      Eliminar_detalle_practica_unico(data.id_practica_paciente_total);
    }
  })
})



function Agregar_practica_editar(){
  var id_practica_edi_principal=$("#txt_id_detalle").val();
  var id_practica_edi=$("#select_practica_editar").val();
  var practica_edi=$("#select_practica_editar option:selected").text();
  var precio_edi=$("#txt_precio_editar").val();




  if(verificarid_editar(id_practica_edi)){
   return Swal.fire("Mensaje de Advertencia","La práctica ya fue agregado a la tabla","warning");
  }

  var datos_agregar ="<tr>";

  datos_agregar+="<td >"+id_practica_edi_principal+"</td>";
  datos_agregar+="<td for='id'>"+id_practica_edi+"</td>";
  datos_agregar+="<td>"+practica_edi+"</td>";
  datos_agregar+="<td>"+precio_edi+"</td>";

  datos_agregar+="<td><button class='btn btn-danger' onclick='remove(this)'><i class='fas fa-trash'><i></button></td>";
  datos_agregar+="</tr>";
  $("#tabla_practica_editar").append(datos_agregar);
  SumarTotal_Editar();

 
}
//BORRAR REGISTRO
function remove(t){
  var td =t.parentNode;
  var tr=td.parentNode;
  var table =tr.parentNode;
  table.removeChild(tr);
  SumarTotal_Editar();

}
//SUMAR TOTAL
// SUMAR TOTAL
function SumarTotal_Editar() {
  let total = 0;

  // Recorremos cada fila de la tabla
  $("#tabla_practica_editar tbody tr").each(function () {
    let precio = $(this).find('td').eq(3).text().trim(); // Tomamos el precio de la columna correcta (índice 2)
    
    if (precio !== "") { // Aseguramos que el valor no esté vacío
      total += parseFloat(precio) || 0; // Convertimos a número y evitamos NaN con || 0
    }
  });

  // Mostramos el total en el label
  $("#lbl_totalneto_editar").html("<b>Total: </b>$AR " + total.toFixed(2));
}

//VALIDACIÓN
function verificarid_editar(id){
  let idverificar=document.querySelectorAll('#tabla_practica_editar td[for="id"]');
  return [].filter.call(idverificar, td=>td.textContent ===id).length===1;
}

//EDITANDO PRACTICAS
function Modificar_detalle_practicas() {
  let componentes = [];  // Se inicializa el array vacío cada vez que se ejecuta la función

  // Recorre cada fila de la tabla de edición para extraer los datos
  $("#tabla_practica_editar tr").each(function() {
    var idpracitcageneral = $(this).find('td').eq(0).text().trim();  // ID de la hora
    var idpracitca = $(this).find('td').eq(1).text().trim();  // ID de la hora
    var precio = $(this).find('td').eq(3).text().trim();  // ID de la asignatura

    // Validar que todos los campos estén llenos y no sean valores vacíos
    if (idpracitca && precio) {
      componentes.push({
        idpracitcageneral:idpracitcageneral,
        idpracitca: idpracitca,
        precio: precio,
      });
    }
  });

  // Verificar si hay componentes válidos para enviar
  if (componentes.length === 0) {
    return Swal.fire("Mensaje de Advertencia", "No hay prácticas válidos en la tabla para modificar", "warning");
  }

  // Enviar la solicitud AJAX al servidor para modificar los componentes
  $.ajax({
    url: '../controller/practicas_paciente/controlador_modificar_detalle_practicas.php',
    type: 'POST',
    data: {
      componentes: JSON.stringify(componentes)  // Enviar solo los datos de la tabla actual
    }
  }).done(function(resp) {
    console.log("Respuesta del servidor:", resp);  // Verificar la respuesta del servidor
    if (resp == 1) {
      Swal.fire("Mensaje de Confirmación", "Prácticas modificadas satisfactoriamente!!!", "success").then(() => {
        tbl_paciente_practica.ajax.reload();  // Recargar la tabla original (si es necesario)
        $("#modal_editar").modal('hide');  // Ocultar el modal de edición
      });
    } else {
      Swal.fire("Mensaje de Información", "No se modificaron las prácticas porque ya existen", "warning");
    }
  });
}

