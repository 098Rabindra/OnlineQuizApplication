<%@ page session="true" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies

    String user = (String) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect("login.html");
        return;
    }
%>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Panel</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<style>

/* =========================
   GOOGLE FONT
========================= */
@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap');

/* =========================
   RESET
========================= */
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Poppins',sans-serif;
}

/* =========================
   BODY
========================= */
body{
    display:flex;
    min-height:100vh;
    overflow-x:hidden;

    background:
    linear-gradient(
    135deg,
    #eff6ff 0%,
    #dbeafe 35%,
    #93c5fd 70%,
    #2563eb 100%);

    background-size:400% 400%;
    animation:bgMove 12s ease infinite;
}

/* BACKGROUND ANIMATION */
@keyframes bgMove{
    0%{background-position:0% 50%;}
    50%{background-position:100% 50%;}
    100%{background-position:0% 50%;}
}

/* =========================
   SIDEBAR
========================= */
.sidebar{
    width:260px;
    height:100vh;

    position:fixed;
    left:0;
    top:0;

    padding:25px 18px;

    background:rgba(255,255,255,0.18);
    backdrop-filter:blur(18px);

    border-right:1px solid rgba(255,255,255,0.3);

    box-shadow:
    0 10px 30px rgba(0,0,0,0.15);

    z-index:1000;
}

/* =========================
   LOGO
========================= */
.logo{
    text-align:center;
    margin-bottom:40px;
    color:#1e3a8a;
}

.logo i{
    font-size:45px;
    color:#2563eb;
    margin-bottom:10px;
}

.logo h2{
    font-size:24px;
    font-weight:700;
}

.logo p{
    font-size:13px;
    opacity:0.8;
}

/* =========================
   MENU
========================= */
.menu{
    display:flex;
    flex-direction:column;
    gap:15px;
}

.menu a{
    display:flex;
    align-items:center;
    gap:14px;

    padding:14px 18px;

    border-radius:14px;

    text-decoration:none;

    background:rgba(255,255,255,0.55);

    color:#1e3a8a;

    font-size:15px;
    font-weight:600;

    cursor:pointer;

    transition:0.35s;
}

.menu a i{
    color:#2563eb;
    font-size:18px;
}

.menu a:hover{
    transform:translateX(6px);

    background:
    linear-gradient(
    135deg,
    #ffffff,
    #bfdbfe);

    box-shadow:
    0 10px 25px rgba(37,99,235,0.25);
}

/* =========================
   MAIN CONTENT
========================= */
.main-content{
    margin-left:260px;
    width:calc(100% - 260px);

    padding:35px;
}

/* =========================
   PANEL
========================= */
.panel{
    background:rgba(255,255,255,0.35);

    backdrop-filter:blur(18px);

    border-radius:25px;

    padding:30px;

    border:1px solid rgba(255,255,255,0.4);

    box-shadow:
    0 12px 35px rgba(0,0,0,0.12);

    color:#1e293b;

    animation:fadeIn 0.5s ease;
}

@keyframes fadeIn{
    from{
        opacity:0;
        transform:translateY(20px);
    }
    to{
        opacity:1;
        transform:translateY(0);
    }
}

/* =========================
   HEADINGS
========================= */
.panel h2{
    margin-bottom:25px;

    color:#1e3a8a;

    font-size:28px;

    font-weight:700;
}

/* =========================
   TABLE
========================= */
.question-table{
    width:100%;
    border-collapse:collapse;
    overflow:hidden;
    border-radius:18px;
}

.question-table th{
    background:
    linear-gradient(
    135deg,
    #2563eb,
    #60a5fa);

    color:white;

    padding:16px;

    text-align:left;

    font-size:15px;
}

.question-table td{
    padding:16px;

    background:rgba(255,255,255,0.65);

    border-bottom:1px solid #dbeafe;

    color:#1e293b;
}

.question-table tr:hover td{
    background:#eff6ff;
}

/* =========================
   FORM
========================= */
.form-group{
    margin-bottom:18px;

    display:flex;
    flex-direction:column;
}

.form-group label{
    margin-bottom:8px;

    color:#1e3a8a;

    font-weight:600;
}

/* INPUTS */
.form-group input,
.form-group textarea,
.form-group select{
    padding:14px;

    border-radius:14px;

    border:1px solid #bfdbfe;

    outline:none;

    background:rgba(255,255,255,0.8);

    color:#1e293b;

    font-size:15px;

    transition:0.3s;
}

/* PLACEHOLDER */
input::placeholder,
textarea::placeholder{
    color:#64748b;
}

/* FOCUS */
.form-group input:focus,
.form-group textarea:focus,
.form-group select:focus{
    border:1px solid #2563eb;

    box-shadow:
    0 0 15px rgba(37,99,235,0.25);

    transform:scale(1.01);
}

/* OPTIONS GRID */
.options-grid{
    display:grid;
    grid-template-columns:1fr 1fr;
    gap:18px;
}

/* =========================
   COMMON BUTTON
========================= */
button{
    border:none;
    outline:none;

    padding:12px 22px;

    border-radius:12px;

    font-size:14px;
    font-weight:600;

    cursor:pointer;

    transition:0.3s;
}

/* =========================
   ADD / UPDATE BUTTON
========================= */
.form-actions button{
    background:
    linear-gradient(
    135deg,
    #2563eb,
    #60a5fa);

    color:white;

    box-shadow:
    0 8px 20px rgba(37,99,235,0.25);
}

.form-actions button:hover{
    transform:translateY(-2px);

    box-shadow:
    0 12px 25px rgba(37,99,235,0.35);
}

/* =========================
   EDIT BUTTON
========================= */
/* =========================
   ACTION BUTTON COLUMN
========================= */
.action-buttons{
    display:flex;
    align-items:center;
    justify-content:center;
    gap:10px;
    flex-wrap:wrap;
}

/* =========================
   COMMON ACTION BUTTON
========================= */
.action-btn{
    border:none;
    outline:none;

    min-width:95px;

    padding:10px 16px;

    border-radius:10px;

    font-size:13px;
    font-weight:600;

    display:flex;
    align-items:center;
    justify-content:center;
    gap:8px;

    cursor:pointer;

    transition:0.3s ease;

    color:white;
}

/* =========================
   EDIT BUTTON
========================= */
.edit-btn{
    background:
    linear-gradient(
    135deg,
    #2563eb,
    #60a5fa);

    box-shadow:
    0 6px 18px rgba(37,99,235,0.25);
}

.edit-btn:hover{
    transform:translateY(-2px);

    box-shadow:
    0 10px 22px rgba(37,99,235,0.35);
}

/* =========================
   DELETE BUTTON
========================= */
.delete-btn{
    background:
    linear-gradient(
    135deg,
    #ef4444,
    #f87171);

    box-shadow:
    0 6px 18px rgba(239,68,68,0.25);
}

.delete-btn:hover{
    transform:translateY(-2px);

    box-shadow:
    0 10px 22px rgba(239,68,68,0.35);
}

/* =========================
   ICON STYLE
========================= */
.action-btn i{
    font-size:14px;
}

/* =========================
   TABLE ALIGN FIX
========================= */
.question-table td{
    vertical-align:middle;
}

/* MOBILE */
@media(max-width:768px){

    .action-buttons{
        flex-direction:column;
    }

    .action-btn{
        width:100%;
    }
}






/* =========================
   SCROLLBAR
========================= */
::-webkit-scrollbar{
    width:8px;
}

::-webkit-scrollbar-thumb{
    background:#2563eb;
    border-radius:20px;
}

/* =========================
   MOBILE
========================= */
@media(max-width:768px){

    body{
        flex-direction:column;
    }

    .sidebar{
        width:100%;
        height:auto;
        position:relative;
    }

    .menu{
        flex-direction:row;
        flex-wrap:wrap;
        justify-content:center;
    }

    .menu a{
        flex:1 1 45%;
        justify-content:center;
    }

    .main-content{
        margin-left:0;
        width:100%;
        padding:15px;
    }

    .options-grid{
        grid-template-columns:1fr;
    }

    .panel{
        overflow-x:auto;
        padding:20px;
    }

    .question-table{
        min-width:700px;
    }
}
</style>

<script>

/* SWITCH SECTIONS */
function showUsers() {
    document.getElementById("userSection").style.display = "block";
    document.getElementById("addSection").style.display = "none";
    document.getElementById("questionSection").style.display = "none";
}

function showAdd() {
    document.getElementById("userSection").style.display = "none";
    document.getElementById("addSection").style.display = "block";
    document.getElementById("questionSection").style.display = "none";
}

function showQuestions() {
    document.getElementById("userSection").style.display = "none";
    document.getElementById("addSection").style.display = "none";
    document.getElementById("questionSection").style.display = "block";
}

/* LOGOUT */
function confirmLogout() {
    Swal.fire({
        title: 'Are you Sure?',
        text: "Do you want to Logout",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Yes'
    }).then((res) => {
        if (res.isConfirmed) {
            window.location.href = "logout";
        }
    });
}

/* ADD QUESTION */
document.addEventListener("DOMContentLoaded", function () {

    const form = document.getElementById("questionForm");

    form.addEventListener("submit", function(e) {
        e.preventDefault();

        const formData = new URLSearchParams();

        formData.append("question", document.getElementById("question").value);
        formData.append("o1", document.getElementById("optA").value);
        formData.append("o2", document.getElementById("optB").value);
        formData.append("o3", document.getElementById("optC").value);
        formData.append("o4", document.getElementById("optD").value);
        formData.append("correct", document.getElementById("correct").value);

        const id = document.getElementById("editId").value;

        let url = "AddQuestionServlet";

        // ✅ EDIT MODE
        if (id && id !== "") {
            url = "UpdateQuestionServlet";
            formData.append("id", id);
            formData.append("answer", document.getElementById("correct").value);
        }

        fetch(url, {
            method: "POST",
            body: formData
        })
        .then(res => res.text())
        .then(msg => {
            if (msg.trim() === "success") {
            	Swal.fire("Success", "Saved successfully!", "success")
            	.then(() => {
            	    window.location.href = "ShowQuestionServlet";
            	});
            	form.reset();
                document.getElementById("editId").value = "";
            } else {
                Swal.fire("Error", msg, "error");
            }
        })
        .catch(() => {
            Swal.fire("Error", "Server error", "error");
        });

    });

});








function deleteQuestion(id) {
    Swal.fire({
        title: "Delete?",
        text: "This cannot be undone!",
        icon: "warning",
        showCancelButton: true
    }).then(res => {
        if (res.isConfirmed) {
            fetch("DeleteQuestionServlet?id=" + id)
            .then(res => res.text())
            .then(msg => {
                Swal.fire("Deleted!", "", "success");
                loadQuestions();
            });
        }
    });
}

function editQuestion(id) {
    window.location.href = "GetQuestionByIdServlet?id=" + id;
}

window.onload = function () {

    <% if (request.getAttribute("editMode") != null) { %>

        // SHOW EDIT FORM
        document.getElementById("addSection").style.display = "block";
        document.getElementById("questionSection").style.display = "none";
        document.getElementById("userSection").style.display = "none";

    <% } else if (request.getAttribute("questions") != null) { %>

        // SHOW QUESTIONS TABLE
        document.getElementById("questionSection").style.display = "block";
        document.getElementById("userSection").style.display = "none";
        document.getElementById("addSection").style.display = "none";

    <% } %>
};

</script>

</head>

<body>

<!-- SIDEBAR -->
<div class="sidebar">
    <div class="logo">
        <i class="fas fa-graduation-cap"></i> Quiz Admin
    </div>

    <div class="menu">
        <!-- CALL SERVLET -->
        <a href="UserListServlet"><i class="fas fa-users"></i> Show Users</a>
		
        <a onclick="showAdd()"><i class="fas fa-plus-circle"></i> Add Question</a>
		<a href="ShowQuestionServlet"><i class="fas fa-list"></i> Show Questions</a>
        <a onclick="confirmLogout()"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </div>
</div>

<!-- MAIN -->
<div class="main-content">

<!-- USERS -->
<div id="userSection" class="panel">

    <h2>Users List</h2>

    <table class="question-table">
        <thead>
            <tr>
                <th>ID</th>
                <th>Username</th>
            </tr>
        </thead>

        <tbody>
        <%
            List<Map<String, String>> users =
                (List<Map<String, String>>) request.getAttribute("users");

            if (users != null && !users.isEmpty()) {
                for (Map<String, String> u : users) {
        %>
            <tr>
                <td><%= u.get("id") %></td>
                <td><%= u.get("username") %></td>
            </tr>
        <%
                }
            } else {
        %>
            <tr>
                <td colspan="2" style="text-align:center;">No users found</td>
            </tr>
        <%
            }
        %>
        </tbody>
    </table>

</div>

<!-- ADD QUESTION -->
<div id="addSection" class="panel" style="display:none;">

    <h2>Add Question</h2>
    <input type="hidden" id="editId" value="${editId}">

    <form id="questionForm">

        <div class="form-group">
            <label>Question</label>
<textarea id="question" required>${editQuestion}</textarea>        </div>

        <div class="options-grid">
            <div class="form-group">
                <label>Option A</label>
                <input type="text" id="optA" value="${editOpt1}" required>
            </div>

            <div class="form-group">
                <label>Option B</label>
                <input type="text" id="optB" value="${editOpt2}" required>
            </div>

            <div class="form-group">
                <label>Option C</label>
                <input type="text" id="optC" value="${editOpt3}" required>
            </div>

            <div class="form-group">
                <label>Option D</label>
                <input type="text" id="optD" value="${editOpt4}" required>
            </div>
        </div>

        <div class="form-group">
            <label>Correct Answer</label>
            <select id="correct" required>
                <option value="">-- Select --</option>
                <option value="A" ${editAnswer == 'A' ? 'selected' : ''}>Option A</option>
				<option value="B" ${editAnswer == 'B' ? 'selected' : ''}>Option B</option>
				<option value="C" ${editAnswer == 'C' ? 'selected' : ''}>Option C</option>
				<option value="D" ${editAnswer == 'D' ? 'selected' : ''}>Option D</option>
		</select>
        </div>

        <div class="form-actions">
            <button type="submit">
     			${editMode != null ? 'Update Question' : 'Add Question'}
 			</button>
        </div>

    </form>

</div>



<!-- SHOW QUESTIONS -->
<div id="questionSection" class="panel" style="display:none;">

    <h2>All Questions</h2>

    <table class="question-table">
        <thead>
            <tr>
                <th>ID</th>
                <th>Question</th>
                <th>Options</th>
                <th>Answer</th>
                <th>Action</th>
            </tr>
        </thead>

<tbody>
<%
    List<Map<String, String>> questions =
        (List<Map<String, String>>) request.getAttribute("questions");

    if (questions != null && !questions.isEmpty()) {
        for (Map<String, String> q : questions) {
%>
    <tr>
        <td><%= q.get("id") %></td>
        <td><%= q.get("question") %></td>
        <td>
            A: <%= q.get("opt1") %><br>
            B: <%= q.get("opt2") %><br>
            C: <%= q.get("opt3") %><br>
            D: <%= q.get("opt4") %>
        </td>
        <td><%= q.get("answer") %></td>
<td>
    <div class="action-buttons">

        <button class="action-btn edit-btn"
            onclick="editQuestion('<%= q.get("id") %>')">

            <i class="fas fa-pen"></i>
            Edit

        </button>

        <button class="action-btn delete-btn"
            onclick="deleteQuestion('<%= q.get("id") %>')">

            <i class="fas fa-trash"></i>
            Delete

        </button>

    </div>
</td>
    </tr>
<%
        }
    } else {
%>
    <tr>
        <td colspan="5" style="text-align:center;">No questions found</td>
    </tr>
<%
    }
%>
</tbody>
    </table>

</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>

window.onload = function () {

    // ================= SECTION DISPLAY =================

    <% if (request.getAttribute("editMode") != null) { %>

        document.getElementById("addSection").style.display = "block";
        document.getElementById("questionSection").style.display = "none";
        document.getElementById("userSection").style.display = "none";

    <% } else if (request.getAttribute("questions") != null) { %>

        document.getElementById("questionSection").style.display = "block";
        document.getElementById("userSection").style.display = "none";
        document.getElementById("addSection").style.display = "none";

    <% } %>


    // ================= LOGIN SWEET ALERT =================

    const params = new URLSearchParams(window.location.search);

    const login = params.get("login");
    const user = params.get("user");
    const role = params.get("role");

    if (login === "success") {

        let message = "";

        if (role === "admin") {
            message = "Admin " + user + " logged in successfully!";
        } else {
            message = "User " + user + " logged in successfully!";
        }

        Swal.fire({
            icon: "success",
            title: "Login Successful",
            text: message,
            confirmButtonText: "OK"
        }).then(() => {

            // ✅ REMOVE URL PARAMETERS
            window.history.replaceState(
                {},
                document.title,
                "admin.jsp"
            );

        });
    }

};

</script>
<script>

/* =========================
   BACK BUTTON PROTECTION
========================= */

history.pushState(null, null, location.href);

window.onpopstate = function () {
    history.go(1);
};

/* =========================
   DISABLE CACHE
========================= */

window.addEventListener("pageshow", function(event){

    if(event.persisted){
        window.location.reload();
    }

});

/* =========================
   AUTO SESSION CHECK
========================= */

setInterval(function(){

    fetch("SessionCheckServlet")

    .then(res => res.text())

    .then(data => {

        if(data.trim() === "invalid"){

            window.location.href = "login.html";
        }

    });

},3000);

</script>

</body>
</html>