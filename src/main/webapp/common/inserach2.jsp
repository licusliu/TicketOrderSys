<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Insert title here</title>
</head>
<script type="text/javascript">
//重置搜索条件
	function resetValue(){
		$("#fromCity").val("");
		$("#toCity").val("");
		$("#fromTime").val("");
		$("#airName").val("");
	}
	</script>
<body>
<div class="panel-body">
    <form method="post"  action="${pageContext.request.contextPath}/flight_list.action"  >
		  <table>
		  	<tr height="40px;">
		  		<td>出发地点：</td>
		  		<td>
		  		<input type="text" value="${s_flight.fromCity}"  id="fromCity" name="s_flight.fromCity" mod="address|notice" mod_address_source="hotel" mod_address_suggest="@Beijing|北京|53@Shanghai|上海|321@Shenzhen|深圳|91@Guangzhou|广州|80@Qingdao|青岛|292@Chengdu|成都|324@Hangzhou|杭州|383@Wuhan|武汉|192@Tianjin|天津|343@Dalian|大连|248@Xiamen|厦门|61@Chongqing|重庆|394@" mod_address_reference="cityid" placeholder="中文/拼音" />
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
            </select></td>
		  </tr>
		  	<tr height="40px;">
		  		<td><input type="submit" value="搜索"/></td>
		  		<td>&nbsp;&nbsp;<input type="button" value="重置" onclick="resetValue()"/></td>
		  	</tr>
		  </table>
		</form>
  </div>
</body>
</html>