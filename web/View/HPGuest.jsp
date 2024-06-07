<%-- 
    Document   : HPGuest
    Created on : Jun 3, 2024, 2:43:21 PM
    Author     : Tung Duong
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>List of Tutors</title>
    <!-- Font Awesome CDN Link -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="../style/header.css">
    <!-- Custom CSS File Link -->
    <link rel="stylesheet" href="../style/homepage.css">
</head>
<body style="padding-top: 30px;">
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
                                <a class="nav-link mx-lg-2 active" aria-current="page" href="#">Become a tutor</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link mx-lg-2 active" aria-current="page" href="#">Become a learner</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link mx-lg-2 active" aria-current="page" href="#">Finding a tutor</a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="login-icon">
                    <a href="#" class="login-button">
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

    <!-- Main Content -->
    <div class="container" style="padding-top: 30px">
        <div class="filter-container">
            <div class="btn-group">
                <button class="btn btn-outline-secondary dropdown-toggle" type="button" id="subjectDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="fa-solid fa-square-root-variable" style="font-weight: bold;"></i> Maths
                </button>
                <ul class="dropdown-menu" aria-labelledby="subjectDropdown">
                    <li><a class="dropdown-item" href="#"><i class="fa-solid fa-flask"></i> Chemistry</a></li>
                    <li><a class="dropdown-item" href="#"><i class="fa-solid fa-atom"></i> Physics</a></li>
                    <li><a class="dropdown-item" href="#"><i class="fa-solid fa-globe"></i> English</a></li>
                    <li><a class="dropdown-item" href="#"><i class="fa-solid fa-book"></i> Literature</a></li>
                </ul>
            </div>

            <span>Filter teachers by</span>

            <div class="btn-group">
                <button class="btn btn-outline-secondary dropdown-toggle" type="button" id="priceDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="fa-solid fa-dollar-sign"></i> Price
                </button>
                <div class="dropdown-menu p-3" aria-labelledby="priceDropdown">
                    <div class="d-flex align-items-center">
                        <span>0k</span>
                        <input type="range" class="form-range mx-2" min="0" max="200" step="10" id="priceRange">
                        <span>200k</span>
                    </div>
                </div>
            </div>

            <div class="btn-group">
                <button class="btn btn-outline-secondary dropdown-toggle" type="button" id="availabilityDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="fa-regular fa-calendar"></i> Availability
                </button>
                <div class="dropdown-menu p-3" aria-labelledby="availabilityDropdown">
                    <div class="availability-times">
                        <div class="times-header">Time of the day</div>
                        <div class="d-flex justify-content-around mb-3">
                            <div>
                                <i class="fa-solid fa-cloud-sun"></i>
                                <br>
                                Morning<br>8 am - 12 am
                            </div>
                            <div>
                                <i class="fa-solid fa-sun"></i>
                                <br>
                                Afternoon<br>2 pm - 6 pm
                            </div>
                            <div>
                                <i class="fa-solid fa-moon"></i>
                                <br>
                                Evening<br>7 pm - 9 pm
                            </div>
                        </div>
                        <div class="times-header">Day of the week</div>
                        <div class="d-flex justify-content-around">
                            <div>Mon</div>
                            <div>Tue</div>
                            <div>Wed</div>
                            <div>Thu</div>
                            <div>Fri</div>
                            <div>Sat</div>
                            <div>Sun</div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="btn-group">
                <button class="btn btn-outline-secondary dropdown-toggle" type="button" id="rateDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="fa-regular fa-star"></i> Rate
                </button>
                <ul class="dropdown-menu p-3" aria-labelledby="rateDropdown">
                    <li class="rating-row" id="ratingRow">
                        <span class="star" data-value="1">&#9733;</span>
                        <span class="star" data-value="2">&#9733;</span>
                        <span class="star" data-value="3">&#9733;</span>
                        <span class="star" data-value="4">&#9733;</span>
                        <span class="star" data-value="5">&#9733;</span>
                    </li>
                </ul>
            </div>            

            <div class="input-group" style="max-width: 200px;">
                <span class="input-group-text"><i class="fa-solid fa-search"></i></span>
                <input type="text" class="form-control" placeholder="Search for tutor">
            </div>
        </div>
        
        <div class="tutor-list">
            <div class="tutor-card border rounded p-3 mb-4 d-flex align-items-center">
                <img src="img/tutor1.jpg" alt="Trinh Thu Tra" width="100" class="rounded-circle me-3">
                <div class="tutor-info flex-grow-1">
                    <h4>Trinh Thu Tra</h4>
                    <p><i class="fa-solid fa-graduation-cap"></i> Math | <i class="fa-solid fa-users"></i> Students: 15</p>
                    <p>Xin chào các em học sinh và quý phụ huynh. Tôi là Trinh Thu Tra, hiện đang là giáo viên dạy Toán...</p>
                </div>
                <div class="tutor-actions text-end">
                    <p><i class="fa-solid fa-dollar-sign"></i> 70k per session</p>
                    <button class="btn btn-primary">Book trial lesson</button>
                    <button class="btn btn-secondary">Register class</button>
                </div>
            </div>
            <div class="tutor-card border rounded p-3 mb-4 d-flex align-items-center">
                <img src="img/tutor2.jpg" alt="Hoang Viet" width="100" class="rounded-circle me-3">
                <div class="tutor-info flex-grow-1">
                    <h4>Hoang Viet</h4>
                    <p><i class="fa-solid fa-graduation-cap"></i> Math | <i class="fa-solid fa-users"></i> Students: 11</p>
                    <p>Xin chào các em học sinh và quý phụ huynh. Tôi là Hoang Viet, hiện đang là giảng viên bộ môn Toán...</p>
                </div>
                <div class="tutor-actions text-end">
                    <p><i class="fa-solid fa-dollar-sign"></i> 85k per session</p>
                    <button class="btn btn-primary">Book trial lesson</button>
                    <button class="btn btn-secondary">Register class</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="js/scripts.js">
</body>
</html>
