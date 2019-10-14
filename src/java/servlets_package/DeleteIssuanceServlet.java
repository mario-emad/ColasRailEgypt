
package servlets_package;

import classes_package.ServerConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class DeleteIssuanceServlet extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String checkissue;
            String issuanceid = request.getParameter("delete_issuance_select");
            String issuanceidarr[] = issuanceid.split("-");
//            String issuanceidarr[] = {"444","8888","4414","9996","B"};
            String issuanceidarr2[] = new String[issuanceidarr.length - 1];
            for(int i = 0; i < issuanceidarr.length - 1; i++){
                issuanceidarr2[i] = issuanceidarr[i];
            }
            String issuanceindex = issuanceidarr[issuanceidarr.length - 1];
            String documentsearchvar = issuanceidarr2[0];
            for(int i = 1; i < issuanceidarr2.length; i++){
                documentsearchvar += "-" + issuanceidarr2[i];
            }
            
            Connection connection = ServerConnection.ConnectionMethod();
            Statement statement = connection.createStatement();
            String issuedocidSQL = "SELECT document.doc_ID FROM document WHERE document.document_ID = '" + documentsearchvar + "';";
            ResultSet resultSet = statement.executeQuery(issuedocidSQL);
            int docid = 0;
            if(resultSet.next()){
                docid = resultSet.getInt("doc_ID");
            }
            
            //delete file of issuance
            String issueidSQL = "SELECT issuance.issuance_ID FROM issuance WHERE issuance.doc_ID = " + docid + " AND issuance.iss_index = '" + issuanceindex + "';";
            resultSet = statement.executeQuery(issueidSQL);
            int issueid = 0;
            if(resultSet.next()){
                issueid = resultSet.getInt("issuance_ID");
            }
            
            String deleteissueSQL = "DELETE FROM file WHERE file.issuance_ID = ?;";
            PreparedStatement preparedStatement = connection.prepareStatement(deleteissueSQL);
            preparedStatement.setInt(1, issueid);
            preparedStatement.executeUpdate();
            //delete file of issuance
            
            String deleteissuanceSQL = "DELETE FROM issuance WHERE issuance.doc_ID = ? AND issuance.iss_index = ?;";
            preparedStatement = connection.prepareStatement(deleteissuanceSQL);
            preparedStatement.setInt(1, docid);
            preparedStatement.setString(2, issuanceindex);
            preparedStatement.executeUpdate();
            
            checkissue = "done";
            HttpSession session = request.getSession();
            session.setAttribute("checkissue", checkissue);
            
            response.sendRedirect("DeleteItems.jsp");
            
//            for(int i = 0; i < issuanceidarr2.length; i++){
//                System.out.println(issuanceidarr2[i]);
//            }
//            System.out.println("------");
//            System.out.println(issuanceindex);
            
            
//            for(int i = 0; i < issuanceidarr.length; i++){
//                out.println(issuanceidarr[i]);
//            }
//            out.println("!!!!!!!!!!!!!!!!!");
//            for(int i = 0; i < issuanceidarr.length - 1; i++){
//                out.println(issuanceidarr[i]);
//            }
            
        } catch (SQLException ex) {
            Logger.getLogger(DeleteIssuanceServlet.class.getName()).log(Level.SEVERE, null, ex);
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
