/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aebd;

/**
 *
 * @author Luismf20
 */
import java.sql.Statement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class StatusConnection {
	
    public static final String DB_DRIVER = "oracle.jdbc.driver.OracleDriver";
    public static final String DB_CONNECTION = "jdbc:oracle:thin:@localhost:1521:orcl12c";
    public static final String DB_USER = "sys";
    public static final String DB_PASSWORD = "oracle";
    
    public static Connection getStatusConnection() {
    	
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
    
}
