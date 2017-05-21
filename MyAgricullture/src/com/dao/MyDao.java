package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.model.Nyxc;

public class MyDao {
	public List getSingleList(String name){
		ArrayList<Nyxc> list = new ArrayList<Nyxc>();
		String sql = "select  distinct * from jena_g1t1_stmt where Subj = ?";
		PreparedStatement pst=null;
		ResultSet res = null;
		Connection conn =null;
		try {
			 conn = BaseDAO.getConn();
			pst =conn.prepareStatement(sql);
			pst.setString(1, name);
			 res = pst.executeQuery();
			 while(res.next()){
					String subj=res.getString("Subj");
					String prop=res.getString("Prop");
					String obj= res.getString("Obj");
					Nyxc n = new Nyxc(subj, prop, obj, "1");
				list.add(n);
			 }
		} catch (SQLException e) {
			e.printStackTrace();
		}
		BaseDAO.closeAll(conn, pst, res);
		return list;
	}
	
	public List getTipList(String name){
		ArrayList<Nyxc> list = new ArrayList<Nyxc>();
		String sql = "select  distinct subj ,length(subj) from jena_g1t1_stmt where Subj like ? order by length(subj)";
		PreparedStatement pst=null;
		ResultSet res = null;
		Connection conn =null;
		try {
			 conn = BaseDAO.getConn();
			pst =conn.prepareStatement(sql);
			pst.setString(1, "%"+name+"%");
			 res = pst.executeQuery();
			 while(res.next()){
					String subj=res.getString("Subj");
					String prop="";
					String obj= "";
					Nyxc n = new Nyxc(subj, prop, obj, "1");
				list.add(n);
			 }
		} catch (SQLException e) {
			e.printStackTrace();
		}
		BaseDAO.closeAll(conn, pst, res);
		return list;
	}
	public static void main(String[] args) {
		//System.out.println(new MyDao().getSingleList("Ë®µ¾¡¾60D¡¿"));
		List<Nyxc> list1 = new MyDao().getTipList("µ¾");
		System.out.println(list1.size());
		for (Nyxc n : list1) {
			System.out.println(n.getSubj()+"---"+n.getProp()+"---"+n.getObj());
		}
	}
}
