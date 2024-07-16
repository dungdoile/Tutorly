<%-- 
    Document   : RegisterTrialView
    Created on : Jun 16, 2024, 8:24:11 PM
    Author     : TRANG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Trial Class</title>

        <link href="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
        <link href="https://cdn.jsdelivr.net/npm/fastbootstrap@2.2.0/dist/css/fastbootstrap.min.css" rel="stylesheet" integrity="sha256-V6lu+OdYNKTKTsVFBuQsyIlDiRWiOmtC8VQ8Lzdm2i4=" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            body {
                margin-top: 20px;
            }
            .bg-light-gray {
                background-color: #f7f7f7;
            }
            .table-bordered thead td, .table-bordered thead th {
                border-bottom-width: 2px;
            }
            .table thead th {
                vertical-align: bottom;
                border-bottom: 2px solid #dee2e6;
            }
            .table-bordered td, .table-bordered th {
                border: 1px solid #dee2e6;
            }
            .bg-sky.box-shadow {
                box-shadow: 0px 5px 0px 0px #0E3C6E
            }
            .bg-sky {
                background-color: #0E3C6E
            }
            .padding-15px-lr {
                padding-left: 15px;
                padding-right: 15px;
            }
            .padding-5px-tb {
                padding-top: 5px;
                padding-bottom: 5px;
            }
            .margin-10px-bottom {
                margin-bottom: 10px;
            }
            .border-radius-5 {
                border-radius: 5px;
            }
            .margin-10px-top {
                margin-top: 10px;
            }
            .font-size14 {
                font-size: 14px;
            }
            .text-light-gray {
                color: #d6d5d5;
            }
            .font-size13 {
                font-size: 13px;
            }
            .table-bordered td, .table-bordered th {
                border: 1px solid #dee2e6;
            }
            .table td, .table th {
                padding: .75rem;
                vertical-align: top;
                border-top: 1px solid #dee2e6;
            }

            .center-form {
                display: flex;
                justify-content: center;
                height: 100vh;
            }
        </style>
    </head>
    <body>
        <%@ include file="StudentHeader.jsp" %>

        <hr/>
        <h1 style="color: #0E3C6E;display: flex; justify-content: center;">Register a trial lesson</h1>
        <h4 style="color: #e09e00;display: flex; justify-content: center;">${tutor.getName()} - ${tutor.getSubject().getName()}</h4>


        <c:set var="hasAvailability" value="false" />
        <c:forEach var="availability" items="${tutorAvailabilities}">
            <c:if test="${availability.status == 'Available'}">
                <c:set var="hasAvailability" value="true" />
            </c:if>
        </c:forEach>

        <c:choose>
            <c:when test="${hasAvailability}">
                <div class="container">
                    <div class="timetable-img text-center">
                        <img src="img/content/timetable.png" alt="">
                    </div>
                    <div class="table-responsive">
                        <table class="table table-bordered text-center">
                            <thead>
                                <tr class="bg-light-gray">
                                    <th class="text-uppercase">Time</th>
                                    <th class="text-uppercase">Monday</th>
                                    <th class="text-uppercase">Tuesday</th>
                                    <th class="text-uppercase">Wednesday</th>
                                    <th class="text-uppercase">Thursday</th>
                                    <th class="text-uppercase">Friday</th>
                                    <th class="text-uppercase">Saturday</th>
                                    <th class="text-uppercase">Sunday</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="align-middle">08:00am</td>
                                    <c:forEach var="availability" items="${tutorAvailabilities}" begin="0" end="6">
                                        <c:choose>
                                            <c:when test="${availability.status == 'Available'}">
                                                <td>
                                                    
                                                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#slot1" style="background: #0E3C6E; color: white">
                                                        Available
                                                    </button>
                                                    <div class="modal fade" tabindex="-1" id="slot1" aria-labelledby="slot1" aria-hidden="true">
                                                        <div class="modal-dialog">
                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                    <h5 class="modal-title" id="exampleModalLabel" style="color: #0E3C6E">Register trial class</h5>
                                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                                </div>
                                                                <hr/>
                                                                <div class="modal-body">
                                                                    <p style="color: #A2A2A2;display: flex; justify-content: center; margin: 20px">
                                                                        <span>You are registering to try a lesson with tutor<span style="color: #e09e00; font-weight: bolder"> ${tutor.getName()} </span> suject <span style="color: #e09e00; font-weight: bolder"> ${tutor.getSubject().getName()}</span> , A trial lesson is a preliminary session 
                                                                            designed by <span style="color: #0E3C6E; font-weight: bolder">Tutorly</span> to introduce potential learners to a tutor's teaching style, subject expertise, 
                                                                            and overall learning environment. It allows both the learner and the tutor to assess compatibility 
                                                                            and determine if further lessons would be beneficial. Learners typically engage in introductory 
                                                                            activities or sample lessons relevant to their learning goals during a trial lesson. 
                                                                            Tutors may use this time to evaluate the learner's skills and tailor future lessons accordingly. The outcome of a trial lesson often guides decisions on continuing with regular lessons, ensuring that both parties can make informed choices about their educational journey together.
                                                                            </span>
                                                                    </p>

                                                                </div>
                                                                            <hr/>
                                                                <div class="modal-footer">
                                                                    <form class="row g-3 needs-validation" action="RegisterTrialCotroller" method="get">
                                                                        <div class="col-12">
                                                                            <label for="validationCustom02" class="form-label" style="color: #0E3C6E; font-size: 20px; font-weight: bolder;">You choose the session :</label>
                                                                         
                                                                                8:00 - 9:30
                                                                        </div>
                                                                        <p style="color: #A2A2A2; font-size: 15px;">You should make sure that you must attend this lesson</p>
                                                                        <div >
                                                                            <div class="form-check" style="margin: 5px">
                                                                                <input class="form-check-input" type="checkbox" value="" id="invalidCheck" required>
                                                                                <label class="form-check-label" for="invalidCheck" style="color: #A2A2A2; font-size: 15px;">
                                                                                    Agree to terms and conditions
                                                                                </label>
                                                                                <div class="invalid-feedback">
                                                                                    You must agree before submitting.
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <input type="hidden" name="session" value="${availability.getSession().getId()}">
                                                                        <input type="hidden" name="tutor_id" value="${tutor.getId()}">
                                                                        <input type="hidden" name="learner_id" value="1">
                                                                        <input type="hidden" name="service" value="registertrial">
                                                                        <div >
                                                                            <button class="btn" style="background-color: #0E3C6E; color: white;" type="submit">Register</button>
                                                                        </div>
                                                                    </form>
                                                                    
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="margin-10px-top font-size14">8:00 - 9:30</div>
                                                    <div class="font-size13 text-light-gray">Tutor ${availability.tutor.name}</div>
                                                </td>
                                            </c:when>
                                            <c:otherwise>
                                                <td class="bg-light-gray"></td>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </tr>
                                <tr>
                                    <td class="align-middle">10:00am</td>
                                    <c:forEach var="availability" items="${tutorAvailabilities}" begin="7" end="13">
                                        <c:choose>
                                            <c:when test="${availability.status == 'Available'}">
                                                <td>
                                                    
                                                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#slot2" style="background: #0E3C6E; color: white">
                                                        Available
                                                    </button>
                                                    <div class="modal fade" tabindex="-1" id="slot2" aria-labelledby="slot2" aria-hidden="true">
                                                        <div class="modal-dialog">
                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                    <h5 class="modal-title" id="exampleModalLabel" style="color: #0E3C6E">Register trial class</h5>
                                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                                </div>
                                                                <hr/>
                                                                <div class="modal-body">
                                                                    <p style="color: #A2A2A2;display: flex; justify-content: center; margin: 20px">
                                                                        <span>You are registering to try a lesson with tutor<span style="color: #e09e00; font-weight: bolder"> ${tutor.getName()} </span> suject <span style="color: #e09e00; font-weight: bolder"> ${tutor.getSubject().getName()}</span> , A trial lesson is a preliminary session 
                                                                            designed by <span style="color: #0E3C6E; font-weight: bolder">Tutorly</span> to introduce potential learners to a tutor's teaching style, subject expertise, 
                                                                            and overall learning environment. It allows both the learner and the tutor to assess compatibility 
                                                                            and determine if further lessons would be beneficial. Learners typically engage in introductory 
                                                                            activities or sample lessons relevant to their learning goals during a trial lesson. 
                                                                            Tutors may use this time to evaluate the learner's skills and tailor future lessons accordingly. The outcome of a trial lesson often guides decisions on continuing with regular lessons, ensuring that both parties can make informed choices about their educational journey together.
                                                                            </span>
                                                                    </p>

                                                                </div>
                                                                            <hr/>
                                                                <div class="modal-footer">
                                                                    <form class="row g-3 needs-validation" action="RegisterTrialCotroller" method="get">
                                                                        <div class="col-12">
                                                                            <label for="validationCustom02" class="form-label" style="color: #0E3C6E; font-size: 20px; font-weight: bolder;">You choose the session :</label>
                                                                         
                                                                                10:00 - 11:30
                                                                        </div>
                                                                        <p style="color: #A2A2A2; font-size: 15px;">You should make sure that you must attend this lesson</p>
                                                                        <div >
                                                                            <div class="form-check" style="margin: 5px">
                                                                                <input class="form-check-input" type="checkbox" value="" id="invalidCheck" required>
                                                                                <label class="form-check-label" for="invalidCheck" style="color: #A2A2A2; font-size: 15px;">
                                                                                    Agree to terms and conditions
                                                                                </label>
                                                                                <div class="invalid-feedback">
                                                                                    You must agree before submitting.
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <input type="hidden" name="session" value="${availability.getSession().getId()}">
                                                                        <input type="hidden" name="tutor_id" value="${tutor.getId()}">
                                                                        <input type="hidden" name="learner_id" value="1">
                                                                        <input type="hidden" name="service" value="registertrial">
                                                                        <div >
                                                                            <button class="btn" style="background-color: #0E3C6E; color: white;" type="submit">Register</button>
                                                                        </div>
                                                                    </form>
                                                                    
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="margin-10px-top font-size14">10:00 - 11:30</div>
                                                    <div class="font-size13 text-light-gray">Tutor ${availability.tutor.name}</div>
                                                </td>
                                            </c:when>
                                            <c:otherwise>
                                                <td class="bg-light-gray"></td>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </tr>
                                <tr>
                                    <td class="align-middle">02:00pm</td>
                                    <c:forEach var="availability" items="${tutorAvailabilities}" begin="14" end="20">
                                        <c:choose>
                                            <c:when test="${availability.status == 'Available'}">
                                                <td>
                                                    
                                                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#slot3" style="background: #0E3C6E; color: white">
                                                        Available
                                                    </button>
                                                    <div class="modal fade" tabindex="-1" id="slot3" aria-labelledby="slot3" aria-hidden="true">
                                                        <div class="modal-dialog">
                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                    <h5 class="modal-title" id="exampleModalLabel" style="color: #0E3C6E">Register trial class</h5>
                                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                                </div>
                                                                <hr/>
                                                                <div class="modal-body">
                                                                    <p style="color: #A2A2A2;display: flex; justify-content: center; margin: 20px">
                                                                        <span>You are registering to try a lesson with tutor<span style="color: #e09e00; font-weight: bolder"> ${tutor.getName()} </span> suject <span style="color: #e09e00; font-weight: bolder"> ${tutor.getSubject().getName()}</span> , A trial lesson is a preliminary session 
                                                                            designed by <span style="color: #0E3C6E; font-weight: bolder">Tutorly</span> to introduce potential learners to a tutor's teaching style, subject expertise, 
                                                                            and overall learning environment. It allows both the learner and the tutor to assess compatibility 
                                                                            and determine if further lessons would be beneficial. Learners typically engage in introductory 
                                                                            activities or sample lessons relevant to their learning goals during a trial lesson. 
                                                                            Tutors may use this time to evaluate the learner's skills and tailor future lessons accordingly. The outcome of a trial lesson often guides decisions on continuing with regular lessons, ensuring that both parties can make informed choices about their educational journey together.
                                                                            </span>
                                                                    </p>

                                                                </div>
                                                                            <hr/>
                                                                <div class="modal-footer">
                                                                    <form class="row g-3 needs-validation" action="RegisterTrialCotroller" method="get">
                                                                        <div class="col-12">
                                                                            <label for="validationCustom02" class="form-label" style="color: #0E3C6E; font-size: 20px; font-weight: bolder;">You choose the session :</label>
                                                                         
                                                                                14:00 - 15:30
                                                                        </div>
                                                                        <p style="color: #A2A2A2; font-size: 15px;">You should make sure that you must attend this lesson</p>
                                                                        <div >
                                                                            <div class="form-check" style="margin: 5px">
                                                                                <input class="form-check-input" type="checkbox" value="" id="invalidCheck" required>
                                                                                <label class="form-check-label" for="invalidCheck" style="color: #A2A2A2; font-size: 15px;">
                                                                                    Agree to terms and conditions
                                                                                </label>
                                                                                <div class="invalid-feedback">
                                                                                    You must agree before submitting.
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <input type="hidden" name="session" value="${availability.getSession().getId()}">
                                                                        <input type="hidden" name="tutor_id" value="${tutor.getId()}">
                                                                        <input type="hidden" name="learner_id" value="1">
                                                                        <input type="hidden" name="service" value="registertrial">
                                                                        <div >
                                                                            <button class="btn" style="background-color: #0E3C6E; color: white;" type="submit">Register</button>
                                                                        </div>
                                                                    </form>
                                                                    
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="margin-10px-top font-size14">14:00 - 15:30</div>
                                                    <div class="font-size13 text-light-gray">Tutor ${availability.tutor.name}</div>
                                                </td>
                                            </c:when>
                                            <c:otherwise>
                                                <td class="bg-light-gray"></td>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                <tr>
                                    <td class="align-middle">04:00pm</td>
                                    <c:forEach var="availability" items="${tutorAvailabilities}" begin="21" end="27">
                                        <c:choose>
                                            <c:when test="${availability.status == 'Available'}">
                                                <td>
                                                    
                                                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#slot4" style="background: #0E3C6E; color: white">
                                                        Available
                                                    </button>
                                                    <div class="modal fade" tabindex="-1" id="slot4" aria-labelledby="slot4" aria-hidden="true">
                                                        <div class="modal-dialog">
                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                    <h5 class="modal-title" id="exampleModalLabel" style="color: #0E3C6E">Register trial class</h5>
                                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                                </div>
                                                                <hr/>
                                                                <div class="modal-body">
                                                                    <p style="color: #A2A2A2;display: flex; justify-content: center; margin: 20px">
                                                                        <span>You are registering to try a lesson with tutor<span style="color: #e09e00; font-weight: bolder"> ${tutor.getName()} </span> suject <span style="color: #e09e00; font-weight: bolder"> ${tutor.getSubject().getName()}</span> , A trial lesson is a preliminary session 
                                                                            designed by <span style="color: #0E3C6E; font-weight: bolder">Tutorly</span> to introduce potential learners to a tutor's teaching style, subject expertise, 
                                                                            and overall learning environment. It allows both the learner and the tutor to assess compatibility 
                                                                            and determine if further lessons would be beneficial. Learners typically engage in introductory 
                                                                            activities or sample lessons relevant to their learning goals during a trial lesson. 
                                                                            Tutors may use this time to evaluate the learner's skills and tailor future lessons accordingly. The outcome of a trial lesson often guides decisions on continuing with regular lessons, ensuring that both parties can make informed choices about their educational journey together.
                                                                            </span>
                                                                    </p>

                                                                </div>
                                                                            <hr/>
                                                                <div class="modal-footer">
                                                                    <form class="row g-3 needs-validation" action="RegisterTrialCotroller" method="get">
                                                                        <div class="col-12">
                                                                            <label for="validationCustom02" class="form-label" style="color: #0E3C6E; font-size: 20px; font-weight: bolder;">You choose the session :</label>
                                                                         
                                                                                16:00 - 17:30
                                                                        </div>
                                                                        <p style="color: #A2A2A2; font-size: 15px;">You should make sure that you must attend this lesson</p>
                                                                        <div >
                                                                            <div class="form-check" style="margin: 5px">
                                                                                <input class="form-check-input" type="checkbox" value="" id="invalidCheck" required>
                                                                                <label class="form-check-label" for="invalidCheck" style="color: #A2A2A2; font-size: 15px;">
                                                                                    Agree to terms and conditions
                                                                                </label>
                                                                                <div class="invalid-feedback">
                                                                                    You must agree before submitting.
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <input type="hidden" name="session" value="${availability.getSession().getId()}">
                                                                        <input type="hidden" name="tutor_id" value="${tutor.getId()}">
                                                                        <input type="hidden" name="learner_id" value="1">
                                                                        <input type="hidden" name="service" value="registertrial">
                                                                        <div >
                                                                            <button class="btn" style="background-color: #0E3C6E; color: white;" type="submit">Register</button>
                                                                        </div>
                                                                    </form>
                                                                    
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="margin-10px-top font-size14">16:00 - 17:30</div>
                                                    <div class="font-size13 text-light-gray">Tutor ${availability.tutor.name}</div>
                                                </td>
                                            </c:when>
                                            <c:otherwise>
                                                <td class="bg-light-gray"></td>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </tr>
                                <tr>
                                    <td class="align-middle">07:00pm</td>
                                    <c:forEach var="availability" items="${tutorAvailabilities}" begin="28" end="34">
                                        <c:choose>
                                            <c:when test="${availability.status == 'Available'}">
                                                <td>
                                                    
                                                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#slot5" style="background: #0E3C6E; color: white">
                                                        Available
                                                    </button>
                                                    <div class="modal fade" tabindex="-1" id="slot5" aria-labelledby="slot5" aria-hidden="true">
                                                        <div class="modal-dialog">
                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                    <h5 class="modal-title" id="exampleModalLabel" style="color: #0E3C6E">Register trial class</h5>
                                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                                </div>
                                                                <hr/>
                                                                <div class="modal-body">
                                                                    <p style="color: #A2A2A2;display: flex; justify-content: center; margin: 20px">
                                                                        <span>You are registering to try a lesson with tutor<span style="color: #e09e00; font-weight: bolder"> ${tutor.getName()} </span> suject <span style="color: #e09e00; font-weight: bolder"> ${tutor.getSubject().getName()}</span> , A trial lesson is a preliminary session 
                                                                            designed by <span style="color: #0E3C6E; font-weight: bolder">Tutorly</span> to introduce potential learners to a tutor's teaching style, subject expertise, 
                                                                            and overall learning environment. It allows both the learner and the tutor to assess compatibility 
                                                                            and determine if further lessons would be beneficial. Learners typically engage in introductory 
                                                                            activities or sample lessons relevant to their learning goals during a trial lesson. 
                                                                            Tutors may use this time to evaluate the learner's skills and tailor future lessons accordingly. The outcome of a trial lesson often guides decisions on continuing with regular lessons, ensuring that both parties can make informed choices about their educational journey together.
                                                                            </span>
                                                                    </p>

                                                                </div>
                                                                            <hr/>
                                                                <div class="modal-footer">
                                                                    <form class="row g-3 needs-validation" action="RegisterTrialCotroller" method="get">
                                                                        <div class="col-12">
                                                                            <label for="validationCustom02" class="form-label" style="color: #0E3C6E; font-size: 20px; font-weight: bolder;">You choose the session :</label>
                                                                         
                                                                                19:00 - 20:30
                                                                        </div>
                                                                        <p style="color: #A2A2A2; font-size: 15px;">You should make sure that you must attend this lesson</p>
                                                                        <div >
                                                                            <div class="form-check" style="margin: 5px">
                                                                                <input class="form-check-input" type="checkbox" value="" id="invalidCheck" required>
                                                                                <label class="form-check-label" for="invalidCheck" style="color: #A2A2A2; font-size: 15px;">
                                                                                    Agree to terms and conditions
                                                                                </label>
                                                                                <div class="invalid-feedback">
                                                                                    You must agree before submitting.
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <input type="hidden" name="session" value="${availability.getSession().getId()}">
                                                                        <input type="hidden" name="tutor_id" value="${tutor.getId()}">
                                                                        <input type="hidden" name="learner_id" value="1">
                                                                        <input type="hidden" name="service" value="registertrial">
                                                                        <div >
                                                                            <button class="btn" style="background-color: #0E3C6E; color: white;" type="submit">Register</button>
                                                                        </div>
                                                                    </form>
                                                                    
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="margin-10px-top font-size14">19:00 - 20:30</div>
                                                    <div class="font-size13 text-light-gray">Tutor ${availability.tutor.name}</div>
                                                </td>
                                            </c:when>
                                            <c:otherwise>
                                                <td class="bg-light-gray"></td>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="container center-form">
                    <div class="col-md-6">
                        
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="container center-form">
                    <div class="col-md-6">
                        <div class="alert alert-warning" role="alert">
                            <h4 class="alert-heading">Cannot Register</h4>
                            <p>There are no available sessions for this tutor at the moment. Please check back later or choose another tutor.</p>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>

        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/js/bootstrap.min.js"></script>
    </body>
</html>
