package com.job36.mobile.bean;

//import com.google.gson.annotations.Expose;

public class JsonResult {
	/**
	 * ajax返回前台状态
	 */
	//@Expose
	private String code;
	/**
	 * ajax返回前台信息
	 */
	//@Expose
	private String msg;
	
	private Object data;
	
	private int totalPage;
	
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public Object getData() {
		return data;
	}
	public void setData(Object data) {
		this.data = data;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	
	/**
	 * 成功
	 * @author dengzw
	 * 2016-11-23 上午10:47:26
	 */
	public void success(){
		this.code = "200";
		this.msg = "请求成功！";
	}
	public void success(Object data){
		success();
		this.data = data;
	}
	/**
	 * 成功
	 * @param msg
	 */
	public void success(String msg){
		success();
		this.msg = msg;
	}
	/**
	 * 失败
	 * @author dengzw
	 * 2016-11-23 上午10:47:36
	 */
	public void failure(){
		this.code = "500";
		this.msg = "请求失败！";
	}
	public void failure(String msg){
		failure();
		this.msg = msg;
	}
}
