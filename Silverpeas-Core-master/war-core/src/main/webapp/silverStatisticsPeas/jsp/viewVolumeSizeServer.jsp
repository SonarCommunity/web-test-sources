<%@ page import="org.silverpeas.admin.user.constant.UserAccessLevel" %>
<%--

    Copyright (C) 2000 - 2012 Silverpeas

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as
    published by the Free Software Foundation, either version 3 of the
    License, or (at your option) any later version.

    As a special exception to the terms and conditions of version 3.0 of
    the GPL, you may redistribute this Program in connection with Free/Libre
    Open Source Software ("FLOSS") applications as described in Silverpeas's
    FLOSS exception.  You should have received a copy of the text describing
    the FLOSS exception, and it is also available here:
    "http://www.silverpeas.org/docs/core/legal/floss_exception.html"

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

--%>

<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="checkSilverStatistics.jsp" %>
<%@ taglib uri="http://www.silverpeas.com/tld/viewGenerator" prefix="view"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
  String spaceId = (String) request.getAttribute("SpaceId");
	Vector<String[]> vPath = (Vector<String[]>) request.getAttribute("Path");
  Vector<String[]> vStatsData = (Vector<String[]>)request.getAttribute("StatsData");
  UserAccessLevel userProfile = (UserAccessLevel)request.getAttribute("UserProfile");

  long totalSize = 0L;

	TabbedPane tabbedPane = gef.getTabbedPane();
	if (UserAccessLevel.ADMINISTRATOR.equals(userProfile)) {
		tabbedPane.addTab(resources.getString("silverStatisticsPeas.JobPeas"), m_context+"/RsilverStatisticsPeas/jsp/ViewVolumeServices",false);
	}
	tabbedPane.addTab(resources.getString("silverStatisticsPeas.volumes.tab.contributions"), m_context+"/RsilverStatisticsPeas/jsp/ViewVolumePublication",false);
	tabbedPane.addTab(resources.getString("GML.attachments"),"javascript:displayVolumes();",true);

	ArrayPane arrayPane = gef.getArrayPane("List", "ViewVolumeSizeServer"+( (spaceId==null) ? "" : ("?SpaceId="+spaceId) ), request,session);
	arrayPane.setVisibleLineNumber(50);
  arrayPane.addArrayColumn(resources.getString("silverStatisticsPeas.organisation"));
  arrayPane.addArrayColumn(resources.getString("silverStatisticsPeas.AttachmentsSize"));

    if (vStatsData != null) {
       	for (String[] item : vStatsData) {
       	  	ArrayLine arrayLine = arrayPane.addArrayLine();
           	if ("SPACE".equals(item[0])) {
				arrayLine.addArrayCellLink("<b>"+item[2]+"</b>", "ViewVolumeSizeServer?SpaceId="+item[1]);
           	} else {
				arrayLine.addArrayCellText(item[2]);
           	}
         	long size = Long.parseLong(item[3]);
         	totalSize += size;
			ArrayCellText cellTextCount = arrayLine.addArrayCellText(FileRepositoryManager.formatFileSize(size));
         	cellTextCount.setCompareOn(new Long(size));
       	}
    }
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title><%=resources.getString("GML.popupTitle")%></title>
<view:looknfeel />
<script type="text/javascript">
	function changeDisplay() {
		document.volumeServerFormulaire.action = document.volumeServerFormulaire.Display.value;
		$.progressMessage();
		document.volumeServerFormulaire.submit();
	}

  function displayVolumes() {
    $.progressMessage();
    $.get('<c:url value="/RsilverStatisticsPeas/jsp/ViewVolumeServer" />', function(newContent) {
      var newPage = document.open("text/html", "replace");
      newPage.write(newContent);
      newPage.close();
    });
  }
</script>
</head>
<body class="admin stats volume attachments">
 <form name="volumeServerFormulaire" action="ViewVolumeSizeServer" method="post">
<%
	browseBar.setDomainName(resources.getString("silverStatisticsPeas.statistics") + " > "+resources.getString("silverStatisticsPeas.Volumes") + " > "+resources.getString("GML.attachments"));
    browseBar.setComponentName(resources.getString("silverStatisticsPeas.AttachmentsSize"), "ViewVolumeSizeServer?SpaceId=");

    if (spaceId != null && !"".equals(spaceId))	{
		String path = "";
		String separator = "";
		for (String[] pathItem : vPath) {
			if (UserAccessLevel.ADMINISTRATOR.equals(userProfile)) {
				path += separator + "<a href=\"ViewVolumeSizeServer"+( (pathItem[0]==null) ? "" : ("?SpaceId="+pathItem[0]) )+"\">"+pathItem[1]+ "</a>";
			} else {
				path += separator + pathItem[1];
			}
			separator = " > ";
		}
		browseBar.setPath(path);
	}

	out.println(window.printBefore());
  out.println(tabbedPane.print());
  out.println(frame.printBefore());
%>

<br/>

	<div align="right">
		<%=resources.getString("silverStatisticsPeas.Display")%>&nbsp;:
		<select name="Display" size="1" onchange="changeDisplay()">
			<option value="ViewVolumeServer"><%=resources.getString("silverStatisticsPeas.AttachmentsNumber")%></option>
			<option value="ViewVolumeSizeServer" selected><%=resources.getString("silverStatisticsPeas.AttachmentsSize")%></option>
			<% if (UserAccessLevel.ADMINISTRATOR.equals(userProfile)) { %>
				<option value="ViewEvolutionVolumeSizeServer"><%=resources.getString("silverStatisticsPeas.AttachmentsTotalSize")%></option>
			<% } %>
		</select>
	</div>

<% if (vStatsData != null) { %>
	<div align="center" id="chart">
		<img src="<%=m_context%>/ChartServlet/?chart=DOCSIZE_VENTIL_CHART&random=<%=new Date().getTime()%>"/>
	</div>
	<div align="center" id="total">
		<span><span class="number"><%=FileRepositoryManager.formatFileSize(totalSize) %></span> <%=resources.getString("silverStatisticsPeas.sums.attachments.size") %></span>
	</div>
<% } %>
<br/>
<%
    if (vStatsData != null) {
  		out.println(arrayPane.print());
    }
  %>
 </form>
<%
out.println(frame.printAfter());
out.println(window.printAfter());
%>
<view:progressMessage/>
</body>
</html>