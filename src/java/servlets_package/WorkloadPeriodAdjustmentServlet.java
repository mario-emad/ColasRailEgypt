package servlets_package;

import classes_package.SetGetWorkloadList;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class WorkloadPeriodAdjustmentServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            String SDate = null, EDate = null;//==adjust default value for start and end date.

            SDate = request.getParameter("startDate");//==get start date from request if it be sent.
            EDate = request.getParameter("endDate");//==get end date from request if it be sent.
//            SDate = "2000-01-01";
//            EDate = "2055-01-01";
            
            //==(main if) show all documents for first access for this page and under demand.
            //==(else 1) show the list depending of the date take it from WorkloadList.jsp page popup menu.
            //==(else 2) show the same list that appear if the WorkloadList.jsp page has reload process.
            if (SDate == null && EDate == null) {
                SetGetWorkloadList workloadobj = new SetGetWorkloadList();
                workloadobj.setWorkloadlist("all");

                HttpSession session1 = request.getSession();
                session1.setAttribute("load1", workloadobj);

                RequestDispatcher requestDispatcher = request.getRequestDispatcher("WorkloadList.jsp");
                requestDispatcher.forward(request, response);
//                System.out.println("without date ------------------");
            } else if (SDate != "" && EDate != "") {
                SetGetWorkloadList workloadobj = new SetGetWorkloadList();
                workloadobj.setWorkloadlist("specificperiod");
                workloadobj.setStartperiod(SDate);
                workloadobj.setEndperiod(EDate);

                HttpSession session1 = request.getSession();
                session1.setAttribute("load1", workloadobj);

                RequestDispatcher requestDispatcher = request.getRequestDispatcher("WorkloadList.jsp");
                requestDispatcher.forward(request, response);
//                System.out.println("with date ====================");
            }else if(SDate == "" && EDate == ""){
                RequestDispatcher requestDispatcher = request.getRequestDispatcher("WorkloadList.jsp");
                requestDispatcher.forward(request, response);
//                response.sendRedirect("WorkloadList.jsp");
            }

        }
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
