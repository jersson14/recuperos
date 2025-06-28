//LISTAR TODOS
var tbl_facturas;
function listar_facturas_diario(){
  tbl_facturas = $("#tabla_facturas").DataTable({
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
          "url":"../controller/facturas/controlador_listar_facturas.php",
          type:'POST'
      },
      dom: 'Bfrtip', 
       
      buttons: [ 
        {
          extend: 'excelHtml5',
          text: '<i class="fas fa-file-excel"></i> Excel',
          titleAttr: 'Exportar a Excel',
          filename: "LISTA DE FACTURAS",
          title: "LISTA DE FACTURAS",
          className: 'btn btn-excel',
          exportOptions: {
            columns: [ 1, 2, 3, 6, 7, 8] // Exportar solo hasta la columna 'estado'
          }
        },
        {
          extend: 'pdfHtml5',
          text: '<i class="fas fa-file-pdf"></i> PDF',
          titleAttr: 'Exportar a PDF',
          filename: "LISTA DE FACTURAS",
          title: "LISTA DE FACTURAS",
          className: 'btn btn-pdf',
          orientation: 'landscape', // <-- Establece la orientación en horizontal
          pageSize: 'A4', // <-- Especifica el tamaño de la página
          exportOptions: {
            columns: [ 1, 2, 3, 6, 7, 8] // Exportar solo hasta la columna 'estado'
          }
        },
        {
          extend: 'print',
          text: '<i class="fa fa-print"></i> Imprimir',
          titleAttr: 'Imprimir',
          title: "LISTA DE FACTURAS",
          className: 'btn btn-print',
          exportOptions: {
            columns: [ 1, 2, 3, 6, 7, 8] // Exportar solo hasta la columna 'estado'
          }
        }
      ],
      "columns":[
        {"defaultContent":""},
        {"data":"obra_social"},
        {"data":"numero_fact"},
        {
          "data": "monto",
          "render": function (data, type, row) {
            return `<strong>$AR ${data}</strong>`;
          }
        },
        {
          "data": "saldo_cobrado",
          "render": function (data, type, row) {
            return `<strong>$AR ${data}</strong>`;
          }
        },
        {
          "data": "saldo_pendiente",
          render: function(data, type, row) {
            if (data == 0) {
              return '<span class="badge bg-success fs-5">$AR ' + data + '</span>';
            } else {
              return '<span class="badge bg-danger fs-5">$AR ' + data + '</span>';
            }
          }
        },
        {"data":"archivo_fact",
          render: function(data,type,row){
                  if(data=='' || data=='controller/facturas/filefacturas/'){
                      return "<button class='btn btn-danger btn-sm' disabled title='Sin archivo'><i class='fa fa-file-pdf'></i></button>";
                  }else{
                    return "<a class='btn btn-success btn-sm' href='../"+data+"' target='_blank' title='Ver archivo'><i class='fas fa-eye'></i> Ver factura</a>";
                  }
              }   
          },    
        {"data":"nota_credito",
          render: function(data,type,row){
                  if(data=='' || data=='controller/facturas/filenotacredito/'){
                      return "<button class='btn btn-danger btn-sm' disabled title='Ver archivo'><i class='fa fa-file-pdf'></i></button>";
                  }else{
                    return "<a class='btn btn-success btn-sm' href='../"+data+"' target='_blank' title='Ver archivo'><i class='fas fa-eye'></i> Ver nota de credito</a>";
                  }
              }   
          },    
       
        

        {"data":"fecha_credito"},

        {"data":"fecha_formateada"},

        {
            "data": "estado_fact",
            render: function(data, type, row) {
                if (data == 'PENDIENTE') {
                    return '<span class="badge bg-warning">PENDIENTE</span>';
                } else if (data == 'COBRADA') {
                    return '<span class="badge bg-success">COBRADA</span>';
                } else if (data == 'FACTURADA') {
                  return '<span class="badge bg-primary">FACTURADA</span>';
              } else {
                    return '<span class="badge bg-danger">RECHAZADA</span>';
                }
            }
        },        
       

{
  "defaultContent": "<button class='editar btn btn-warning btn-sm' title='Editar archivos de factura'><i class='fa fa-edit'></i> Editar archivos</button>"
}

                
    ],

    "language":idioma_espanol,
    select: true
});
tbl_facturas.on('draw.td',function(){
  var PageInfo = $("#tabla_facturas").DataTable().page.info();
  tbl_facturas.column(0, {page: 'current'}).nodes().each(function(cell, i){
    cell.innerHTML = i + 1 + PageInfo.start;
  });
});
}

function listar_facturas(){
  Cargar_Select_Obras_Sociales();
  Cargar_Select_Usuarios();
  document.getElementById('txt_fecha_desde').value='';
  document.getElementById('txt_fecha_hasta').value='';
  document.getElementById('select_estado').value='';

  tbl_facturas = $("#tabla_facturas").DataTable({
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
          "url":"../controller/facturas/controlador_listar_facturas_total.php",
          type:'POST'
      },
      dom: 'Bfrtip', 
     
      buttons: [ 
        {
          extend: 'excelHtml5',
          text: '<i class="fas fa-file-excel"></i> Excel',
          titleAttr: 'Exportar a Excel',
          filename: "LISTA DE FACTURAS",
          title: "LISTA DE FACTURAS",
          className: 'btn btn-excel',
          exportOptions: {
            columns: [ 1, 2, 3, 6, 7, 8] // Exportar solo hasta la columna 'estado'
          }
        },
        {
          extend: 'pdfHtml5',
          text: '<i class="fas fa-file-pdf"></i> PDF',
          titleAttr: 'Exportar a PDF',
          filename: "LISTA DE FACTURAS",
          title: "LISTA DE FACTURAS",
          className: 'btn btn-pdf',
          orientation: 'landscape', // <-- Establece la orientación en horizontal
          pageSize: 'A4', // <-- Especifica el tamaño de la página
          exportOptions: {
            columns: [ 1, 2, 3, 6, 7, 8] // Exportar solo hasta la columna 'estado'
          }
        },
        {
          extend: 'print',
          text: '<i class="fa fa-print"></i> Imprimir',
          titleAttr: 'Imprimir',
          title: "LISTA DE FACTURAS",
          className: 'btn btn-print',
          exportOptions: {
            columns: [ 1, 2, 3, 6, 7, 8] // Exportar solo hasta la columna 'estado'
          }
        }
      ],
      "columns":[
        {"defaultContent":""},
        {"data":"obra_social"},
        {"data":"numero_fact"},
        {
          "data": "monto",
          "render": function (data, type, row) {
            return `<strong>$AR ${data}</strong>`;
          }
        },
        {
          "data": "saldo_cobrado",
          "render": function (data, type, row) {
            return `<strong>$AR ${data}</strong>`;
          }
        },
        {
          "data": "saldo_pendiente",
          render: function(data, type, row) {
            if (data == 0) {
              return '<span class="badge bg-success fs-5">$AR ' + data + '</span>';
            } else {
              return '<span class="badge bg-danger fs-5">$AR ' + data + '</span>';
            }
          }
        },
        {"data":"archivo_fact",
          render: function(data,type,row){
                  if(data=='' || data=='controller/facturas/filefacturas/'){
                      return "<button class='btn btn-danger btn-sm' disabled title='Sin archivo'><i class='fa fa-file-pdf'></i></button>";
                  }else{
                    return "<a class='btn btn-success btn-sm' href='../"+data+"' target='_blank' title='Ver archivo'><i class='fas fa-eye'></i> Ver factura</a>";
                  }
              }   
          },    
        {"data":"nota_credito",
          render: function(data,type,row){
                  if(data=='' || data=='controller/facturas/filenotacredito/'){
                      return "<button class='btn btn-danger btn-sm' disabled title='Ver archivo'><i class='fa fa-file-pdf'></i></button>";
                  }else{
                    return "<a class='btn btn-success btn-sm' href='../"+data+"' target='_blank' title='Ver archivo'><i class='fas fa-eye'></i> Ver nota de credito</a>";
                  }
              }   
          },    
       
        

        {"data":"fecha_credito"},

        {"data":"fecha_formateada"},

        {
          "data": "estado_fact",
          render: function(data, type, row) {
              if (data == 'PENDIENTE') {
                  return '<span class="badge bg-warning">PENDIENTE</span>';
              } else if (data == 'COBRADA') {
                  return '<span class="badge bg-success">COBRADA</span>';
              } else if (data == 'FACTURADA') {
                return '<span class="badge bg-primary">FACTURADA</span>';
            } else {
              return ` <span class="badge bg-danger">RECHAZADA</span>                    `;

              }
          }
      },        
    
{
  "defaultContent": "<button class='editar btn btn-warning btn-sm' title='Editar archivos de factura'><i class='fa fa-edit'></i> Editar archivos</button>"
}

                
    ],

    "language":idioma_espanol,
    select: true
});
tbl_facturas.on('draw.td',function(){
  var PageInfo = $("#tabla_facturas").DataTable().page.info();
  tbl_facturas.column(0, {page: 'current'}).nodes().each(function(cell, i){
    cell.innerHTML = i + 1 + PageInfo.start;
  });
});
}

//LISTAR POR OBRAS SOCIALES
function listar_practica_paciente_obras(){
  let obra = document.getElementById('select_obras_buscar').value;
  let estado = document.getElementById('select_estado').value;

  tbl_facturas = $("#tabla_facturas").DataTable({
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
          "url":"../controller/facturas/controlador_listar_facturas_obra_estado.php",
          type:'POST',
          data:{
            obra:obra,
            estado:estado
          }
      },
      dom: 'Bfrtip', 
      buttons: [ 
        {
          extend: 'excelHtml5',
          text: '<i class="fas fa-file-excel"></i> Excel',
          titleAttr: 'Exportar a Excel',
          filename: "LISTA DE FACTURAS",
          title: "LISTA DE FACTURAS",
          className: 'btn btn-excel',
          exportOptions: {
            columns: [ 1, 2, 3, 6, 7, 8] // Exportar solo hasta la columna 'estado'
          }
        },
        {
          extend: 'pdfHtml5',
          text: '<i class="fas fa-file-pdf"></i> PDF',
          titleAttr: 'Exportar a PDF',
          filename: "LISTA DE FACTURAS",
          title: "LISTA DE FACTURAS",
          className: 'btn btn-pdf',
          orientation: 'landscape', // <-- Establece la orientación en horizontal
          pageSize: 'A4', // <-- Especifica el tamaño de la página
          exportOptions: {
            columns: [ 1, 2, 3, 6, 7, 8] // Exportar solo hasta la columna 'estado'
          }
        },
        {
          extend: 'print',
          text: '<i class="fa fa-print"></i> Imprimir',
          titleAttr: 'Imprimir',
          title: "LISTA DE FACTURAS",
          className: 'btn btn-print',
          exportOptions: {
            columns: [ 1, 2, 3, 6, 7, 8] // Exportar solo hasta la columna 'estado'
          }
        }
      ],
      "columns":[
        {"defaultContent":""},
        {"data":"obra_social"},
        {"data":"numero_fact"},
        {
          "data": "monto",
          "render": function (data, type, row) {
            return `<strong>$AR ${data}</strong>`;
          }
        },
        {
          "data": "saldo_cobrado",
          "render": function (data, type, row) {
            return `<strong>$AR ${data}</strong>`;
          }
        },
        {
          "data": "saldo_pendiente",
          render: function(data, type, row) {
            if (data == 0) {
              return '<span class="badge bg-success fs-5">$AR ' + data + '</span>';
            } else {
              return '<span class="badge bg-danger fs-5">$AR ' + data + '</span>';
            }
          }
        },
        {"data":"archivo_fact",
          render: function(data,type,row){
                  if(data=='' || data=='controller/facturas/filefacturas/'){
                      return "<button class='btn btn-danger btn-sm' disabled title='Sin archivo'><i class='fa fa-file-pdf'></i></button>";
                  }else{
                    return "<a class='btn btn-success btn-sm' href='../"+data+"' target='_blank' title='Ver archivo'><i class='fas fa-eye'></i> Ver factura</a>";
                  }
              }   
          },    
        {"data":"nota_credito",
          render: function(data,type,row){
                  if(data=='' || data=='controller/facturas/filenotacredito/'){
                      return "<button class='btn btn-danger btn-sm' disabled title='Ver archivo'><i class='fa fa-file-pdf'></i></button>";
                  }else{
                    return "<a class='btn btn-success btn-sm' href='../"+data+"' target='_blank' title='Ver archivo'><i class='fas fa-eye'></i> Ver nota de credito</a>";
                  }
              }   
          },    
       
        

        {"data":"fecha_credito"},

        {"data":"fecha_formateada"},

        {
          "data": "estado_fact",
          render: function(data, type, row) {
              if (data == 'PENDIENTE') {
                  return '<span class="badge bg-warning">PENDIENTE</span>';
              } else if (data == 'COBRADA') {
                  return '<span class="badge bg-success">COBRADA</span>';
              } else if (data == 'FACTURADA') {
                return '<span class="badge bg-primary">FACTURADA</span>';
            } else {
              return ` <span class="badge bg-danger">RECHAZADA</span>                    `;

              }
          }
      },        
   
       {
  "defaultContent": "<button class='editar btn btn-warning btn-sm' title='Editar archivos de factura'><i class='fa fa-edit'></i> Editar archivos</button>"
}

                
    ],

    "language":idioma_espanol,
    select: true
});
tbl_facturas.on('draw.td',function(){
  var PageInfo = $("#tabla_facturas").DataTable().page.info();
  tbl_facturas.column(0, {page: 'current'}).nodes().each(function(cell, i){
    cell.innerHTML = i + 1 + PageInfo.start;
  });
});
}

//LISTAR POR FECHAS Y USUARIO
function listar_practica_paciente_fecha_usu(){
  let fechaini = document.getElementById('txt_fecha_desde').value;
  let fechafin = document.getElementById('txt_fecha_hasta').value;
  let usu = document.getElementById('select_usuario').value;

  tbl_facturas = $("#tabla_facturas").DataTable({
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
          "url":"../controller/facturas/controlador_listar_facturas_fecha_usu.php",
          type:'POST',
          data:{
            fechaini:fechaini,
            fechafin:fechafin,
            usu:usu
          }
      },
      dom: 'Bfrtip', 
     
      buttons: [ 
        {
          extend: 'excelHtml5',
          text: '<i class="fas fa-file-excel"></i> Excel',
          titleAttr: 'Exportar a Excel',
          filename: "LISTA DE FACTURAS",
          title: "LISTA DE FACTURAS",
          className: 'btn btn-excel',
          exportOptions: {
            columns: [ 1, 2, 3, 6, 7, 8] // Exportar solo hasta la columna 'estado'
          }
        },
        {
          extend: 'pdfHtml5',
          text: '<i class="fas fa-file-pdf"></i> PDF',
          titleAttr: 'Exportar a PDF',
          filename: "LISTA DE FACTURAS",
          title: "LISTA DE FACTURAS",
          className: 'btn btn-pdf',
          orientation: 'landscape', // <-- Establece la orientación en horizontal
          pageSize: 'A4', // <-- Especifica el tamaño de la página
          exportOptions: {
            columns: [ 1, 2, 3, 6, 7, 8] // Exportar solo hasta la columna 'estado'
          }
        },
        {
          extend: 'print',
          text: '<i class="fa fa-print"></i> Imprimir',
          titleAttr: 'Imprimir',
          title: "LISTA DE FACTURAS",
          className: 'btn btn-print',
          exportOptions: {
            columns: [ 1, 2, 3, 6, 7, 8] // Exportar solo hasta la columna 'estado'
          }
        }
      ],
      "columns":[
        {"defaultContent":""},
        {"data":"obra_social"},
        {"data":"numero_fact"},
        {
          "data": "monto",
          "render": function (data, type, row) {
            return `<strong>$AR ${data}</strong>`;
          }
        },
        {
          "data": "saldo_cobrado",
          "render": function (data, type, row) {
            return `<strong>$AR ${data}</strong>`;
          }
        },
        {
          "data": "saldo_pendiente",
          render: function(data, type, row) {
            if (data == 0) {
              return '<span class="badge bg-success fs-5">$AR ' + data + '</span>';
            } else {
              return '<span class="badge bg-danger fs-5">$AR ' + data + '</span>';
            }
          }
        },
        {"data":"archivo_fact",
          render: function(data,type,row){
                  if(data=='' || data=='controller/facturas/filefacturas/'){
                      return "<button class='btn btn-danger btn-sm' disabled title='Sin archivo'><i class='fa fa-file-pdf'></i></button>";
                  }else{
                    return "<a class='btn btn-success btn-sm' href='../"+data+"' target='_blank' title='Ver archivo'><i class='fas fa-eye'></i> Ver factura</a>";
                  }
              }   
          },    
        {"data":"nota_credito",
          render: function(data,type,row){
                  if(data=='' || data=='controller/facturas/filenotacredito/'){
                      return "<button class='btn btn-danger btn-sm' disabled title='Ver archivo'><i class='fa fa-file-pdf'></i></button>";
                  }else{
                    return "<a class='btn btn-success btn-sm' href='../"+data+"' target='_blank' title='Ver archivo'><i class='fas fa-eye'></i> Ver nota de credito</a>";
                  }
              }   
          },    
       
        

        {"data":"fecha_credito"},

        {"data":"fecha_formateada"},

    

        {
          "data": "estado_fact",
          render: function(data, type, row) {
              if (data == 'PENDIENTE') {
                  return '<span class="badge bg-warning">PENDIENTE</span>';
              } else if (data == 'COBRADA') {
                  return '<span class="badge bg-success">COBRADA</span>';
              } else if (data == 'FACTURADA') {
                return '<span class="badge bg-primary">FACTURADA</span>';
            } else {
              return ` <span class="badge bg-danger">RECHAZADA</span>`;

              }
          }
      },        
      
      {
  "defaultContent": "<button class='editar btn btn-warning btn-sm' title='Editar archivos de factura'><i class='fa fa-edit'></i> Editar archivos</button>"
}

    ],

    "language":idioma_espanol,
    select: true
});
tbl_facturas.on('draw.td',function(){
  var PageInfo = $("#tabla_facturas").DataTable().page.info();
  tbl_facturas.column(0, {page: 'current'}).nodes().each(function(cell, i){
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

// MODAL ESTADO
$('#tabla_facturas').on('click','.editar',function(){
    var data = tbl_facturas.row($(this).parents('tr')).data();
  
    if(tbl_facturas.row(this).child.isShown()){
        var data = tbl_facturas.row(this).data();
    }
  $("#modal_editar").modal('show');
  
    document.getElementById('lb_tituloesta_pagar').innerHTML="<b>FACTURA N°:</b> "+data.numero_fact+"";
    document.getElementById('lb_titulo2esta_pagar').innerHTML="<b>OBRA SOCIAL:</b> "+data.obra_social+"";
    
    document.getElementById('txt_idfactura').value=data.id_factura;

    document.getElementById('facturaactual').value=data.archivo_fact;
    document.getElementById('notaactual').value=data.nota_credito;
  
  })



function Modificar_Practica_paciente() {


  // DATOS DEL DOCENTE
  let idfactu = document.getElementById('txt_idfactura').value;
  let facturaactu = document.getElementById('facturaactual').value;
  let factura = document.getElementById('txt_factura_editar').value;
  let notacre = document.getElementById('txt_notacre_editar').value;
  let notacreactu = document.getElementById('notaactual').value;
  let fecha = document.getElementById('txt_fecha_nota_editar').value;
  let idusu = document.getElementById('txtprincipalid').value;

  if (idfactu.length == 0 ) {
      return Swal.fire("Mensaje de Advertencia", "Tiene campos vacíos en el formulario, revise", "warning");
  }

  // Obtener la fecha actual para generar nombres únicos
  let f = new Date();

  // Procesar Factura
  let nombrefactura = "";
  if (factura.length > 0) {
      let extensionFact = factura.split('.').pop();
      nombrefactura = "FAC" + f.getDate() + "-" + (f.getMonth() + 1) + "-" + f.getFullYear() + "-" + f.getHours() + "-" + f.getMilliseconds() + "." + extensionFact;
  }

  // Procesar Nota de Crédito
  let nombrenotacre = "";
  if (notacre.length > 0) {
      let extensionNotacre = notacre.split('.').pop();
      nombrenotacre = "NC" + f.getDate() + "-" + (f.getMonth() + 1) + "-" + f.getFullYear() + "-" + f.getHours() + "-" + f.getMilliseconds() + "." + extensionNotacre;
  }

  // Crear FormData
  let formData = new FormData();
  let facturaObj = $("#txt_factura_editar")[0].files[0]; // Obtener el archivo de factura
  let notacreObj = $("#txt_notacre_editar")[0].files[0]; // Obtener el archivo de nota de crédito

  if (facturaObj) {
      formData.append("factura", facturaObj, nombrefactura);
  }
  if (notacreObj) {
      formData.append("notacre", notacreObj, nombrenotacre);
  }

  // Agregar otros datos al FormData
  formData.append("idfactu", idfactu);
  formData.append("facturaactu", facturaactu);
  formData.append("nombrefactura", nombrefactura);
  formData.append("facturaObj", facturaObj);
  formData.append("notacreactu", notacreactu);
  formData.append("nombrenotacre", nombrenotacre);
  formData.append("notacreObj", notacreObj);
  formData.append("fecha", fecha);
  formData.append("idusu", idusu);

  $.ajax({
      url: "../controller/facturas/controlador_modificar_factura_archivos.php",
      type: 'POST',
      data: formData,
      contentType: false,
      processData: false,
      success: function (resp) {
          if (resp.length > 0) {
              // Verificar si hay datos en la tabla antes de llamar a Modificar_detalle_facturas
                  Swal.fire("Mensaje de Confirmación", "Los archivos de la factura se modificó correctamente.", "success").then(() => {
                      tbl_facturas.ajax.reload(); // Recargar tabla
                      $("#modal_editar").modal('hide'); // Cerrar modal
              });
          } else {
              Swal.fire("Mensaje de Advertencia", "No se pudo registrar la factura", "warning");
          }
      }
  });
}

