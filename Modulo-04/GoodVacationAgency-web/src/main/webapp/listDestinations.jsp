<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Good Vacation - Agency</title>
    <meta name="author" content="Rodrigo Alberto" />
    <meta name="description" content="Good Vacation: As melhores ofertas e planos de viagens estão aqui!">
    <meta name="keywords" content="viagem, passagens, pacotes">

    <!-- Favicon -->
    <link rel="shortcut icon" href="imgs/favicon.ico" type="image/x-icon">

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="stylesheet"
        href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap">

    <!-- CSS Files -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link rel="stylesheet" href="css/style.css">
</head>

<body>
    
  <!-- - header - -->
  <header>
    <nav class="navbar navbar-expand-lg" id="navbar">
      <div class="container-fluid">
        <a class="navbar-brand d-flex align-items-center" href="index.html">
          <img src="imgs/logo.png" alt="Good Vacation">
          <span class="me-2 fw-semibold">Good Vacation</span>
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
          aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav me-auto mb-2 mb-lg-0">
            <li class="nav-item me-2" id="nav-utilities">
              <div class="account-box rounded-bottom py-1">
                <a onclick="printAlert()" class="nav-link d-flex align-items-center text-decoration-none pt-2 px-2">
                  <img src="imgs/user-default.png" id="userPefil" class="rounded-circle me-2" alt="Perfil do usuário">
                  <span id="userName">Iniciar sessão</span>
                </a>
              </div>
            </li>

            <li class="nav-item ms-0" id="nav-utilities">
              <div class="account-box rounded-bottom py-1">
                <a href="ReadDestinyController" class="nav-link d-flex align-items-center text-decoration-none pt-2 px-2">
                  <img src="imgs/warning-default.png" class="rounded-circle me-2" alt="Área restrita">
                  <span id="restrictedArea">Área restrita</span>
                </a>
              </div>
            </li>

            <li class="nav-item">
              <a class="nav-link" aria-current="page" href="index.html">Home</a>
            </li>

            <li class="nav-item">
              <a class="nav-link" onclick="printAlert()">Destinos</a>
            </li>

            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                Promoções e pacotes
              </a>
              <ul class="dropdown-menu">
                <li><a class="dropdown-item" onclick="printAlert()">Planos para o inverno</a></li>
                <li><a class="dropdown-item" onclick="printAlert()">Planos para o verão</a></li>
                <li><a class="dropdown-item" onclick="printAlert()">Planos internacionais</a></li>
              </ul>
            </li>

            <li class="nav-item">
              <a class="nav-link" onclick="printAlert()">Contatos</a>
            </li>
          </ul>

          <div class="nav-help ms-3 ps-2">
            <a class="nav-link fs-6" href="https://www.bibliaonline.com.br/" target="_blank">Ajuda
              <button class="btn btn-outline-primary rounded-circle ms-3" type="submit">?</button>
            </a>
          </div>
        </div>
      </div>
    </nav>
  </header>
  
  <!-- - main - -->
  <main class="container">
    <section id="destinations-restricted-section" class="py-4">
      <div class="table-responsive py-5">
        <a href="./registrationDestinations.jsp" class="my-2 d-block text-decoration-none">
          <img src="imgs/register-icon-default.png" alt="resgister" class="icon-40">
          <span class="btn btn-primary">Novo destino</span>
        </a>
		
        <table class="table table-bordered table-hover align-middle">
          <thead>
            <tr>
              <th>ID:</th>
              <th>Nome:</th>
              <th>Cidade:</th>
              <th>Imagem-tema:</th>
            </tr>
          </thead>
          
          <tbody>
            <c:forEach items="${arrDestinys}" var="arrDestiny">
              <tr>
                <td>${arrDestiny.idDestiny}</td>
                <td>${arrDestiny.name}</td>
                <td>${arrDestiny.city}</td>
				<td><img alt="Imagem do destino" src="data:image/jpeg;base64,${arrDestiny.imageBase64}" height="70px"></td>
                <td>
                  <a href="UpdateDestinyController?idDestiny=${arrDestiny.idDestiny}" class="mx-3 text-decoration-none">
                    <img src="imgs/update-icon-default.png" alt="update" class="icon-40 p-1 rounded-circle border border-1 border-secondary-subtle">
                  </a>

                  <a href="DeleteDestinyController?idDestiny=${arrDestiny.idDestiny}" class="mx-3 text-decoration-none">
                    <img src="imgs/delete-icon-default.png" alt="delete" class="icon-40 p-1 rounded-circle border border-1 border-secondary-subtle">
                  </a>
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
    </section>
  </main>

  <!-- - footer - -->
  <footer class="container-fluid" id="footer">
    <div class="container">
      <div class="row">
        <div class="col-12" id="footer-top">
          <div class="row justifi-content-between">
            <div class="col-6">
              <h3 class="fs-5">Good Vacation Agency</h3>
            </div>
            <div class="col-6 text-end" id="social-networks">
              <a href="https://www.instagram.com/"><i class="bi bi-instagram me-3 fs-4"></i></a>
              <a href="https://www.facebook.com/"><i class="bi bi-facebook me-3 fs-4"></i></a>
              <a href="https://www.linkedin.com/"><i class="bi bi-linkedin me-3 fs-4"></i></a>
              <a href="https://twitter.com/"><i class="bi bi-twitter me-3 fs-4"></i></a>
            </div>
          </div>
        </div>

        <div class="col-12" id="footer-bottom">
          <div class="row justify-content-between">
            <div class="col-12 col-md-3">
              <p class="fw-light">Recode Pro 2023</p>
            </div>

            <div class="col-12 col-md-4">
              <p class="fw-light text-end me-3 autor">Desenvolvido por: Rodrigo Alberto &copy; 2023</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </footer>

  <!-- JS scripts -->
  <script>
    function printAlert() {
      alert("Função desabilitada! Acesse 'Área restrita'");
    }
  </script>
  <script src="js/activePage.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.min.js"></script>
</body>

</html>