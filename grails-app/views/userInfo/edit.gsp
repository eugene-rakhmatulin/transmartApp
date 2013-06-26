<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        
		<link rel="stylesheet" href="${resource(dir:'js', file:'ext/resources/css/ext-all.css')}"></link>
		<link rel="stylesheet" href="${resource(dir:'js', file:'ext/resources/css/xtheme-gray.css')}"></link>
		<link rel="stylesheet" href="${resource(dir:'css', file:'main.css')}"></link>
        
        <g:javascript library="prototype" />
		<script type="text/javascript" src="${resource(dir:'js', file:'ext/adapter/ext/ext-base.js')}"></script>
		<script type="text/javascript" src="${resource(dir:'js', file:'ext/ext-all.js')}"></script>
        <script type="text/javascript" src="${resource(dir:'js', file:'utilitiesMenu.js')}"></script>
        <script type="text/javascript" charset="utf-8">
        Ext.BLANK_IMAGE_URL = "${resource(dir:'js', file:'ext/resources/images/default/s.gif')}";
        
		Ext.onReady(function(){			
            var helpURL = '${grailsApplication.config.com.recomdata.searchtool.adminHelpURL}';
            var contact = '${grailsApplication.config.com.recomdata.searchtool.contactUs}';
            var appTitle = '${grailsApplication.config.com.recomdata.searchtool.appTitle}';
            var buildVer = 'Build Version: <g:meta name="environment.BUILD_NUMBER"/> - <g:meta name="environment.BUILD_ID"/>';
			
			var viewport = new Ext.Viewport({
				layout: "border",
				items:[new Ext.Panel({                          
					   region: "center",
					   tbar: createUtilitiesMenu(helpURL, contact, appTitle,'${request.getContextPath()}', buildVer, 'utilities-div'), 
					   contentEl: "header-div"
				    })
		        ]
			});
			viewport.doLayout();
		});
        </script>
        
        <title>User info</title>
    </head>
    <body>
		<div id="header-div">
			<g:render template="/layouts/commonheader" />
		
			<div class="body" width="90%">
				<h1>${person.userRealName?.encodeAsHTML()}'s user information edit</h1>
				<g:if test="${flash.message}">
				<div class="message">${flash.message}</div>
				</g:if>
				
				<g:form>
					<div class="dialog">
						<table>
						<tbody>
	
							<tr class="prop">
								<td valign="top" class="name"><label for="username">Login Name:</label></td>
								<td valign="top" class="value">${person.username?.encodeAsHTML()}</td>
							</tr>
		
							<tr class="prop">
								<td valign="top" class="name"><label for="userRealName">Full Name:</label></td>
								<td valign="top" class="value ${hasErrors(bean:person,field:'userRealName','errors')}">
									<input type="text" id="userRealName" name="userRealName" value="${person.userRealName?.encodeAsHTML()}" size="30"/>
								</td>
							</tr>
		
							<tr class="prop">
								<td valign="top" class="name"><label for="description">Description:</label></td>
								<td valign="top" class="value ${hasErrors(bean:person,field:'description','errors')}">
									<input type="text" id="description" name="description" value="${person.description?.encodeAsHTML()}" size="100"/>
								</td>
							</tr>
		
							<tr class="prop">
								<td valign="top" class="name"><label for="email">Email:</label></td>
								<td valign="top" class="value ${hasErrors(bean:person,field:'email','errors')}">
									<input type="text" id="email" name="email" value="${person?.email?.encodeAsHTML()}" size="50"/>
								</td>
							</tr>
		
							<tr class="prop">
								<td valign="top" class="name"><label for="emailShow">Show Email:</label></td>
								<td valign="top" class="value ${hasErrors(bean:person,field:'emailShow','errors')}">
									<g:checkBox name="emailShow" value="${person.emailShow}"/>
								</td>
							</tr>
							
							<tr class="prop">
								<td colspan=2><br/><b>Enter your password to apply changes</b></td>
							</tr>
							
							<tr class="prop">
								<td valign="top" class="name"><label for="current_passwd">Password:</label></td>
								<td valign="top" class="value <g:if test="${password_error}">errors</g:if>">
									<input type="password" id="current_passwd" name="current_passwd" size="30"/>
								</td>
							</tr>
		
						</tbody>
						</table>
					</div>
		
					<div class="buttons">
						<span class="button"><g:actionSubmit class="save" value="Update" action="update" /></span>
						<span class="button"><g:actionSubmit class="cancel" value="Cancel" action="show" /></span>
					</div>
		
				</g:form>
	
			</div>
		
		</div>
    </body>
</html>