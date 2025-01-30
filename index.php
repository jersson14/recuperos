<?php
session_start();
if(isset($_SESSION['S_ID'])){
    header('Location: view/index.php');
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Iniciar Sesión</title>

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="plantilla/plugins/fontawesome-free/css/all.min.css">
  <!-- icheck bootstrap -->
  <link rel="stylesheet" href="plantilla/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="plantilla/dist/css/adminlte.min.css">
  <link rel="icon" href="img/sami.jpg" type="image/jpg">
</head>
<body class="hold-transition login-page" style="background-image: url('img/hospital.jpg'); background-size: 100% 100%; position: relative;">
    <div style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.5);"></div>
</body>
    <!-- Texto en la parte superior -->
    <div style="
    position: absolute; 
    top: 5%; 
    width: 100%; 
    text-align: center; 
    color: white; 
    font-family: 'Georgia', serif; 
    font-size: clamp(30px, 4vw, 60px); 
    letter-spacing: 0.1em; 
    text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.7);">
    <b>Hospital SAMIC Presidente Néstor Kirchner</b>
</div>

<div style="
    position: absolute; 
    top: 15%; 
    width: 100%; 
    text-align: center; 
    color: white; 
    font-family: 'Garamond', serif; 
    font-size: clamp(16px, 2vw, 32px); 
    letter-spacing: 0.05em; 
    font-style: italic; 
    text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.7);">
    <b>"SISTEMA WEB DE RECUPERO DE COSTOS"</b>
</div>




    <div class="login-box">
  

      <!-- /.login-logo -->
      <div class="card" style="border-radius: 15px;">
    <div class="card-body login-card-body" style="border-radius: 15px;">
        <img src="img/banner.jpg" alt="" width="100%" height="100%">
        
        <p class="login-box-msg" style="font-family:Arial black; font-size:15px; color:black">
            <b>DATOS DEL USUARIO</b>
        </p>

        <div class="input-group mb-3">
            <input type="text" class="form-control" placeholder="Ingrese su usuario" id="txt_usuario" 
                   style="border-radius: 8px 0 0 8px; height: 38px; border-right: none;">
            <div class="input-group-append">
                <div class="input-group-text" style="background: #fff; border-radius: 0 8px 8px 0; height: 38px; border-left: none;">
                    <span class="fas fa-user" style="color: #666;"></span>
                </div>
            </div>
        </div>

        <div class="input-group mb-3">
            <input type="password" class="form-control" placeholder="Ingrese su contraseña" id="txt_contra" 
                   style="border-radius: 8px 0 0 8px; height: 38px; border-right: none;">
            <div class="input-group-append">
                <div class="input-group-text" style="background: #fff; height: 38px; border-left: none; border-right: none;">
                    <span class="fas fa-lock" style="color: #666;"></span>
                </div>
                <div class="input-group-text" style="background: #fff; border-radius: 0 8px 8px 0; height: 38px; border-left: none;">
                    <i class="fas fa-eye" id="togglePassword" style="color: #666; cursor: pointer;"></i>
                </div>
            </div>
        </div>

        <div class="row align-items-center">
    <div class="col-8 d-flex align-items-center">
        <div class="icheck-primary" style="color:#023D77;">
            <input type="checkbox" id="remember" style="accent-color: #023D77;">
            <label for="remember" style="color: #023D77;">Recuérdame</label>
        </div>
    </div>
    <div class="col-12 mt-2">
        <button class="btn btn-block" id="entrar" onclick="Iniciar_Sesion()" 
                style="border-radius: 15px; background-color: #023D77; color: white;">
            <i class='fas fa-share-square ml-1 mr-1'></i>&nbsp;<b>Iniciar Sesión</b>
        </button>
    </div>
</div>
    </div>
</div>

<style>
  .btn:hover {
    background-color: #002b6e !important;
    color: white !important;
}

/* Estilo para el checkbox cuando está marcado */
input[type="checkbox"]:checked {
    background-color: #023D77;
    border-color: #023D77;
}
.input-group .form-control:focus {
    border-color: #80bdff;
    box-shadow: 0 0 0 0.2rem rgba(0,123,255,.25);
    z-index: 1;
}

.input-group-text {
    border-color: #ced4da;
}
</style>
<!-- Pie de página -->
<div style="
    position: absolute; 
    bottom: 0; 
    left: 0; 
    width: 100%; 
    background-color: rgba(0, 0, 0, 0.7); 
    text-align: center; 
    padding: 10px 0; 
    font-family: 'Georgia', serif; 
    font-size: 14px; 
    color: white; 
    letter-spacing: 0.5px; 
    border-top: 2px solid rgba(255, 255, 255, 0.5); 
    text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.5);">
    Hospital SAMIC Presidente Néstor Kirchner - Ministerio de Salud de la República Argentina
</div>


    <!-- /.login-box -->

    <!-- jQuery -->
    <script src="plantilla/plugins/jquery/jquery.min.js"></script>
    <!-- Bootstrap 4 -->
    <script src="plantilla/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- AdminLTE App -->
    <script src="plantilla/dist/js/adminlte.min.js"></script>
    <script src="js/console_usuario.js?rev=<?php echo time();?>"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        const rmcheck = document.getElementById('remember'),
              usuarioInput = document.getElementById('txt_usuario'),
              passInput = document.getElementById('txt_contra'),
              togglePassword = document.getElementById('togglePassword');
        
        // Mostrar/ocultar contraseña
        togglePassword.addEventListener('click', function () {
            const type = passInput.getAttribute('type') === 'password' ? 'text' : 'password';
            passInput.setAttribute('type', type);
            this.classList.toggle('fa-eye-slash');
        });

        if(localStorage.checkbox && localStorage.checkbox !== ""){
            rmcheck.setAttribute("checked","checked");
            usuarioInput.value = localStorage.usuario;
            passInput.value = localStorage.pass;
        } else {
            rmcheck.removeAttribute("checked");
            usuarioInput.value = "";
            passInput.value = "";
        }
        
        txt_usuario.focus();
        var input = document.getElementById("txt_contra");
        input.addEventListener("keyup", function(event) {
            if (event.keyCode === 13) {
                event.preventDefault();
                document.getElementById("entrar").click();
            }
        });
    </script>
</body>
</html>

  <style>
@media (max-width: 768px) {
    div {
        font-size: 7vw;
        letter-spacing: 0.1vw;
    }
    div:nth-of-type(2) {
        font-size: 4vw;
    }
}
@media (max-width: 480px) {
    div {
        font-size: 8vw;
        letter-spacing: 0.05vw;
    }
    div:nth-of-type(2) {
        font-size: 5vw;
    }
}

</style>
