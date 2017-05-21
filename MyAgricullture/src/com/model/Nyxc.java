package com.model;

public class Nyxc {
	private String subj;
	private String prop;
	private String obj;
	private String gid;
	
	public Nyxc(String subj, String prop, String obj, String gid) {
		super();
		this.subj = subj;
		this.prop = prop;
		this.obj = obj;
		this.gid = gid;
	}
	public String getSubj() {
		return subj;
	}
	public void setSubj(String subj) {
		this.subj = subj;
	}
	public String getProp() {
		return prop;
	}
	public void setProp(String prop) {
		this.prop = prop;
	}
	public String getObj() {
		return obj;
	}
	public void setObj(String obj) {
		this.obj = obj;
	}
	public String getGid() {
		return gid;
	}
	public void setGid(String gid) {
		this.gid = gid;
	}
}
