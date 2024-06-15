<%-- 
    Document   : Dashboard
    Created on : May 29, 2024, 3:11:59 AM
    Author     : TRANG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src='js/newjavascript.js'></script>
        <script src='https://cdn.jsdelivr.net/npm/@fullcalendar/core@5.10.1/main.min.js'></script>
        <link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/@fullcalendar/core@5.10.1/main.min.css' />

        <style>
            
            html, body {
                overflow: hidden; /* don't do scrollbars */
                font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
                font-size: 14px;
                height: 100%;
                margin: 0;
                display: flex;
                flex-direction: column;
            }

            .container-fluid {
                display: flex;
                flex-grow: 1;
                overflow: hidden;
                padding: 0;
                margin: 0;
            }

            .content {
                display: flex;
                flex-grow: 1;
                overflow: hidden;
            }

            .todo, .classofstudent, .upcommingclass {
                margin-bottom: 20px;
                flex-shrink: 0;
            }

            .todo {
                background-color: white;
                border-radius: 20px;
                padding-top: 20px;
            }

            .todo .todohead {
                background-color: #F7B500;
                width: fit-content;
                border-radius: 5px;
                padding: 5px;
                margin-left: 30px;
                color: white;
                box-shadow: 6px 6px 10px 0px rgba(0, 0, 0, 0.4);
            }

            .todo .todonumber {
                text-align: center;
                font-size: 80px;
            }

            .todo .foot {
                text-align: center;
                color: #A2A2A2;
                padding-bottom: 10px;
            }

            .classofstudent {
                background-color: white;
                border-radius: 20px;
                padding-top: 20px;
            }

            .classofstudent .classofstudenthead {
                background-color: #F7B500;
                width: fit-content;
                border-radius: 5px;
                padding: 5px;
                margin-left: 30px;
                color: white;
                box-shadow: 6px 6px 10px 0px rgba(0, 0, 0, 0.4);
            }

            .classofstudent ul {
                display: inline-flex;
                text-decoration: none;
            }

            .classofstudent li {
                text-decoration: none;
            }

            .classofstudent .classongoing {
                text-align: center;
                font-size: 80px;
            }

            .classofstudent .classongoingfoot {
                text-align: center;
                color: #A2A2A2;
                padding-bottom: 10px;
            }

            .classofstudent .classcomplete {
                text-align: center;
                font-size: 80px;
            }

            .classofstudent .classcompletefoot {
                text-align: center;
                color: #A2A2A2;
                padding-bottom: 10px;
            }

            .ongoingclass {
                margin-left: 40px;
            }

            .completedclass {
                margin-right: 40px;
            }

            .upcommingclass {
                background-color: white;
                border-radius: 20px;
                padding-top: 10px;
                padding-bottom: 20px;
                padding: 40px;
                display: flex;
                flex-direction: column;
                height: 100%;
                overflow: hidden;
                flex-grow: 1;
            }

            .upcommingclasstitle {
                color: #0E3C6E;
                font-weight: bold;
            }

            .upcommingclassnote {
                color: #A2A2A2;
            }

            .upcommingclassdedtails {
                background-color: #E6E6E6;
                border-radius: 20px;
                flex: 1;
                overflow: hidden;
                display: flex;
                flex-direction: column;
                padding: 20px;
                box-sizing: border-box;
            }

            #calendar-container {
                height: 100%;
                width: 100%;
                box-sizing: border-box;
                display: flex;
                flex-direction: column;
                flex-grow: 1;
                background-color: white;
                padding: 20px;
                overflow: hidden;
                box-shadow: 0px 5px 15px 0px rgba(0, 0, 0, 0.35);
            }

            #calendar {
                flex-grow: 1;
            }

            .leftupcoming h4 {
                color: #0E3C6E;
            }

            .leftupcoming p {
                color: #0E3C6E;
            }

            .rightupcoming h4 {
                color: #0E3C6E;
            }
        </style>
        <title>Dashboard</title>
    </head>
    <body>

        <%@ include file = "StudentHeader.jsp" %>
        <main style="background-color: #D9D9D9; flex-grow: 1; display: flex; flex-direction: column;">

            <!--Content-->
            <div class="container-fluid content">
                <div class="row" style="flex-grow: 1; display: flex;">
                    <div class="col-sm-3 d-flex flex-column">
                        <div class="todo">
                            <p class="todohead">To do</p>
                            <!--Number of assignment which have status : Not completed-->
                            <p class="todonumber">${todoassignment}</p>
                            <p class="foot">assignment(s) not completed</p>
                        </div>

                        <div class="classofstudent">
                            <p class="classofstudenthead">Class</p>

                            <nav class="navbar navbar-expand-sm">
                                <!-- Left -->
                                <ul class="navbar-nav mr-auto ongoingclass">
                                    <li class="nav-item">
                                        <!--Number of class which have status : ongoing-->
                                        <p class="classongoing">1</p>
                                        <p class="classongoingfoot">ongoing</p>
                                    </li>
                                </ul>
                                <!-- Right -->
                                <ul class="navbar-nav ml-auto completedclass">
                                    <li class="nav-item">
                                        <!--Number of class which have status : completed-->
                                        <p class="classcomplete">1</p>
                                        <p class="classcompletefoot">completed</p>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                    <!-- Session occur in 5 hours -->
                    <div class="col-sm-9 d-flex flex-column">
                        <div class="upcommingclass flex-grow-1">
                            <!--HEAD-->
                            <nav class="navbar navbar-expand-sm">
                                <!-- Left -->
                                <ul class="navbar-nav mr-auto">
                                    <li class="nav-item">
                                        <h1 class="upcommingclasstitle">Upcoming...</h1>
                                    </li>
                                </ul>
                            </nav>

                            <!--Content-->
                            <div class="upcommingclassdedtails">
                                <script>
                                    document.addEventListener('DOMContentLoaded', function () {
                                        var calendarEl = document.getElementById('calendar');

                                        var events = [
                                    <c:forEach items="${lesson_vector}" var="v">
                                        {
                                        title: '${v.getAClass().getTutor().getSubject().getName()}-${v.getAClass().getTutor().getName()}',
                                        start: '${v.getDate()}T${v.getSession().getStartTime()}',
                                        url: 'http://google.com/',
                                        end: '${v.getDate()}T${v.getSession().getEndTime()}',
                                        className: 'custom-event'
                                        }${not empty v and v != vector[vector.size() - 1] ? ',' : ''}
                                    </c:forEach>
                                        ];

                                        var calendar = new FullCalendar.Calendar(calendarEl, {
                                            height: '100%',
                                            expandRows: true,
                                            slotMinTime: '08:00',
                                            slotMaxTime: '21:00',
                                            headerToolbar: {
                                                left: 'prev,next today',
                                                center: 'title',
                                                right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
                                            },
                                            initialView: 'dayGridMonth',
                                            initialDate: new Date().toISOString().split('T')[0], // Current date
                                            navLinks: true, // can click day/week names to navigate views
                                            editable: false,
                                            selectable: false,
                                            nowIndicator: true,
                                            dayMaxEvents: true, // allow "more" link when too many events
                                            events: events
                                        });

                                        calendar.render();
                                    });
                                </script>
                                <div id='calendar-container'>
                                    <div id='calendar'></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </body>
</html>
