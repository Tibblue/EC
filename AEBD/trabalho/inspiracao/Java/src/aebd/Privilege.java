/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aebd;

public class Privilege
{
	private String user, priv, prop;

	public Privilege(String u, String pr, String pro)
	{
                user = u;
		priv = pr;
		prop = pro;
	}

	public String getPrivilege()
	{
		return priv;
	}


	public String getProperty()
	{
		return prop;
	}
        
        public String getUser()
	{
		return user;
	}
        
        public String toString() {
            return priv + " " + prop;
        }
}
