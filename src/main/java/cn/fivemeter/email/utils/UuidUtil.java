package cn.fivemeter.email.utils;

import java.util.UUID;

public class UuidUtil {

	public static String uuid() {
		return UUID.randomUUID().toString().replace("-", "");
	}
}
