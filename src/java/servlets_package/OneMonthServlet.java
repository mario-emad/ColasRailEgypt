
package servlets_package;

import classes_package.SetGetWorkloadList;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class OneMonthServlet extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String STARTDATE = null, ENDDATE = null;

            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");//==set formate for date.
            Date start = new Date(), end = new Date();//==start to hold the main date, end to hold the new date after adding week.
            Calendar c = Calendar.getInstance();//==object of calender to hold the old date and add the new value (week, year, day, ...).

            STARTDATE = dateFormat.format(start);//==execute the formate and hold it.
            c.setTime(start);//==convert start date into calendar.
            c.add(Calendar.MONTH, 1);//==add one month into date.
            end = c.getTime();//==get new date and hold it.
            ENDDATE = dateFormat.format(end);//==execute the formate and hold it.

            //==object of SetGetWorkloadList.java class to adjust specific data of this period (one week).
            SetGetWorkloadList workloadobj = new SetGetWorkloadList();
            workloadobj.setWorkloadlist("oneweek");
            workloadobj.setStartperiod(STARTDATE);
            workloadobj.setEndperiod(ENDDATE);

            //==send object through session.
            HttpSession session = request.getSession();
            session.setAttribute("load1", workloadobj);

            RequestDispatcher requestDispatcher = request.getRequestDispatcher("WorkloadList.jsp");
            requestDispatcher.forward(request, response);
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
