/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aebd;

import static java.lang.System.out;
import java.sql.ResultSet;
import java.time.LocalDateTime;


public class MonitorBD {
    
    public static void init(){
        
        String agora = LocalDateTime.now().toString().replace("T", " ");
             
        Get g = new Get();
        Sets s = new Sets(agora);                            
        ResultSet rs;
        
        out.println("CPU");
        rs = g.getCPU();
        s.setCPU(rs);
                
        out.println("MEMORY");
        rs = g.getMemory();
        s.setMemory(rs);

        out.println("TABLESPACE");
        rs = g.getTablespace();
        s.setTablespace(rs);

        out.println("DATAFILE");
        rs = g.getDatafile();
        s.setDatafile(rs);

        out.println("USER");
        rs = g.getUser();
        s.setUser(rs);

        out.println("SESSION");
        rs = g.getSession();
        s.setSession(rs);

        out.println("PRIVILEGE");
        rs = g.getPrivilege();
        s.setPrivilege(rs);

        out.println("ROLE");
        rs = g.getRole();
        s.setRole(rs);

        out.println("ROLEUSER");
        s.setRoleUser();

        out.println("ROLEPRIVILEGE");
        s.setRolePrivilege();

    }
    
}
