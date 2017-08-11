<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8>
<title>基础设置-Java互助学习VIP群业务运行系统</title>
<link href="${pageContext.request.contextPath}/css/style.css?time=20161215" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/tableTemplet/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/resources/images/Icon.ico" />
<link
	href="${pageContext.request.contextPath}/resources/H-ui_v3.0/css/H-ui.min.css"
	rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/resources/css/page.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/jslib/jquery-1.11.1.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/layer-v2.4/layer.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/jslib/currency.js"></script>
<script type="text/javascript">
	$(function() {
		//第一次进来默认设置
		getData("艾渊");
		//加载密码重置
		mycellclick();
		//创建26个字母数组
		var a = new Array("A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"); 
		var line="";
		for(var i=0;i<a.length;i++){
			line+="<a class='num'  value='" + a[i] + "' id='" + a[i] +"'><font size=5px>" + a[i] + "</font></a>&nbsp;&nbsp;";
		}
		//控制隐藏和显示div
		var current=document.getElementById("menu1"); 
	   	if($("#member").val()=="")  
	     {  
	       current.style.display="none";  
	     }
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
				//alert(letter);
				var name=null;
				$("#tabsC").html("");
				$.post("${pageContext.request.contextPath}/member/getAllNames.action",{letter:letter},function(data){
					$("#tabsC").append("<ul>")
					for(var i=0;i<data.length;i++){
						//$("#tabsC").append("<li><a href=${pageContext.request.contextPath}/member/setMember.action?name=" + data[i] + "><span>" + data[i] + "</span></a></li>");	
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
						getData(name);
						})
						
					})

			}
		})
		$.ajaxSetup ({

	    cache: false //关闭AJAX相应的缓存

		});
		//第一次点击进来的默认值
		function getData(name) {
			$.ajaxSetup({
				async : false
			});
			$.post("${pageContext.request.contextPath}/member/getMemInfoByName.action",{mname:name}, function(data) {
				var dataObj = eval("(" + data + ")");
				drawTable(dataObj);
				clickRows();
				summarytdclick();
				setupclick();
				mycellclick();
			})
		}
		function drawTable(data) {
			var line = "";
				line += "<tr class='rows'>";
				line += "<td>" + data.name + "</td>";
				line += "<td>" + data.member.name + "</td>";
				line += "<td class='td-status' lang='"+ data.member.id + "," + data.member.name + "'>";
				if (data.member.summaryflag == '1') {
					line += "<span class='label label-danger radius'>需要</span>";
				} else {
					line += "<span class='label label-success radius'>不需要</span>";
				}
				line += "</td>";
				if (data.admin != null) {
					line += "<td>" + data.admin.realname + "</td>";
				} else {
					line += "<td>" + "" + "</td>";
				}
				line += "<td>";
				line += "<a href='javascript:void(0)' lang='"
						+ data.member.id + "," + data.member.name
						+ "' class='setup' >设置</a>";
				line += "</td>";
				line=line + "<td>" + "<a href='javascript:void(0)' lang='"
						+ data.id + "' class='mycell' >重置</a>" + "</td>";
				line += "</tr>";
			
			$("#tbody").html(line);
		}
	/* 	//周报标记td点击事件
		function summarytdclick() {
			$(".td-status").click(function() {
				var data = this.lang.split(",");
				var id = data[0];
				var name = data[1];
				$.post("${pageContext.request.contextPath}/member/toggleSummryflag.action",{id : id}, function() {
					getData(name);
				})
			})
		} */
		//周报标记td点击事件
		function summarytdclick() {
			$(".td-status").click(function() {
				var data = this.lang.split(",");
				var id = data[0];
				var name = data[1];
				var msg = ""
				//alert($(this).children("span").text());
				if ($(this).children("span").text() == "需要") {
					msg = "你确定要设置\"不需要\"提交周报？";
				} else {
					msg = "你确定要设置\"需要\"提交周报？";
				}
				layer.confirm(msg,{btn : [ '确定', '取消' ]},function(index, layero) {
					$.post("${pageContext.request.contextPath}/member/toggleSummryflag.action",{id : id},function() {
						getData(name);
						layer.closeAll();
					})
				});
			})
		}
		function setupclick() {
			$(".setup").click(function() {
				var data = this.lang.split(",");
				var id = data[0];
				var name = data[1];
				//alert(id);
				//alert(name);
				layer.open({
						type : 2,
						title : '设置小助手',
						area : [ '600px', '361px' ],
						// closeBtn: 0, //不显示关闭按钮
						shift : 1,
						shade : 0.5, //开启遮罩关闭
						content : '${pageContext.request.contextPath}/admin/assistantselect.jsp?id='
								+ id + '&name=' + name,
						end : function() {
							getData(name);
						}
					});

				});
		}
		
		//密码重置
		function mycellclick(){
			$(".mycell").click(function(data){
				var authority;
				$.post("${pageContext.request.contextPath}/admin/checkAdminAuthorith.action",function(data){
					if(data == 1)
					{
						authority=data;
					}
				});	
				if(authority==1)
				{
					var newpwd;
					$.post("${pageContext.request.contextPath}/user/getPwd.action",{id:this.lang},function(data){
						newpwd=data;
					});
					$(this).html("");
					$(this).parent().text(newpwd);
				}
				else
				{
					alert("您不具备该权限，请联系管理员!");
				}

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
	
	
	<c:if test="${ADMIN==null}">
		<jsp:forward page="/user/login.jsp"></jsp:forward>
	</c:if>
	<h1 class="text-c">VIP会员基础设置</h1>
	<div class="mt-20">
		<table id="users"
			class="table table-border table-bg table-bordered radius">
		</table>
	</div>
	<div class="panel panel-secondary">
		<!-- <div class="panel-header"></div> -->
		<div class="panel-primary">
			<table class="table table-border table-bg table-bordered radius">
				<thead class='text-c'>
					<tr>
						<th>会员编号</th>
						<th>会员姓名</th>
						<th>是否需要写周报</th>
						<th>小助手姓名</th>
						<th>操作</th>
						<th>密码重置</th>
					</tr>
				</thead>
				<tbody id="tbody" class='text-c'></tbody>
			</table>
		</div>
	</div>
	<div class='page-nav' style="float: right; margin-top: 10px;"></div>
</body>
</html>