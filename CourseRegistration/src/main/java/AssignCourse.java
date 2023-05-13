

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
 * Servlet implementation class AssignCourse
 */
@WebServlet("/AssignCourse")
public class AssignCourse extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AssignCourse() {
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
        String teacherName = request.getParameter("teacher_id");
        String courseName = request.getParameter("course_id");
        System.out.print(teacherName+courseName);
        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/CourseManagement", "root", "connected");
            String query = "UPDATE courses SET teacher_name = ? WHERE name = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, teacherName);
            stmt.setString(2, courseName);
            stmt.executeUpdate();
            conn.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
		response.sendRedirect("teacher.jsp");

    }

}
