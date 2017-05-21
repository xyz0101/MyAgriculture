package com.action;

import java.util.List;

import net.sf.json.JSON;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


import com.dao.BaseDAO;
import com.dao.MyDao;
import com.model.Nyxc;

@org.springframework.stereotype.Controller
public class Controller {
	@RequestMapping("/toselect")
	public String toSelect(){
		return "select";
	}
	@RequestMapping("/select")
	public String select(String name,Model model){
		System.out.println(name);
		List<Nyxc> list = new MyDao().getSingleList(name);
		System.out.println(list.size());
		JSONArray ja = new JSONArray();
		JSONArray jalink = new JSONArray();
		JSONObject jo1 = new JSONObject();
			jo1.put("id", name);			
			jo1.put("category", (int)0);
			jo1.put("name", name);				
			jo1.put("label", name);
			jo1.put("symbolSize", (int)40);
			jo1.put("ignore", (boolean)false);
			jo1.put("flag", (boolean)true);
			ja.add(jo1);
		for (int i=0;i<list.size();i++) {
			String target=name;
			Nyxc n = list.get(i);
			String obj="";
			if(n.getObj().equals("null"))
				obj="没有内容";
			else obj=n.getObj();
			JSONObject jo = new JSONObject();
			JSONObject jolink = new JSONObject();
				jo.put("id", obj);			
				jo.put("category", (int)1);
				jo.put("name", obj);				
				jo.put("label", obj);
				jo.put("symbolSize", (int)20);			
				jo.put("ignore", (boolean)false);
				jo.put("flag", (boolean)true);
				
				jolink.put("source", obj);
				jolink.put("target",target );
				if(!n.getProp().equals("null"))
				jolink.put("name", n.getProp());
				else
					jolink.put("name", "没有内容");
				ja.add(jo);
				jalink.add(jolink);
			}
		System.out.println(ja);
		System.out.println(jalink);
		System.out.println();
		model.addAttribute("node", ja);
		model.addAttribute("link", jalink);
		return "view";
	}
	
	@RequestMapping("/getNextData")
	public @ResponseBody JSON getNextData(String name){
		System.out.println(name);
		List<Nyxc> list = new MyDao().getSingleList(name);
		System.out.println(list.size());
		JSONArray ja = new JSONArray();
		JSONArray jalink = new JSONArray();
		
		for (int i=0;i<list.size();i++) {
		
			Nyxc n = list.get(i);
			String obj="";
			if(n.getObj().equals("null"))
				obj="没有内容";
			else obj=n.getObj();
			JSONObject jo = new JSONObject();
			JSONObject jolink = new JSONObject();
				jo.put("id", obj);			
				jo.put("category", (int)2);
				jo.put("name", obj);				
				jo.put("label", obj);
				jo.put("symbolSize", (int)20);			
				jo.put("ignore", (boolean)false);
				jo.put("flag", (boolean)true);
				ja.add(jo);
				
			}
		return ja;
		
	}
	@RequestMapping("/getNextLink")
	public @ResponseBody JSON getNextLink(String name){
		System.out.println(name);
		List<Nyxc> list = new MyDao().getSingleList(name);
		System.out.println(list.size());
		
		JSONArray jalink = new JSONArray();
		
		for (int i=0;i<list.size();i++) {
			JSONObject jolink = new JSONObject();
			String target=name;
			Nyxc n = list.get(i);
			if(!n.getObj().equals("null"))
			jolink.put("source", n.getObj());
			else 
				jolink.put("source", "没有内容");
			jolink.put("target",name );
			if(!n.getProp().equals("null"))
			jolink.put("name", n.getProp());
			else jolink.put("name", "没有内容");
			jalink.add(jolink);
				
			}
		
		return jalink;
		
		
	}
	
	@RequestMapping( value="/findname",produces={"text/html;charset=UTF-8;","application/json;"})	
	public @ResponseBody  String Message( String name ){
		String data="";
		System.out.println(name);
		List<Nyxc> list = new MyDao().getTipList(name);
		System.out.println(list.size());
		if(list.size()>0){
		int m;
		if(list.size()<26)
			m=list.size();
		else
			m=25;
		String name1="";
		for(int i=0;i<m;i++){
			name1=list.get(i).getSubj();
			data=data+name1+",";
	//	jsonArray.add(list.get(i).getSubj());
		}data=data+"一共"+list.size()+"条记录";
		System.out.println(data);
		return data;
		}else
		return null;
	}
	
}
