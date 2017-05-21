package com.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class BaseDAO {
		static String url="jdbc:mysql://localhost:3306/word";
		static String driver="com.mysql.jdbc.Driver";
		static	String user="root";
		static	String password="961215";
		public static Connection getConn(){
			Connection conn =null;
			try {
				Class.forName(driver);
			conn= DriverManager.getConnection(url,user,password);
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return conn;
		}
		public static void closeAll(Connection conn,Statement pst,ResultSet res){
			
				try {
					if(conn!=null)conn.close();
					if(pst!=null) pst.close();
					if(res!=null) res.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		}
}
