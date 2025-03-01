<?php
session_start();
if (!isset($_SESSION['S_ID'])) {
  header('Location: ../index.php');
}
?>
<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>RECUPEROS | HOSPITAL SAMIC</title>

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome Icons -->
  <link rel="stylesheet" href="../plantilla/plugins//fontawesome-free/css/all.min.css">
  <!-- Theme style -->
  <link rel="shortcut icon" href="../img/sami.jpg" type="image/jpg">

  <link rel="stylesheet" href="../plantilla/dist//css/adminlte.min.css">
  <link href="../utilitario/DataTables/datatables.min.css" type="text/css" rel="stylesheet" />
  <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
</head>

<body class="">
  <div class="wrapper">
    <?php if ($_SESSION['S_ROL'] == "ADMINISTRADOR") { ?>
      <!-- Navbar -->
      <nav class="main-header navbar navbar-expand navbar-white navbar-light">
        <!-- Left navbar links -->
        <ul class="navbar-nav">
          <li class="nav-item">
            <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
          </li>
        </ul>
        <!-- Right navbar links -->
        <ul class="navbar-nav ml-auto">
          <!-- Notifications Dropdown Menu -->

          <li class="nav-item dropdown">
            <a class="nav-link" data-toggle="dropdown" href="#">
              <img src="../<?php echo $_SESSION['S_FOTO']; ?>" class="img-circle elevation-1" width="15" height="18">
              <b>Usuario: <?php echo $_SESSION['S_COMPLETOS'] ?></b>
              <i class="fas fa-caret-down"></i>
            </a>
            <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
              <div class="dropdown-divider"></div>
              <a href="../controller/usuario/controlador_cerrar_sesion.php" class="dropdown-item">
                <i class="fas fa-power-off mr-2"></i><u><b>Cerrar Sesión</b></u>
              </a>
              <div class="dropdown-divider"></div>
            </div>
          </li>
        </ul>

      </nav>
    <?php
    }
    ?>
    <?php if ($_SESSION['S_ROL'] == "MEDICO") { ?>
      <!-- Navbar -->
      <nav class="main-header navbar navbar-expand navbar-white navbar-light">
        <!-- Left navbar links -->
        <ul class="navbar-nav">
          <li class="nav-item">
            <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
          </li>
        </ul>

        <!-- Right navbar links -->
        <ul class="navbar-nav ml-auto">
          <!-- Notifications Dropdown Menu -->


          <li class="nav-item dropdown">
            <a class="nav-link" data-toggle="dropdown" href="#">
              <img src="../<?php echo $_SESSION['S_FOTO']; ?>" class="img-circle elevation-1" width="15" height="18">

              <b>Usuario: <?php echo $_SESSION['S_COMPLETOS'] ?></b>
              <i class="fas fa-caret-down"></i>
            </a>
            <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
              <div class="dropdown-divider"></div>
              <a href="../controller/usuario/controlador_cerrar_sesion.php" class="dropdown-item">
                <i class="fas fa-power-off mr-2"></i><u><b>Cerrar Sesión</b></u>
              </a>
              <div class="dropdown-divider"></div>
            </div>
          </li>
        </ul>

      </nav>
    <?php
    }
    ?>
    <!-- /.navbar -->

    <!-- Main Sidebar Container -->
    <aside class="main-sidebar sidebar-dark-primary elevation-4">
      <!-- Brand Logo -->
      <a href="index.php" class="brand-link">
        <img src="../img/banner.jpg" alt="<?php echo $_SESSION['S_RAZON']; ?>" width="100%" height="auto">
      </a>

      <!-- Sidebar -->
      <div class="sidebar">
        <!-- Sidebar user panel (optional) -->
        <div class="user-panel mt-1 pb-3 mb-3 d-flex">
          <div class="image">
            <img src="../<?php echo $_SESSION['S_FOTO']; ?>" class="img-circle elevation-2" style="max-width: 100%;height: auto;">
          </div>
          <div class="info">
            <a style="text-align:center;" href="#" class="d-block"><i class="fa fa-circle text-success fa-0x"></i> ¡Hola!<br> <b style="color:white"><?php echo $_SESSION['S_NOMBRE']; ?></b></a>
            <a style="text-align:center;margin:5px;color:white;font-size:15px" href="#" class="d-block">&nbsp;&nbsp;<b style="text-align:center"><i class="fa fa-user text-success fa-0x"></i><em> ROL: <?php echo $_SESSION['S_ROL']; ?></em></b></a>
          </div>
        </div>
        <!-- Sidebar Menu -->
        <nav class="mt-1">
          <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
            <li class="header text-center" style="color:#FFFFFF; background-color:#023D77; border-radius: 10px;">
              <b>GESTIÓN PRÁCTICAS</b>
            </li>

            <!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->
            <?php if ($_SESSION['S_ROL'] == "ADMINISTRADOR") { ?>
              <li class="nav-item">
                <a href="#" onclick="cargar_contenido('contenido_principal','area/view_area.php')" class="nav-link">
                  <i class="nav-icon fas fa-th"></i>
                  <p style="color:white">
                    Áreas
                  </p>
                </a>
              </li>
             
              <li class="nav-item">
                <a href="#" onclick="cargar_contenido('contenido_principal','obra_social/view_obra_social.php')" class="nav-link">
                  <i class="nav-icon fas fas fa-hands-helping"></i>

                  <p style="color:white">
                    Obras Sociales
                  </p>
                </a>
              </li>

              <li class="nav-item">
                <a href="#" onclick="cargar_contenido('contenido_principal','paciente/view_paciente.php')" class="nav-link">
                  <i class="nav-icon fas fa-users"></i>
                  <p style="color:white">
                    Pacientes
                  </p>
                </a>
              </li>
              <li class="nav-item">
                <a href="#" onclick="cargar_contenido('contenido_principal','practicas/view_practicas.php')" class="nav-link">
                  <i class="nav-icon fas fa-briefcase-medical"></i>

                  <p style="color:white">
                    Prácticas
                  </p>
                </a>
              </li>
              <li class="nav-item">
                <a href="#" onclick="cargar_contenido('contenido_principal','practicas_paciente/view_practicas_paciente.php')" class="nav-link">
                  <i class="nav-icon fas fa-stethoscope"></i>
                  <p style="color:white">
                    Prácticas - Paciente
                  </p>
                </a>
              </li>
              <li class="header text-center" style="color:#FFFFFF; background-color:#023D77; border-radius: 10px;">
                <b>FACTURAS</b>
              </li>
              <li class="nav-item">
                <a href="#" onclick="cargar_contenido('contenido_principal','facturas/view_facturas.php')" class="nav-link">
                  <i class="nav-icon fas fa-file-invoice-dollar"></i>

                  <p style="color:white">
                    Gestión de Facturas
                  </p>
                </a>
              </li>
              <li class="nav-item">
                <a href="#" onclick="cargar_contenido('contenido_principal','facturas/view_facturas_archivadas.php')" class="nav-link">
                <i class="nav-icon fas fa-file-archive" ></i> <!-- Archivada -->

                  <p style="color:white">
                    Facturas Archivadas
                  </p>
                </a>
              </li>
              <li class="header text-center" style="color:#FFFFFF; background-color:#023D77; border-radius: 10px;">
                <b>CONFIGURACIÓN Y MANUAL</b>
              </li>
              <li class="nav-item">
                <a onclick="cargar_contenido('contenido_principal','usuario/view_usuario.php')" class="nav-link">
                  <i class="nav-icon fas fa-user"></i>
                  <p style="color:white">
                    Usuarios
                  </p>
                </a>
              </li>
              <li class="nav-item">
                <a href="../manual_admin.pdf" target="blank" onclick="" class="nav-link">
                  <i class="nav-icon fas fa-file-pdf"></i>
                  <p style="color:white">
                    Manual de Usuario
                  </p>
                </a>
              </li>
            <?php
            }
            ?>
            <?php if ($_SESSION['S_ROL'] == "MEDICO") { ?>
              
              <li class="nav-item">
                <a href="#" onclick="cargar_contenido('contenido_principal','practicas_paciente/view_practicas_paciente2.php')" class="nav-link">
                <i class="nav-icon fas fa-stethoscope"></i>
                <p style="color:white">
                    Prácticas - Paciente
                  </p>
                </a>
              </li>
            
              <li class="header text-center" style="color:#FFFFFF; background-color:#023D77; border-radius: 10px;">
                <b>MANUAL</b>
              </li>
              <li class="nav-item">
                <a href="../manual_doctor.pdf" target="blank" onclick="" class="nav-link">
                <i class="nav-icon fas fa-file-pdf"></i>
                <p style="color:white">
                    Manual de Usuario
                  </p>
                </a>
              </li>
            
            <?php
            }
            ?>
          </ul>
        </nav>
        <!-- /.sidebar-menu -->
      </div>
      <!-- /.sidebar -->
    </aside>
    <input type="text" id="txtprincipalid" value="<?php echo $_SESSION['S_ID']; ?>" hidden>
    <input type="text" id="txtprincipalusu" value="<?php echo $_SESSION['S_USU']; ?>" hidden>
    <input type="text" id="txtprincipalrol" value="<?php echo $_SESSION['S_ROL']; ?>" hidden>
    <input type="text" id="txtfotoempresa" value="<?php echo $_SESSION['S_FOTO_EMPRESA']; ?>" hidden>
    <input type="text" id="txtrazon" value="<?php echo $_SESSION['S_RAZON']; ?>" hidden>


    <div class="content-wrapper" id="contenido_principal">


      <!-- Content Wrapper. Contains page content -->

      <!-- Content Header (Page header) -->
    
      <?php if ($_SESSION['S_ROL'] == "ADMINISTRADOR") { ?>
        <div class="content-header">
        <div class="container-fluid">
          <div class="row mb-2">
            <div class="col-sm-6">
              <h1 class="m-0"><i class="fas fa-home"></i>
                <b>BIENVENIDOS AL SISTEMA</b>
              </h1>
            </div><!-- /.col -->
            <div class="col-sm-6">
              <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="#">MENÚ</a></li>
                <li class="breadcrumb-item active">MENÚ PRINCIPAL</li>
              </ol>
            </div><!-- /.col -->
          </div><!-- /.row -->
        </div><!-- /.container-fluid -->
      </div>
      <!-- /.content-header -->


        <div class="col-md-12">
          <div class="card card-primary">
            <div class="card-header py-2"   style="background: linear-gradient(135deg, #023D77, #0266C8)">
              <h5 class="m-0" style="font-family:cooper; text-align:center; line-height: 1; padding: 0;">
                <i class="fas fa-list-ol" style="margin-right: 8px;"></i>DATOS IMPORTANTES
              </h5>
              <div class="card-tools" style="position: absolute; right: 10px; top: 5px;">
                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                  <i class="fas fa-minus"></i>
                </button>
              </div>
            </div>
            <div class="table-responsive" style="text-align:center">
              <!-- Resto del contenido igual -->
              <div class="card-body" style="background-color:white">
                <div class="row">
                  <div class="col-lg-3 col-6">
                    <!-- small box -->
                    <div class="small-box bg-info">
                      <div class="inner">
                        <b>Total de Facturas</b>
                        <h3 id="total_facturas"><sup style="font-size: 20px"></sup></h3>

                      </div>
                      <div class="icon">
                      <i class="fas fa-file-invoice-dollar"></i> <!-- Factura con signo de dólar -->
                      </div>
                      <a href="#" onclick="cargar_contenido('contenido_principal','facturas/view_facturas.php')" class="small-box-footer"><b>Ver Facturas</b>&nbsp;<i class="fas fa-arrow-circle-right"></i></a>
                    </div>
                  </div>
                  <!-- ./col -->
                  <div class="col-lg-3 col-6">
                    <!-- small box -->
                    <div class="small-box bg-warning">
                      <div class="inner">
                        <b>Facturas Pendientes</b>
                        <h3 id="total_fact_pendiente"><sup style="font-size: 20px"></sup></h3>

                      </div>
                      <div class="icon">
                      <i class="fas fa-file-invoice-dollar"></i> <!-- Factura con signo de dólar -->
                      </div>
                      <a href="#" onclick="cargar_contenido('contenido_principal','facturas/view_facturas.php')" class="small-box-footer"><b>Ver Facturas</b>&nbsp;<i class="fas fa-arrow-circle-right"></i></a>
                    </div>
                  </div>
                  <!-- ./col -->
                  <div class="col-lg-3 col-6">
                    <!-- small box -->
                    <div class="small-box bg-success">
                      <div class="inner">

                        <b>Facturas Cobradas</b>
                        <h3 id="total_fact_cobradas"><sup style="font-size: 20px"></sup></h3>

                      </div>
                      <div class="icon">
                      <i class="fas fa-file-invoice-dollar"></i> <!-- Factura con signo de dólar -->
                      </div>
                      <a href="#" onclick="cargar_contenido('contenido_principal','facturas/view_facturas.php')" class="small-box-footer"><b>Ver Facturas</b>&nbsp;<i class="fas fa-arrow-circle-right"></i></a>
                    </div>
                  </div>
                  <!-- ./col -->
                  <div class="col-lg-3 col-6">
                    <!-- small box -->
                    <div class="small-box bg-danger">
                      <div class="inner">
                        <b>Facturas Rechazadas</b>
                        <h3 id="total_fact_rechazada"><sup style="font-size: 20px"></sup></h3>

                      </div>
                      <div class="icon">
                      <i class="fas fa-file-invoice-dollar"></i> <!-- Factura con signo de dólar -->
                      </div>
                      
                      <a href="#" onclick="cargar_contenido('contenido_principal','facturas/view_facturas.php')" class="small-box-footer"><b>Ver Facturas</b>&nbsp;<i class="fas fa-arrow-circle-right"></i></a>
                    </div>
                  </div>
                  <div class="col-lg-3 col-6">
                    <!-- small box -->
                    <div class="small-box bg-dark">
                      <div class="inner">
                        <b> Total de Prácticas Realizadas a Pacientes</b>
                        <h3 id="total_practicas_paciente"><sup style="font-size: 20px"></sup></h3>

                      </div>
                      <div class="icon">
                      <i class="nav-icon fas fa-stethoscope"></i>
                      </div>
                      <a href="#" onclick="cargar_contenido('contenido_principal','practicas_paciente/view_practicas_paciente.php')" class="small-box-footer"><b>Ver Prácticas - Paciente</b>&nbsp;<i class="fas fa-arrow-circle-right"></i></a>
                    </div>
                  </div>
                  <!-- ./col -->
                  <div class="col-lg-3 col-6">
                    <!-- small box -->
                    <div class="small-box bg-success">
                      <div class="inner">
                        <b>Total de Prácticas</b>
                        <h3 id="total_practicas"><sup style="font-size: 20px"></sup></h3>

                      </div>
                      <div class="icon">
                      <i class="fas fa-briefcase-medical"></i> <!-- Maletín médico (prácticas médicas) -->
                      </div>
                      <a href="#" onclick="cargar_contenido('contenido_principal','practicas/view_practicas.php')" class="small-box-footer"><b>Ver Prácticas</b>&nbsp;<i class="fas fa-arrow-circle-right"></i></a>
                    </div>
                  </div>
                  <!-- ./col -->
                  <div class="col-lg-3 col-6">
                    <!-- small box -->
                    <div class="small-box bg-info">
                      <div class="inner">

                        <b>Total de Pacientes</b>
                        <h3 id="total_pacientes"><sup style="font-size: 20px"></sup></h3>

                      </div>
                      <div class="icon">
                      <i class="nav-icon fas fa-users"></i>
                      </div>
                      <a href="#" onclick="cargar_contenido('contenido_principal','paciente/view_paciente.php')" class="small-box-footer"><b>Ver Pacientes</b>&nbsp; <i class="fas fa-arrow-circle-right"></i></a>
                    </div>
                  </div>
                  <!-- ./col -->
                  <div class="col-lg-3 col-6">
                    <!-- small box -->
                    <div class="small-box bg-warning">
                      <div class="inner">
                        <b>Total de Obras Sociales</b>
                        <h3 id="total_obras_sociales"><sup style="font-size: 20px"></sup></h3>

                      </div>
                      <div class="icon">
                      <i class="fas fa-hands-helping"></i> <!-- Manos ayudando (solidaridad) -->
                      </div>
                      
                      <a href="#" onclick="cargar_contenido('contenido_principal','obra_social/view_obra_social.php')" class="small-box-footer"><b>Ver Obras Sociales</b>&nbsp; <i class="fas fa-arrow-circle-right"></i></a>
                    </div>
                  </div>

                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="col-md-12">
          <div class="card card-primary" style="border-radius: 15px; overflow: hidden;">
            <div class="card-header py-2"   style="background: linear-gradient(135deg, #023D77, #0266C8)">
              <h5 class="m-0" style="font-family:cooper; text-align:center; line-height: 1; padding: 0; color: white;">
                <i class="fas fa-hospital" style="margin-right: 8px;"></i>DATOS DEL HOSPITAL
              </h5>
              <div class="card-tools" style="position: absolute; right: 10px; top: 5px;">
                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                  <i class="fas fa-minus"></i>
                </button>
              </div>
            </div>
            <div class="table-responsive" style="text-align:center">
              <div class="card-body" style="display: block;">
                <table id="tabla_empresa" class="table table-striped table-bordered" style="width:100%; border-radius: 10px; overflow: hidden; border-collapse: separate; border-spacing: 0;">
                  <thead style="background-color:#023D77;color:white;">
                    <tr>
                      <th style="text-align:center; border-top: none;">Nro.</th>
                      <th style="text-align:center; border-top: none;">Logo</th>
                      <th style="text-align:center; border-top: none;">Nombre</th>
                      <th style="text-align:center; border-top: none;">Email</th>
                      <th style="text-align:center; border-top: none;">Código</th>
                      <th style="text-align:center; border-top: none;">Teléfono</th>
                      <th style="text-align:center; border-top: none;">Dirección</th>
                      <th style="text-align:center; border-top: none;">Acciones</th>
                    </tr>
                  </thead>
                </table>
              </div>
            </div>
          </div>
        </div>

        <div class="col-md-12">
          <div class="card card-primary">
            <div class="card card-primary">
              <div class="card-header py-2"   style="background: linear-gradient(135deg, #023D77, #0266C8)">
                <h5 class="m-0" style="font-family:cooper; text-align:center; line-height: 1; padding: 0;">
                  <i class="fas fa-image" style="margin-right: 8px;"></i>CATALOGO DE FOTOS
                </h5>
              </div>
              <div class="table-responsive" style="text-align:center">
                <div class="card-body" style="display: block;">
                  <div id="photoCarousel" class="carousel slide" data-ride="carousel" data-interval="5000" style="transition: opacity 1s ease-in-out;">
                    <div class="carousel-inner">
                      <div class="carousel-item active">
                        <img src="../Fotos/1.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 1">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/2.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 2">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/4.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 4">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/5.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 5">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/6.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 6">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/7.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 7">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/8.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 8">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/9.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 9">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/10.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 10">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/11.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 11">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/12.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 12">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/13.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 13">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/14.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 14">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/15.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 15">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/16.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 16">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/17.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 17">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/18.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 18">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/19.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 19">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/20.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 20">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/21.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 21">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/22.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 22">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/23.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 23">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/24.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 24">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/25.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 25">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/26.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 26">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/27.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 27">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/28.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 28">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/29.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 29">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/30.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 30">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/31.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 31">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/32.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 32">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/33.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 33">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/34.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 34">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/35.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 35">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/36.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 36">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/37.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 37">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/38.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 38">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/39.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 39">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/40.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 40">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/41.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 41">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/42.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 42">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/43.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 43">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/44.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 44">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/45.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 45">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/46.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 46">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/47.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 47">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/48.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 48">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/49.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 49">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/50.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 50">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/51.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 51">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/52.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 52">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/53.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 53">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/54.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 54">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/55.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 55">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/56.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 56">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/57.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 57">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/58.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 58">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/59.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 59">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/60.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 60">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/61.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 61">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/62.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 62">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/63.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 63">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/64.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 64">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/65.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 65">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/66.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 66">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/67.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 67">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/68.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 68">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/69.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 69">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/70.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 70">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/71.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 71">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/72.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 72">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/73.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 73">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/74.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 74">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/75.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 75">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/76.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 76">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/77.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 77">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/78.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 78">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/79.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 79">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/80.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 80">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/81.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 81">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/82.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 82">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/83.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 83">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/84.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 84">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/85.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 85">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/86.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 86">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/87.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 87">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/88.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 88">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/90.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 90">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/91.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 91">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/92.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 92">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/93.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 93">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/94.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 94">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/95.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 95">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/96.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 96">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/97.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 97">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/98.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 98">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/99.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 99">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/100.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 100">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/101.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 101">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/102.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 102">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/103.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 103">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/104.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 104">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/105.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 105">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/106.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 106">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/107.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 107">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/108.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 108">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/109.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 109">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/110.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 110">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/111.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 111">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/112.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 112">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/113.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 113">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/114.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 114">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/115.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 115">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/116.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 116">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/117.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 117">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/118.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 118">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/119.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 119">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/120.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 120">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/121.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 121">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/122.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 122">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/124.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 124">
                      </div>
                      <!-- Agrega más fotos aquí -->
                    </div>
                  </div>
                  <!-- Botones personalizados para cambiar foto -->
                  <button id="prevBtn" class="btn btn-primary" style="margin-top: 10px;">
                    <i class="fas fa-chevron-left"></i> Anterior
                  </button>
                  <button id="nextBtn" class="btn btn-primary" style="margin-top: 10px;">
                    Siguiente <i class="fas fa-chevron-right"></i>
                  </button>

                </div>
              </div>
            </div>
          </div>
        </div>



        <!-- /.content-wrapper -->
        <div class="modal fade" id="modal_editar" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
          <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
              <div class="modal-header" style="background-color:#1FA0E0;">
                <h5 class="modal-title" id="exampleModalLabel" style="color:white; text-align:center"><b>EDITAR DATOS DE LA INSTITUCIÒN</b></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                </button>
              </div>
              <div class="modal-body">
                <div class="row">
                  <div class="col-12 form-group" style="color:red">
                    <h6><b>Campos Obligatorios (*)</b></h6>
                  </div><br>
                  <div class="col-6 form-group">
                    <input type="text" id="txt_id_empresa" hidden>
                    <label for="">Nombre(*):</label>
                    <input type="text" class="form-control" id="txt_nombre" maxlenght="8">
                  </div>
                  <div class="col-6 form-group">
                    <label for="">Email(*):</label>
                    <input type="text" class="form-control" id="txt_email">
                  </div>
                  <div class="col-6 form-group">
                    <label for="">Código(*):</label>
                    <input type="text" class="form-control" id="txt_codigo">
                  </div>
                  <div class="col-6 form-group">
                    <label for="">Teléfono / Celular(*):</label>
                    <input type="text" class="form-control" id="txt_telefono" maxlenght="9" onkeypress="return soloNumeros(event)">
                  </div>
                  <div class="col-12 form-group">
                    <label for="">Dirección(*):</label>
                    <input type="text" class="form-control" id="txt_direccion">
                  </div>
                </div>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fas fa-times ml-1"></i> Cerrar</button>
                <button type="button" class="btn btn-success" onclick="Modificar_Empleado()"><i class="fas fa-check"></i> Modificar</button>
              </div>
            </div>
          </div>
        </div>

        <div class="modal fade" id="modal_editar_foto" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
          <div class="modal-dialog" role="document">
            <div class="modal-content">
              <div class="modal-header"   style="background: linear-gradient(135deg, #023D77, #0266C8)">
                <h5 class="modal-title" id="exampleModalLabel" style="color:white; text-align:center"><b>EDITAR FOTO DE LA INSTITUCIÓN: </b><label for="" id="lb_empresa"></label></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                </button>
              </div>
              <div class="modal-body">
                <div class="row">
                  <div class="col-12">
                    <input type="text" id="fotoactual" hidden>
                    <input type="text" id="txt_idempresa_foto" hidden>
                    <label for="checkboxSuccess2" style="align:justify;color:red">
                      OJO: Una vez cambiado el logo, tambien se cambiara el logo en los reportes y ticket.
                    </label>
                    <label for="">Subir Foto:</label>
                    <input class="form-control" type="file" id="txt_foto">
                  </div>
                </div>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fas fa-times ml-1"></i> Cerrar</button>
                <button type="button" class="btn btn-success" onclick="Modificar_Foto_Empresa()"><i class="fas fa-check"></i> Modificar</button>
              </div>
            </div>
          </div>
        </div>

      <?php
      }
      ?>
      <?php if ($_SESSION['S_ROL'] == "MEDICO") { ?>

        <!-- Main content -->

        <div class="content">
  <div class="container-fluid">
    <div class="row justify-content-center">
      <div class="col-lg-10 text-center">
        <div class="p-5 rounded shadow-lg" 
             style="background: linear-gradient(135deg, #023D77, #0266C8); 
                    color: white; 
                    border-radius: 20px; 
                    margin-bottom: 20px;">
          <h1 class="display-3 font-weight-bold" style="font-family: Cooper;">
            ¡BIENVENIDO AL SISTEMA!
          </h1>
          <p class="lead" style="font-size: 1.3rem;">
            Gestiona y revisa las prácticas realizadas a cada paciente de manera eficiente y organizada.
          </p>
          <hr class="my-4 border-light">
          <a href="#seccion_practicas" onclick="cargar_contenido('contenido_principal','practicas_paciente/view_practicas_paciente2.php')" class="btn btn-light btn-lg font-weight-bold" 

             style="border-radius: 10px;">
            <i class="fas fa-stethoscope"></i> Ver Prácticas
          </a>
        </div>
      </div>
    </div> <!-- /.row -->
  </div> <!-- /.container-fluid -->
</div> <!-- /.content -->


        <div class="col-md-12">
          <div class="card card-primary">
            <div class="card card-primary">
              <div class="card-header py-2"   style="background: linear-gradient(135deg, #023D77, #0266C8)">
              <h5 class="m-0 text-center" style="font-family: 'Poppins', sans-serif; font-weight: 600; line-height: 1.2; padding: 5px;">
  <i class="fas fa-image me-2"></i> Catálogo de Fotos
</h5>

              </div>
              <div class="table-responsive" style="text-align:center">
                <div class="card-body" style="display: block;">
                  <div id="photoCarousel" class="carousel slide" data-ride="carousel" data-interval="5000" style="transition: opacity 1s ease-in-out;">
                    <div class="carousel-inner">
                      <div class="carousel-item active">
                        <img src="../Fotos/1.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 1">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/2.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 2">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/4.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 4">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/5.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 5">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/6.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 6">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/7.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 7">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/8.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 8">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/9.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 9">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/10.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 10">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/11.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 11">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/12.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 12">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/13.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 13">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/14.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 14">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/15.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 15">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/16.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 16">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/17.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 17">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/18.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 18">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/19.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 19">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/20.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 20">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/21.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 21">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/22.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 22">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/23.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 23">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/24.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 24">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/25.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 25">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/26.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 26">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/27.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 27">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/28.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 28">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/29.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 29">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/30.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 30">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/31.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 31">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/32.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 32">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/33.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 33">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/34.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 34">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/35.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 35">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/36.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 36">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/37.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 37">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/38.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 38">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/39.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 39">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/40.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 40">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/41.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 41">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/42.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 42">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/43.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 43">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/44.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 44">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/45.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 45">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/46.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 46">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/47.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 47">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/48.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 48">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/49.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 49">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/50.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 50">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/51.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 51">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/52.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 52">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/53.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 53">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/54.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 54">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/55.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 55">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/56.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 56">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/57.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 57">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/58.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 58">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/59.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 59">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/60.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 60">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/61.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 61">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/62.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 62">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/63.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 63">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/64.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 64">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/65.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 65">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/66.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 66">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/67.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 67">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/68.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 68">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/69.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 69">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/70.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 70">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/71.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 71">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/72.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 72">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/73.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 73">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/74.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 74">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/75.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 75">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/76.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 76">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/77.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 77">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/78.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 78">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/79.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 79">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/80.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 80">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/81.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 81">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/82.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 82">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/83.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 83">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/84.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 84">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/85.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 85">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/86.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 86">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/87.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 87">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/88.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 88">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/90.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 90">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/91.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 91">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/92.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 92">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/93.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 93">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/94.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 94">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/95.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 95">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/96.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 96">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/97.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 97">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/98.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 98">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/99.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 99">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/100.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 100">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/101.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 101">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/102.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 102">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/103.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 103">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/104.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 104">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/105.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 105">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/106.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 106">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/107.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 107">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/108.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 108">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/109.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 109">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/110.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 110">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/111.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 111">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/112.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 112">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/113.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 113">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/114.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 114">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/115.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 115">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/116.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 116">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/117.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 117">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/118.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 118">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/119.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 119">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/120.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 120">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/121.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 121">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/122.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 122">
                      </div>
                      <div class="carousel-item">
                        <img src="../Fotos/124.jpg" class="d-block w-100" style="height: 600px; object-fit: cover;" alt="Foto 124">
                      </div>
                      <!-- Agrega más fotos aquí -->
                    </div>
                  </div>
                  <!-- Botones personalizados para cambiar foto -->
                  <button id="prevBtn" class="btn btn-primary" style="margin-top: 10px;">
                    <i class="fas fa-chevron-left"></i> Anterior
                  </button>
                  <button id="nextBtn" class="btn btn-primary" style="margin-top: 10px;">
                    Siguiente <i class="fas fa-chevron-right"></i>
                  </button>

                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- /.content -->

        <!-- /.content-wrapper -->
      <?php
      }
      ?>
    </div>
    <!-- Control Sidebar -->
    <aside class="control-sidebar control-sidebar-dark">
      <!-- Control sidebar content goes here -->
      <div class="p-3">
        <h5>Title</h5>
        <p>Sidebar content</p>
      </div>
    </aside>
    <!-- /.control-sidebar -->

    <!-- Main Footer -->
    <footer class="main-footer">
      <!-- To the right -->
      <div class="float-right d-none d-sm-inline">
        <em>Versión 1.0.0</em>
      </div>
      <!-- Default to the left -->
      <strong>Copyright &copy; 2025 <a href="https://samicnestorkirchner.org/" target="_blank"><em>Hospital SAMIC – Presidente Néstor Kirchner</em></a></strong>
    </footer>
  </div>
  <!-- ./wrapper -->
  <!-- MODAL EDITAR HORARIO -->




  <!-- REQUIRED SCRIPTS -->
  <script>
    function cargar_contenido(id, vista) {
      $("#" + id).load(vista);
    }
    var idioma_espanol = {
      select: {
        rows: "%d fila seleccionada"
      },
      "sProcessing": "Procesando...",
      "sLengthMenu": "Mostrar _MENU_ registros",
      "sZeroRecords": "No se encontraron resultados",
      "sEmptyTable": "Ning&uacute;n dato disponible en esta tabla",
      "sInfo": "Registros del (_START_ al _END_) total de _TOTAL_ registros",
      "sInfoEmpty": "Registros del (0 al 0) total de 0 registros",
      "sInfoFiltered": "(filtrado de un total de _MAX_ registros)",
      "sInfoPostFix": "",
      "sSearch": "Buscar:",
      "sUrl": "",
      "sInfoThousands": ",",
      "sLoadingRecords": "<b>No se encontraron datos</b>",
      "oPaginate": {
        "sFirst": "Primero",
        "sLast": "Último",
        "sNext": "Siguiente",
        "sPrevious": "Atras"
      },
      "oAria": {
        "sSortAscending": ": Activar para ordenar la columna de manera ascendente",
        "sSortDescending": ": Activar para ordenar la columna de manera descendente"
      }
    }

    function sololetras(e) {
      key = e.keyCode || e.which;

      teclado = String.fromCharCode(key).toLowerCase();

      letras = "qwertyuiopasdfghjklñzxcvbnmáéíóú ";

      especiales = "8-37-38-46-164";

      teclado_especial = false;

      for (var i in especiales) {
        if (key == especiales[i]) {
          teclado_especial = true;
          break;
        }
      }

      if (letras.indexOf(teclado) == -1 && !teclado_especial) {
        return false;
      }
    }


    function soloNumeros(e) {
      tecla = (document.all) ? e.keyCode : e.which;
      if (tecla == 8) {
        return true;
      }
      // Patron de entrada, en este caso solo acepta numeros
      patron = /[0-9]/;
      tecla_final = String.fromCharCode(tecla);
      return patron.test(tecla_final);
    }



    ///////VALIDAR EMAIL
    function validar_email(email) {
      var regex = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
      return regex.test(email) ? true : false;
    }
  </script>
  <!-- jQuery -->
  <script src="../plantilla/plugins//jquery/jquery.min.js"></script>
  <!-- Bootstrap 4 -->
  <script src="../plantilla/plugins//bootstrap/js/bootstrap.bundle.min.js"></script>
  <!-- AdminLTE App -->
  <script src="../plantilla/dist/js/adminlte.min.js"></script>


  <script src="../utilitario/DataTables/datatables.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
  <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
  <script src="../js/console_usuario.js?rev=<?php echo time(); ?>"></script>
  <script src="../js/console_empresa.js?rev=<?php echo time(); ?>"></script>

</body>

</html>
<script>
  $(document).ready(function() {
   listar_empresa();
   Total_facturas();
   Total_facturas_pendientes();
   Total_facturas_cobradas();
   Total_facturas_rechazadas();
   Total_practicas_paciente();
   Total_practicas();
   Total_pacientes();
   Total_obras_sociales();

  });


</script>

<style>
  /* Color de fondo principal del aside con degradado */
  .main-sidebar {
    background: linear-gradient(135deg, #023D77, #0266C8) !important;
    color: white !important; /* Texto en blanco */
  }

  /* Eliminar cualquier color heredado del tema dark */
  .sidebar-dark-primary {
    background: linear-gradient(135deg, #023D77, #0266C8) !important;
    color: white !important;
  }

  /* Asegurar que la elevación no afecte el color */
  .elevation-4 {
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1) !important;
  }
</style>

<style>
  /* Estilos para la tabla con bordes redondeados */
  .table-bordered {
    border: 1px solid #dee2e6;
    border-radius: 10px;
  }

  /* Bordes redondeados para las celdas de las esquinas */
  .table-bordered thead th:first-child {
    border-top-left-radius: 10px;
  }

  .table-bordered thead th:last-child {
    border-top-right-radius: 10px;
  }

  .table-bordered tbody tr:last-child td:first-child {
    border-bottom-left-radius: 10px;
  }

  .table-bordered tbody tr:last-child td:last-child {
    border-bottom-right-radius: 10px;
  }

  /* Ajustes para mantener los bordes consistentes */
  .table-bordered th,
  .table-bordered td {
    border: 1px solid #dee2e6;
  }

  /* Estilos para el card contenedor */
  .card {
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  }

  /* Ajuste para el responsive */
  .table-responsive {
    border-radius: 10px;
    overflow: hidden;
  }
</style>
<style>
  .carousel {
    position: relative;
    overflow: hidden;
  }

  .carousel-item {
    transition: transform 1s ease, opacity 1s ease;
  }


  .carousel-item.active {
    display: block;
  }
</style>
<script>
  // Iniciar el cambio automático de imagen cada 5 segundos
  var carousel = document.querySelector('#photoCarousel');
  var nextBtn = document.querySelector('#nextBtn');
  var prevBtn = document.querySelector('#prevBtn');

  // Configurar el intervalo para cambiar automáticamente cada 5 segundos
  setInterval(function() {
    $(carousel).carousel('next');
  }, 5000); // 5000 milisegundos = 5 segundos

  // Botón "Siguiente"
  nextBtn.addEventListener('click', function() {
    $(carousel).carousel('next');
  });

  // Botón "Anterior"
  prevBtn.addEventListener('click', function() {
    $(carousel).carousel('prev');
  });
</script>