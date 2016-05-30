package dtu.dagprojekt.bankaroo;

import javax.annotation.Resource;
import javax.sql.DataSource;
import javax.ws.rs.ApplicationPath;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Application;
import javax.ws.rs.core.MediaType;
import java.sql.*;

@ApplicationPath("rest")
@Path("/test")
public class HelloWorld extends Application {

//    @Resource(name = "jdbc/exampleDS")
//    DataSource ds1;

    @GET
    @Produces(MediaType.TEXT_PLAIN)
    public String getMessage() {

//        try {
//            Connection con = ds1.getConnection("DTU24", "FAGP2016");
//            Statement stmt = con.createStatement();
//            ResultSet result = stmt.executeQuery("SELECT * FROM 'DTUGRP09'.'Customer'");
//            while (result.next()) {
//                String empNo = result.getString(1);
//                System.out.println("Result = " + empNo);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
        String url = "jdbc:db2://192.86.32.54:5040/DALLASB";
        String user = "DTU24";
        String password = "FAGP2016";
        String empNo;

        Connection con;
        Statement stmt;
        ResultSet rs;

        System.out.println("**** Enter class EzJava");

        try {
            // Load the driver
            Class.forName("COM.ibm.db2os390.sqlj.jdbc.DB2SQLJDriver");
            System.out.println("**** Loaded the JDBC driver");

            // Create the connection using the IBM Data Server Driver for JDBC and SQLJ
            con = DriverManager.getConnection(url, user, password);

            // Commit changes manually
            con.setAutoCommit(false);
            System.out.println("**** Created a JDBC connection to the data source");

            // Create the Statement
            stmt = con.createStatement();
            System.out.println("**** Created JDBC Statement object");

            // Execute a query and generate a ResultSet instance
            rs = stmt.executeQuery("SELECT * FROM \"DTUGRP09\".\"Customer\"");

            System.out.println("**** Created JDBC ResultSet object");

            // Print all of the employee numbers to standard output device
            while (rs.next()) {
                empNo = rs.getString(1);
                System.out.println("Result = " + empNo);
            }

            System.out.println("**** Fetched all rows from JDBC ResultSet");
            // Close the ResultSet
            rs.close();
            System.out.println("**** Closed JDBC ResultSet");

            // Close the Statement
            stmt.close();
            System.out.println("**** Closed JDBC Statement");

            // Connection must be on a unit-of-work boundary to allow close
            con.commit();
            System.out.println("**** Transaction committed");

            // Close the connection
            con.close();

            System.out.println("**** Disconnected from data source");

            System.out.println("**** JDBC Exit from class EzJava - no errors");

        } catch (SQLException ex)
        {
            System.err.println("SQLException information");
            while (ex != null) {
                System.err.println("Error msg: " + ex.getMessage());
                System.err.println("SQLSTATE: " + ex.getSQLState());
                System.err.println("Error code: " + ex.getErrorCode());
                ex.printStackTrace();
                ex = ex.getNextException(); // For drivers that support chained exceptions
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        return "Database Test 2.0";
    }
}
