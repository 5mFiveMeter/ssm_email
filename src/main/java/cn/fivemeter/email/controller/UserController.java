package cn.fivemeter.email.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.fivemeter.email.bean.User;
import cn.fivemeter.email.service.UserService;
import cn.fivemeter.email.utils.HttpResultContent;
import cn.fivemeter.email.utils.JwtUtil;
import cn.fivemeter.email.utils.RandomCodeUtil;
import cn.fivemeter.email.utils.UuidUtil;

@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	private UserService UserService;

	@ResponseBody
	@RequestMapping("/login")
	public HttpResultContent login(HttpServletRequest request, HttpServletResponse response,@RequestParam(value = "verifyCode") String verifyCode,
			@RequestParam(value = "userName") String userName, @RequestParam(value = "password") String password) {
		//��֤��
		HttpSession session = request.getSession();
		verifyCode = verifyCode.toLowerCase();
		String sessionCode = session.getAttribute(RandomCodeUtil.SESSION_KEY).toString().toLowerCase();
		if(! verifyCode.equals(sessionCode) ) {
			return HttpResultContent.fail().setMsg("��֤�����");
		}
		User user = UserService.login(userName, password);
		if (user != null) {
			//��token��cookie
			String token = JwtUtil.createJwt(user);
			Cookie tokenCookie = new Cookie("token", token);
			tokenCookie.setPath("/");
			tokenCookie.setMaxAge((int) (JwtUtil.EXPIRE));
			response.addCookie(tokenCookie);
			//�洢token�����ݿ�
			HashMap updateMap = new HashMap<String,String>();
			updateMap.put("token",token);
			updateMap.put("userName",userName);
			user.setToken(token);
			if(UserService.update(updateMap)) {
				//���÷�����Ϣ
				HttpResultContent rsp = HttpResultContent.success();
				//ȥ������
				user.setPassword(null);
				rsp.setData(user);
				return rsp;
			}else {
				return HttpResultContent.fail().setMsg("��֤ʧ��");
			}
		} else {
			return HttpResultContent.fail().setMsg("�û������ڻ��������");
		}

	}
	
	@ResponseBody
	@RequestMapping("/doRegister")
	public HttpResultContent register(User user) {
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String send_stamp = df.format(new Date());
		user.setUserId(UuidUtil.uuid());
		user.setRegisterTime(send_stamp);
		user.setToken(JwtUtil.createJwt(user));
		int state = UserService.register(user);
		if(state == 1) {
			return HttpResultContent.success().setMsg("ע��ɹ�");
		}else if(state == 2) {
			return HttpResultContent.fail().setMsg("�û��Ѵ���");
		}else {
			return HttpResultContent.fail().setMsg("ע��ʧ��");
		}
	}
	
	@RequestMapping("/selectTree")
	public String turnSelectTree() {
		return "components/selectUser";
	}

	@ResponseBody
	@RequestMapping("/getUserTree")
	public HttpResultContent getUserTree() {
		HttpResultContent rsp = HttpResultContent.success();
		rsp.setData(UserService.getUserTree());
		return rsp;
	}

}
