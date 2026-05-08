<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quiz Result</title>

<style>

body{
    font-family:Arial;
    background:#f2f2f2;
    display:flex;
    justify-content:center;
    align-items:center;
    height:100vh;
}

.result-box{
    background:white;
    padding:40px;
    border-radius:10px;
    text-align:center;
    width:400px;
    box-shadow:0 0 15px rgba(0,0,0,0.1);
}

h1{
    color:#667eea;
    margin-bottom:20px;
}

.score{
    font-size:28px;
    margin:20px 0;
    color:#333;
}

.btn{
    padding:12px 20px;
    background:#667eea;
    color:white;
    text-decoration:none;
    border-radius:6px;
}

</style>

</head>
<body>

<div class="result-box">

    <h1>Quiz Result</h1>

    <div class="score">

        Your Score :
        <br><br>

        <b>
            <%= request.getAttribute("score") %>
            /
            <%= request.getAttribute("total") %>
        </b>

    </div>

    <a href="dashboard.jsp" class="btn">
        Back to Dashboard
    </a>

</div>

</body>
</html>