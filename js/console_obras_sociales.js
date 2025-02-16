var tbl_obras_sociales;
function listar_obras_sociales(){
  tbl_obras_sociales = $("#tabla_obras_sociales").DataTable({
      "ordering":true,   
      "bLengthChange":true,
      "searching": { "regex": false },
      "lengthMenu": [ [10, 25, 50, 100, -1], [10, 25, 50, 100, "All"] ],
      "pageLength": 10,
      "destroy":true,
      pagingType: 'full_numbers',
      scrollCollapse: true,
      responsive: true,
      "async": false ,
      "processing": true,
      "ajax":{
          "url":"../controller/obras_sociales/controlador_listar_obras_sociales.php",
          type:'POST'
      },
      dom: 'Bfrtip', 
   
      buttons: [ 
        {
          extend: 'excelHtml5',
          text: '<i class="fas fa-file-excel"></i> Excel',
          titleAttr: 'Exportar a Excel',
          filename: function() {
            return "LISTA DE OBRAS SOCIALES"
          },
          title: function() {
            return "LISTA DE OBRAS SOCIALES"
          },
          className: 'btn btn-excel',
          exportOptions: {
            columns: [ 1, 2, 3, 4, 5, 6,7] // Exportar solo hasta la columna 'estado'
          }
        },
        {
          extend: 'pdfHtml5',
          text: '<i class="fas fa-file-pdf"></i> PDF',
          titleAttr: 'Exportar a PDF',
          filename: function() {
            return "LISTA DE OBRAS SOCIALES"
          },
          title: function() {
            return "LISTA DE OBRAS SOCIALES"
          },
          className: 'btn btn-pdf',
          exportOptions: {
            columns: [ 1, 2, 3, 4, 5, 6,7] // Exportar solo hasta la columna 'estado'
          }
        },
        {
          extend: 'print',
          text: '<i class="fa fa-print"></i> Imprimir',
          titleAttr: 'Imprimir',
          title: function() {
            return "LISTA DE OBRAS SOCIALES"
          },
          className: 'btn btn-print',
          exportOptions: {
            columns: [ 1, 2, 3, 4, 5, 6,7] // Exportar solo hasta la columna 'estado'
          }
        }
      ],
      "columns":[
        {"defaultContent":""},
        {"data":"Cuit"},
        {"data":"Nombre"},
        {"data":"domicilio"},
        {"data":"localidad"},
        {"data":"email"},
        {"data":"fecha_formateada"},
        {"data":"estado_obra",
            render: function(data,type,row){
                    if(data=='ACTIVO'){
                    return '<span class="badge bg-success">ACTIVO</span>';
                    }else{
                    return '<span class="badge bg-danger">INACTIVO</span>';
                    }
            }   
        },
        {
          "defaultContent": `
            <button class='mostrar btn btn-success btn-sm' title='Mostrar datos de área'>
              <i class='fa fa-eye'></i> Mostrar
            </button>
            <button class='editar btn btn-primary btn-sm' title='Editar datos de área'>
              <i class='fa fa-edit'></i> Editar
            </button>
            <button class='eliminar btn btn-danger btn-sm' title='Eliminar datos de área'>
              <i class='fa fa-trash'></i> Eliminar
            </button>
          `
        }
                
    ],

    "language":idioma_espanol,
    select: true
});
tbl_obras_sociales.on('draw.td',function(){
  var PageInfo = $("#tabla_obras_sociales").DataTable().page.info();
  tbl_obras_sociales.column(0, {page: 'current'}).nodes().each(function(cell, i){
    cell.innerHTML = i + 1 + PageInfo.start;
  });
});
}

//MOSTRAR
$('#tabla_obras_sociales').on('click','.mostrar',function(){
  var data = tbl_obras_sociales.row($(this).parents('tr')).data();

  if(tbl_obras_sociales.row(this).child.isShown()){
      var data = tbl_obras_sociales.row(this).data();
  }
  $("#modal_mostrar").modal('show');
  document.getElementById('txt_cuit_mostrar').value=data.Cuit;
  document.getElementById('tct_nombre_mostrar').value=data.Nombre;
  document.getElementById('txt_domicilio_mostrar').value=data.domicilio;
  document.getElementById('tct_localidad_mostrar').value=data.localidad;
  document.getElementById('tct_email_mostrar').value=data.email;
  document.getElementById('tct_update_mostrar').value=data.fecha_formateada2;
  document.getElementById('txt_user_mostrar').value=data.USUARIO;

})



//EDITAR
$('#tabla_obras_sociales').on('click','.editar',function(){
  var data = tbl_obras_sociales.row($(this).parents('tr')).data();

  if(tbl_obras_sociales.row(this).child.isShown()){
      var data = tbl_obras_sociales.row(this).data();
  }
  $("#modal_editar").modal('show');
  document.getElementById('id_obra_social').value=data.id_cuit;
  document.getElementById('txt_cuit_editar').value=data.Cuit;
  document.getElementById('tct_nombre_editar').value=data.Nombre;
  document.getElementById('txt_domicilio_editar').value=data.domicilio;
  document.getElementById('tct_localidad_editar').value=data.localidad;
  document.getElementById('tct_email_editar').value=data.email;
  document.getElementById('txt_estatus').value=data.estado_obra;

})



function AbrirRegistro(){
  $("#modal_registro").modal({backdrop:'static',keyboard:false})
  $("#modal_registro").modal('show');
}

function Registrar_Obra_Social(){
  let cuit = document.getElementById('txt_cuit').value;
  let nombre = document.getElementById('tct_nombre').value;
  let domi = document.getElementById('txt_domicilio').value;
  let local = document.getElementById('tct_localidad').value;
  let email = document.getElementById('tct_email').value;
  let idusu = document.getElementById('txtprincipalid').value;


  if(cuit.length==0||nombre.length==0||domi.length==0||local.length==0||email.length==0){
      return Swal.fire("Mensaje de Advertencia","Tiene campos vacios","warning");
  }
  $.ajax({
    "url":"../controller/obras_sociales/controlador_registro_obras_sociales.php",
    type:'POST',
    data:{
      cuit:cuit,
      nombre:nombre,
      domi:domi,
      local:local,
      email:email,
      idusu:idusu
    }
  }).done(function(resp){
    if(resp>0){
      if(resp==1){
        Swal.fire("Mensaje de Confirmación","Nueva obra social registrada con el nombre: <b>"+nombre+"</b>","success").then((value)=>{
          tbl_obras_sociales.ajax.reload();
          document.getElementById('txt_cuit').value="";
          document.getElementById('tct_nombre').value="";
          document.getElementById('txt_domicilio').value="";
          document.getElementById('tct_localidad').value="";
          document.getElementById('tct_email').value="";

        $("#modal_registro").modal('hide');
        });
      }else{
        Swal.fire("Mensaje de Advertencia","La obra social con el N° CUIT que intenta registrar ya se encuentra en la base de datos, ingrese otro número","warning");
      }
    }else{
      return Swal.fire("Mensaje de Error","No se completo el registro","error");

    }
  })
}
function Modificar_Obra_Social(){
  let id = document.getElementById('id_obra_social').value;
  let cuit = document.getElementById('txt_cuit_editar').value;
  let nombre = document.getElementById('tct_nombre_editar').value;
  let domi = document.getElementById('txt_domicilio_editar').value;
  let local = document.getElementById('tct_localidad_editar').value;
  let email = document.getElementById('tct_email_editar').value;
  let estado = document.getElementById('txt_estatus').value;
  let idusu = document.getElementById('txtprincipalid').value;

  if(id.length==0||cuit.length==0||nombre.length==0||domi.length==0||local.length==0||email.length==0||estado.length==0){
    return Swal.fire("Mensaje de Advertencia","Tiene campos vacios","warning");
  }
  $.ajax({
    "url":"../controller/obras_sociales/controlador_modificar_obras_sociales.php",
    type:'POST',
    data:{
      id:id,
      cuit:cuit,
      nombre:nombre,
      domi:domi,
      local:local,
      email:email,
      estado:estado,
      idusu:idusu
    }
  }).done(function(resp){
    if(resp>0){
      if(resp==1){
        Swal.fire("Mensaje de Confirmación","Datos actualizados correctamente!!!","success").then((value)=>{
          tbl_obras_sociales.ajax.reload();
        $("#modal_editar").modal('hide');
        });
      }else{
        Swal.fire("Mensaje de Advertencia","El N° de CUIT que intenta actualizar ya se encuentra en la base de datos, ingrese otro número o revise por favor","warning");
      }
    }else{
      return Swal.fire("Mensaje de Error","No se completo la actualización","error");

    }
  })
}

//ELIMINAR
function Eliminar_Obras_Sociales(id){
  $.ajax({
    "url":"../controller/obras_sociales/controlador_eliminar_obra_social.php",
    type:'POST',
    data:{
      id:id
    }
  }).done(function(resp){
    if(resp>0){
        Swal.fire("Mensaje de Confirmación","Se elimino la obra social con exito","success").then((value)=>{
          tbl_obras_sociales.ajax.reload();

        });
    }else{
      return Swal.fire("Mensaje de Advetencia","No se puede eliminar la obra por que esta siendo utilizado en el módulo de Pacientes, verifique por favor","warning");

    }
  })
}

//ENVIANDO AL BOTON DELETE
$('#tabla_obras_sociales').on('click','.eliminar',function(){
  var data = tbl_obras_sociales.row($(this).parents('tr')).data();

  if(tbl_obras_sociales.row(this).child.isShown()){
      var data = tbl_obras_sociales.row(this).data();
  }
  Swal.fire({
    title: 'Desea eliminar la obra social con el N° CUIT: '+data.Cuit+'?',
    text: "Una vez aceptado la obra social sera eliminado!!!",
    icon: 'warning',
    showCancelButton: true,
    confirmButtonColor: '#3085d6',
    cancelButtonColor: '#d33',
    confirmButtonText: 'Si, Eliminar'
  }).then((result) => {
    if (result.isConfirmed) {
      Eliminar_Obras_Sociales(data.id_cuit);
    }
  })
})