/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aebd;

public class User
{
	private String name, exp, creation, common, account, prof, tablespace, tempTs;

	public User(String n, String e, String cr, String co, String a, String p, String ts, String temp)
	{
		name = n;
                exp = e;
                creation = cr;
                common = co;
                account = a;
                prof = p;
                tablespace = ts;
                tempTs = temp;
	}

    public String getName() {
        return name;
    }

    public String getExp() {
        return exp;
    }

    public String getCreation() {
        return creation;
    }

    public String getCommon() {
        return common;
    }

    public String getAccount() {
        return account;
    }
    
    public String getProfile() {
        return prof;
    }
    
    public String getTablespace() {
        return tablespace;
    }
    
    public String getTempTablespace() {
        return tempTs;
    }
        
        
        public String toString() {
            return name + " " + exp +" " + creation +  " " + common + " " + account + " " + prof;
        }
}
