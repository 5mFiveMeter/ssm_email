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
		//验证码
		HttpSession session = request.getSession();
		verifyCode = verifyCode.toLowerCase();
		String sessionCode = session.getAttribute(RandomCodeUtil.SESSION_KEY).toString().toLowerCase();
		if(! verifyCode.equals(sessionCode) ) {
			return HttpResultContent.fail().setMsg("验证码错误");
		}
		User user = UserService.login(userName, password);
		if (user != null) {
			//加token到cookie
			String token = JwtUtil.createJwt(user);
			Cookie tokenCookie = new Cookie("token", token);
			tokenCookie.setPath("/");
			tokenCookie.setMaxAge((int) (JwtUtil.EXPIRE));
			response.addCookie(tokenCookie);
			//存储token到数据库
			HashMap updateMap = new HashMap<String,String>();
			updateMap.put("token",token);
			updateMap.put("userName",userName);
			user.setToken(token);
			if(UserService.update(updateMap)) {
				//设置返回信息
				HttpResultContent rsp = HttpResultContent.success();
				//去掉密码
				user.setPassword(null);
				rsp.setData(user);
				return rsp;
			}else {
				return HttpResultContent.fail().setMsg("验证失败");
			}
		} else {
			return HttpResultContent.fail().setMsg("用户不存在或密码错误");
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
			return HttpResultContent.success().setMsg("注册成功");
		}else if(state == 2) {
			return HttpResultContent.fail().setMsg("用户已存在");
		}else {
			return HttpResultContent.fail().setMsg("注册失败");
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
