

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class DeleteCourse
 */
@WebServlet("/DeleteCourse")
public class DeleteCourse extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteCourse() {
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
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    String courseId = request.getParameter("course_id");

	    try {
	      Class.forName("com.mysql.cj.jdbc.Driver");
	      Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/CourseManagement", "root", "connected");
	      String query = "DELETE FROM courses WHERE id=?";
	      PreparedStatement st = con.prepareStatement(query);
	      st.setString(1, courseId);

	      int rowsAffected = st.executeUpdate();
	      if (rowsAffected > 0) {
	        response.sendRedirect("courses.jsp"); // redirect back to courses.jsp
	      } else {
	        // handle error
	      }

	      con.close();
	    } catch (Exception e) {
	      e.printStackTrace();
	      // handle error
	    }
	  }

}
