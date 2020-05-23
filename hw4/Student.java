import java.io.*;
import java.sql.*;
import javax.sql.*;
import java.util.Scanner;

class Student{
	// the host name of the server and the server instance name/id
	public static final String oracleServer = "dbs3.cs.umb.edu";
	public static final String oracleServerSid = "dbs3";
	public static void main(String args[]) {
		Connection conn = null;
		conn = getConnection();
		if (conn==null)
			System.exit(1);

		//now execute query
    int sid = 0;
    int student_id;
		Scanner input = new Scanner(System.in);
		try {
		  // Create statement object
		  Statement stmt = conn.createStatement();
		  while(true){
	 	    //get room number from user
		    System.out.print("please enter your student id = (type -1 -> if a new student)");
		    String filter = input.nextLine();
        //checking if id is wrong
        student_id = Integer.parseInt(filter);
        ResultSet d = stmt.executeQuery("select sid from Students");
      boolean wrongid = true;
         while (d.next()) {
               if (student_id == d.getInt("sid")) {
                 wrongid = false;
                 break;
               }
            }
        //This part of the code checks for a new student a
        //and it will enroll a new student into STudents, courses table and it also ask student to enroll into a course. 
		    if (filter.equals("-1"))
			{

        System.out.print("please enter your name = ");
        String sname = input.nextLine();
        ResultSet s = stmt.executeQuery("select sid from Students");
        while (s.next()){
          if (s.getInt("sid") != sid) {
            break;
          }
          sid++;
        }
        String junk = "insert into Students (sid, sname) values ("+ sid + ",'"+ sname+"')";
        stmt.executeUpdate(junk);
        System.out.print("type the course id of which first course you want to enroll in: (11->Cs101, 22->CS120, 33->Math320, 44->Cs830) ");
        String bulshit = input.nextLine();
        int cid = Integer.parseInt(bulshit);
        ResultSet c_id = stmt.executeQuery("select credits, cname from courses"
			+ " where cid="+cid);
        String c_name = "";
        int credits = 0;
        while (c_id.next()) {
            c_name = c_id.getString("cname");
            credits = c_id.getInt("credits");
        }

        String junk1 = "insert into Courses (cid, cname, credits) values (" + cid +",'" + c_name + "'," + credits + ")";
        String junk2 = "insert into Enrolled (sid, cid) values ("+ sid+","+ cid+")";
        stmt.executeUpdate(junk1);
        stmt.executeUpdate(junk2);
        System.out.print("Student successfully Enrolled!\n\n");
        continue;
      }
     else if (wrongid) {
      System.out.print("Wrong Id is entered!!\n");
    }
            //this part of the code is main menu for the program. 
        else {
  System.out.print("Click one of the following code letters to perform one of the following attributes: \nL – List: lists all records in the course table");
        System.out.print("\nE – Enroll: enrolls the active student in a course; user is prompted for course ID; check for conflicts, i.e., student cannot enroll twice in same course");
        System.out.print("\nW – Withdraw: deletes an entry in the Enrolled table corresponding to active student; student is prompted for course ID to be withdrawn from");
        System.out.print("\nS – Search: search course based on substring of course name which is given by user; list all matching courses");
        System.out.print("\nM – My Classes: lists all classes enrolled in by the active student.");
        System.out.print("\nX – Exit: exit application");
     
      String action = input.nextLine();
      //L
      if(action.equals("L") || action.equals("l")) {
        ResultSet record = stmt.executeQuery("select cid, cname, credits from courses");
        if (record.next()){
          do{
              System.out.println(
          "Course id = " + record.getInt("cid")+
          ", Course Name= " + record.getString("cname")+
          ", Credit Hours= "+ record.getInt("credits")
              );
            }while(record.next());
        }
        else
      System.out.println("No Records Retrieved");
      }
      //E
      else if(action.equals("E") || action.equals("e")) {
         while(true){
        System.out.print("type the course id of which first course you want to enroll in: (11->Cs101, 22->CS120, 33->Math320, 44->Cs830) ");
         String bulshit = input.nextLine();
        int cid = Integer.parseInt(bulshit);
        //takes care of class conflicts
        ResultSet c_id = stmt.executeQuery("select e.cid from courses c, enrolled e where e.sid =" +student_id);
      boolean conflict = false;
      while(c_id.next()) {
        if (c_id.getInt("cid") == cid) {
          conflict = true;
          break;
        }
      }
      ResultSet c_id1 = stmt.executeQuery("select credits, cname from courses"
    + " where cid="+cid);
      
      if (!conflict) {
        c_id1.next();
        stmt.executeUpdate("insert into Courses values ("+ cid +",'" +c_id1.getString("cname") + "'," + c_id1.getInt("credits") + ")");
        stmt.executeUpdate("insert into Enrolled values ("+ student_id +"," + cid +")");
      }
      else {
        System.out.println("Class Conflict!!");
      }
      System.out.print("if you are done choosing courses:- \n-->to exit: enter 0\n-->to continue: any number other than 0 ");
      String junk = input.nextLine();
      int leave = Integer.parseInt(junk);
      if(leave == 0) {
        break;
      }
      else {
        continue;
      }
    }
      }
      //W
      else if(action.equals("W") || action.equals("w")) {
        System.out.print("please enter the course id you want to widthdraw from a course: ");
        String bulshit = input.nextLine();
        int cid = Integer.parseInt(bulshit);
        stmt.executeUpdate("delete from enrolled e where e.cid= " + cid+" and e.sid = " + student_id);
        System.out.print("Course withdrawal Successful!");
      }
      //S
      else if(action.equals("S") || action.equals("s")) {
          System.out.print("----------------Search------------\nenter the course name: ");
          String cname = input.nextLine();
          ResultSet record = stmt.executeQuery("select cname from courses where cname like '"+ cname+ "%'");
          if (record.next()){
            do{
                System.out.println("Course Name= " + record.getString("cname"));
              }while(record.next());
          }
          else {
            System.out.println("No classes record were found!!");}
      }
      //M
      else if(action.equals("M") || action.equals("m")) {
        ResultSet record = stmt.executeQuery("select cname from courses c, enrolled e where e.cid = c.cid and e.sid = "+ student_id);
        if (record.next()){
          do{
              System.out.println(
          "Course id = " + record.getInt("cid")+
          ", Course Name= " + record.getString("cname")+
          ", Credit Hours= "+ record.getInt("credits"));
            }while(record.next());
        }
        else
      System.out.println("No classes record were found!!");
      }
      //X
      else if(action.equals("X") || action.equals("x")){
        //exitting out of the program
        System.out.println("Exitting out of the program!!!");
        break;
      }
      else {
        System.out.println("Wrong code word entered! Try again later!!");
      }
    }
		  }
		} catch (SQLException e) {
			System.out.println ("ERROR OCCURRED");
			e.printStackTrace();
		}
	}
	public static Connection getConnection(){

	String jdbcDriver = "oracle.jdbc.OracleDriver";
    try {
      Class.forName(jdbcDriver); 
    } catch (Exception e) {
      e.printStackTrace();
    }

    // Get username and password
    Scanner input = new Scanner(System.in);
    System.out.print("Username:");
    String username = input.nextLine();
    System.out.print("Password:");
    //the following is used to mask the password
    Console console = System.console();
    String password = new String(console.readPassword()); 
    String connString = "jdbc:oracle:thin:@" + oracleServer + ":1521:"
        + oracleServerSid;

    System.out.println("Connecting to the database...");
  
    Connection conn;
    // Connect to the database
    try{
      conn = DriverManager.getConnection(connString, username, password);
      System.out.println("Connection Successful");
    }
    catch(SQLException e){
      System.out.println("Connection ERROR");
      e.printStackTrace();  
      return null;
    }

    return conn;
	}
}
