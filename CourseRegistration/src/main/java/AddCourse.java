

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AddCourse
 */
@WebServlet("/AddCourse")
public class AddCourse extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddCourse() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        // Retrieve form data from request parameters
	        String courseName = request.getParameter("course_name");
	        String courseCode = request.getParameter("course_code");
	        String courseCredit = request.getParameter("course_credit");
	        
			try {
				
			    // Create a connection to your database
			    Class.forName("com.mysql.cj.jdbc.Driver");
			    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/CourseManagement", "root", "connected");
			    String sql = "INSERT INTO courses (id, name, credit, teacher_id) VALUES (?,?,?,?)";
			    PreparedStatement statement = conn.prepareStatement(sql);
			    statement.setString(1, courseName);
			    statement.setString(2, courseCode);
			    statement.setString(3, courseCredit);
			    statement.setString(4, "");
			    statement.executeUpdate();
			    conn.close();
			} catch (SQLException e) {
			    e.printStackTrace();
			}
			catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			response.sendRedirect("courses.jsp");
	        // Set response content type and write the response

	    }
}


