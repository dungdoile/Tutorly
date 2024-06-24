<%-- 
    Document   : HomePage
    Created on : Jun 3, 2024, 2:42:13 PM
    Author     : Tung Duong
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tutorly</title>
    <!-- Font Awesome CDN Link -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Header CSS -->
    <link rel="stylesheet" href="../style/header.css">
    <!-- Custom CSS File Link -->
    <link rel="stylesheet" href="../style/homepage.css">
</head>
<body>
    <!-- Start Header -->
    <header class="header">
        <nav class="navbar navbar-expand-lg fixed-top">
            <div class="container-fluid">
                <a href="HomePage.jsp" class="img me-auto">
                    <img src="../image/LOGO_TUTORLY.png" style="max-height: 50px;">
                </a>
                <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasNavbar" aria-labelledby="offcanvasNavbarLabel">
                    <div class="offcanvas-header">
                        <h5 class="offcanvas-title" id="offcanvasNavbarLabel">Tutorly</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                    </div>
                    <div class="offcanvas-body">
                        <ul class="navbar-nav justify-content-start flex-grow-1 pe-3">
                            <li class="nav-item">
                                <a class="nav-link mx-lg-2 active" aria-current="page" href="../View/Login.jsp">Become a learner</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link mx-lg-2 active" aria-current="page" href="../View/Register.jsp">Become a tutor</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link mx-lg-2 active" aria-current="page" href="../TutorController">Finding a tutor</a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="login-icon">
                    <a href="Login.jsp" class="login-button">
                        <span class="button-icon">
                            <i class="fa-solid fa-arrow-right-to-bracket"></i>
                        </span>
                        <span class="button-text">
                            Login
                        </span>
                    </a>
                </div>
                <button class="navbar-toggler" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasNavbar" aria-controls="offcanvasNavbar" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
            </div>
        </nav>
    </header>
    <!-- End Header -->

    <!-- Start Body -->
    <main>
        <section class="hero">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <div class="hero-content">
                            <h1 style="font-weight: 750; font-size: 53px;">Unlock your potential <br> with the best <br> tutors.</h1>
                            <a href="Login.jsp" class="btn btn-primary">Get started <i class="fa-solid fa-arrow-right"></i></a>
                        </div>
                    </div>
                    <div class="col-md-6 text-center">
                        <img src="../image/banner.png" class="img-fluid" alt="Banner Image">
                    </div>
                </div>
            </div>
        </section>
      
        <section class="stats">
            <div class="container">
                <div class="row text-center">
                    <div class="col-4">
                        <div class="stat">
                            <h3>100+</h3>
                            <p>Tutors</p>
                        </div>
                    </div>
                    <div class="col-4">
                        <div class="stat">
                            <h3>150+</h3>
                            <p>Learners</p>
                        </div>
                    </div>
                    <div class="col-4">
                        <div class="stat">
                            <h3>10+</h3>
                            <p>Subjects</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>
    <!-- End Body -->

    <!-- Start Footer -->
    <footer class="footer">
        <div class="container">
            <div class="row">
                <div class="col-md-4 text-center text-md-start">
                    <div class="logo-footer">
                        <a href="../View/HomePage.jsp" class="img me-auto">
                            <img src="../image/LOGO_TUTORLY_W.png" style="max-height: 50px;">
                        </a>
                    </div>
                </div>
                <div class="col-md-4 text-center">
                    <div class="info-footer">
                        <p>&copy; 2024 VerblingTerms | Privacy</p>
                        <p>Respecting your "do not sell my personal information" rights</p>
                    </div>
                </div>
                <div class="col-md-4 text-center text-md-start">
                    <div class="share">
                        <a href="mailto:support@tutorly.com" class="fa fa-envelope"> tutorly@gmail.com </a>
                        <a href="tel:+1234567890" class="fa fa-phone"> 0969.995.633</a>
                        <a href="https://instagram.com/tutorly" class="fa-brands fa-instagram"> _tutorly</a>
                        <a href="https://facebook.com/tutorly" class="fab fa-facebook"> Tutorly</a>
                    </div>
                </div>
            </div>
        </div>
    </footer>
    <!-- End Footer -->

<!--     Pop-up Modal 
    <div class="modal fade" id="subjectModal" tabindex="-1" aria-labelledby="subjectModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content" style="border-radius: 50px;">
                <div class="modal-header border-0">
                    <h5 class="modal-title mx-auto" id="subjectModalLabel">What subject do you want to learn?</h5>
                </div>
                <div class="modal-body">
                    <form action="../TutorController" method="get">
                        <div class="mb-4 custom-select-container">
                            <select class="form-select form-select-lg" id="subjectSelect" name="subject" aria-label="Select subject" style="background-color:#D9D9D9;">
                                <option selected value="-Select subject-">-Select subject-</option>
                                <option value="Math">Math</option>
                                <option value="Math">Physics</option>
                                <option value="Math">Chemistry</option>                                
                                <option value="Science">English</option>
                                <option value="English">Literature</option>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-primary btn-lg">Continue <i class="fa-solid fa-arrow-right"></i></button>
                    </form>
                </div>
            </div>
        </div>
    </div>-->

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
