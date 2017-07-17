<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>信息展示-Java互助学习VIP群业务运行系统</title>
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
.operate ul li h4 { cursor:pointer; background:url(../images/bg3.png) no-repeat 16% 18px; padding-left:30px; text-decoration:none; font-size:16px; color:#555; display:block;  line-height:43px; font-weight:normal; }
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
<link
	href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css"
	rel="stylesheet" type="text/css" />
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/images/favicon.ico" />
<link
	href="${pageContext.request.contextPath}/tableTemplet/css/H-ui.css"
	rel="stylesheet" type="text/css" />
<link
	href="${pageContext.request.contextPath}/tableTemplet/lib/Hui-iconfont/1.0.1/iconfont.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(function() {
		$.post(
						"${pageContext.request.contextPath}/notice/notice.action",
						function(data) {
							if (data == "1") {
								$(".notice")
										.attr("src",
												"${pageContext.request.contextPath}/images/notice.gif");
								$(".nodata")
										.html(
												"<marquee behavior='scroll'   scrollamount='4' width='300' onmouseover='this.stop();' onmouseout='this.start();' style='overflow:hidden'><a class='notice' href='javascript:;'> <b>有新公告了，快去看看吧！</b></marquee>");
							} else {
								$(".notice")
										.attr("src",
												"${pageContext.request.contextPath}/images/notice.png");
							}
						});
		//layer层打开系统公告
		$(".notice")
				.click(
						function() {
							var index = layer
									.open({
										type : 2,
										title : '系统公告',
										area : [ '810px', '563px' ],
										shift : 5,
										maxmin : true,
										content : '${pageContext.request.contextPath }/notice/mynotice.jsp',
										end : function() {
											location.href = "${pageContext.request.contextPath}/member/navbar1.jsp";
										}
									});
						});

		//获取学过的类别
		$.post(
						"${pageContext.request.contextPath}/course/getMyCategory.action",
						function(data) {
							var line = "";
							for (var i = 0; i < data.length; i++) {
								var caid = data[i].id;
								line += data[i].title + ":&nbsp;&nbsp;&nbsp;";
								//获取进度相似学员
								$.post(
												"${pageContext.request.contextPath}/course/getTheSameProgressStudent.action",
												{
													caid : caid
												},
												function(data) {
													for (var i = 0; i < data.length; i++) {
														line += "<a class='lookprogress' lang='"+data[i].id+","+data[i].identityType+","+caid+"'>"
																+ data[i].name
																+ "</a>";
														line += "&nbsp;&nbsp;&nbsp;";
													}
													line += "<br>";
												});
							}
							$("#theSameProgress").html(line);
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
							alert("1");
							layer
									.open({
										type : 2,
										title : '问题分享',
										area : [ '780px', '550px' ],
										shift : 1,
										shade : 0.5, //开启遮罩关闭
										content : '${pageContext.request.contextPath}/question/dailyLogWrite.jsp',
										end : function() {
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
		$.post("${pageContext.request.contextPath}/courseandpro/getOnlineStudentCategory.action",function(data){
			if(data.length>0){
				showdata(data);
				$(".category").eq(0).addClass('active');
				if(data[0].capid!=""){
					flag="true";
				}
				id=data[0].caid;
				getcachapter(id);
			}
			categoryclick();
			imgclck();	
		});
		function getcachapter(id){
			$.ajaxSetup({async:false});
			$.post("${pageContext.request.contextPath}/course/getcachapter.action",{caid:id},function(data){								
				showchapter(data);		
			});
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
						line=line+"<p><a href='${pageContext.request.contextPath}/question/getQuestion.action?cId="+data2[j].id+"' style='text-decoration:none;' title='课程章节'>"+data2[j].title+ img +"</a></p>";	
						}
					line=line+"</div>";
					line = line + "</li>";				
				});			
			}
			//alert(line);
			$("#J_navlist").html(line);
			navList(1);

		}
		
		$("#query").click(function() {
			/* 防止没有数据导致页码为空的情况 */
			if($("b").text()) {
				query($("b").text());
			}
			else {
				query(1);
			}
		});
		
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
		            $("#J_navlist li").removeClass("selected");
		            $(this).parent().addClass("selected");
		            $div.slideDown(600);

		        } else {
		            $div.slideUp(600);
		        }
		    });
		}
			
	});
	function query(data) {	
		var page2 = data;	
		getData(page2);
		$("#courses").html("");
	}
</script>

</head>
<body>
		<div class="main content">
			<div class="left-sider">
				<div class="operate">
					<ul id="J_navlist">
					</ul>
				</div>
			</div>
		</div>
		<div style="width:1480px;margin-left: 100px;folat:left;">
		<input type="hidden" class="cId" value="${cId}"/>
		<h2 align="center">问题分享页面<small id="msg"></small></h2>
		<table class="table table-hover" style="padding-top: 100px;padding-bottom: 300px;">
			<tr class="success" style="width: 50%; height: 80px;">
				<td colspan="2"><br /><h4>问题分享：</h4></td>
			</tr>
			<c:forEach var="it" items="${list}" varStatus="item">
				<tr style="width: 50%; height: 150px;">
					<th align="center"><br />
					<br /><span style="color:red">问题：</span></th>
					<td>${it.question}</td>
				</tr>
				<tr style="width: 50%; height: 150px;">
					<th align="center"><br />
					<br /><span style="color:#4a86ea">答案：</span></th>
					<td>${it.solution}</td>
				</tr>
			</c:forEach>
		</table>
		<button type="button" class="btn btn-info" id="share">-- 问题分享 --</button>
		<span style="padding:200px"></span>
		</div>
</body>
</html>