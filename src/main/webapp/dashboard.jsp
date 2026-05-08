<%@ page session="true" %>
<%
    String user = (String) session.getAttribute("user");
    String role = (String) session.getAttribute("role");

    if (user == null) {
        response.sendRedirect("login.html");
        return;
    }
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>User Dashboard</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<style>

/* RESET */
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Poppins',sans-serif;
}

/* ANIMATED BACKGROUND */
body{
    min-height:100vh;

    background:linear-gradient(-45deg,
        #0f172a,
        #1e3a8a,
        #facc15,
        #2563eb);

    background-size:400% 400%;

    animation:gradientBG 12s ease infinite;

    display:flex;
    flex-direction:column;

    overflow:hidden;
}

/* BACKGROUND ANIMATION */
@keyframes gradientBG{

    0%{
        background-position:0% 50%;
    }

    50%{
        background-position:100% 50%;
    }

    100%{
        background-position:0% 50%;
    }
}

/* NAVBAR */
.navbar{
    width:100%;
    height:85px;

    background:rgba(255,255,255,0.12);

    backdrop-filter:blur(18px);

    border-bottom:1px solid rgba(255,255,255,0.2);

    display:flex;
    justify-content:space-between;
    align-items:center;

    padding:0 45px;

    box-shadow:0 8px 30px rgba(0,0,0,0.25);
}

/* LEFT SECTION */
.left-section{
    display:flex;
    align-items:center;
    gap:18px;
}

/* PROFILE LOGO */
.logo{
    width:65px;
    height:65px;

    border-radius:50%;

    background:linear-gradient(135deg,#facc15,#2563eb);

    display:flex;
    justify-content:center;
    align-items:center;

    box-shadow:
        0 0 20px rgba(250,204,21,0.7),
        0 0 35px rgba(37,99,235,0.5);

    animation:floatLogo 3s ease-in-out infinite;
}

/* ICON */
.logo i{
    font-size:30px;
    color:white;
}

/* FLOAT EFFECT */
@keyframes floatLogo{

    0%{
        transform:translateY(0px);
    }

    50%{
        transform:translateY(-6px);
    }

    100%{
        transform:translateY(0px);
    }
}

/* WELCOME */
.welcome-text h2{
    color:white;
    font-size:24px;
    font-weight:700;

    text-shadow:0 2px 10px rgba(0,0,0,0.3);
}

.welcome-text p{
    color:#facc15;
    font-size:14px;
    letter-spacing:1px;
}

/* LOGOUT BUTTON */
.logout-btn{
    padding:12px 24px;

    border:none;
    border-radius:14px;

    background:linear-gradient(135deg,#facc15,#2563eb);

    color:white;

    font-size:15px;
    font-weight:600;

    cursor:pointer;

    transition:0.4s;

    box-shadow:0 6px 20px rgba(0,0,0,0.2);
}

.logout-btn:hover{
    transform:translateY(-3px) scale(1.05);

    box-shadow:
        0 0 20px rgba(250,204,21,0.6),
        0 0 25px rgba(37,99,235,0.5);
}

/* MAIN */
.main-container{
    flex:1;

    display:flex;
    justify-content:center;
    align-items:center;

    padding:20px;
}

/* GLASS CARD */
.dashboard-card{
    width:430px;

    background:rgba(255,255,255,0.12);

    backdrop-filter:blur(18px);

    border:1px solid rgba(255,255,255,0.18);

    border-radius:28px;

    padding:45px;

    text-align:center;

    box-shadow:
        0 15px 40px rgba(0,0,0,0.25);

    animation:cardGlow 4s infinite alternate;
}

/* CARD GLOW */
@keyframes cardGlow{

    from{
        box-shadow:
            0 0 20px rgba(250,204,21,0.3),
            0 0 30px rgba(37,99,235,0.2);
    }

    to{
        box-shadow:
            0 0 35px rgba(250,204,21,0.6),
            0 0 45px rgba(37,99,235,0.5);
    }
}

/* TITLE */
.dashboard-card h1{
    color:white;

    font-size:38px;

    margin-bottom:12px;

    text-shadow:0 4px 15px rgba(0,0,0,0.4);
}

/* DESCRIPTION */
.dashboard-card p{
    color:#f8fafc;

    margin-bottom:35px;

    font-size:15px;

    line-height:1.6;
}

/* BUTTONS */
.action-btn{
    width:100%;

    padding:15px;

    margin:14px 0;

    border:none;
    border-radius:16px;

    font-size:17px;
    font-weight:700;

    cursor:pointer;

    transition:0.4s;
}

/* START */
.start-btn{
    background:linear-gradient(135deg,#facc15,#eab308);

    color:#111827;
}

/* LEADERBOARD */
.leader-btn{
    background:linear-gradient(135deg,#2563eb,#1e40af);

    color:white;
}

/* BUTTON HOVER */
.action-btn:hover{
    transform:translateY(-5px) scale(1.03);

    box-shadow:
        0 10px 25px rgba(0,0,0,0.25);
}

/* MOBILE */
@media(max-width:768px){

    .navbar{
        flex-direction:column;
        height:auto;

        gap:15px;

        padding:18px;
    }

    .dashboard-card{
        width:100%;
        padding:30px;
    }

    .welcome-text h2{
        font-size:20px;
    }
}
</style>
</head>

<body>

<!-- TOP NAVBAR -->
<div class="navbar">

    <!-- LEFT -->
    <div class="left-section">

<div class="logo">
    <i class="fa-solid fa-user"></i>
</div>

        <div class="welcome-text">
            <h2>Welcome, <%= user %></h2>
            <p>User Dashboard</p>
        </div>

    </div>

    <!-- RIGHT -->
    <button class="logout-btn" onclick="confirmLogout()">
        Logout
    </button>

</div>

<!-- MAIN -->
<div class="main-container">

    <div class="dashboard-card">

        <h1>Online Quiz</h1>

        <p>
            Test your knowledge and improve your skills
        </p>

        <button class="action-btn start-btn" onclick="startQuiz()">
            Start Quiz
        </button>

        <button class="action-btn leader-btn" onclick="leaderboard()">
            Leaderboard
        </button>

    </div>

</div>

<script>

/* START QUIZ */
function startQuiz(){
    window.location.href="QuizServlet";
}

/* LEADERBOARD */
function leaderboard(){
    window.location.href="leaderboard";
}

/* LOGOUT */
function confirmLogout(){

    Swal.fire({
        title:'Logout?',
        text:'Do you want to logout?',
        icon:'warning',
        showCancelButton:true,
        confirmButtonText:'Yes',
        cancelButtonText:'Cancel'
    }).then((result)=>{

        if(result.isConfirmed){

            window.location.href="logout";
        }
    });
}

/* LOGIN ALERT */
window.onload=function(){

    const params=new URLSearchParams(window.location.search);

    const login=params.get("login");
    const role=params.get("role");

    if(login==="success"){

        let msg="";

        if(role==="admin"){
            msg="Admin logged in successfully!";
        }
        else{
            msg="User logged in successfully!";
        }

        Swal.fire({
            icon:"success",
            title:"Login Successful",
            text:msg
        }).then(()=>{

            window.history.replaceState(
                {},
                document.title,
                "dashboard.jsp"
            );

        });
    }
};

/* PREVENT BACK CACHE */
window.addEventListener("pageshow", function(event){

    if(event.persisted){
        window.location.reload();
    }
});

</script>

</body>
</html>