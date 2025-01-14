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

<%@ include file="checkThesaurus.jsp"%>
<%
	String idVoca = (String) request.getAttribute("idVoca");
%>
<HTML>
<HEAD>
<TITLE><%=resource.getString("GML.popupTitle")%></TITLE>
<%
out.println(gef.getLookStyleSheet());
%>
<SCRIPT LANGUAGE="JavaScript">
<!--
function CreateJargonsVoca()
{
	document.forms[0].action = "CreateJargonsVoca";
	document.forms[0].submit();
}
function Cancel()
{
	document.forms[0].action = "SelectVocabulary";
	document.forms[0].submit();
}
//-->
</SCRIPT>
</HEAD>
<BODY marginheight="5" marginwidth="5" leftmargin="5" topmargin="5" bgcolor="#FFFFFF">
<%
	browseBar.setComponentName(componentLabel);
	browseBar.setPath(resource.getString("thesaurus.BBmessageConflit"));

	out.println(window.printBefore());
    
	out.println(frame.printBefore());
%>

<% // Ici debute le code de la page %>
<center>
<FORM METHOD=POST ACTION="">
<table width="98%" border="0" cellspacing="0" cellpadding="0" class=intfdcolor4><!--tablcontour-->
	<tr> 
		<td nowrap>
			<table border="0" cellspacing="0" cellpadding="5" class="contourintfdcolor" width="100%"><!--tabl1-->
				<tr align="center"> 
					<td  class="intfdcolor4" valign="baseline" align="center">
						<span class="txtnav"><%=resource.getString("thesaurus.dejaAffecteUtilisateur")%> &nbsp;</span>
					</td>
				</tr>
		</table>
		</td>
	</tr>
</table>
<INPUT TYPE="hidden" name="idVoca" value="<%=idVoca%>">
</FORM>
<%
    ButtonPane buttonPane = gef.getButtonPane();
    buttonPane.addButton((Button) gef.getFormButton(resource.getString("thesaurus.affecter"), "javascript:CreateJargonsVoca();", false));
    buttonPane.addButton((Button) gef.getFormButton(resource.getString("GML.cancel"), "javascript:Cancel();", false));
    out.println(buttonPane.print());
%>


</center>
<% // Ici se termine le code de la page %>

<%
out.println(frame.printAfter());
out.println(window.printAfter());
%>

</BODY>
</HTML>