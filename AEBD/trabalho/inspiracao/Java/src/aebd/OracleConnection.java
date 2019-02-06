package aebd;

import java.sql.Statement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class OracleConnection {
	
//    public static final String DB_DRIVER = "oracle.jdbc.driver.OracleDriver";
//    public static final String DB_CONNECTION = "jdbc:oracle:thin:@localhost:1521:orcl12c";
//    public static final String DB_USER = "sys as sysdba";
//    public static final String DB_PASSWORD = "oracle";
    public static final String DB_DRIVER = "oracle.jdbc.driver.OracleDriver";
    public static final String DB_CONNECTION = "jdbc:oracle:thin:@localhost:1521:orcl12c";
    public static final String DB_USER = "sys as sysdba";
    public static final String DB_PASSWORD = "oracle";
    
    public static Connection getOracleConnection() {
    	
    	Connection oc = null;
    	
    	try {
    		
    		Class.forName(DB_DRIVER);
    		
    	} catch (ClassNotFoundException e) {
    		
    		System.out.println("Error driver JDBC: "+e.getMessage());
    		
    	}
    	
    	try {

    		oc = DriverManager.getConnection(DB_CONNECTION,DB_USER,DB_PASSWORD);
            return oc;

        } catch (SQLException e) {

            System.out.println("Cannot open connection: "+e.getMessage());

        }

        return oc;

        }
    
    public String getTeste() throws SQLException {
    	
    	String s;
    	
    	ResultSet rs;
    	Statement st = getOracleConnection().createStatement();
    	
    	String query = "SELECT USERNAME FROM ALL_USERS WHERE USER_ID = 8";
    	
    	rs = st.executeQuery(query);
    	
    	rs.next();
    	
    	s = rs.toString();
    	
    	return s;
    }
    
    public void grant() throws SQLException {
    	
    	String query = "alter session set \"_ORACLE_SCRIPT\"=true;\r\n" + 
    			"";
    	
    	PreparedStatement ps = getOracleConnection().prepareStatement(query);
    	ps.executeQuery();
    }
    	
}
    
