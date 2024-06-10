<%-- 
    Document   : forgotPassword
    Created on : Jun 6, 2024, 2:17:09 PM
    Author     : Acer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="../style/LoginStyle.css" />
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

            <meta name="google-signin-client_id" content="119477182092-7uq7v6a5vivsekvp6ia8sfdg2tn9296e.apps.googleusercontent.com">
    </head>
     <body>
            <div class="container-fluid vh-100">
                <div class="row h-100">
                    <div class="col-md-6 d-flex justify-content-center align-items-center bg-white text-dark position-relative left-half">
                        <div class="logo-container">
                            <a href="#"><img style="width: 100px;margin: -10% 1px;" src="../Pictures/LOGO_TUTORLY.png" class="logo" alt="Brand Logo" /></a>
                        </div>
                        <div class="login-container mt-5">
                            <h1 style="font-family: 'Poppins', sans-serif; font-weight: 700; font-size: 30px; line-height: 45px; vertical-align: middle;">
                                Reset your password
                            </h1>
                            <p>Enter your email address or username, and we'll send you a link to get back into your account.</p>

                            <form class="register-form" action="../authorize" method="get">
                                <input type="text" name="email_for_get_new_password" placeholder="Email or Username" required>


                                <input type="hidden" name="action" value="forgotPassword">
                                <button style="    padding-left: 2px;
                                        white-space: nowrap;
                                        margin: 0 35%;" type="submit" class="btn btn-primary btn-sm register-button" >
                                    Send Link
                                </button>

                            </form>
                            <div><p style="color: red">${requestScope.messageError}</p></div>
                            <div>

                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 d-flex justify-content-center align-items-center  text-light right-half">

                        <div class="border border-light rounded" id="miniDescription-login">
                            <div class="banner">
                                <div class="content">
                                    <p>Find Tutor</p>

                                    <p> <b>Find Future</b></p>
                                    <p style="    margin-left: 42px; font-weight:bold;
                                       margin-top: -24px;">
                                        With <img src="../Pictures/LOGO_TUTORLY.png" alt="Tutorly Logo" />
                                    </p>
                                </div>
                            </div>
                            <div class="banner-logo">
                                <img style="margin: 12%;height: 50%;width: 121%;" src="../Pictures/banner-descrition.png" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </body>
</html>