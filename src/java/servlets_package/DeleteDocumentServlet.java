
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


public class DeleteDocumentServlet extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            String checkdoc;
            String documentid = request.getParameter("delete_document_ID_select");
            Connection connection = ServerConnection.ConnectionMethod();
            Statement statement = connection.createStatement();
            String docidSQL = "SELECT document.doc_ID FROM document WHERE document.document_ID = '" + documentid + "';";
            ResultSet resultSet = statement.executeQuery(docidSQL);
            int docid = 0;
            if(resultSet.next()){
                docid = resultSet.getInt("doc_ID");
            }
            
            String deleteissuesSQL = "DELETE FROM issuance WHERE issuance.doc_ID = ?;";
            PreparedStatement preparedStatement = connection.prepareStatement(deleteissuesSQL);
            preparedStatement.setInt(1, docid);
            preparedStatement.executeUpdate();
            
            String deletedocSQL = "DELETE FROM document WHERE document.document_ID = ?;";
            preparedStatement = connection.prepareStatement(deletedocSQL);
            preparedStatement.setString(1, documentid);
            preparedStatement.executeUpdate();
            
            checkdoc = "done";
            HttpSession session = request.getSession();
            session.setAttribute("checkdoc", checkdoc);
            
            response.sendRedirect("DeleteItems.jsp");
            
        } catch (SQLException ex) {
            Logger.getLogger(DeleteDocumentServlet.class.getName()).log(Level.SEVERE, null, ex);
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
