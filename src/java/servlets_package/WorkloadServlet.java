package servlets_package;

import classes_package.SetGetWorkloadList;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class WorkloadServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

//            SetGetWorkloadList workloadobj = new SetGetWorkloadList();
//            workloadobj.setWorkloadlist("all");
//            
//            HttpSession session1 = request.getSession();
//            session1.setAttribute("load1", workloadobj);
//            
//            RequestDispatcher requestDispatcher = request.getRequestDispatcher("WorkloadList.jsp");
//            requestDispatcher.forward(request, response);
//            String STARTDATE = null, ENDDATE = null;
//
//            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");//==set formate for date.
//            Date start = new Date(), end = new Date();//==start to hold the main date, end to hold the new date after adding week.
//            Calendar c = Calendar.getInstance();//==object of calender to hold the old date and add the new value (week, year, day, ...).
//
//            STARTDATE = dateFormat.format(start);//==execute the formate and hold it.
//            c.setTime(start);//==convert start date into calendar.
//            c.add(Calendar.WEEK_OF_YEAR, 2);//==add one week into date.
//            end = c.getTime();//==get new date and hold it.
//            ENDDATE = dateFormat.format(end);//==execute the formate and hold it.
//            out.println("before : " + STARTDATE);
//            out.println("<br/>after : " + ENDDATE);
            try {
                String foreseen_send_date = "09-mar-2019";
//                DateFormat DF1 = new SimpleDateFormat("dd-MM-yyyy");
//                DateFormat DF2 = new SimpleDateFormat("yyyy-MM-dd");
//
//                Date date = (Date) DF1.parse(foreseen_send_date);
//                String str = DF2.format(date);
//                System.out.println("new date is : " + str);
//                out.println("new date is : " + str);
//                Date date2 = (Date) DF2.parse(foreseen_send_date);
//                String str2 = DF2.format(date);
//                System.out.println("new date is : " + str2);
//                out.println("new date is : " + str2);


                SimpleDateFormat format1 = new SimpleDateFormat("dd-MMM-yyyy");
                SimpleDateFormat format2 = new SimpleDateFormat("yyyy-MM-dd");
                Date date = (Date) format1.parse(foreseen_send_date);
                out.println(format2.format(date));
            } catch (ParseException ex) {
                Logger.getLogger(WorkloadServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
//            String str = DF.format(foreseen_send_date);

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
