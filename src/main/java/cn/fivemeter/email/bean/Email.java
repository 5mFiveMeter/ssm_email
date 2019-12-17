package cn.fivemeter.email.bean;

public class Email {
	private String emailId;

	private String receiveId;
	private String receiveName;
	private String sendId;
	private String sendName;
	
	
	private String title;
	private String attachId;
	private String content;
	
	private int isRead; //1�Ѷ���2δ��
	private int sendState; //1�������У�2�ݸ����У�3����վ�У�4��ɾ��
	private int receiveState; //1�ռ����У�2�������У�3��ɾ��
	
	private String readTime;
	private String sendTime;
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

	@Override
	public String toString() {
		return "Email [emailId=" + emailId + ", receiveId=" + receiveId + ", receiveName=" + receiveName + ", sendId="
				+ sendId + ", sendName=" + sendName + ", title=" + title + ", attachId=" + attachId + ", content="
				+ content + ", isRead=" + isRead + ", sendState=" + sendState + ", receiveState=" + receiveState
				+ ", readTime=" + readTime + ", sendTime=" + sendTime + "]";
	}

	public String getEmailId() {
		return emailId;
	}

	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}

	public String getReceiveId() {
		return receiveId;
	}

	public void setReceiveId(String receiveId) {
		this.receiveId = receiveId;
	}

	public String getReceiveName() {
		return receiveName;
	}

	public void setReceiveName(String receiveName) {
		this.receiveName = receiveName;
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

	public String getAttachId() {
		return attachId;
	}

	public void setAttachId(String attachId) {
		this.attachId = attachId;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getIsRead() {
		return isRead;
	}

	public void setIsRead(int isRead) {
		this.isRead = isRead;
	}

	public int getSendState() {
		return sendState;
	}

	public void setSendState(int sendState) {
		this.sendState = sendState;
	}

	public int getReceiveState() {
		return receiveState;
	}

	public void setReceiveState(int receiveState) {
		this.receiveState = receiveState;
	}

	public String getReadTime() {
		return readTime;
	}

	public void setReadTime(String readTime) {
		this.readTime = readTime;
	}

	public String getSendTime() {
		return sendTime;
	}

	public void setSendTime(String sendTime) {
		this.sendTime = sendTime;
	}
	
	
}