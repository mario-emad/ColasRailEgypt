package classes_package;

import java.io.FileInputStream;
//import java.io.FileOutputStream;
import java.sql.Connection;
//import java.sql.PreparedStatement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.sql.ResultSet;
import java.sql.Statement;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
//import org.joda.time.LocalDate;
//import org.joda.time.format.DateTimeFormat;
//import org.joda.time.format.DateTimeFormatter;

public class ImportFileIntoDataBaseClass {

    private Workbook workbookObject;
    private Sheet sheetObject;
    private FileInputStream fileInputStreamObject;
//    private FileOutputStream fileOutputStreamObject;
    private Row rowObject;
    private Cell cellObject;
    private Connection connectionObject;
    //final column to store in DataBase.
    private String DOCUMENT_ID = "", INDEX = "", TITLE = "", FORESEEN_SEND_DATE = "", LIST_INDEX = "", DOCUMENT_ID_INDEX = "", REAL_SEND_DATE = "", STATUS = "", PRODUCTION_START_DATE = "", PRODUCTION_END_DATE = "";
    private int PHASE_ID = 0, PROJECT_ID = 0, ISSUETOINSERT = 0, ESTIMATED_WORKLOAD = 0;
//    private double PHASE_ID2 = 0;
    //temporary columns to store in final columns.
    private String id1 = "", id2 = "", id3 = "", id4 = "", id5 = "", id6 = "", project_name = "", foreseen_send_date = "", phase_id_string = "", document_id_confirmation = "", real_send_date = "", production_start_date = "", production_end_date = "", estimated_workload = "";
    private int doc_id_for_issaunce = 0;
    private String projectSQL = "", issaunceconfirmationSQL = "", documentconfirmationSQL = "", documentinsertifnotexistSQL = "", issaunceifexistSQL = "", issaunceifnotexistSQL = "";

    private Date date;
    private final DateFormat DF = new SimpleDateFormat("dd-MMM-yyyy");
    private final DateFormat DF1 = new SimpleDateFormat("dd-MM-yyyy");
    private final DateFormat DF2 = new SimpleDateFormat("yyyy-MM-dd");

    public void ImportMethod(String filePath) {
        try {
            connectionObject = ServerConnection.ConnectionMethod();
            Statement statement = null, statement1 = null;
            ResultSet resultSet = null, resultSet1 = null;
            fileInputStreamObject = new FileInputStream(filePath);
            workbookObject = WorkbookFactory.create(fileInputStreamObject);
            sheetObject = workbookObject.getSheet("Sheet1");
            int noOfRows = sheetObject.getLastRowNum();
//            out.println(noOfRows);
            for (int i = 0; i <= noOfRows; i++) {
                if (i == 0) {
                    continue;
                }
                id1 = sheetObject.getRow(i).getCell(0).toString();
                if ((id1.indexOf(".")) >= 0) {
                    int ind = id1.indexOf(".");
                    id1 = id1.substring(0, ind);
                }
                id2 = sheetObject.getRow(i).getCell(1).toString();
                id3 = sheetObject.getRow(i).getCell(2).toString();
                id4 = sheetObject.getRow(i).getCell(3).toString();
                if ((id4.indexOf(".")) >= 0) {
                    int ind = id4.indexOf(".");
                    id4 = id4.substring(0, ind);
                }
                id5 = sheetObject.getRow(i).getCell(4).toString();
                id6 = sheetObject.getRow(i).getCell(5).toString();
                if ((id6.indexOf(".")) >= 0) {
                    int ind = id6.indexOf(".");
                    id6 = id6.substring(0, ind);
                }
                DOCUMENT_ID = id1 + "-" + id2 + "-" + id3 + "-" + id4 + "-" + id5 + "-" + id6;//hold the String(document ID).

                INDEX = sheetObject.getRow(i).getCell(6).toString();//hold the String (issuance index).
//                System.out.println("\nindex : " + INDEX);

                DOCUMENT_ID_INDEX = DOCUMENT_ID + "-" + INDEX;

                TITLE = sheetObject.getRow(i).getCell(7).toString();
                TITLE = TITLE.replaceAll("'", "");//hold the String (document title).
//                System.out.println("\ntitle : " + TITLE);

                foreseen_send_date = sheetObject.getRow(i).getCell(8).toString();
                if (foreseen_send_date == null || foreseen_send_date == "") {
                    FORESEEN_SEND_DATE = "";
//                    System.out.println("\nDate is : " + FORESEEN_SEND_DATE);
                } else {
                    date = DF.parse(foreseen_send_date);
                    FORESEEN_SEND_DATE = DF2.format(date);
//                    System.out.println("\nDate is : " + FORESEEN_SEND_DATE);
                }//hold the String (foreseen date) and change the formate.

                LIST_INDEX = sheetObject.getRow(i).getCell(9).toString();//hold the String(list indx for issuance).
//                System.out.println("\nlist index : " + LIST_INDEX);

                phase_id_string = sheetObject.getRow(i).getCell(10).toString();
                PHASE_ID = (int) Double.parseDouble(phase_id_string);//hold the integer(phase number).
//                System.out.println("\nphase id : " + PHASE_ID);

                project_name = sheetObject.getRow(i).getCell(11).toString();//hold the String(project name).
//                System.out.println("\nproject name : " + project_name);

                //select id of project to store it in document table (database).
                projectSQL = "SELECT project.project_ID FROM project WHERE project.project_title = '" + project_name + "';";
                statement = connectionObject.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                resultSet = statement.executeQuery(projectSQL);
                if (resultSet.next()) {
                    PROJECT_ID = resultSet.getInt("project_ID");
//                    System.out.println("\nproject id : " + PROJECT_ID);
                }

                real_send_date = sheetObject.getRow(i).getCell(12).toString();
                if (real_send_date == null || real_send_date == "") {
                    REAL_SEND_DATE = "";
//                    System.out.println("\nDate is : " + REAL_SEND_DATE);
                } else {
                    date = DF.parse(real_send_date);
                    REAL_SEND_DATE = DF2.format(date);
//                    System.out.println("\nDate is : " + REAL_SEND_DATE);
                }//hold the String (real date) and change the formate

                STATUS = sheetObject.getRow(i).getCell(13).toString();//hold the String (status).
                if(STATUS == null){
                    STATUS = "";
                }

                production_start_date = sheetObject.getRow(i).getCell(14).toString();
                if (production_start_date == null || production_start_date == "") {
                    PRODUCTION_START_DATE = "";
//                    System.out.println("\nDate is : " + PRODUCTION_START_DATE);
                } else {
                    date = DF.parse(production_start_date);
                    PRODUCTION_START_DATE = DF2.format(date);
//                    System.out.println("\nDate is : " + PRODUCTION_START_DATE);
                }//hold the String (production start date) and change the formate.

                production_end_date = sheetObject.getRow(i).getCell(15).toString();
                if (production_end_date == null || production_end_date == "") {
                    PRODUCTION_END_DATE = "";
//                    System.out.println("\nDate is : " + PRODUCTION_END_DATE);
                } else {
                    date = DF.parse(production_end_date);
                    PRODUCTION_END_DATE = DF2.format(date);
//                    System.out.println("\nDate is : " + PRODUCTION_END_DATE);
                }//hold the String (production end date) and change the formate.

                estimated_workload = sheetObject.getRow(i).getCell(16).toString();
                double dob = Double.parseDouble(estimated_workload);
                ESTIMATED_WORKLOAD = (int) dob;
                /*
                first part of code is to store specific data into document table (database).
                second part of code is to store another specific data into issuance table (database).
                 */
                //first part
                //documentconfirmationSQL is to select document data if exist to prvent duplicated in document table (database).
                //documentconfirmationSQL used in hold document id if exist to connect between it and issuance related to it in issuance table (database).
                documentconfirmationSQL = "SELECT document.document_ID, document.doc_ID FROM document WHERE document.document_ID = '" + DOCUMENT_ID + "';";
                statement1 = connectionObject.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                resultSet1 = statement1.executeQuery(documentconfirmationSQL);
                if (resultSet1.next()) {
                    document_id_confirmation = resultSet1.getString("document_ID");
                    doc_id_for_issaunce = resultSet1.getInt("doc_ID");
                } else {
                    documentinsertifnotexistSQL = "INSERT INTO document(document_ID, phase_ID, document_title, list_index, project_ID) VALUES ('" + DOCUMENT_ID + "'," + PHASE_ID + ",'" + TITLE + "','" + INDEX + "'," + PROJECT_ID + ");";
                    statement1 = connectionObject.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                    statement1.executeUpdate(documentinsertifnotexistSQL);
                    resultSet1 = statement1.executeQuery(documentconfirmationSQL);
                    if (resultSet1.next()) {
                        document_id_confirmation = resultSet1.getString("document_ID");
                        doc_id_for_issaunce = resultSet1.getInt("doc_ID");
                    }
                }

                //second part
                issaunceconfirmationSQL = "SELECT issuance.issuance_ID, issuance.doc_ID, issuance.iss_index FROM issuance WHERE issuance.doc_ID = " + doc_id_for_issaunce + " AND issuance.iss_index = '" + INDEX + "';";
                statement1 = connectionObject.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                resultSet1 = statement1.executeQuery(issaunceconfirmationSQL);
                if (resultSet1.next()) {
                    ISSUETOINSERT = resultSet1.getInt("issuance_ID");
                    issaunceifexistSQL = "UPDATE issuance SET issuance.foreseen_send_date = '" + FORESEEN_SEND_DATE + "', issuance.real_date = '" + REAL_SEND_DATE + "', issuance.status = '" + STATUS + "', issuance.production_start_date = '" + PRODUCTION_START_DATE + "', issuance.production_end_date = '" + PRODUCTION_END_DATE + "', issuance.estimated_workload = " + ESTIMATED_WORKLOAD + " WHERE issuance.issuance_ID = " + ISSUETOINSERT + " AND issuance.iss_index = '" + INDEX + "';";
                    statement1 = connectionObject.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                    statement1.executeUpdate(issaunceifexistSQL);
                } else {
                    issaunceifnotexistSQL = "INSERT INTO issuance (doc_ID, iss_index, foreseen_send_date, real_date, status, production_start_date, production_end_date, estimated_workload) VALUES ('" + doc_id_for_issaunce + "','" + INDEX + "','" + FORESEEN_SEND_DATE + "', '" + REAL_SEND_DATE + "', '" + STATUS + "', '" + PRODUCTION_START_DATE + "', '" + PRODUCTION_END_DATE + "', " + ESTIMATED_WORKLOAD + ");";
                    statement1 = connectionObject.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                    statement1.executeUpdate(issaunceifnotexistSQL);
                }
//                System.out.println("666666666666666666666666666666");
////                connectionObject.setAutoCommit(false);
//                documentSQL = "INSERT INTO document(document_ID, phase_ID, document_title, list_index, project_ID) VALUES (" + DOCUMENT_ID + "," + PHASE_ID + "," + TITLE + "," + LIST_INDEX + "," + PROJECT_ID + ");";
//                statement1 = connectionObject.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
//                statement1.executeQuery(documentSQL);
//                statement2.addBatch(documentSQL);
//                documentforissaunceSQL = "SELECT document.doc_ID FROM document WHERE document.document_ID = '" + DOCUMENT_ID + "';";
//                statement1 = connectionObject.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
//                resultSet1 = statement1.executeQuery(documentforissaunceSQL);
//                doc_id = Integer.parseInt(resultSet1.getString("doc_ID"));
//                issaunceSQL = "INSERT INTO issaunce (issaunce.doc_ID, issaunce.iss_index, issaunce.foreseen_send_date) VALUES (" + doc_id + "," + INDEX + "," + FORESEEN_SEND_DATE + ");";
//                statement2.addBatch(issaunceSQL);
//                statement2.executeBatch();
//                connectionObject.commit();
                //System.out.println(id+"///"+name+"///"+email+"///"+phone+"///"+address);
//                String sql = "INSERT INTO studenttable VALUES('" + id + "','" + name + "','" + email + "','" + phone + "','" + address + "')";
//                pstm = (PreparedStatement) connectionObject.prepareStatement(sql);
//                pstm.execute();
                //1111111111111111111111111111111111111
//                //1111111111111111111111111111111111111
//                documentconfirmationSQL = "SELECT document.document_ID, document.doc_ID FROM document WHERE document.document_ID = '" + DOCUMENT_ID + "';";
//                statement1 = connectionObject.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
//                resultSet1 = statement1.executeQuery(documentconfirmationSQL);
//                while (resultSet1.next()) {
//                    document_id_confirmation = resultSet1.getString("document_ID");
//                    doc_id_for_issaunce = resultSet1.getInt("doc_ID");
//                } 
//                if(document_id_confirmation == "" && doc_id_for_issaunce == 0){
//                    documentinsertifnotexistSQL = "INSERT INTO document(document_ID, phase_ID, document_title, list_index, project_ID) VALUES ('" + DOCUMENT_ID + "'," + PHASE_ID + ",'" + TITLE + "','" + INDEX + "'," + PROJECT_ID + ");";
////                    documentinsertifnotexistSQL = "INSERT INTO document(document_ID, phase_ID, document_title, list_index, project_ID) VALUES (?,?,?,?,?);";
//                    statement2 = connectionObject.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
////                    PreparedStatement preparedStatement = connectionObject.prepareStatement(documentinsertifnotexistSQL);
////                    preparedStatement.setString(1, DOCUMENT_ID);
////                    preparedStatement.setInt(2, PHASE_ID);
////                    preparedStatement.setString(3, TITLE);
////                    preparedStatement.setString(4, INDEX);
////                    preparedStatement.setInt(5, PROJECT_ID);
//                    statement2.executeUpdate(documentinsertifnotexistSQL);
////                    resultSet2 = preparedStatement.executeQuery();
//                    
//                    statement11 = connectionObject.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
//                    resultSet11 = statement11.executeQuery(documentconfirmationSQL);
//                    if (resultSet11.next()) {
//                        doc_id_for_issaunce = resultSet1.getInt("doc_ID");
//                    }
//                }
//                
//                issaunceconfirmationSQL = "SELECT issuance.issuance_ID, issuance.doc_ID, issuance.iss_index FROM issuance WHERE issuance.doc_ID = " + doc_id_for_issaunce + ";";
//                statement3 = connectionObject.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
//                System.out.println("111111111111111111111111");
//                resultSet3 = statement3.executeQuery(issaunceconfirmationSQL);
////                int issuetoinsert = resultSet3.getInt("issuance_ID");
//                while (resultSet3.next()) {System.out.println("222222222222222222222");
//                    issuetoinsert = resultSet3.getInt("issuance_ID");
//                    issaunceifexistSQL = "INSERT INTO issuance (foreseen_send_date) VALUES ('" + FORESEEN_SEND_DATE + "' WHERE issuance.issuance_ID = " + issuetoinsert + ";";
//                    statement4 = connectionObject.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
//                    System.out.println("3333333333333333333333333");
//                    statement4.executeUpdate(issaunceifexistSQL);System.out.println("44444444444444444444");
//                }
//                if(issuetoinsert == 0){
//                    issaunceifnotexistSQL = "INSERT INTO issuance (doc_ID, iss_index, foreseen_send_date) VALUES ('" + doc_id_for_issaunce + "','" + INDEX + "','" + FORESEEN_SEND_DATE + "');";
//                    statement4 = connectionObject.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
//                    statement4.executeUpdate(issaunceifnotexistSQL);System.out.println("5555555555555555555");
//                }
//                System.out.println("666666666666666666666666666666");
//////                connectionObject.setAutoCommit(false);
////                documentSQL = "INSERT INTO document(document_ID, phase_ID, document_title, list_index, project_ID) VALUES (" + DOCUMENT_ID + "," + PHASE_ID + "," + TITLE + "," + LIST_INDEX + "," + PROJECT_ID + ");";
////                statement1 = connectionObject.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
////                statement1.executeQuery(documentSQL);
////                statement2.addBatch(documentSQL);
////                documentforissaunceSQL = "SELECT document.doc_ID FROM document WHERE document.document_ID = '" + DOCUMENT_ID + "';";
////                statement1 = connectionObject.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
////                resultSet1 = statement1.executeQuery(documentforissaunceSQL);
////                doc_id = Integer.parseInt(resultSet1.getString("doc_ID"));
////                issaunceSQL = "INSERT INTO issaunce (issaunce.doc_ID, issaunce.iss_index, issaunce.foreseen_send_date) VALUES (" + doc_id + "," + INDEX + "," + FORESEEN_SEND_DATE + ");";
////                statement2.addBatch(issaunceSQL);
////                statement2.executeBatch();
////                connectionObject.commit();
//                //System.out.println(id+"///"+name+"///"+email+"///"+phone+"///"+address);
////                String sql = "INSERT INTO studenttable VALUES('" + id + "','" + name + "','" + email + "','" + phone + "','" + address + "')";
////                pstm = (PreparedStatement) connectionObject.prepareStatement(sql);
////                pstm.execute();
//                //1111111111111111111111111111111111111
            }
            workbookObject.close();
            //pstm.close();
            connectionObject.close();
            fileInputStreamObject.close();
//            fileOutputStreamObject.close();
        } catch (Exception ex) {
            System.out.println("<br>");
            System.out.println(ex);
        }

    }
}
