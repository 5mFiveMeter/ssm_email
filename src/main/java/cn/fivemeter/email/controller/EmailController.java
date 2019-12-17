package cn.fivemeter.email.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.fivemeter.email.anno.TokenRequired;
import cn.fivemeter.email.bean.Email;
import cn.fivemeter.email.service.EmailService;
import cn.fivemeter.email.utils.HttpResultContent;
import cn.fivemeter.email.utils.UuidUtil;
import cn.fivemeter.email.vo.EmailGroupSend;

@Controller
@RequestMapping("/email")
public class EmailController {
	
	@Autowired
	private EmailService emailService;
	
	@TokenRequired
	@RequestMapping("receive")
	public String turnReceive() {
		return "/email/receive";
	}
	
	@TokenRequired
	@RequestMapping("send")
	public String turnSend() {
		return "/email/send";
	}
	
	@TokenRequired
	@RequestMapping("draft")
	public String turnDraft() {
		return "/email/draft";
	}
	
	@TokenRequired
	@RequestMapping("editEmailPage")
	public String turnEditEmail() {
		return "/email/editEmail";
	}
	
	@TokenRequired
	@RequestMapping("emailDetailPage")
	public String turnEmailDetail() {
		return "/email/emailDetail";
	}
	
	/*
	 * 发送邮件
	 */
	@ResponseBody
	@RequestMapping("sendEmail")
	public HttpResultContent sendEmail(@RequestBody EmailGroupSend emailGroupSend) {
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String send_stamp = df.format(new Date());
		
		String emailId = emailGroupSend.getEmailId();
		if(emailId != null) {
			//草稿发送将之前假删除
			Map<String,Object> old = new HashMap();
			old.put("emailId",emailId);
			old.put("sendState",4);
			old.put("changeTime",send_stamp);
			emailService.updateEmail(old);
		}
		//新邮件发送
		List<Email> email_list = emailGroupSend.getReceiveList();
		//邮件id
		String uuid = UuidUtil.uuid();
		for(Email email : email_list) {
			email.setEmailId(uuid);
			email.setSendTime(send_stamp);
			email.setCreateTime(send_stamp);
			email.setChangeTime(send_stamp);
			email.setSendId(emailGroupSend.getSendId());
			email.setSendName(emailGroupSend.getSendName()); //receive已经从参数获取
			email.setTitle(emailGroupSend.getTitle());
			email.setContent(emailGroupSend.getContent());
			email.setSendState(1);
			email.setReceiveState(1);
			emailService.save(email); 
	    }
		return HttpResultContent.success();
	}
	
	/*
	 * 保存草稿箱
	 */
	@ResponseBody
	@RequestMapping("saveDraft")
	public HttpResultContent saveDraft(@RequestBody EmailGroupSend emailGroupSend) {
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String send_stamp = df.format(new Date());
		//先将之前邮件放入回收站
		String emailId = emailGroupSend.getEmailId();
		if(emailId != null) {
			Map<String,Object> old = new HashMap();
			old.put("emailId",emailId);
			old.put("sendState",3);
			old.put("changeTime",send_stamp);
			emailService.updateEmail(old);
		}
		//重新创建新邮件
		List<Email> email_list = emailGroupSend.getReceiveList();
		//邮件id
		String uuid = UuidUtil.uuid();
		for(Email email : email_list) {
			email.setEmailId(uuid);
			email.setSendTime(send_stamp);
			email.setCreateTime(send_stamp);
			email.setChangeTime(send_stamp);
			email.setSendId(emailGroupSend.getSendId());
			email.setSendName(emailGroupSend.getSendName()); //receive已经从参数获取
			email.setTitle(emailGroupSend.getTitle());
			email.setContent(emailGroupSend.getContent());
			email.setSendState(2);
			email.setReceiveState(5);
			emailService.save(email); 
	    }
		return HttpResultContent.success();
	}
	
	/*
	 * 修改邮件内容
	 */
	@ResponseBody
	@RequestMapping("editEmail")
	public HttpResultContent editEmail(@RequestBody EmailGroupSend emailGroupSend) {
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String send_stamp = df.format(new Date());
		List<Email> email_list = emailGroupSend.getReceiveList();
		//邮件id
		String uuid = UuidUtil.uuid();
		for(Email email : email_list) {
			email.setEmailId(uuid);
			email.setSendTime(send_stamp); 
			email.setChangeTime(send_stamp);
			email.setSendId(emailGroupSend.getSendId());
			email.setSendName(emailGroupSend.getSendName()); //receive已经从参数获取
			email.setTitle(emailGroupSend.getTitle());
			email.setContent(emailGroupSend.getContent());
			email.setSendState(2);
			email.setReceiveState(5);
			emailService.save(email); 
	    }
		return HttpResultContent.success();
	}
	
	/*
	 * 获取已发送邮件列表
	 */
	@ResponseBody
	@RequestMapping("getEmailBySend")
	public HttpResultContent getEmailBySend(@RequestParam("sendId") String sendId,@RequestParam("page") String page,@RequestParam("limit") String limit) {
		//获取列表
		Map<String,Object> query = new HashMap();
		query.put("sendId", sendId);
		query.put("sendState",1);
		query.put("offset",(Integer.parseInt(page) - 1 ) *  Integer.parseInt(limit));
		query.put("limit", Integer.parseInt(limit));
		List<Map> emails = emailService.getSendEmailList(query);
		//获取数量
		int count = emailService.getSendEmailCount(query);
		HttpResultContent rst = HttpResultContent.success();
		Map<String,Object> data = new HashMap();
		data.put("list", emails);
		data.put("count", count);
		rst.setData(data);
		return rst;
	}
	
	/*
	 * 草稿箱列表
	 */
	@ResponseBody
	@RequestMapping("getEmailByDraft")
	public HttpResultContent getEmailByDraft(@RequestParam("sendId") String sendId,@RequestParam("page") String page,@RequestParam("limit") String limit) {
		//获取列表
		Map<String,Object> query = new HashMap();
		query.put("sendId", sendId);
		query.put("sendState",2);
		query.put("offset",(Integer.parseInt(page) - 1 ) *  Integer.parseInt(limit));
		query.put("limit", Integer.parseInt(limit));
		List<Map> emails = emailService.getSendEmailList(query);
		//获取数量
		int count = emailService.getSendEmailCount(query);
		HttpResultContent rst = HttpResultContent.success();
		Map<String,Object> data = new HashMap();
		data.put("list", emails);
		data.put("count", count);
		rst.setData(data);
		return rst;
	}
	
	/*
	 * 获取收件箱列表
	 */
	@ResponseBody
	@RequestMapping("getEmailByReceive")
	public HttpResultContent getEmailByReceive(@RequestParam("receiveId") String receiveId,@RequestParam("page") String page,@RequestParam("limit") String limit) {
		//收件箱分页列表
		Map<String,Object> listMap = new HashMap();
		listMap.put("receiveId",receiveId);
		listMap.put("receiveState",1);
		listMap.put("offset",(Integer.parseInt(page) - 1 ) *  Integer.parseInt(limit));
		listMap.put("limit", Integer.parseInt(limit));
		List<Map> emails = emailService.getReceiveEmailList(listMap);
		//收件箱总数
		Map<String,Object> countMap = new HashMap();
		countMap.put("receiveId",receiveId);
		countMap.put("receiveState",1);
		int count = emailService.getReceiveEmailCount(countMap);
		Map<String,Object> rst = new HashMap();
		rst.put("count",count);
		rst.put("list",emails);
		return HttpResultContent.success().setData(rst);
	}
	
	/*
	 * 查看发送邮件
	 */
	@ResponseBody
	@RequestMapping("getEmailDetailAsSend")
	public HttpResultContent getEmailDetailAsSend(@RequestParam("emailId") String emailId) {
		Map<String,String> map = new HashMap();
		map.put("emailId",emailId);
		List<Map> list = emailService.getSendEmailList(map);
		if(list.size()>0) {
			return HttpResultContent.success().setData(list.get(0));
		}else {
			return HttpResultContent.fail();
		}
	}
	/*
	 * 查看接收邮件
	 */
	@ResponseBody
	@RequestMapping("getEmailDetailAsReceive")
	public HttpResultContent getEmailDetailAsReceive(@RequestParam("emailId") String emailId,@RequestParam("receiveId") String receiveId) {
		Map<String,Object> map = new HashMap();
		map.put("emailId",emailId);
		List<Email> list = emailService.getEmailList(map);
		if(list.size()>0) {
			//设置已读
			map.put("isRead",1);
			map.put("receiveId",receiveId);
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			map.put("readTime",df.format(new Date()));
			emailService.updateEmail(map);
			return HttpResultContent.success().setData(list.get(0));
		}else {
			return HttpResultContent.fail();
		}
	}
	
	/*
	 * 查看邮件阅读状态
	 */
	@ResponseBody
	@RequestMapping("getReceiveState")
	public HttpResultContent getReceiveState(@RequestParam("emailId") String emailId) {
		Map<String,String> map = new HashMap();
		map.put("emailId",emailId);
		List<Email> list = emailService.getEmailList(map);
		if(list.size()>0) {
			return HttpResultContent.success().setData(list);
		}else {
			return HttpResultContent.fail();
		}
	}
	
	/*
	 * 删除邮件
	 */
	@ResponseBody
	@RequestMapping("deleteEmail")
	public HttpResultContent deleteEmail(@RequestParam("userId") String userId,@RequestParam("emailIdGroup[]") List<String> emailIdGroup,@RequestParam("type") String type) {
		SimpleDateFormat df = new SimpleDateFormat("yy-MM-dd hh-mm-ss");
		String now_time = df.format(new Date());
		for(String id : emailIdGroup) {
			Map<String,Object> map = new HashMap();
			map.put("emailId",id);
			if(type.equals("1") ) {
				//收件箱删除
				map.put("receiveId",userId);
				map.put("receiveState",2);
			}else if(type.equals("2") ) {
				//发件箱删除
				map.put("sendId",userId);
				map.put("sendState",3);
			}else if(type.equals("3")){
				//草稿箱删除
				map.put("sendId",userId);
				map.put("sendState",3);
			}
			map.put("changeTime",now_time);
			if(emailService.updateEmail(map)<1) {
				return HttpResultContent.fail().setMsg("删除失败");
			}
		}
		return HttpResultContent.success().setMsg("删除成功");
	}
	
	/*
	 * 收藏邮件
	 */
	@ResponseBody
	@RequestMapping("collectEmail")
	public HttpResultContent collectEmail(@RequestParam("emailIdGroup[]") List<String> emailIdGroup) {
		SimpleDateFormat df = new SimpleDateFormat("yy-MM-dd hh-mm-ss");
		String now_time = df.format(new Date());
		for(String id : emailIdGroup) {
			Map<String,Object> map = new HashMap();
			map.put("emailId",id);
			map.put("receiveState",4);
			map.put("changeTime",now_time);
			if(emailService.updateEmail(map)<1) {
				return HttpResultContent.fail().setMsg("收藏失败");
			}
		}
		return HttpResultContent.success().setMsg("收藏成功，可在收藏夹查看");
	}
}
