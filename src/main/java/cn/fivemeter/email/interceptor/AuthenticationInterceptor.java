package cn.fivemeter.email.interceptor;

import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import cn.fivemeter.email.anno.TokenRequired;
import cn.fivemeter.email.service.UserService;
import cn.fivemeter.email.utils.JwtUtil;
import io.jsonwebtoken.Claims;

@Component
public class AuthenticationInterceptor implements HandlerInterceptor{
	
	@Autowired
	UserService userService;
	
	public boolean preHandle(HttpServletRequest request,HttpServletResponse response,Object handler) throws Exception{
		
		if(!(handler instanceof HandlerMethod)) {return true;}
		
		HandlerMethod handlerMethod = (HandlerMethod)handler;
		Method method = handlerMethod.getMethod();
		if(method.getAnnotation(TokenRequired.class) != null) {
			//tokenªÒ»°
			String token = "";
			Cookie[] cookies = request.getCookies();
			if(cookies != null) {
				for(Cookie cookie : cookies) {
					if("token".equals(cookie.getName())) {
						token = cookie.getValue();
					}
				}
			}
			//token≈–∂œ
			if(token.equals("")) {
				response.sendRedirect(request.getContextPath()+"/login.jsp");
				return false;
			}else {
				Claims claims = null;
				try {
					claims = JwtUtil.parseJwt(token);
				}catch(Exception e) {
					response.sendRedirect(request.getContextPath()+"/login.jsp");
					return false;
				}
				if(claims!=null) {
					Map<String,String> map = new HashMap();
					map.put("userName",claims.get("userName").toString());
					map.put("password",claims.get("password").toString());
					if(userService.authExist(map)) {
						return true;
					}else {
						response.sendRedirect(request.getContextPath()+"/login.jsp");
						return false;
					}
					
				}
				response.sendRedirect(request.getContextPath()+"/login.jsp");
				return false;
			}
		}
		
		return true;
	}
	
	public void postHandle(HttpServletRequest request,HttpServletResponse response,Object handler,ModelAndView modelAndView) throws Exception {
		
	}
	
	public void afterCompletion(HttpServletRequest request,HttpServletResponse response,Object handler,Exception ex) throws Exception {
		
	}
	
}
