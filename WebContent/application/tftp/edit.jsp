<%@page language="java" contentType="text/html;charset=gb2312" %>
<%@ include file="/include/globe.inc"%>

<%@page import="com.afunms.common.base.JspPage"%>
<%@page import="java.util.List"%>
<%@page import="com.afunms.system.model.TimeShareConfig"%>
<%@page import="java.util.*"%>
<%@page import="com.afunms.application.model.*"%>
<%@page import="com.afunms.config.model.*"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
  String rootPath = request.getContextPath();
  String menuTable = (String)request.getAttribute("menuTable");
  List<Business> allBusiness = (List<Business>)request.getAttribute("allBusiness");
  TFTPConfig vo = (TFTPConfig)request.getAttribute("vo");
  String bid = (vo.getBid()==null?"''":vo.getBid());
  String id[] = bid.split(",");
  List bidlist = new ArrayList();
  if(id != null &&id.length>0){
	for(int i=0;i<id.length;i++){
		bidlist.add(id[i]);
	}
  }
%>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script type="text/javascript" src="<%=rootPath%>/include/swfobject.js"></script>
<script language="JavaScript" type="text/javascript" src="<%=rootPath%>/include/navbar.js"></script>

<script type="text/javascript" src="<%=rootPath%>/resource/js/wfm.js"></script>

<link href="<%=rootPath%>/resource/<%=com.afunms.common.util.CommonAppUtil.getSkinPath() %>css/global/global.css" rel="stylesheet" type="text/css"/>
<!-- snow add for gatherTime at 2010-5-21 start -->
<script type="text/javascript" 	src="<%=rootPath%>/application/resource/js/addTimeConfig.js" charset="gb2312"></script>
<script type="text/javascript" 	src="<%=rootPath%>/application/resource/js/jquery-1.4.2.js" charset="gb2312"></script>
<script type="text/javascript">
	$(addTimeConfigRow);//addTimeConfigRow函数在application/resource/js/addTimeConfig.js中 
</script>
<!-- snow add for gatherTime at 2010-5-21 end -->

<!--nielin add for timeShareConfig at 2010-01-04 start-->
<script type="text/javascript" 	src="<%=rootPath%>/application/resource/js/timeShareConfigdiv.js" charset="gb2312"></script>
<!--nielin add for timeShareConfig at 2010-01-04 end-->


<link rel="stylesheet" type="text/css" 	href="<%=rootPath%>/js/ext/lib/resources/css/ext-all.css" charset="gb2312" />
<link rel="stylesheet" type="text/css" href="<%=rootPath%>/js/ext/css/common.css" charset="gb2312"/>
<script type="text/javascript" 	src="<%=rootPath%>/js/ext/lib/adapter/ext/ext-base.js" charset="gb2312"></script>
<script type="text/javascript" src="<%=rootPath%>/js/ext/lib/ext-all.js" charset="gb2312"></script>
<script type="text/javascript" src="<%=rootPath%>/js/ext/lib/locale/ext-lang-zh_CN.js" charset="gb2312"></script>


<script language="JavaScript" type="text/javascript">
 
  Ext.onReady(function()
{  

setTimeout(function(){
	        Ext.get('loading').remove();
	        Ext.get('loading-mask').fadeOut({remove:true});
	    }, 250);
	
 Ext.get("process").on("click",function(){
  
     //var chk1 = checkinput("ip_address","ip","名称",15,false);
     //var chk2 = checkinput("alias","string","描述",30,false);
     //var chk3 = checkinput("community","string","用户名",30,false);
     
     //if(chk1&&chk2&&chk3)
     {
     
        Ext.MessageBox.wait('数据加载中，请稍后.. '); 
        //msg.style.display="block";
        mainForm.action = "<%=rootPath%>/tftp.do?action=update";
        mainForm.submit();
     }  
       // mainForm.submit();
 });	
	
});
//-- nielin modify at 2010-01-04 start ----------------
function CreateWindow(url)
{
	
msgWindow=window.open(url,"protypeWindow","toolbar=no,width=600,height=400,directories=no,status=no,scrollbars=yes,menubar=no")
}    

function setReceiver(eventId){
	var event = document.getElementById(eventId);
	return CreateWindow('<%=rootPath%>/user.do?action=setReceiver&event='+event.id+'&value='+event.value);
}
//-- nielin modify at 2010-01-04 end ----------------


//-- nielin add at 2010-07-27 start ----------------
function setBid(eventTextId , eventId){
	var event = document.getElementById(eventId);
	return CreateWindow('<%=rootPath%>/business.do?action=setBid&event='+event.id+'&value='+event.value + '&eventText=' + eventTextId);
}
//-- nielin add at 2010-07-27 end ----------------

  
</script>
<script language="JavaScript" type="text/JavaScript">
var show = true;
var hide = false;
//修改菜单的上下箭头符号
function my_on(head,body)
{
	var tag_a;
	for(var i=0;i<head.childNodes.length;i++)
	{
		if (head.childNodes[i].nodeName=="A")
		{
			tag_a=head.childNodes[i];
			break;
		}
	}
	tag_a.className="on";
}
function my_off(head,body)
{
	var tag_a;
	for(var i=0;i<head.childNodes.length;i++)
	{
		if (head.childNodes[i].nodeName=="A")
		{
			tag_a=head.childNodes[i];
			break;
		}
	}
	tag_a.className="off";
}
//添加菜单	
function initmenu()
{
	var idpattern=new RegExp("^menu");
	var menupattern=new RegExp("child$");
	var tds = document.getElementsByTagName("div");
	for(var i=0,j=tds.length;i<j;i++){
		var td = tds[i];
		if(idpattern.test(td.id)&&!menupattern.test(td.id)){					
			menu =new Menu(td.id,td.id+"child",'dtu','100',show,my_on,my_off);
			menu.init();		
		}
	}
	timeShareConfiginit(); // nielin add for timeShareConfig 2010-01-04

}

</script>
<script>
//-- nielin add for timeShareConfig 2010-01-04 end-------------------------------------------------------------
	/*
	* 此方法用于短信分时详细信息
	* 需引入 /application/resource/js/timeShareConfigdiv.js 
	*/
	//接受用户的列表
	var action = "<%=rootPath%>/user.do?action=setReceiver";
	// 获取短信分时详细信息的div
	function timeShareConfiginit(){
		var rowNum = document.getElementById("rowNum");
		rowNum.value = "0";
		// 获取设备或服务的分时数据列表,
		var timeShareConfigs = new Array();
		var smsConfigs = new Array();
		var phoneConfigs = new Array();
		<%	
			List timeShareConfigList = (List) request.getAttribute("timeShareConfigList");
			if(timeShareConfigList!=null&&timeShareConfigList.size()>=0){
			for(int i = 0 ; i < timeShareConfigList.size(); i++){	        
	            TimeShareConfig timeShareConfig = (TimeShareConfig) timeShareConfigList.get(i);
	            int timeShareConfigId = timeShareConfig.getId();
	            String timeShareType = timeShareConfig.getTimeShareType();
	            String timeShareConfigbeginTime = timeShareConfig.getBeginTime();
	            String timeShareConfigendTime = timeShareConfig.getEndTime();
	            String timeShareConfiguserIds = timeShareConfig.getUserIds();
	            
	    %>
	            timeShareConfigs.push({
	                timeShareConfigId:"<%=timeShareConfigId%>",
	                timeShareType:"<%=timeShareType%>",
	                beginTime:"<%=timeShareConfigbeginTime%>",
	                endTime:"<%=timeShareConfigendTime%>",
	                userIds:"<%=timeShareConfiguserIds%>"
	            });
	    <%
	        }
	        }
	    %>   
	    for(var i = 0; i< timeShareConfigs.length; i++){
	    	var item = timeShareConfigs[i];
	    	if(item.timeShareType=="sms"){
	    		smsConfigs.push({
	                timeShareConfigId:item.timeShareConfigId,
	                timeShareType:item.timeShareType,
	                beginTime:item.beginTime,
	                endTime:item.endTime,
	                userIds:item.userIds
	            });
	    	}
	    	if(item.timeShareType=="phone"){
	    		
	    		phoneConfigs.push({
	                timeShareConfigId:item.timeShareConfig,
	                timeShareType:item.timeShareType,
	                beginTime:item.beginTime,
	                endTime:item.endTime,
	                userIds:item.userIds
	            });
	    	}
	    }
		timeShareConfig("smsConfigTable",smsConfigs);
		timeShareConfig("phoneConfigTable",phoneConfigs);
	}
//---- nielin add for timeShareConfig 2010-01-04 end-------------------------------------------------------------------------
</script>


</head>
<body id="body" class="body" onload="initmenu();">

	<div id="loading">
		<div class="loading-indicator">
		<img src="<%=rootPath%>/js/ext/lib/resources/extanim64.gif" width="32" height="32" style="margin-right: 8px;" align="middle" />Loading...</div>
	</div>
	<!-- 这里用来定义需要显示的右键菜单 -->
	<div id="itemMenu" style="display: none";>
	<table border="1" width="100%" height="100%" bgcolor="#F1F1F1"
		style="border: thin;font-size: 12px" cellspacing="0">
		<tr>
			<td style="cursor: default; border: outset 1;" align="center"
				onclick="parent.edit()">修改信息</td>
		</tr>
		<tr>
			<td style="cursor: default; border: outset 1;" align="center"
				onclick="parent.detail();">监视信息</td>
		</tr>
		<tr>
			<td style="cursor: default; border: outset 1;" align="center"
				onclick="parent.cancelmanage()">取消监视</td>
		</tr>
		<tr>
			<td style="cursor: default; border: outset 1;" align="center"
				onclick="parent.addmanage()">添加监视</td>
		</tr>		
	</table>
	</div>
	<!-- 右键菜单结束-->

	<form  method="post" name="mainForm">
		<input type=hidden name="id" value="<%=vo.getId()%>">
		
		<table id="body-container" class="body-container">
			<tr>
				<td class="td-container-menu-bar">
					<table id="container-menu-bar" class="container-menu-bar">
						<tr>
							<td>
								<%=menuTable%>
							</td>	
						</tr>
					</table>
				</td>
				<td class="td-container-main">
					<table id="container-main" class="container-main">
						<tr>
							<td class="td-container-main-add">
								<table id="container-main-add" class="container-main-add">
									<tr>
										<td>
											<table id="add-content" class="add-content">
												<tr>
													<td>
														<table id="add-content-header" class="add-content-header">
										                	<tr>
											                	<td align="left" width="5"><img src="<%=rootPath%>/common/images/right_t_01.jpg" width="5" height="29" /></td>
											                	<td class="add-content-title">应用 >> 数据库管理 >> tftp编辑</td>
											                    <td align="right"><img src="<%=rootPath%>/common/images/right_t_03.jpg" width="5" height="29" /></td>
											       			</tr>
											        	</table>
				        							</td>
				        						</tr>
				        						<tr>
				        							<td>
				        								<table id="detail-content-body" class="detail-content-body">
				        									<tr>
				        										<td>
				        										
				        												<table border="0" id="table1" cellpadding="0" cellspacing="1"
																				width="100%">
																			<TBODY>
																				<tr style="background-color: #ECECEC;">						
																			<TD nowrap align="right" height="24" width="10%"><font color="red">*&nbsp;</font>名称&nbsp;</TD>				
																			<TD nowrap width="40%" colspan=3>&nbsp;
																				<input type="text" name="name" maxlength="50" size="20" class="formStyle" value="<%=vo.getName() %>">
																			</TD>
																		</tr>
																		<!--  
																		<tr>						
																			<TD nowrap align="right" height="24" width="10%"><font color="red">*&nbsp;</font>用户名&nbsp;</TD>				
																			<TD nowrap width="40%" colspan=3>&nbsp;
																				<input type="text" name="username" maxlength="50" size="20" class="formStyle" value="<%=vo.getUsername()%>">
																			</TD>
																		</tr>
																		<tr style="background-color: #ECECEC;">						
																			<TD nowrap align="right" height="24" width="10%"><font color="red">*&nbsp;</font>密码&nbsp;</TD>				
																			<TD nowrap width="40%" colspan=3>&nbsp;
																				<input type="password" name="password" maxlength="50" size="20" class="formStyle" value="<%=vo.getPassword()%>">
																			</TD>
																		</tr>
																		-->
																		<tr>					
																			<TD nowrap align="right" height="24" width="10%"><font color="red">*&nbsp;</font>IP地址&nbsp;</TD>				
																			<TD nowrap width="40%">&nbsp;
																				<input type="text" name="ipaddress" maxlength="50" size="50" class="formStyle" value="<%=vo.getIpaddress()%>">
																			</TD>
																			<TD nowrap align="right" height="24" width="10%">文件名称&nbsp;</TD>				
																			<TD nowrap width="40%">&nbsp;
																				<input type="text" name="filename" maxlength="50" size="20" class="formStyle" value="<%=vo.getFilename()%>">
																			</TD>
																		</tr>
																		<tr style="background-color: #ECECEC;">					
																			<TD nowrap align="right" height="24" width="10%">是否监控&nbsp;</TD>				
																			<TD nowrap width="40%" colspan=3>&nbsp;
																				<select   name="monflag"  class="formStyle">
																					<%
																					if(vo.getMonflag() == 0){
																				%>
																					<option value=0 selected>否</option>
																					<option value=1>是</option>
																				<%
																					}else{
																				%>
																					<option value=0 >否</option>
																					<option value=1 selected>是</option>								
																				<%
																					}
																				%>
																				</select>
																			</TD>
																		</tr>
																		<tr>					
																			<TD nowrap align="right" height="24" width="10%">超时&nbsp;</TD>				
																			<TD nowrap width="40%" colspan=3>&nbsp;
																				<input type="text" name="timeout" maxlength="50" size="20" class="formStyle" value="<%=vo.getTimeout()%>">
																			</TD>
																		</tr>
																		<!--<tr style="background-color: #ECECEC;"> 
												  							<TD nowrap align="right" height="24" width="10%">短信接收人&nbsp;</TD>       
																			<TD nowrap width="40%">&nbsp;
																			<input type="text" id="sendmobiles" readonly="readonly" name="sendmobiles" maxlength="32" size="50" value="<%=vo.getSendmobiles()%>">
																			&nbsp;&nbsp;<input id="sendmobilesbutton"  type="button" value="设置短信接收人" onclick="setReceiver();"> 
																			</td>
												 						</tr>-->
												 						<!-- snow modify begin */ 2010-05-18 -->
																		<tr>												
																			<TD nowrap align="right" height="24" width="10%">供应商&nbsp;</TD>				
																			<TD nowrap width="40%">&nbsp;
																				<select size=1 name='supperid' style="width:260px;">
																					<option value='0' ></option>
																					<c:forEach items="${allSupper}" var="al">
																						<c:choose>
																							<c:when test="${vo.supperid eq al.su_id }">
																								<option value='${al.su_id }' selected>${al.su_name }（${al.su_dept}）</option>
																							</c:when>
																							<c:otherwise>
																		      							<option value='${al.su_id }'>${al.su_name }（${al.su_dept}）</option>
																							</c:otherwise>
																						</c:choose>
																		    					</c:forEach>
																		      			</select>
																		      		</TD>	
																		      		<TD nowrap align="right" height="24" width="10%"></TD>				
																			<TD nowrap width="40%">&nbsp;
																		      		</TD>																					
																		</tr>						
																		<!-- snow modify end -->
												    					<tr > 
												  							<TD nowrap align="right" height="24" width="10%">邮件接收人&nbsp;</TD>       
																			<TD nowrap width="40%">&nbsp;
																			<input type="text" id="sendemail" readonly="readonly" name="sendemail" maxlength="32" size="50" value="<%=vo.getSendemail()%>">
																			&nbsp;&nbsp;<input id="sendemailbutton" type="button" value="设置邮件接收人" onclick="setReceiver();"> 
																			</td>
												 						</tr>  
												    					<!--<tr style="background-color: #ECECEC;"> 
												  							<TD nowrap align="right" height="24" width="10%">电话接收人&nbsp;</TD>       
																			<TD nowrap width="40%">&nbsp;
																			<input type="text" id="sendphone" readonly="readonly" name="sendphone" maxlength="32" size="50" value="<%=vo.getSendphone()%>">
																			&nbsp;&nbsp;<input id="sendphonebutton" type="button" value="设置电话接收人" onclick="setReceiver();"> 
																			</td>
												 						</tr>-->  								
																		<tr style="background-color: #ECECEC;">	
																			<TD nowrap align="right" height="24">所属业务&nbsp;</TD>
																			<td nowrap colspan="3" height="1">
																			<% 
																				String bussName = "";
																				if( allBusiness.size()>0){
																					for(int i=0;i<allBusiness.size();i++){
																						Business buss = (Business)allBusiness.get(i);
																						
																						if(bidlist.contains(buss.getId()+"")){
																							bussName = bussName + ',' + buss.getName();
																						}
																						
																	 				}
																				}
																			%>   
																			<input type=text readonly="readonly" onclick='setBid("bidtext" , "bid");' id="bidtext" name="bidtext" size="50" maxlength="32" value="<%=bussName%>">&nbsp;&nbsp;<input type=button value="设置所属业务" onclick='setBid("bidtext" , "bid");'>
																			<input type="hidden" id="bid" name="bid" value="<%=vo.getBid()%>">
																			</td>
																		</tr>
																		<!-- snow modify begin (timeConfig div)*/ 2010-05-20 -->
																		<tr>
																		 	<td nowrap align="right" width="10%" style="height:35px;">信息采集时间&nbsp;</td>		
																		 	<td nowrap  colspan="3">
																		        <div id="formDiv" style="">         
																	                <table width="100%" style="BORDER-COLLAPSE: collapse" borderColor=#cedefa cellPadding=0 rules=none border=1 algin="center" >
																                        <tr>
																                            <td align="left">  
																	                            <br>
																                                <table id="timeConfigTable" style="width:60%; padding:0;  background-color:#FFFFFF; position:relative; left:15px;" >
															                                        <c:forEach items="${timeGratherConfigList}" var="tg" varStatus="tgindex">
															                                        	<script type="text/javascript">
															                                        		$(document).ready(function(){
															                                        			$("#addTimeConfigRow").click();
															                                        			selectedAll(${tg.startHour},${tg.startMin},${tg.endHour},${tg.endMin},${tgindex.index});
															                                        		});
															                                        	</script>
															                                        </c:forEach>
															                                        <tr>
															                                            <td colspan="7" height="50" align="center"> 
															                                                <span id="addTimeConfigRow" style="border: 1px solid black;margin:10px;padding:0px 3px 0px 3px;cursor: hand;line-height:15px">增加一行</span>
															                                            </td>
															                                        </tr>
																                                </table>
																                            </td>
																                        </tr>
																	                </table>
																	            </div> 
																			</td>
																		</tr>
																		<!-- snow modify end */ 2010-05-20 -->
																		
																		
																		<tr>	
																			<td nowrap colspan="8">
																			
																			    <!-- nielin modify begin (SMS div)*/ 2009-01-04-->
																			        <div id="formDiv" style="">         
																		                <table width="100%" style="BORDER-COLLAPSE: collapse" borderColor=#cedefa cellPadding=0 rules=none border=1 algin="center" >
																	                        <tr>
																	                            <td style="padding:0px 0px 0px 5px">&nbsp;&nbsp;短信发送详细配置</td>
																	                        </tr>
																	                        <tr>
																	                            <td align="center">           
																	                                <table id="smsConfigTable"  style="width:80%; padding:0;  background-color:#FFFFFF;" >
																                                        <tr>
																                                            <td colspan="0" height="50" align="center"> 
																                                                <span  onClick='addRow("smsConfigTable","sms");' style="border: 1px solid black;margin:10px;padding:0px 3px 0px 3px;cursor: hand;line-height:15px">增加一行</span>
																                                            </td>
																                                        </tr>
																	                                </table>
																	                            </td>
																	                        </tr>
																		                </table>
																		            </div> 
																			      <!-- nielin modify end */ 2009-01-04--->					
																			
																			</td>
																		</tr>
																		<tr>
																			<td nowrap colspan="8">
																			
																			    <!-- nielin modify begin (Phone div)*/ 2009-01-04--->
																			        <div id="formDiv" style="">         
																		                <table width="100%" style="BORDER-COLLAPSE: collapse" borderColor=#cedefa cellPadding=0 rules=none border=1 algin="center" >
																	                        <tr>
																	                            <td style="padding:0px 0px 0px 5px">&nbsp;&nbsp;电话接收详细配置</td>
																	                        </tr>
																	                        <tr>
																	                            <td align="center">           
																	                                <table id="phoneConfigTable"  style="width:80%; padding:0;  background-color:#FFFFFF;" >
																                                        <tr>
																                                            <td colspan="0" height="50" align="center"> 
																                                                <span  onClick='addRow("phoneConfigTable","phone");' style="border: 1px solid black;margin:10px;padding:0px 3px 0px 3px;cursor: hand;line-height:15px">增加一行</span>
																                                            </td>
																                                        </tr>
																	                                </table>
																	                            </td>
																	                        </tr>
																		                </table>
																		            </div> 
																			      <!-- nielin modify end */ 2009-01-04--->					
																				
																			</td>
																		</tr>
																		
																		<tr>
																			<!-- nielin add (for timeShareConfig) start 2010-01-04 -->
																			<td><input type="hidden" id="rowNum" name="rowNum"></td>
																			<!-- nielin add (for timeShareConfig) end 2010-01-04 -->
																		</tr>
																
																		<tr>
																			<TD nowrap colspan="4" align=center>
																			<br><input type="button" value="保 存" style="width:50" id="process" onclick="#">&nbsp;&nbsp;
																				<input type="reset" style="width:50" value="返回" onclick="javascript:history.back(1)">
																			</TD>	
																		</tr>	
																			</TBODY>
																		</TABLE>
										 							
										 							
				        										</td>
				        									</tr>
				        								</table>
				        							</td>
				        						</tr>
				        						<tr>
				        							<td>
				        								<table id="detail-content-footer" class="detail-content-footer">
				        									<tr>
				        										<td>
				        											<table width="100%" border="0" cellspacing="0" cellpadding="0">
											                  			<tr>
											                    			<td align="left" valign="bottom"><img src="<%=rootPath%>/common/images/right_b_01.jpg" width="5" height="12" /></td>
											                    			<td></td>
											                    			<td align="right" valign="bottom"><img src="<%=rootPath%>/common/images/right_b_03.jpg" width="5" height="12" /></td>
											                  			</tr>
											              			</table>
				        										</td>
				        									</tr>
				        								</table>
				        							</td>
				        						</tr>
				        					</table>
										</td>
									</tr>
									<tr>
										<td>
											
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		
	</form>
</BODY>

<script>

function unionSelect(){
	var type = document.getElementById("type");
	var nameFont = document.getElementById("nameFont");
	var db_nameTD = document.getElementById("db_nameTD");
	var db_nameInput = document.getElementById("db_nameInput");
	var category = document.getElementById("category");
	var port  = document.getElementById("port");
	if(type.value == 2){
		nameFont.style.display="inline";
		db_nameTD.style.display="none";
		db_nameInput.style.display="none";
	}else{
		nameFont.style.display="none";
		db_nameTD.style.display="inline";
		db_nameInput.style.display="inline";
		
	}
	var categoryvalue = "";
	var portvalue = "";
	if(type.value == 1){
		categoryvalue = 53;
		portvalue = 1521;
	}else if(type.value == 2){
		categoryvalue = 54;
		portvalue = 1433;
	}else if(type.value == 4){
		categoryvalue = 52;
		portvalue = 3306;
	}else if(type.value == 5){
		categoryvalue = 59;
		portvalue = 50000;
	}else if(type.value == 6){
		categoryvalue = 55;
		portvalue = 2638;
	}else if(type.value == 7){
		categoryvalue = 60;
		portvalue = 9088;
	}
	port.value = portvalue;
	category.value = categoryvalue;
}

unionSelect();

</script>

</HTML>