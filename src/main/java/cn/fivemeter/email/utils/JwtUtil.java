package cn.fivemeter.email.utils;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import cn.fivemeter.email.bean.User;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtBuilder;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

public class JwtUtil {
	
	private final static String SECRET = "EWPG*14$12(HG43$*41&67&)6789GH980&)%98%)G)$851&)&%#1JG";
	
	public final static long EXPIRE = 2592000;
	
	public static String createJwt(User user) {
		
		SignatureAlgorithm signatureAlgorithm = SignatureAlgorithm.HS256;
		
		Date nowDate = new Date();
		
		Map<String,Object> claims = new HashMap<String,Object>();
		claims.put("id", user.getUserId());
		claims.put("userName", user.getUserName());
		claims.put("password", user.getPassword());
		
		String userName = user.getUserName();
		String password = user.getPassword();
		
		JwtBuilder builder = Jwts.builder()
				.setClaims(claims)
				.setId(UuidUtil.uuid())
				.setIssuedAt(nowDate)
				.setIssuer(userName)
				.signWith(signatureAlgorithm,SECRET);
		return builder.compact();
	}
	
	public static Claims parseJwt(String toekn) {
		
		Claims claims = Jwts.parser().setSigningKey(SECRET).parseClaimsJws(toekn).getBody();
		
		return claims;
	
		
	}
	
	public static Boolean verifyJwt(String token,User user) {

		Claims claims = Jwts.parser().setSigningKey(SECRET).parseClaimsJws(token).getBody();
		
		if(claims.get("password").equals(user.getPassword())) {
			return true;
		}else {
			return false;
		}
	}
	
}
