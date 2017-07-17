<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>管理后台</title>

<style type="text/css">
/*定位*/

.none { display:none }

/*通用*/

.main { margin:20px auto 0 auto;  overflow:hidden; zoom:1 }
.main .left-sider { float:left; width:90%; }
.operate h3 { font-family: "Microsoft YaHei",微软雅黑; font-size:16px; background:#f7f7f7; height:43px; line-height:43px; padding-left:12px; }
.operate ul li { display:inline; }
.operate ul li a { background:url(../images/bg1.png) no-repeat 100px 18px; padding-left:30px; text-decoration:none; font-size:16px; color:#555; display:block;  height:43px;  line-height:43px; border-bottom:1px dotted #d2d2d2; }
.operate ul li a.noline { border-bottom:none; }
.operate ul li a:hover{ color:#8caf00; }
.operate ul li a.selected:hover { color:#fff; }
.operate ul li .selected { background-color:#8caf00;  background-position:270px -9px; color:#fff; }
.operate ul li h4 { cursor:pointer; background: no-repeat 16% 18px; padding-left:30px; text-decoration:none; font-size:16px; color:#555; display:block;  line-height:43px; font-weight:normal; }
.operate ul li.noline { border-bottom:none; }
.operate ul li h4:hover { color:#8caf00; text-decoration:underline; }
.operate ul li.selected h4 { background-position:18% -37px; border-bottom:1px dotted #d2d2d2; }
.operate ul li a { }
.operate ul li .on a { color:#8caf00; font-weight:bold; }
.operate ul li a:hover { color:#8caf00; text-decoration:underline; }
.bg-color { background-color:#8caf00; }
.operate li .list-item { padding:5px 0; position:relative; zoom:1 }
.operate li .list-item a { background:none;  border:none; color: #333333; display:block; height:32px; line-height: 32px; margin: 0 -1px 0 1px; padding-left: 28px;  position: relative; text-decoration: none; font-size:14px;width:400px; }
.left-sider .ser-online a { background:url(../images/bg_ser_online.jpg) no-repeat 0 0; margin-top:10px; height:75px; border:1px solid #eaeaea; display:block; }
.pflag{float:right; margin-right:10%;}
.active{color:red}
</style>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css"  rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/tableTemplet/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/navbar/css/index.css" type="text/css" media="screen" />
<script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>	
<script type="text/javascript" src="${pageContext.request.contextPath}/navbar/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/navbar/js/tendina.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/navbar/js/common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>

<script type="text/javascript">
 $(function(){
//layer层打开系统公告
//获取学过的类别


 var caid=7;
 $.post("${pageContext.request.contextPath}/course/getcachapter.action",{caid:7},function(data){
		showchapter(data);		
	});  
$(".lookprogress")
		.click(
				function() {
					var arr = this.lang.split(",");
					var id = arr[0];
					var identityType = arr[1];
					var caid = arr[2];
					var url = '${pageContext.request.contextPath}/course/lookprogress.jsp?id='
							+ id + '&identityType=' + identityType;
					if (caid != null) {
						url = '${pageContext.request.contextPath}/course/lookprogress.jsp?id='
								+ id
								+ '&identityType='
								+ identityType
								+ '&caid=' + caid;
					}
					layer.open({
						type : 2,
						title : '查看进度',
						area : [ '800px', '500px' ],
						shift : 1,
						shade : 0.5, //开启遮罩关闭
						content : url,
						end : function() {
						}
					});
				})
//分享问题页面
$("#share").click(
				function() {
					layer
							.open({
								type : 2,
								title : '问题分享',
								area : [ '780px', '550px' ],
								shift : 1,
								shade : 0.5, //开启遮罩关闭
								content : '${pageContext.request.contextPath}/question/dailyLogWrite.jsp',
								end : function(){s
									getdata($("#aname").val(),
											new Date($("#date").val()),
											1);
								}
							});
				});
$.ajaxSetup({
	async:false
});
$.post("${pageContext.request.contextPath}/course/getCourseById.action",{"id":$(".cId").val()},function(data){
		$("#msg").html(data.title);
});

var id;
var flag="false";//当前专业是否可设置进度
	//获取专业

function getcachapter(id){
	$.ajaxSetup({async:false});
	$.post("${pageContext.request.contextPath}/course/getcachapter.action",{caid:id},function(data){								
		showchapter(data);		
	});
	categoryclick();
	imgclck();
}
function categoryclick(){
	$(".category").click(function(){
			var arr=this.lang.split(",");
			id=arr[0];
			flag=arr[1];
			$(".category").siblings().removeClass('active'); // 删除其他兄弟元素的样式
			$(this).addClass('active'); // 添加当前元素的样式
			getcachapter(id);
	});
}
//图标点击事件 确认学到了哪里
function imgclck(){
	$(".pflag").dblclick(function(){
		if(flag=="false"){
			layer.msg('你不能设置该专业的进度', {
			    icon: 1,
			    time: 2000
			});
			return;
		}
		var arr=this.lang.split(",");
		var caid=id;
		var chorder=arr[0];
		var corder=arr[1];
		var title=arr[2];
		layer.confirm('您确定已经学到【'+title+'】这里来了吗？',{btn:['是','否']},//按钮一的回调函数
				function(){					
					$.ajaxSetup({async:false});
					$.post("${pageContext.request.contextPath}/courseandpro/add.action",{caid:caid,chorder:chorder,corder:corder},function(data){						
						layer.closeAll('dialog');
						getcachapter(id);
					});
		});
	});
}
//表头专业 
function showdata(data){
	var line="";
	
	for(i=0;i<data.length;i++){
		if(i!=data.length-1)
		{
			if(data[i].capid==""){
				line=line + "<a herf='#' style='text-decoration:none' class='category' lang='"+data[i].caid+","+"false"+"'><i class='Hui-iconfont'>&#xe647;</i>"+data[i].title+"</a>&nbsp;|&nbsp;";

			}else{
				line=line + "<a herf='#' style='text-decoration:none' class='category' lang='"+data[i].caid+","+"true"+"'><i class='Hui-iconfont'>&#xe647;</i>"+data[i].title+"(可选)"+"</a>&nbsp;|&nbsp;";
			}
		}
		else
		{
			if(data[i].capid==""){
				line=line + "<a herf='#' style='text-decoration:none' class='category' lang='"+data[i].caid+","+"false"+"'><i class='Hui-iconfont'>&#xe647;</i>"+data[i].title+"</a>";

			}else{
				line=line + "<a herf='#' style='text-decoration:none' class='category' lang='"+data[i].caid+","+"true"+"'><i class='Hui-iconfont'>&#xe647;</i>"+data[i].title+"(可选)"+"</a>";
			}
		}
	}
	$(".l").append(line);
	
}

function showchapter(data){
	var chorder=0;
	var corder=0;
	$.ajaxSetup({async:false});
	$.post("${pageContext.request.contextPath}/courseandpro/exists.action",{caid:id},function(pro){
		if(pro!=""&& pro!=null){
			chorder=pro.chorder;
			corder=pro.corder;
			$("#proportion").html(pro.proportion);
		}else{
			$("#proportion").html(0);
		}		
	});
	var img="";
	var chaptitle="";
	var line="";
	for(i=0;i<data.length;i++){			
		$.post("${pageContext.request.contextPath}/course/getLessons.action",{chid:data[i].id},function(data2){	
			line = line + "<li >";
			if(data[i].optional_flag==true){
				chaptitle = "<span style='color:#76EE00;'>"+ data[i].title+ "（选修课）</span>";
			}else{
				chaptitle = data[i].title;
			}
			if(data[i].courseAndCategory.order<chorder||(data[i].courseAndCategory.order==chorder&&data2.length==corder)){
				chaptitle = chaptitle + "<img src='${pageContext.request.contextPath}/images/ok-green.png' style='padding-left:30px;'>";				
			}	
			line = line + "<h4 >"+chaptitle+"</h4>";
			line=line+"<div class='list-item none'>";
			for(j=0;j<data2.length;j++){
				if(data[i].courseAndCategory.order<chorder){
					//img="<img src='${pageContext.request.contextPath}/images/ok-green.png' class='pflag' lang='"+data[i].courseAndCategory.order+","+data2[j].order+","+data2[j].title+"' style='padding-left:30px;'>";
				}else if(data[i].courseAndCategory.order==chorder){
					if(data2[j].order<=corder){
						//img="<img src='${pageContext.request.contextPath}/images/ok-green.png' class='pflag' lang='"+data[i].courseAndCategory.order+","+data2[j].order+","+data2[j].title+"' style='padding-left:30px;'>";
					}else{
						//img="<img src='${pageContext.request.contextPath}/images/x-red.png' class='pflag' lang='"+data[i].courseAndCategory.order+","+data2[j].order+","+data2[j].title+"' style='padding-left:30px;'>";
					}
				}else{
					//img="<img src='${pageContext.request.contextPath}/images/x-red.png' class='pflag' lang='"+data[i].courseAndCategory.order+","+data2[j].order+","+data2[j].title+"' style='padding-left:30px;'>";
				}
				
				line=line+"<p><a  href='${pageContext.request.contextPath}/question/getQuestion.action?cId="+data2[j].id+"' style='text-decoration:none;' title='课程章节'>"+data2[j].title+ img +"</a></p>";	
			};

			line=line+"</div>";
			line = line + "</li>";				
		});			
	}
	$("#J_navlist").html(line);
	navList(1);

}


//列表下拉
function navList(id) {
 var $obj = $("#J_navlist"), $item = $("#J_nav_" + id);
 $item.addClass("on").parent().removeClass("none").parent().addClass("selected");
 $obj.find("h4").hover(function () {
     $(this).addClass("hover");
 }, function () {
     $(this).removeClass("hover");
 });
 $obj.find("p").hover(function () {
     if ($(this).hasClass("on")) { return; }
     $(this).addClass("hover");
 }, function () {
     if ($(this).hasClass("on")) { return; }
     $(this).removeClass("hover");
 });
 $obj.find("h4").click(function () {
     var $div = $(this).siblings(".list-item");
     if ($(this).parent().hasClass("selected")) {
         $div.slideUp(600);
         $(this).parent().removeClass("selected");
     }
     if ($div.is(":hidden")) {
         $("#J_navlist li").find(".list-item").slideUp(600);
         //修改页面 removeClass()
         $("#J_navlist li").addClass("selected");
         $(this).parent().addClass("selected");
         $div.slideDown(600);

     } else {
         $div.slideUp(600);
     }
 });
}
	//判断密码
	//如果有未查看的评论，就给出layer提示
	$.post("${pageContext.request.contextPath}/summary/checkRemind.action",function(data){
		if(data>0){		
			layer.tips('您有未读的评论，快去看看吧~', '#summary');
		}
	});
	session();
	$("html").click(function() {
		session();
	})
	$(".wrap").load("${pageContext.request.contextPath}/question/infoshow.jsp");	
	$("[title='主页']").click(function(){
	taggleWriteAndModify();
	writeclick();
	modifyclick();
});
var t;
function session() {
	clearTimeout(t);
	$.ajaxSetup({async : false});
	$.post("${pageContext.request.contextPath}/user/checkUserSession.action",function(data) {
		if (data == "1") {
			t = setTimeout("session()", 1000 * 60 * 120);
		} else {
			location.href = "${pageContext.request.contextPath}/user/login.jsp";
		}
	});
}

function exit(){
		if(confirm("确定要退出吗？")) {
			$.post("${pageContext.request.contextPath}/user/clearSession.action",function(data) {
				window.location.href="${pageContext.request.contextPath}/index.jsp";
			});
		 }		
}	
function personal(){
	window.open("${pageContext.request.contextPath}/personal/navbar.jsp");
}

	
});
</script>   

</head>
<body background="${pageContext.request.contextPath }/images/bg2.jpg"> 

	   
	<h1 style="text-align:center">进度选择</h1>
	<div class="c">
	<div class="pd-20">
		<div class="cl pd-5 bg-1 bk-gray mt-20"> 
			<span class="l" style="font-size:20px">			
			</span> 
		</div>	
	</div>
	<div class="row" style="padding-left:60px;">
		<div style="float:left;width:23%;">
	   
	<div>
		<div class="main content">
			<div class="left-sider">
				<div class="operate">
					<ul id="J_navlist">
					</ul>
				</div>
			</div>
		</div> 
	</div>
	 </div> 
	<div style="width:77% ;float:left; padding-right:60px;">
   <div>
		<input type="hidden" class="cId" value="${cId}"/>
		<h2 align="center">问题分享--问题及解答</h2>
		<br>
		<h4 align="center"><span id="msg"></span></h4>
		<table class="table table-hover" style="padding-top:100px;padding-bottom: 300px;">
			<tr class="success" >
				<td colspan="3" style="width:50%;height: 100px;"><h4>问题分享：</h4></td>
				
			</tr>
			<c:forEach var="it" items="${list}" varStatus="item">
				<tr style="width: 50%; height: 150px;">
					<th align="center"><br />
					<br /><span style="color:red">问题：</span></th>
					<td>${it.question}</td>
					<td><button type="button"   class="btn btn-success" value="问题修改">问题修改</button></td>
				</tr>
					<tr style="width: 50%; height: 150px;">
					<th align="center"><br />
					<br /><span style="color:#4a86ea">答案：</span></th>
					<td>${it.solution}</td>
					<td><button type="button"class="btn btn-success" value="答案修改">答案修改</button></td>
				</tr>
			</c:forEach>
		</table>
		<button type="button" class="btn btn-info" id="share">-- 问题分享 --</button>
		<span style="padding:200px"></span>
		</div>
	</div>
	</div>
	</div>
		<input type="hidden" id="info" value="${data}"/>
</body>
</html>