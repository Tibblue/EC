package aebd;

import static java.lang.System.out;
import static java.lang.Thread.sleep;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.logging.Level;
import java.util.logging.Logger;

public class AEBD {

    private static OracleConnection oc = new OracleConnection();
    
    public static void main(String[] args) throws SQLException {
        
        while (true) {
            MonitorBD.init();
            try {
                sleep(10000);
            } catch (InterruptedException ex) {
                ex.printStackTrace();
            }
        }

    }   
}
