package data_management;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnectivity 
{
	private static  Connection conn;
	private static DatabaseConnectivity db;
	private static String url = "jdbc:mysql://localhost:3306/hospital";
	private static String user = "root";
	private static String password = "Manju@123";
	public DatabaseConnectivity()
	{
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(url,user,password);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static Connection getConnection()
	{
		if(db==null)
		{
			db = new DatabaseConnectivity();
		}
		return db.conn;
	}
	
	public static void closeConnection()
	{
		if(conn!=null)
		{
			try {
				conn.close();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
}
