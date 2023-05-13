<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Available Teachers</title>
	<style>
	
.teacher-table {
border-collapse: collapse;
width: 100%;
margin-top: 20px;
}

.teacher-table th, 
.teacher-table td {
padding: 12px 15px;
text-align: left;
border-bottom: 1px solid #ddd;
width: 41.8%;
font-size:25px;
}

.teacher-table th {
background-color: #f2f2f2;
font-weight: bold;
color: #555;
}

.teacher-table td {
color: #333;
width: 41.8%;
font-size:25px;
}

.teacher-table tr:hover {
background-color: #f5f5f5;
}

/* Add striped rows to the table */
.teacher-table tr:nth-child(even) {
background-color: #f9f9f9;
}

/* Add hover styles to table cells */
.teacher-table td:hover {
background-color: #e8f1f8;
color: #333;
cursor: pointer;
}

/* Add styles for selected table cells */
.teacher-table .selected {
background-color: #4CAF50;
color: #fff;
}

.popup-background {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.7);
    z-index: 9999;
    display: none;
}

.popup-form {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background-color: #f9f9f9;
    padding: 20px;
    border-radius: 5px;
    width: 400px;
}

.form-group {
    margin-bottom: 10px;
}

.form-group label {
    display: block;
    font-weight: bold;
    margin-bottom: 5px;
}

.form-group select {
    width: 100%;
    padding: 10px;
    border-radius: 5px;
    border: 1px solid #ccc;
    font-size: 16px;
}

.form-buttons {
    margin-top: 20px;
    text-align: right;
}

.form-buttons .btn {
    padding: 10px 20px;
    background-color: #4CAF50;
    color: #fff;
    border-radius: 5px;
    border: none;
    cursor: pointer;
    font-size: 16px;
    margin-left: 10px;
}

.form-buttons .btn:hover {
    background-color: #3e8e41;
}

.form-buttons .btn:first-child {
    background-color: #3e8e41;
}



.form-buttons .btn:first-child:hover {
    background-color: #3e8e41;
}


</style>
	<link rel="stylesheet" href="teacher.css">
</head>
<body>

 		<div>
		<% 
			// fetch teacher data
        String[] teachername = new String[20]; // Adjust the size as per your requirement
        String[] teacherrole = new String[20];
        String[] teachermail = new String[20];

        int total = 0;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/CourseManagement", "root", "connected");
            String query = "SELECT name,role,mail FROM teacher";
            PreparedStatement st = con.prepareStatement(query);

            ResultSet rs = st.executeQuery();
            int index = 0;
            while (rs.next()) {
                teachername[index] = rs.getString("name");
                teacherrole[index] = rs.getString("role");
                teachermail[index] = rs.getString("mail");
                index++;
                total++;
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        // fetch course data 
        String[] coursename = new String[20]; // Adjust the size as per your requirement
        String[] courseid = new String[20];
        String[] coursecredit = new String[20];
        String[] courseteacher = new String[20];

        int total1 = 0;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/CourseManagement", "root", "connected");
            String query = "SELECT id,name,credit,teacher_name FROM courses";
            PreparedStatement st = con.prepareStatement(query);

            ResultSet rs = st.executeQuery();
            int index = 0;
            while (rs.next()) {
                coursename[index] = rs.getString("name");
                courseid[index] = rs.getString("id");
                coursecredit[index] = rs.getString("credit");
                courseteacher[index] = rs.getString("teacher_name");
                index++;
                total1++;
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        for (String lo:courseteacher){
        	System.out.println(lo+"jdsjbd");
        }
        %>
    </div>
	<div class="container">
		<div class="header">
			<h2 style="margin: 0;">Available Teachers</h2>
			<button class="assign-course-button btn" onclick="showAssignForm()">Assign Courses</button>			
		</div>
		<div class="teacher-table">
			<table>
				<thead>
					<%if(total!=0) {%>
						<tr>
							<th>Name</th>
							<th>Role</th>
							<th>Email</th>
						</tr>
					<%} %>
				</thead>
				<tbody>
					<%int iter = 0; %>
					<% while (iter!=total) { %>
						<tr>
							<td><%= teachername[iter] %></td>
							<td><%= teacherrole[iter] %></td>
							<td><%= teachermail[iter] %></td>
						</tr>
						<% iter++;} %>
		  		   </tbody>
			</table>
		</div>
		<div id="assign-form-background" class="popup-background" style="display:none;">
			<div id="assign-form" class="popup-form">
				<form action="AssignCourse" method="POST">
					<div class="form-group">
						<label for="teacher_id">Teacher:</label>
						<select id="teacher_id" name="teacher_id">
							<option value="">Select A Teacher</option>
							<% for(int i=0;i<total;i++) { %>
								<option value="<%= teachername[i] %>"><%= teachername[i] %></option>
							<% } %>
						</select>
					</div>
					<div class="form-group">
						<label for="course_id">Course:</label>
						<select id="course_id" name="course_id">
							<option value="">Available Courses</option>
							<% for(int i=0; i<total1; i++) { %>
								<%if(courseteacher[i]==null){%>
								<option value="<%= coursename[i] %>"><%= coursename[i] %></option>
							<%}}%>
						</select>

					</div>
					<div class="form-buttons">
						<input type="submit" value="Assign" class="btn">
						<button type="button" onclick="hideAssignForm()" class="btn">Cancel</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script>
		function showAssignForm() {
			document.getElementById("assign-form-background").style.display = "block";
		}

		function hideAssignForm() {
			document.getElementById("assign-form-background").style.display = "none";
		}
	</script>
<%-- 	<% response.sendRedirect("teacher.jsp"); %> --%>
	
</body>
</html>
