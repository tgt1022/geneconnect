<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>

<table summary="" cellpadding="0" cellspacing="0" border="0">
    <tr>
    
	<td>
      	<img src="images/ftrMenuSeparator.gif" width="1" height="16" alt="" />
      </td> 
      <td height="20" class="footerMenuItem" onmouseover="changeMenuStyle(this,'footerMenuItemOver'),showCursor()" onmouseout="changeMenuStyle(this,'footerMenuItem'),hideCursor()" onclick="document.location.href='#'">
        &nbsp;&nbsp;
		<a class="footerMenuLink" href="#">
			<bean:message key="app.contactUs" />
		</a>&nbsp;&nbsp;
      </td>
      
      <td>
      	<img src="images/ftrMenuSeparator.gif" width="1" height="16" alt="" />
      </td>
      
      <td height="20" class="footerMenuItem" onmouseover="changeMenuStyle(this,'footerMenuItemOver'),showCursor()" onmouseout="changeMenuStyle(this,'footerMenuItem'),hideCursor()" onclick="document.location.href='#'">
        &nbsp;&nbsp;
        <a class="footerMenuLink" href="#">
        	<bean:message key="app.privacyNotice" />
        </a>&nbsp;&nbsp;
      </td>
      
      <td>
      	<img src="images/ftrMenuSeparator.gif" width="1" height="16" alt="" />
      </td>
      
      <td height="20" class="footerMenuItem" onmouseover="changeMenuStyle(this,'footerMenuItemOver'),showCursor()" onmouseout="changeMenuStyle(this,'footerMenuItem'),hideCursor()" onclick="document.location.href='#'">
        &nbsp;&nbsp;
        <a class="footerMenuLink" href="#">
        	<bean:message key="app.disclaimer" />
        </a>&nbsp;&nbsp;
      </td>
      
      <td>
      	<img src="images/ftrMenuSeparator.gif" width="1" height="16" alt="" />
      </td>
      
      <td height="20" class="footerMenuItem" onmouseover="changeMenuStyle(this,'footerMenuItemOver'),showCursor()" onmouseout="changeMenuStyle(this,'footerMenuItem'),hideCursor()" onclick="document.location.href='#'">
        &nbsp;&nbsp;
        <a class="footerMenuLink" href="#">
        	<bean:message key="app.accessibility" />
        </a>&nbsp;&nbsp;
      </td>
      
      <td>
      	<img src="images/ftrMenuSeparator.gif" width="1" height="16" alt="" />
      </td>
      
      <td height="20" class="footerMenuItem" onmouseover="changeMenuStyle(this,'footerMenuItemOver'),showCursor()" onmouseout="changeMenuStyle(this,'footerMenuItem'),hideCursor()" onclick="'Home.do'">
        &nbsp;&nbsp;
        <a class="footerMenuLink" href="Home.do">
        	<bean:message key="app.reportProblem" />
        </a>&nbsp;&nbsp;
      </td>
      
      <td>
      	<img src="images/ftrMenuSeparator.gif" width="1" height="16" alt="" />
      </td>
    </tr>
  </table>