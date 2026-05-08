<%@ page session="true" %>
<%
    // ================= CACHE PROTECTION =================
    response.setHeader("Cache-Control",
            "no-cache, no-store, must-revalidate"); // HTTP 1.1

    response.setHeader("Pragma", "no-cache"); // HTTP 1.0

    response.setDateHeader("Expires", 0); // Proxies

    // ================= SESSION CHECK =================
    HttpSession sessionObj = request.getSession(false);

    if(sessionObj == null ||
       sessionObj.getAttribute("user") == null){

        response.sendRedirect("login.html");
        return;
    }

    String user =
        (String) sessionObj.getAttribute("user");
%>

<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quiz</title>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:Arial, sans-serif;
}

body{
    background:#f4f7ff;
}

/* TOP BAR */
.top-bar{
    width:100%;
    height:70px;
    background:#667eea;
    color:white;
    display:flex;
    justify-content:space-between;
    align-items:center;
    padding:0 30px;
    position:fixed;
    top:0;
    z-index:1000;
}

.top-back-btn{
    border:none;
    background:white;
    color:#667eea;
    padding:10px 18px;
    border-radius:8px;
    font-weight:bold;
    cursor:pointer;
    transition:0.3s;
}

.top-back-btn:hover{
    background:#eef2ff;
}

/* TIMER */
.timer{
    background:white;
    color:#667eea;
    padding:10px 20px;
    border-radius:8px;
    font-weight:bold;
}

/* MAIN */
.main-container{
    display:flex;
    gap:20px;
    padding:90px 20px 20px;
}

/* LEFT SIDE */
.quiz-section{
    width:75%;
}

/* QUESTION BOX */
.quiz-box{
    background:white;
    padding:25px;
    border-radius:12px;
    box-shadow:0 2px 10px rgba(0,0,0,0.1);
    display:none;
}

.quiz-box.active{
    display:block;
}

.question h3{
    margin-bottom:20px;
}

/* OPTIONS */
.option{
    border:1px solid #ddd;
    padding:14px;
    border-radius:8px;
    margin:12px 0;
    cursor:pointer;
}

.option:hover{
    background:#eef2ff;
}

/* BUTTONS */
.question-actions{
    margin-top:20px;
    display:flex;
    justify-content:space-between;
}

.btn{
    border:none;
    padding:12px 22px;
    border-radius:6px;
    color:white;
    cursor:pointer;
}

.back-btn{
    background:#ff5252;
}

.next-btn{
    background:#00c853;
}

.submit-btn{
    background:#667eea;
}

/* RIGHT PANEL */
.question-panel{
    width:25%;
    background:white;
    padding:20px;
    border-radius:12px;
    height:fit-content;
    position:sticky;
    top:90px;
    box-shadow:0 2px 10px rgba(0,0,0,0.1);
}

.question-panel h3{
    margin-bottom:20px;
    text-align:center;
}

.q-numbers{
    display:grid;
    grid-template-columns:repeat(4,1fr);
    gap:10px;
}

.q-btn{
    border:none;
    padding:12px;
    background:#667eea;
    color:white;
    border-radius:6px;
    cursor:pointer;
}

.q-btn:hover{
    background:#5568d8;
}

</style>
</head>

<body>

<!-- HEADER -->
<div class="top-bar">

    <!-- LEFT SIDE BACK BUTTON -->
    <button class="top-back-btn"
        onclick="window.location.href='dashboard.jsp'">
        ← Back
    </button>

    <!-- CENTER TITLE -->
    <h2>Online Quiz</h2>

    <!-- RIGHT SIDE TIMER -->
    <div class="timer">
        Time Left: <span id="timer">05:00</span>
    </div>

</div>

<div class="main-container">

<!-- LEFT SIDE -->
<div class="quiz-section">

<form action="SubmitQuizServlet" method="post">

<%
List<Map<String, String>> questions =
(List<Map<String, String>>) request.getAttribute("questions");

if(questions != null && !questions.isEmpty()){

    int i = 1;

    for(Map<String, String> q : questions){
%>

<!-- QUESTION BOX -->
<div class="quiz-box <%= (i==1) ? "active" : "" %>" id="question<%=i%>">

    <div class="question">

        <h3>
            Q<%=i%>. <%=q.get("question")%>
        </h3>

        <div class="option">
            <input type="radio" name="q<%=q.get("id")%>" value="A">
            A. <%=q.get("option1")%>
        </div>

        <div class="option">
            <input type="radio" name="q<%=q.get("id")%>" value="B">
            B. <%=q.get("option2")%>
        </div>

        <div class="option">
            <input type="radio" name="q<%=q.get("id")%>" value="C">
            C. <%=q.get("option3")%>
        </div>

        <div class="option">
            <input type="radio" name="q<%=q.get("id")%>" value="D">
            D. <%=q.get("option4")%>
        </div>

    </div>

    <!-- BUTTONS -->
    <div class="question-actions">

        <% if(i > 1){ %>
        <button type="button"
            class="btn back-btn"
            onclick="showQuestion(<%=i-1%>)">
            Previous
        </button>
        <% } else { %>
        <div></div>
        <% } %>

        <% if(i < questions.size()){ %>

        <button type="button"
            class="btn next-btn"
            onclick="showQuestion(<%=i+1%>)">
            Save & Next
        </button>

        <% } else { %>

        <button type="submit"
            class="btn submit-btn">
            Submit Quiz
        </button>

        <% } %>

    </div>

</div>

<%
        i++;
    }
}
%>

</form>

</div>

<!-- RIGHT SIDE -->
<div class="question-panel">

<h3>Questions</h3>

<div class="q-numbers">

<%
if(questions != null){

    for(int j=1; j<=questions.size(); j++){
%>

<button type="button"
    class="q-btn"
    onclick="showQuestion(<%=j%>)">

    <%=j%>

</button>

<%
    }
}
%>

</div>

</div>

</div>

<!-- SCRIPT -->
<script>

/* =========================================
   START QUIZ SECURITY
========================================= */

let warningCount = 0;
let quizSubmitted = false;

/* =========================================
   SHOW QUESTION
========================================= */

function showQuestion(num){

    let allQuestions =
        document.querySelectorAll(".quiz-box");

    allQuestions.forEach(q => {
        q.classList.remove("active");
    });

    document
        .getElementById("question" + num)
        .classList.add("active");
}

/* =========================================
   TIMER
========================================= */

let time = 300;

let timer = setInterval(function(){

    if(quizSubmitted) return;

    let minutes = Math.floor(time / 60);
    let seconds = time % 60;

    seconds = seconds < 10
        ? "0" + seconds
        : seconds;

    document.getElementById("timer").innerText =
        minutes + ":" + seconds;

    time--;

    if(time < 0){

        clearInterval(timer);

        autoSubmitQuiz(
            "Time Up! Quiz Submitted."
        );
    }

}, 1000);

/* =========================================
   AUTO SUBMIT FUNCTION
========================================= */

function autoSubmitQuiz(message){

    if(quizSubmitted) return;

    quizSubmitted = true;

    alert(message);

    document.forms[0].submit();
}

/* =========================================
   DISABLE BACK BUTTON
========================================= */

history.pushState(null, null, location.href);

window.onpopstate = function () {

    history.go(1);
};

/* =========================================
   TAB SWITCH DETECTION
========================================= */

document.addEventListener(
    "visibilitychange",
    function () {

    if(document.hidden){

        warningCount++;

        // FIRST WARNING
        if(warningCount === 1){

            alert(
                "Warning!\n\n" +
                "Tab switching detected."
            );
        }

        // SECOND WARNING
        else if(warningCount === 2){

            alert(
                "Final Warning!\n\n" +
                "Next tab switch will submit quiz."
            );
        }

        // THIRD TIME
        else if(warningCount >= 3){

            autoSubmitQuiz(
                "Multiple tab switches detected.\nQuiz Submitted."
            );
        }
    }
});

/* =========================================
WINDOW BLUR DETECTION
========================================= */

window.addEventListener("blur", function(){

 if(quizSubmitted) return;

 warningCount++;

 // FIRST TIME = WARNING + AUTO SUBMIT
 alert(
     "Warning!\n\n" +
     "Window switching detected.\n" +
     "Quiz will be submitted automatically."
 );

 autoSubmitQuiz(
     "Window switch detected.\nQuiz Submitted."
 );

});
/* =========================================
   DISABLE RIGHT CLICK
========================================= */

document.addEventListener(
    "contextmenu",
    e => e.preventDefault()
);

/* =========================================
   DISABLE COPY / PASTE
========================================= */

["copy","cut","paste"].forEach(function(evt){

    document.addEventListener(evt, function(e){

        e.preventDefault();
    });

});

/* =========================================
DISABLE DEVTOOLS + ALT TAB
========================================= */

let altTabWarning = false;

document.addEventListener(
 "keydown",
 function(e){

 // ================= ALT + TAB =================
 if(e.altKey && e.key === "Tab"){

     e.preventDefault();

     // FIRST WARNING
     if(!altTabWarning){

         altTabWarning = true;

         alert(
             "Warning!\n\n" +
             "Alt + Tab is not allowed.\n" +
             "Next attempt will submit quiz."
         );
     }

     // SECOND TIME = SUBMIT
     else{

         autoSubmitQuiz(
             "Alt + Tab detected.\nQuiz Submitted."
         );
     }
 }

 // ================= F12 =================
 if(e.key === "F12"){
     e.preventDefault();
 }

 // ================= CTRL + SHIFT + I =================
 if(
     e.ctrlKey &&
     e.shiftKey &&
     e.key.toLowerCase() === "i"
 ){
     e.preventDefault();
 }

 // ================= CTRL + SHIFT + J =================
 if(
     e.ctrlKey &&
     e.shiftKey &&
     e.key.toLowerCase() === "j"
 ){
     e.preventDefault();
 }

 // ================= CTRL + U =================
 if(
     e.ctrlKey &&
     e.key.toLowerCase() === "u"
 ){
     e.preventDefault();
 }

});

/* =========================================
   FULLSCREEN
========================================= */

function enableFullscreen(){

    let elem = document.documentElement;

    if(elem.requestFullscreen){

        elem.requestFullscreen()
        .catch(err => {
            console.log(err);
        });
    }
}

/* =========================================
   START FULLSCREEN AFTER CLICK
========================================= */

document.addEventListener(
    "click",
    function startFS(){

    enableFullscreen();

    document.removeEventListener(
        "click",
        startFS
    );

});

/* =========================================
   EXIT FULLSCREEN DETECTION
========================================= */

document.addEventListener(
    "fullscreenchange",
    function(){

    if(!document.fullscreenElement){

        autoSubmitQuiz(
            "Fullscreen exited.\nQuiz Submitted."
        );
    }
});

/* =========================================
   SESSION CHECK
========================================= */

setInterval(function(){

    fetch("SessionCheckServlet")

    .then(res => res.text())

    .then(data => {

        if(data.trim() === "invalid"){

            window.location.href =
                "login.html";
        }

    });

}, 3000);

</script>

</body>
</html>

