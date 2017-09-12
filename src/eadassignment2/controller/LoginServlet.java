package eadassignment2.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import eadassignment2.model.*;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
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
		// TODO Auto-generated method stub
		//doGet(request, response);
		
		//user login variables
		String adminUserId = request.getParameter("adminUserId");
		String adminPassword = request.getParameter("adminPassword");
		
		adminDB adminLogin = new adminDB();
		admin adminFound = adminLogin.adminLoginCheck(adminUserId, adminPassword);
		
		if(adminFound!=null){
			System.out.println(adminFound.getAdmin_id());
			System.out.println(adminFound.getAdmin_pass());
			
			HttpSession session = request.getSession();
			session.invalidate();
			
			session = request.getSession();
			session.setAttribute("adminFound", adminFound);
			session.setMaxInactiveInterval(60*60);
			
			response.sendRedirect("a1Dashboard.jsp");
		}
		else{
			response.sendRedirect("a1Login.jsp?loginFail=user id or password is incorrect!");
		}
		
	}

}
