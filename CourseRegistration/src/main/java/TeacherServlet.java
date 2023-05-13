import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/TeacherServlet")
public class TeacherServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public TeacherServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		// Connect to the database
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3306/CourseRegistration";
			String user = "root";
			String password = "connected";
			conn = DriverManager.getConnection(url, user, password);
			
			// Fetch data from the teacher table
			String query = "SELECT * FROM teacher";
			stmt = conn.prepareStatement(query);
			rs = stmt.executeQuery();
			
			// Display the data on the webpage
			out.println("<div class='teacher-list'>");
			while (rs.next()) {
				String name = rs.getString("name");
				String id = rs.getString("id");
				String role = rs.getString("role");
				out.println("<div class='teacher'>");
				out.println("<span class='name'>" + name + "</span>");
				out.println("<span class='id'>" + id + "</span>");
				out.println("<span class='role'>" + role + "</span>");
				out.println("</div>");
			}
			out.println("</div>");
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (stmt != null) {
					stmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
