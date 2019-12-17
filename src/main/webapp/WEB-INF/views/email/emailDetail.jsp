<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>杭州思达智慧协同办公</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/css/layui.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/reset.css">
<style type="text/css">
	#content_edit{
		height:300px;
		overflow-y:auto; 
	}
	
</style>
</head>
<body>
	<div class="iframe_container">

		<div class="box_padding_xl">
			<table>
				<tr>
					<td class="bg_table_label">
						<c:if test="${param.type=='1'}">
							<span>发件人</span>
						</c:if>
						<c:if test="${param.type=='2'}">
							<span>收件人</span>
						</c:if>
					</td>
					<td class="box_padding_xl">
						<c:if test="${param.type=='1'}">
							<span id="send_group"></span>
						</c:if>
						<c:if test="${param.type=='2'}">
							<span id="receive_group"></span>
						</c:if>
					</td>
				</tr>
				<tr>
					<td class="bg_table_label">
						<span>主 题</span>
					</td>
					<td class="box_padding_xl" id="email_title">
					
					</td>
				</tr>
				<tr>
					<td class="bg_table_label">
						<span>附 件</span>
					</td>
					<td class="box_padding_xxl">
						
					</td>
				</tr>
				
				<tr>
					<td class="bg_table_label">
						<span>邮件内容</span>
					</td>
					<td>
						<div class="box_padding_xl" id="content_edit"></div>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<script type="text/javascript" src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
	<script type="text/javascript">
		layui.use(["jquery"],function(){
			window.$ = layui.$
			//拿到邮件详情
			var url;
			if("${param.type}" == 1){
				url = "${pageContext.request.contextPath}/email/getEmailDetailAsReceive"+window.location.search;
			}else if ("${param.type}" == 2) {
				url = "${pageContext.request.contextPath}/email/getEmailDetailAsSend"+window.location.search;
			}
			$.ajax({
				url:url,
				success:function(rsp){
					if(rsp.code==200){
						var email_detail = rsp.data || {};
						$("#receive_group").html(email_detail.allReceiveName || "");
						$("#send_group").html(email_detail.sendName || "");
						$("#email_title").html(email_detail.title || "");
						$("#content_edit").html(email_detail.content || "");
					}else{
						layer.msg("加载失败",{icon:2,time:2000})
					}
				}
			});
		})
	</script>
</body>
</html>