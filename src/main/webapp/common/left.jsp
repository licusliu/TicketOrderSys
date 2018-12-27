<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
 #ul1{
margin: 0;
padding: 0;
line-height: 30px;
        }
.li3{
display: inline-block;
list-style: none;
padding:3px;
margin-left:50px;
}
.a3{
display: inline-block;
color: white;
text-decoration: none;
        }
</style>
<script type="text/javascript">

	// 登录
	function login(){
		var userName=$("#userName").val();
		var password=$("#password").val();
		var rand=$("#rand").val();
		if(userName==null||userName==""){
			document.getElementById("error").innerHTML="用户名不能为空！";
			return;
		}
		if(password==null||password==""){
			document.getElementById("error").innerHTML="密码不能为空！";
			return;
		}
		if(rand==null||rand==""){
			document.getElementById("error").innerHTML="验证码不能为空！";
			return;
		}
		$.post("${pageContext.request.contextPath}/user_login.action",{'user.userName':userName,'user.password':password,'user.sfz':rand},
				function(result){
					var result=eval('('+result+')');
					if(result.error){
						document.getElementById("error").innerHTML=result.error;
					}
					else if(result.success){
						window.location.href="${pageContext.request.contextPath}/flight_indexList.action";
					}
				}
			);
	}
	
	// 安全退出
	function logout(){
		if(confirm("您确认要退出系统吗？")){
			$.post("${pageContext.request.contextPath}/user_logout.action",{},
				function(result){
					var result=eval('('+result+')');
					if(result.success){
						window.location.href="${pageContext.request.contextPath}/flight_indexList.action";
					}
				}
			);
		}
	}
	
	// 用户注册
	function register(){
		var userName=$("#userName2").val();
		var pwd=$("#pwd").val();
		var pwd2=$("#pwd2").val();
		var email=$("#email").val();
		var rand1=$("#rand1").val();
		if(userName==null||userName==""){
			document.getElementById("error2").innerHTML="用户名不能为空！";
			return;
		}
		if(pwd==null||pwd==""){
			document.getElementById("error2").innerHTML="密码不能为空！";
			return;
		}
		if(pwd2==null||pwd2==""){
			document.getElementById("error2").innerHTML="确认密码不能为空！";
			return;
		}
		if(pwd!=pwd2){
			document.getElementById("error2").innerHTML="确认密码和密码不一致！";
			return;
		}
		if(email==null||email==""){
			document.getElementById("error2").innerHTML="邮箱账号为空！";
			return;
		}
		if(rand1==null||rand1==""){
			document.getElementById("error").innerHTML="验证码不能为空！";
			return;
		}
		$.post("${pageContext.request.contextPath}/user_register.action",{'user.userName':userName,'user.password':pwd,'user.email':email,'user.sfz':rand1},
				function(result){
					var result=eval('('+result+')');
					if(result.error){
						document.getElementById("error2").innerHTML=result.error;
					}else{
						alert("注册成功！请登录！");
						window.location.href="${pageContext.request.contextPath}/flight_indexList.action";
					}
				}
			);
	}
	//刷新图片
	function reloadcode(id)
	{
		var verify=document.getElementById(id);
		verify.setAttribute('src','${pageContext.request.contextPath}/image.jsp?'+Math.random());
	}
	
	//重置搜索条件
	function resetValue(){
		$("#fromCity").val("");
		$("#toCity").val("");
		$("#fromTime").val("");
		$("#airName").val("");
	}
	//重置搜索条件
	function resetValue1(){
		$("#fromCity1").val("");
		$("#toCity1").val("");
		$("#fromTime1").val("");
		$("#airName1").val("");
	}
	//选择搜索器
	function selectsearch(id)
	{
		if(id==1)
		{
			document.getElementById('li1').style.background="blue";
			document.getElementById('li2').style.background="gray";
			document.getElementById('iframe2').style.display="none";
			document.getElementById('iframe1').style.display="block";
		}
		if(id==2)
		{
			document.getElementById('li2').style.background="blue";
			document.getElementById('li1').style.background="gray";
			document.getElementById('iframe1').style.display="none";
			document.getElementById('iframe2').style.display="block";
		  /*  ("#").css=('display','none');
		   ("#iframe2").css=('display','block'); */
		}
	}
	
</script>
<div class="panel panel-default">
  <div class="panel-heading">
    <h3 class="panel-title">用户信息</h3>
  </div>
  <div class="panel-body">
  	    <c:if test="${currentUser!=null }">
  	    </c:if>
  	    <c:choose>
  	    	<c:when test="${currentUser!=null }">
  	    		<p>欢迎旅客：<strong>${currentUser.userName }</strong>&nbsp;&nbsp;<a href="javascript:logout()"><font color="black">【安全退出】</font></a></p>
  	    		<a href="${pageContext.request.contextPath}/main_userCenter.jsp" ><font color="red"><strong>进入个人中心</strong></font></a></p>
  	    	</c:when>
  	    	<c:otherwise>
  	    		<form  method="post"  action="${pageContext.request.contextPath}/user/login.action"  >
					  <table>
					  	<tr height="40px;">
					  		<td>用户名：</td>
					  		<td><input type="text"  id="userName" /></td>
					  	</tr>
					  	<tr height="40px;">
					  		<td>密码：</td>
					  		<td><input type="password" id="password"/></td>
					  	</tr>
					  	<tr height="40px;">
					  		<td>验证码：</td>
					  		<td><input type="text" id="rand" /><img border=0 id="randimg1" onclick="reloadcode('randimg1')" src="${pageContext.request.contextPath}/image.jsp"/></td>
					  	</tr>
					  	<tr height="40px;">
					  		<td><input type="button" value="登录" onclick="login()"/></td>
					  		<td>&nbsp;&nbsp;<input type="button" value="注册" data-toggle="modal" data-target="#myModal"/>&nbsp;&nbsp;<span id="error" style="color: red"></span></td>
					  	</tr>
					  </table>
					</form>
  	    	</c:otherwise>
  	    </c:choose>
    	
  </div>
</div>
<div class="panel panel-default">
  <div class="panel-heading">
    <h3 class="panel-title">航班查询</h3>
  </div>  
  <div>
  <ul id="ul1">
  <li class="li3" id="li1" style="background: blue;"><a class="a3"  onclick="selectsearch(1)">国内航班</a></li>
  <li class="li3" id="li2" style="background: gray;"><a class="a3" onclick="selectsearch(2)">国际航班</a></li> 
  </ul>
  </div>
  <div id="iframe1" class="panel-body" style="display:block;">
    <form method="post" action="${pageContext.request.contextPath}/flight_list.action"  >
		  <table>
		  	<tr height="40px;">
		  		<td>出发地点：</td>
		  		<td>
		  		<input type="text" value="${s_flight.fromCity}"  id="fromCity" name="s_flight.fromCity" mod="address|notice" mod_address_source="hotel" mod_address_suggest="@Beijing|北京|53|BJ@Shanghai|上海|321@Shenzhen|深圳|91@Guangzhou|广州|80@Qingdao|青岛|292@Chengdu|成都|324@Hangzhou|杭州|383@Wuhan|武汉|192@Tianjin|天津|343@Dalian|大连|248@Xiamen|厦门|61@Chongqing|重庆|394@" mod_address_reference="cityid" placeholder="中文/拼音" />
				</td>
				<td>
				<input id="cityid" name="cityid" type="hidden" value="{$cityid}" />
		  		<%-- <input type="text" id="fromCity"  name="s_flight.fromCity"  value="${s_flight.fromCity}"/> --%>
		  		</td>
		  	</tr>
		  	<tr height="40px;">
		  		<td>到达地点：</td>
		  		<td>
		  		<input type="text" value="${s_flight.toCity}"  id="toCity" name="s_flight.toCity" mod="address|notice" mod_address_source="hotel" mod_address_suggest="@Beijing|北京|53@Shanghai|上海|321@Shenzhen|深圳|91@Guangzhou|广州|80@Qingdao|青岛|292@Chengdu|成都|324@Hangzhou|杭州|383@Wuhan|武汉|192@Tianjin|天津|343@Dalian|大连|248@Xiamen|厦门|61@Chongqing|重庆|394@" mod_address_reference="getcityid" placeholder="中文/拼音" />
				</td>
				<td>
				<input id="getcityid" name="getcityid" type="hidden" value="{$getcityid}" />
		  		<%-- <input type="text" id="toCity" name="s_flight.toCity" value="${s_flight.toCity}"/> --%>
		  		<input  name="s_flight.flightType" type="hidden" value="国内航班" />
		  		</td>
		  	</tr>
		  	<tr height="40px;">
		  		<td>出发日期：</td>
		  		<td><input type="text" id="fromTime"  class="Wdate" onclick="WdatePicker()" name="s_flight.fromTime" value="<fmt:formatDate value="${s_flight.fromTime }" type="date" pattern="yyyy-MM-dd"/>"/></td>
		  	</tr>
		  	<tr height="40px;">
		  		<td>航空公司：</td>
		  		<td>
		  		<select name="s_flight.name" id="airName">
                <option value="">不限</option>
                <option value="中国国航">中国国航-CA</option>
                <option value="南方航空">南方航空-CZ</option>
                <option value="东方航空">东方航空-MU</option>
                <option value="">——————</option>
                <option value="奥凯航空">A-奥凯航空公司-BK</option>
                <option value="北京首都航空">B-北京首都航空公司-JD</option>
                <option value="长龙航空">C-长龙航空公司-GJ</option>
                <option value="春秋航空">C-春秋航空公司-9C</option>
                <option value="成都航空">C-成都航空公司-EU</option>
                <option value="大新华航空">D-大新华航空公司-CN</option>
                <option value="东海航空">D-东海航空公司-DZ</option>
                <option value="河北航空">H-河北航空公司-NS</option>
                <option value="海南航空">H-海南航空公司-HU</option>
                <option value="华夏航空">H-华夏航空公司-G5</option>
                <option value="吉祥航空">J-吉祥航空公司-HO</option>
                <option value="昆明航空">K-昆明航空公司-KY</option>
                <option value="青岛航空">Q-青岛航空公司-QW</option>
                <option value="四川航空">S-四川航空公司-3U</option>
                <option value="山东航空">S-山东航空公司-SC</option>
                <option value="深圳航空">S-深圳航空公司-ZH</option>
                <option value="上海航空">S-上海航空公司-FM</option>
                <option value="天津航空">T-天津航空公司-GS</option>
                <option value="西部航空">X-西部航空公司-PN</option>
                <option value="西藏航空">X-西藏航空公司-TV</option>
                <option value="幸福航空">X-幸福航空公司-JR</option>
                <option value="厦门航空">X-厦门航空公司-MF</option>
                <option value="祥鹏航空">X-祥鹏航空公司-8L</option>
                <option value="英安航空">Y-英安航空公司-YI</option>
                <option value="中国联合航空">Z-中国联合航空公司-KN</option>
            </select></td>
		  </tr>
		  	<tr height="40px;">
		  		<td><input type="submit" value="搜索"/></td>
		  		<td>&nbsp;&nbsp;<input type="button" value="重置" onclick="resetValue()"/></td>
		  	</tr>
		  </table>
		</form>
  </div>
  
  
  <div id="iframe2" class="panel-body" style="display:none;">
    <form method="post"  action="${pageContext.request.contextPath}/flight_list.action"  >
		  <table>
		  	<tr height="40px;">
		  		<td>出发地点：</td>
		  		<td>
		  		<input type="text" value="${s_flight.fromCity}"  id="fromCity1" name="s_flight.fromCity" mod="address|notice" mod_address_source="hotel1" mod_address_suggest="@Beijing|北京|53|BJ@Shanghai|上海|321@Shenzhen|深圳|91@Guangzhou|广州|80@Qingdao|青岛|292@Chengdu|成都|324@Hangzhou|杭州|383@Wuhan|武汉|192@Tianjin|天津|343@Dalian|大连|248@Xiamen|厦门|61@Chongqing|重庆|394@" mod_address_reference="cityid"  placeholder="中文/拼音" />
				</td>
		  	</tr>
		  	<tr height="40px;">
		  		<td>到达地点：</td>
		  		<td>
		  		<input type="text" value="${s_flight.toCity}"  id="toCity1" name="s_flight.toCity" mod="address|notice" mod_address_source="hotel1" mod_address_suggest="@Beijing|北京|53|BJ@Shanghai|上海|321@Shenzhen|深圳|91@Guangzhou|广州|80@Qingdao|青岛|292@Chengdu|成都|324@Hangzhou|杭州|383@Wuhan|武汉|192@Tianjin|天津|343@Dalian|大连|248@Xiamen|厦门|61@Chongqing|重庆|394@" mod_address_reference="getcityid"  placeholder="中文/拼音" />
				</td>
		  	</tr>
		  	<tr height="40px;">
		  		<td>出发日期：</td>
		  		<td><input type="text" id="fromTime1"  class="Wdate" onclick="WdatePicker()" name="s_flight.fromTime" value="<fmt:formatDate value="${s_flight.fromTime }" type="date" pattern="yyyy-MM-dd"/>"/>
		  		<input  name="s_flight.flightType" type="hidden" value="国际航班" /></td>
		  	</tr>
		  	<tr height="40px;">
		  		<td>航空公司：</td>
		  		<td>
		  		<select name="s_flight.name" id="airName1">
                <option value="">不限</option>
                <option value="中国国航">中国国航-CA</option>
                <option value="南方航空">南方航空-CZ</option>
                <option value="东方航空">东方航空-MU</option>
            </select></td>
		  </tr>
		  	<tr height="40px;">
		  		<td><input type="submit" value="搜索"/></td>
		  		<td>&nbsp;&nbsp;<input type="button" value="重置" onclick="resetValue1()"/></td>
		  	</tr>
		  </table>
		</form>
  </div>
</div>

<div id="jsContainer" class="jsContainer" style="height:0">
    <div id="tuna_alert" style="display:none;position:absolute;z-index:999;overflow:hidden;"></div>
    <div id="tuna_jmpinfo" style="visibility:hidden;position:absolute;z-index:120;"></div>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/fixdiv.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/address.js"></script>
<script type='text/javascript' src='${pageContext.request.contextPath}/js/citylist.js'></script>
<div class="modal fade bs-example-modal-sm" id="myModal" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
  <div class="modal-dialog" style="width: 350px;">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">用户注册</h4>
      </div>
      <div class="modal-body">
       	  <table align="center">
		  	<tr height="40px;">
		  		<td>用户名：</td>
		  		<td><input type="text"  id="userName2"/></td>
		  	</tr>
		  	<tr height="40px;">
		  		<td>密码：</td>
		  		<td><input type="password" id="pwd"/></td>
		  	</tr>
		  	<tr height="40px;">
		  		<td>确认密码：</td>
		  		<td><input type="password" id="pwd2"/></td>
		  	</tr>
		  	<tr height="40px;">
		  		<td>邮箱：</td>
		  		<td><input type="text" id="email"/></td>
		  	</tr>
		  	<tr height="40px;">
				<td>验证码：</td>
				<td><input type="text" id="rand1"/><img border=0 id="randimg2" onclick="reloadcode('randimg2')" src="${pageContext.request.contextPath}/image.jsp"/></td>
			</tr>
		  	<tr>
		  		<td colspan="2"><span id="error2" style="color: red"></span></td>
		  	</tr>
		  </table>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="register()">注册</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      </div>
    </div>
  </div>
</div>