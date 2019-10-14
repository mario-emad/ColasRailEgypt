package servlets_package;

import classes_package.SetGetData;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SaveProjectServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String project = request.getParameter("base_project");
        SetGetData projectName = new SetGetData();
        projectName.setProject(project);

        HttpSession session = request.getSession();
        session.setAttribute("projectname", projectName);

        RequestDispatcher requestDispatcher = request.getRequestDispatcher("Main.jsp");
        requestDispatcher.forward(request, response);
//        response.sendRedirect("Main.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
