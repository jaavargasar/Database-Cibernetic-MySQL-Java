package model;

import java.sql.*;

import javax.swing.JOptionPane;

public class MyConnection{
	
	private String host = "localhost:3306";
	private String user = "root";
	private String database = "cibernetic4";
	private String password = "1234"; //Change Password
	private String server = "jdbc:mysql://"+host+"/"+database;
	private static Connection connection=null;
	
	//jdbc:mysql://localhost:3306/cibernetic2
	
	public MyConnection(){}
	
	public Connection getConnection(){
		if(connection != null) return connection;
		try {
			Class.forName("com.mysql.jdbc.Driver");	//Verifying that the Connector class is available 
			connection = DriverManager.getConnection(server,user,password);
		} catch (Exception e) {
			JOptionPane.showMessageDialog(null, e.toString());
			
		}
		return connection;
	}

	public ResultSet execute(String string) {
		if(connection == null) getConnection();
		ResultSet resultSet = null;
		try {
			Statement statement = connection.createStatement();
			resultSet = statement.executeQuery(string);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return resultSet;
	}
	
}
