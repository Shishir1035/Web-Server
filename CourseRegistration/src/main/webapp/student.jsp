<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Student List</title>
<style>
body {
			margin: 0;
			padding: 0;
			background-color: #f0f0f0;
			font-family: Arial, sans-serif;
		}
		

.container {
			width: 80%;
			margin: 0 auto;
			padding: 20px;
			background-color: white;
			box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
		}
		
		.header {
			display: flex;
			justify-content: space-between;
			align-items: center;
			margin-bottom: 20px;
			border-bottom: 1px solid #ccc;
			padding-bottom: 10px;
		}
		
		.header h2 {
			font-size: 24px;
			margin: 0;
			padding: 0;
		}
/* Style for button container */
.student-btn {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  align-items: center;
  margin-top: 20px;
}

/* Style for each button */
.student-btn button {
  display: inline-block;
  width: 80%;
  margin: 10px 1%;
  padding: 70px;
  font-size: 24px;
  text-align:center;
  background-color: #4CAF50;
  color: white;
  border: none;
  border-radius: 10px;
  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  transition: transform 0.2s;
}


.student-btn button:hover {
  transform: scale(1.05);
}

/* Style for the username panel */
.username-panel {
  background-color: #f2f2f2;
  border: 1px solid #ddd;
  border-radius: 5px;
  padding: 10px;
  margin-top: 20px;
  display: none;
}

/* Style for the username */
.username-panel p {
  font-size: 16px;
  font-weight: bold;
  margin-bottom: 5px;
}

/* Style for the close button */
.close-btn {
  background-color: #ddd;
  color: #555;
  border: none;
  border-radius: 5px;
  padding: 5px 10px;
  font-size: 14px;
  cursor: pointer;
  transition: all 0.3s ease-in-out;
}

/* Style for close button hover */
.close-btn:hover {
  background-color: #bbb;
}

</style>


</head>
<body>
	<div class="container">
		<div class="header">
			<h2 style="margin: 0;">Available Students</h2>
		</div>
	
	<div class="student-btn">
	
	<%
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/CourseManagement", "root", "connected");

        String query = "SELECT username, password FROM user where role = 'Student'";
        stmt = conn.prepareStatement(query);
        rs = stmt.executeQuery();

        while (rs.next()) {
            String id = rs.getString("username");
            String name = rs.getString("password");
    %>
            <div>
                <button style=text-align:"center" type="button" onclick="togglePanel('<%= id %>')"><%= name %></button>
                <div id="<%= id %>-panel" style="display:none;"><%= id %></div>
            </div>
    <%
        }
    } catch (SQLException ex) {
        ex.printStackTrace();
    } catch (ClassNotFoundException ex) {
        ex.printStackTrace();
    } finally {
        try { rs.close(); } catch (Exception e) {}
        try { stmt.close(); } catch (Exception e) {}
        try { conn.close(); } catch (Exception e) {}
    }
	%>
	</div>
	
	</div>
	
<script type="text/javascript">
function togglePanel(studentId) {
    var panel = document.getElementById(studentId + "-panel");
    if (panel.style.display === "none") {
        panel.style.display = "block";
    } else {
        panel.style.display = "none";
    }
}
</script>
</body>
</html>
