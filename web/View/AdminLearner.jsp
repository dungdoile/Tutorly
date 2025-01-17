<%-- 
    Document   : AdminLearner
    Created on : Jun 1, 2024, 9:57:54 PM
    Author     : Admin
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Learner</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
        <link href="https://cdn.jsdelivr.net/npm/fastbootstrap@2.2.0/dist/css/fastbootstrap.min.css" rel="stylesheet" integrity="sha256-V6lu+OdYNKTKTsVFBuQsyIlDiRWiOmtC8VQ8Lzdm2i4=" crossorigin="anonymous">
        <style>
            .table th, .table td {
                text-align: center;
                vertical-align: middle;
            }



            .stu_image {
                width: 50px; /* Adjust the width as needed */
                height: 50px; /* Adjust the height as needed */
                object-fit: cover; /* Ensure the image fits within the dimensions without distortion */
                border-radius: 50%; /* Optional: make the image circular */
                border: 2px solid #ccc; /* Optional: add a border */
            }

            .search {
                width: 40%;
                height: 40px;
                background-color: #fff;
                padding: 5px;
                border-radius: 5px;
            }

            .search-input {
                color: white;
                border: 0;
                outline: 0;
                background: none;
                width: 0;
                caret-color: transparent;
                line-height: 30px;
                transition: width 0.4s linear
            }

            .search .search-input {
                padding: 0 10px;
                width: 100%;
                caret-color: #536bf6;
                font-size: 19px;
                font-weight: 300;
                color: black;
                transition: width 0.4s linear;
            }


            .search-icon {
                height: 34px;
                width: 34px;
                float: right;
                display: flex;
                justify-content: center;
                align-items: center;
                color: white;
                background-color: #536bf6;
                font-size: 10px;
                bottom: 30px;
                position: relative;
                border-radius: 5px;
            }

            .search-icon:hover{

                color: #fff !important;
            }

        </style>
    </head>
    <body>
        <%@ include file="AdminHeader.jsp" %>
        </br>
        <div class="container" style="background-color: #eee">
            <div class="col d-flex justify-content-end align-items-center" >
                <form class="search" action="AdminController" style="margin-top: 15px">
                    <input type="hidden" name="action" value="searchLearner"/>
                    <input type="text" class="search-input" placeholder="Search..." name="searchLearner" value="${param.searchLearner}">
                    <button type="submit" class="search-icon">
                        <i class="fa fa-search"></i>
                    </button>
                </form>
            </div>
            <div class="row justify-content-center">
                <div class="col-md-12">
                    <div class="row">
                        <div class="col-md-6">
                            <h3></h3>
                        </div>
                    </div>
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Learner ID</th>
                                <th>Avatar</th>
                                <th>Learner Name</th>
                                <th>Learner Email</th>
                                <th>No. Class</th>
                                <th>Detail</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="learner" items="${learners}">
                                <tr>
                                    <td>${learner.id}</td>
                                    <td><img src="image/${learner.image}" class="stu_image"></td>
                                    <td><strong>${learner.name}</strong></td>
                                    <td>${learner.getUserInfo().email}</td>
                                    <td>${learner.getTotalClasses()}</td>
                                    <td><a href="#" class="btn btn-outline-primary btn-sm" data-toggle="modal" data-target="#classModal" onclick="loadClasses(${learner.id})">Details</a></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <!-- Modal Structure -->
                    <div class="modal fade" id="classModal" tabindex="-1" role="dialog" aria-labelledby="classModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="classModalLabel">Classes for Learner</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <div id="classList" class="card-columns">
                                        <!-- Class cards will be appended here -->
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Include jQuery, Bootstrap JS, and other necessary JS files -->
                    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
                    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
                    <script>
                        function loadClasses(learnerId) {
                            $.ajax({
                                url: 'LearnerModal',
                                method: 'GET',
                                data: { learnerId: learnerId },
                                success: function(response) {
                                    $('#classList').empty(); // Clear the previous list of classes
                                    $('#classList').append(response); // Insert the received HTML into the modal
                                },
                                error: function(xhr, status, error) {
                                    console.error('AJAX Error: ' + status + error); // Log any AJAX errors
                                }
                            });
                        }
                    </script>
                </div>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>                                       
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
