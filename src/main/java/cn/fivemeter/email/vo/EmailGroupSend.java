package cn.fivemeter.email.vo;

import java.util.List;

import cn.fivemeter.email.bean.Email;

public class EmailGroupSend {
	
	private String emailId;
	
	private String sendId;
	private String sendName;
	private String title;
	private String content;
	private List<Email> receiveList;
	private String createTime;
	private String changeTime;
	
	public String getChangeTime() {
		return changeTime;
	}
	public void setChangeTime(String changeTime) {
		this.changeTime = changeTime;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public String getEmailId() {
		return emailId;
	}
	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}
	public String getSendId() {
		return sendId;
	}
	public void setSendId(String sendId) {
		this.sendId = sendId;
	}
	public String getSendName() {
		return sendName;
	}
	public void setSendName(String sendName) {
		this.sendName = sendName;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public List<Email> getReceiveList() {
		return receiveList;
	}
	public void setReceiveList(List<Email> receiveList) {
		this.receiveList = receiveList;
	}

	
	
}
