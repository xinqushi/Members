<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>分期信息-Java互助学习VIP群业务运行系统</title>
<link href="${pageContext.request.contextPath}/tableTemplet/css/H-ui.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/css/style.css?time=20161215" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/tableTemplet/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
<style type="text/css">
	body{margin:0 auto;}
</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/myfile.js"></script>
<script type="text/javascript">
$(function(){
	//创建26个字母数组
	var a = new Array("A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"); 
	var line="";
	for(var i=0;i<a.length;i++){
		line+="<a class='num'  value='" + a[i] + "' id='" + a[i] +"'><font size=5px>" + a[i] + "</font></a>&nbsp;&nbsp;";
	}
	//控制隐藏和显示div
	$(".showinfo").hide();
	
   	var name=null;
	$("#tag").append(line);
	$(".num").click(function(){
		//var theEvent = window.event || arguments.callee.caller.arguments[0]; 
		//alert(theEvent.target.id)
		$(".num").css("color","#BFBFBF");
		$(this).css("color","#212122");
		var letter=$(this).text();
		getName(letter);
		function getName(letter){
			var name=null;
			$("#tabsC").html("");
			$.post("${pageContext.request.contextPath}/member/getAllNames.action",{letter:letter},function(data){
				//alert(letter);
				$("#tabsC").append("<ul>")
				for(var i=0;i<data.length;i++){
					//$("#tabsC").append("<li><a href=${pageContext.request.contextPath}/member/setMember.action?name=" + data + "><span>" + data + "</span></a></li>");	
					$("#tabsC").append("<li><a href='javascript:void(0)' class='setMember'><span>" + data[i] + "</span></a></li>");
				}
				$("#tabsC").append("</ul>")
				//设置选中会员的id
				$(".setMember").on('click',function(){
					$("#tabsC li a span").css("color","#212122")
					$(this).children("span").css("color","red");
					//current.style.display="block"; 
					var reStripTags = /<\/?.*?>/g;
					var textOnly = this.innerHTML.replace(reStripTags, ''); //只有文字的结果
					name=textOnly;
					$("#tabsC2").html("");
					$.post("${pageContext.request.contextPath}/user/getUserTest.action",{name:name},function(data){
						drawTable(data);
					})
					deleteclick();
					modifymemberinfoclick();
					modifyuserinfoclick();
				})
			})
		}
	})
	
	function getData( name ){
		$.post("${pageContext.request.contextPath}/user/getUserTest.action",{name:name},function(data){
			drawTable(data);
			deleteclick();
			modifymemberinfoclick();
			modifyuserinfoclick();
		})
	}
	
	$.ajaxSetup ({

    cache: false //关闭AJAX相应的缓存

	});
	//添加表格内容
	function drawTable(data) {
		var line = "";
			var student = "在学"
			if (data.member.student == false) {
				student = "在职";
			}
			line += "<tr class='rows'>"
			line += "<td>" + data.name + "</td>";
			line += "<td class='nowrap'>"
					+ data.member.name + "</td>";
			line += "<td>" + data.member.school + "</td>";
			line += "<td class='nowrap'>"
					+ data.member.mobile + "</td>";
			line += "<td>" + data.member.company + "</td>";
			line += "<td>"
					+ data.member.formatGraduateDate + "</td>";
			line += "<td>" + student + "</td>";
			var mycheck = "";
			if (data.member.abnormal == true) {
				mycheck = "checked";
			}
			/* line += "<td><input type='checkbox' name='abnormal' " + mycheck + " lang=" + data.id + "></td>"; */
			line += "<td><a href='javascript:void(0)' class='modifymemberinfo' lang="
					+ data.member.id
					+ ","
					+ data.id
					+ ","
					+ data.member.name + ">修改</a></td>";
			line += "<td><a href='javascript:void(0)' class='modifyuserinfo' lang="
					+ data.id
					+ ","
					+ data.member.name
					+ ">修改</a></td>";
			line += "<td><a href='javascript:void(0)' class='delete' lang="
					+ data.id + ">删除</a></td>";

			line += "</tr>";
		$("#tbody").html(line);
		$(".showinfo").show();
	}
	
	//删除点击事件
	function deleteclick() {
		$(".delete").click(
				function() {
					var id = this.lang;
					layer.confirm(
							'您确定要删除该用户吗?删除该用户时，同时也会删除该用户的基本信息和信用信息，请谨慎操作！',
							{
								btn : [ '是', '否' ]
							},//按钮一的回调函数
							function() {
								$.post(
										"${pageContext.request.contextPath}/user/deleteById.action?id="
												+ id, function(data) {
											layer.closeAll('dialog');
											getData(name);
										});
							});
				});
	}
	function modifymemberinfoclick() {
		$(".modifymemberinfo")
				.click(
						function() {
							var data = this.lang.split(",");
							var id = data[0];
							var uid = data[1];
							var name = data[2];
							//alert(id);
							//alert(name);
							layer
									.open({
										type : 2,
										title : '修改会员信息',
										area : [ '300px', '650px' ],
										// closeBtn: 0, //不显示关闭按钮
										shift : 1,
										shade : 0.5, //开启遮罩关闭
										content : '${pageContext.request.contextPath}/admin/modifymemberinfo.jsp?id='
												+ id
												+ '&uid='
												+ uid
												+ '&name=' + name,
										end : function() {
											getData(name);
										}
									});

						});
	}
	function modifyuserinfoclick() {
		$(".modifyuserinfo")
				.click(
						function() {
							var data = this.lang.split(",");
							var uid = data[0];
							var name = data[1];
							//alert(id);
							//alert(name);
							layer
									.open({
										type : 2,
										title : '修改信用信息',
										area : [ '500px', '650px' ],
										// closeBtn: 0, //不显示关闭按钮
										shift : 1,
										shade : 0.5, //开启遮罩关闭
										content : '${pageContext.request.contextPath}/admin/modifyuserinfo.jsp?uid='
												+ uid + '&name=' + name,
										end : function() {
											getData(name);
										}
									});

						});
	}

});	
</script>
</head>
<body>
<div id="tag" style="padding-right:50px;">
</div>
<div id="msg"></div>
<div id="tabsC" style="margin-bottom:20px;"></div>
<div id="tabsC2" style="margin-bottom:20px;"></div>
<%-- <div id="menu1">
	<a id="baseinfo">基本信息</a>
	<a id="summaryinfo">周报信息</a>
	<a id="feeinfo">缴费信息</a>
	<a id="protocol">培训协议</a>
	<input type="hidden" id="member" value="${myuser.member}">
</div> --%>
<!-- <div class="showinfo" style="margin-left:0;padding-left:10px;margin-top:30px;"> </div>-->
	<c:if test="${ADMIN==null}">
		<jsp:forward page="/user/login.jsp"></jsp:forward>
	</c:if>
	<div class="showinfo">
	<h1 class="text-c" style="text-align: center; margin: 20px;">VIP会员信息管理</h1>
			<table class="table table-border table-bg table-bordered radius">
				<thead class='text-c'>
					<tr>
						<th style='white-space: nowrap'>用户名</th>
						<th>姓名</th>
						<th>学校名称</th>
						<th>联系电话</th>
						<th>公司名称</th>
						<th>毕业时间</th>
						<th>类型</th>
						<!-- <th>特殊</th> -->
						<th>会员信息</th>
						<th>信用信息</th>
						<th>删除</th>
					</tr>
				</thead>
				<tbody id="tbody" class='text-c'></tbody>
			</table>
</div>
</body>
</html>