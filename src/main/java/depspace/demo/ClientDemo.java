/*
 * ClientTest.java
 *
 * Created on 15 de Maio de 2006, 15:20
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package depspace.demo;

import java.util.Collection;
import java.util.Properties;
import java.util.Scanner;
import java.util.logging.Logger;

import depspace.client.DepSpaceAccessor;
import depspace.client.DepSpaceAdmin;
import depspace.general.DepSpaceConfiguration;
import depspace.general.DepSpaceException;
import depspace.general.DepSpaceProperties;
import depspace.general.DepTuple;

/**
 * 
 * @author edualchieri
 */
public class ClientDemo {

	public static final Logger logger = Logger.getLogger(ClientDemo.class.getName());
	


	/** Creates a new instance of ClientTest */
	public ClientDemo(int clientId, int exec, boolean createSpace) {

	}

	public void run() {
		try {

			System.out.println("THE END!!!");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public DepTuple get(int i) {
		return DepTuple.createTuple(i, "confidentiality", "I'm the client",
				"BUMMMM!!!");
	}


	public static void main(String[] args) throws DepSpaceException {

		
		DepSpaceAccessor accessor = getDepSpaceAccessor();

		int cont = 50;

		
		Scanner sc = new Scanner(System.in);
		Command command = Command.rdp;
		DepTuple template, tuple;
		while(command!=Command.exit){
			String[] commStr; 
			if(cont<50){
				commStr = new String [] {"out", "a,"+cont};
				System.out.println("> " + commStr[0] + " " + commStr[1]);
				cont++;
			} else {
				System.out.print("> ");
				commStr = sc.nextLine().split(" ");
			}
			if(commStr.length > 3){
				System.out.println("Invalid number of args. ");
				continue;
			}

			try{
				command=Command.valueOf(commStr[0]);
			}catch(java.lang.IllegalArgumentException e){
				System.out.println("Invalid Command.");
				continue;
			}

			// === OPERATIONS THREATMENT ====
			switch(command){
			case rdp:
				if(commStr.length<2){
					System.out.println("Invalid number of args. ");
					continue;
				}
				template = DepTuple.createTuple((Object[])commStr[1].split(","));
				DepTuple dt = accessor.rdp(template);
				if(dt==null)
					System.out.println("null");
				else
					System.out.println(dt.toStringTuple());
				break;
			case cas:
				if(commStr.length<3){
					System.out.println("Invalid number of args. ");
					continue;
				}
				template = DepTuple.createTuple((Object[])commStr[1].split(","));
				tuple = DepTuple.createTuple((Object[])commStr[2].split(","));
				DepTuple res = accessor.cas(template, tuple);
				if(res==null)
					System.out.println("null");
				else
					System.out.println(res.toStringTuple());
				break;
			case inall:
				if(commStr.length<2){
					System.out.println("Invalid number of args. ");
					continue;
				}
				template = DepTuple.createTuple((Object[])commStr[1].split(","));
				Collection<DepTuple> l = accessor.inAll(template);
				for(DepTuple t : l)
					System.out.println(t.toStringTuple());
				break;
			case inp:
				if(commStr.length<2){
					System.out.println("Invalid number of args. ");
					continue;
				}
				template = DepTuple.createTuple((Object[])commStr[1].split(","));
				DepTuple t = accessor.inp(template);
				if(t==null)
					System.out.println("null");
				else
					System.out.println(t.toStringTuple());
				break;
			case out:
				if(commStr.length<2){
					System.out.println("Invalid number of args. ");
					continue;
				}
				tuple = DepTuple.createTuple((Object[])commStr[1].split(","));
				accessor.out(tuple);
				break;
			case rdall:
				Collection<DepTuple> list=null;
				if(commStr.length==2){
					template = DepTuple.createTuple((Object[])commStr[1].split(","));
					list = accessor.rdAll(template, 0);
				}else{
					System.out.println("Invalid number of args. ");
					continue;
				}
				for(DepTuple tup : list)
					System.out.println(tup.toStringTuple());
				break;
			case replace:
				if(commStr.length<3){
					System.out.println("Invalid number of args. ");
					continue;
				}
				template = DepTuple.createTuple((Object[])commStr[1].split(","));
				tuple = DepTuple.createTuple((Object[])commStr[2].split(","));
				DepTuple r = accessor.replace(template, tuple);
				if(r==null)
					System.out.println("null");
				else
					System.out.println(r.toStringTuple());
				break;
			case exit:
				break;
			}
		}
		sc.close();
	}

	private static DepSpaceAccessor getDepSpaceAccessor() throws DepSpaceException {
		boolean create = true;

		String name = "Demo Space";
		
		DepSpaceConfiguration.init(null);
		
		// the DepSpace name
		Properties prop = DepSpaceProperties.createDefaultProperties(name);

		// use confidentiality?
		prop.put(DepSpaceProperties.DPS_CONFIDEALITY, "false");

		int clientID = 4;

		// the DepSpace Accessor, who will access the DepSpace.
		DepSpaceAccessor accessor = null;
		if (create) {
			accessor = new DepSpaceAdmin(clientID).createSpace(prop);
		} else {
			accessor = new DepSpaceAdmin(clientID).createAccessor(prop, create);
		}
		return accessor;
	}
}

enum Command{
	rdp, cas, inp, rdall, inall, out, replace,exit;
}