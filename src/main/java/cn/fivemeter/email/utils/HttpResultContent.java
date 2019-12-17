package cn.fivemeter.email.utils;

import java.io.Serializable;

public class HttpResultContent implements Serializable{
	private Integer code;
	private String msg;
	private Object data;
	
	public Integer getCode() {
		return code;
	}
	public HttpResultContent setCode(Integer code) {
		this.code = code;
		return this;
	}
	public String getMsg() {
		return msg;
	}
	public HttpResultContent setMsg(String msg) {
		this.msg = msg;
		return this;
	}
	public Object getData() {
		return data;
	}
	public HttpResultContent setData(Object data) {
		this.data = data;
		return this;
	}
	
	public static HttpResultContent success() {
		HttpResultContent result = new HttpResultContent();
		result.setCode(200);
		result.setMsg("请求成功");
		return result;
	}
	
	public static HttpResultContent fail() {
		HttpResultContent result = new HttpResultContent();
		result.setCode(500);
		result.setMsg("请求失败");
		return result;
	}
	
}
