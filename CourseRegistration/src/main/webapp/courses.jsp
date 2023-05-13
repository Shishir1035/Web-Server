<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
	<title>Example JSP Page</title>
	<link rel="stylesheet" href="courses.css">
</head>
<body>

		<div>
		<% 
        String[] coursename = new String[20]; // Adjust the size as per your requirement
        String[] courseid = new String[20];
        String[] coursecredit = new String[20];

        int total = 0;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/CourseManagement", "root", "connected");
            String query = "SELECT name,id,credit FROM courses";
            PreparedStatement st = con.prepareStatement(query);

            ResultSet rs = st.executeQuery();
            int index = 0;
            while (rs.next()) {
                coursename[index] = rs.getString("name");
                courseid[index] = rs.getString("id");
                coursecredit[index] = rs.getString("credit");
                index++;
                total++;
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        %>
        </div>
			
			<div class="container">
				<div class="header">
					<h2>Available Courses</h2>
					<button class="btn" onclick="showPopupForm()">Add New Course</button>
					<button class="btn" onclick="showDeleteForm()">Delete Course</button>
			</div>

		<div class = "course-table">
			<table>
				<thead>
				<%if(total!=0) {%>
					<tr>
						<th>Course ID</th>
						<th>Course Name</th>
						<th>Course Credit</th>
					</tr>
					<%} %>
				</thead>
				<tbody>
					<%int iter = 0; %>
					<% while (iter!=total) { %>
				        <tr>
				          <td><%= coursename[iter] %></td>
				          <td><%= courseid[iter] %></td>
				          <td><%= coursecredit[iter] %></td>
				        </tr>
				      <% iter++;} %>
	  		   </tbody>
			</table>
		</div>

	</div>

	<div id="popup-background" class="popup-background">
		<div id="popup-form" class="popup-form">
			<form action="AddCourse" method="POST">
				<h2>Add New Course</h2>
			<label for="course_name" class="form-label">Course Name:</label>
			<input type="text" id="course_name" name="course_name" class="form-input"><br>
			
			<label for="course_code" class="form-label">Course Code:</label>
			<input type="text" id="course_code" name="course_code" class="form-input"><br>			
			
			<label for="course_credit" class="form-label">Course Credit:</label>
			<input type="text" id="course_credit" name="course_credit" class="form-input"><br>
			
			<input type="submit" value="Add Course" class="btn">
			<button type="button" onclick="hidePopupForm()" class="btn">Cancel</button>
		</form>
		</div>
	</div>
		<div id="delete-form-background" class="popup-background">
		  <div id="delete-form" class="popup-form">
		    <form action="DeleteCourse" method="POST">
		      <h2>Delete Course</h2>
		      <label for="course_id" class="form-label">Course ID:</label>
		      <select id="course_id" name="course_id" class="form-input">
		        <% 
		          try {
		            Class.forName("com.mysql.cj.jdbc.Driver");
		            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/CourseManagement", "root", "connected");
		            String query = "SELECT id, name FROM courses";
		            PreparedStatement st = con.prepareStatement(query);
		            ResultSet rs = st.executeQuery();
		
		            while (rs.next()) {
		              String courseId = rs.getString("id");
		              String courseName = rs.getString("name");
		              %>
		              <option value="<%= courseId %>"><%= courseId %> - <%= courseName %></option>
		              <% 
		            }
		            con.close();
		          } catch (Exception e) {
		            e.printStackTrace();
		          }
		        %>
		      </select>
		      <input type="submit" value="Delete Course" class="btn">
		      <button type="button" onclick="hideDeleteForm()" class="btn">Cancel</button>
		    </form>
		  </div>
		</div>

	<script>
		function showPopupForm() {
			document.getElementById("popup-background").style.display = "flex";
		}

		function hidePopupForm() {
			document.getElementById("popup-background").style.display = "none";
		}
		  function showDeleteForm() {
		    document.getElementById("delete-form-background").style.display = "flex";
		  }
		
		  function hideDeleteForm() {
		    document.getElementById("delete-form-background").style.display = "none";
		  }
	</script>
</body>
</html>
