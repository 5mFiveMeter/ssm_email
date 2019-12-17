<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>杭州思达智慧协同办公</title>
</head>
<body>
	<jsp:include page="../components/header.jsp"></jsp:include>
	
	<div class="box_padding_xl fm_bdb">
		<button class="fm_btn bg_theme_green" id="delete_email">删 除</button>
		<button class="fm_btn bg_theme_green" id="clear_send_email">清 空</button>
	</div>
	
	<div class="box_padding_xl ">
		<div id="email_list" lay-filter="email-list"></div>
	</div>
	
	<script type="text/javascript">
		layui.use(["layer","table"],function(){
			window.layer = layui.layer;
			window.table = layui.table;
			
			//拿到收件箱列表
			table.render({
				elem:"#email_list",
				id:"email_list",
				url:"${pageContext.request.contextPath}/email/getEmailByReceive",
				method:"post",
				page:true,
				where:{
					receiveId: user_info.userId
				},
				limit:20,
				parseData:function(rsp){
					return {
						code:rsp.code,
						msg:rsp.msg,
						count:rsp.data.count,
						data:rsp.data.list
					}
				},
				response:{
					statusName: "code",
					statusCode: 200
				},
				cols:[[
					{type:'emailId',hide:true},
					{type:'allReceiveId',hide:true},
					{type:'emailId',hide:true},
					{type:'checkbox',width:'5%'},
					{title:'主题',width:'35%',event:"review",templet:function(data){
						return "<span class='fm_bdb_blue'>"+data.title+"</span>";
					}},
					{field:'attachId',title:'附件',width:'18%'},
					{field:'sendTime',title:'发送时间',width:'15%'},
					{title:'发件人',width:'20%',field:'sendName'},
					{title:"内容",align:'center',width:'7%',event:"review",templet:function(data){
						return "<button class='fm_btn'>查看</button>"
					}}
				]]
			});
			//表格事件监听
			table.on("tool(email-list)",function(evt){
				if(evt.event=="review"){
					//点击查看
					if(evt.event.emailId){return false}
					layer.open({
						type:2,
						title:"邮件内容",
						area:["800px","530px"],
						maxmin:true,
						content:["${pageContext.request.contextPath}/email/emailDetailPage?type=1&emailId="+evt.data.emailId+"&receiveId="+evt.data.receiveId,"no"]
					});
				}
				
			});
			//删除邮件请求
			$("#delete_email").on("click",function(){
				var emailIdGroup = []
				$.each(table.checkStatus("email_list").data,function(k,v){
					emailIdGroup.push(v.emailId);
				});
				if(emailIdGroup.length<1){
					layer.msg("未勾选任何邮件",{icon:2,time:1000});
				}else{
					//确认删除
					layer.confirm('确定删除？可在回收箱中找到。', {icon: 3, title:'清空发件箱'},function(index){
						$.ajax({
							url:"${pageContext.request.contextPath}/email/deleteEmail",
							type:"post",
							data: {
								emailIdGroup:emailIdGroup,
								type:1,
								userId:user_info.userId
							},
							success:function(rsp){
								if(rsp.code==200){
									table.reload("email_list");
									layer.msg(rsp.msg,{icon:1,time:1000});
								}else{
									layer.msg(rsp.msg,{icon:2,time:1000});
								}
								layer.close(index);
							}
						})
					});
				}
			});
			//清空收件箱
			$("#clear_send_email").on("click",function(){
				layer.confirm('确定清空收件箱？可在回收箱中找到。', {icon: 3, title:'清空发件箱'}, function(index){
					var emailIdGroup = []
					$.each(table.cache.email_list,function(k,v){
						emailIdGroup.push(v.emailId);
					});
					$.ajax({
						url:"${pageContext.request.contextPath}/email/deleteEmail",
						type:"post",
						data: {
							emailIdGroup: emailIdGroup,
							type:1,
							userId:user_info.userId
						},
						success:function(rsp){
							if(rsp.code==200){
								table.reload("email_list");
								layer.msg(rsp.msg,{icon:1,time:1000});
							}else{
								layer.msg(rsp.msg,{icon:2,time:1000});
							}
						}
					});
				  	layer.close(index);
				});
			});
			//收藏邮件
			$("#collect_email").on("click",function(){
				var emailIdGroup = []
				$.each(table.checkStatus("email_list").data,function(k,v){
					emailIdGroup.push(v.emailId);
				});
				if(emailIdGroup.length<1){
					layer.msg("未勾选任何邮件",{icon:2,time:1000});
				}else{
					//确认收藏
					$.ajax({
						url:"${pageContext.request.contextPath}/email/collectEmail",
						type:"post",
						data: {
							emailIdGroup:emailIdGroup
						},
						success:function(rsp){
							if(rsp.code==200){
								table.reload("email_list");
								layer.msg(rsp.msg,{icon:1,time:1000});
							}else{
								layer.msg(rsp.msg,{icon:2,time:1000});
							}
						}
					})
				}
			})
		});
	</script>
</body>
</html>