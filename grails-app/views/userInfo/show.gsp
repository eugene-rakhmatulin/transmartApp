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

			<div class="body">
				<h1>${person.userRealName?.encodeAsHTML()}'s user information</h1>
				<g:if test="${flash.message}">
				<div class="message">${flash.message}</div>
				</g:if>
				<div class="dialog">
					<table>
					<tbody>
	
						<tr class="prop">
							<td valign="top" class="name">Login Name:</td>
							<td valign="top" class="value">${person.username?.encodeAsHTML()}</td>
						</tr>
	
						<tr class="prop">
							<td valign="top" class="name">Full Name:</td>
							<td valign="top" class="value">${person.userRealName?.encodeAsHTML()}</td>
						</tr>
	
						<tr class="prop">
							<td valign="top" class="name">Description:</td>
							<td valign="top" class="value">${person.description?.encodeAsHTML()}</td>
						</tr>
	
						<tr class="prop">
							<td valign="top" class="name">Email:</td>
							<td valign="top" class="value">${person.email?.encodeAsHTML()}</td>
						</tr>
	
						<tr class="prop">
							<td valign="top" class="name">Show Email:</td>
							<td valign="top" class="value">${person.emailShow}</td>
						</tr>
	
							
						<tr class="prop">
							<td colspan=2><br/><b>The following information can be changed by tranSMART administrator only</b></td>
						</tr>
	
						<tr class="prop">
							<td valign="top" class="name">Roles:</td>
							<td valign="top" class="value">
								<ul>
								<g:each in="${roleNames}" var='name'>
									<li>${name}</li>
								</g:each>
								</ul>
							</td>
						</tr>
								<tr class="prop">
							<td valign="top" class="name">Groups:</td>
							<td valign="top" class="value">
								<ul>
								<g:each in="${person.groups}" var='group'>
									<li><g:link controller="userGroup" action="show" id="${group.id}">${group.name}</g:link></li>
								</g:each>
								</ul>
							</td>
						</tr>
							<tr class="prop">
							<td valign="top" class="name">Studies Assigned:</td>
							<td valign="top" class="value">
								<ul>
								<g:each in="${SecureObjectAccess.findAllByPrincipal(person,[sort:accessLevel])}" var='soa'>
									<li>${soa.getObjectAccessName()}</li>
								</g:each>
								</ul>
							</td>
						</tr>
						</tr>
							<tr class="prop">
							<td valign="top" class="name">Studies with Access(via groups):</td>
							<td valign="top" class="value">
								<ul>
								<g:each in="${AuthUserSecureAccess.findAllByAuthUser(person,[sort:accessLevel])}" var='soa'>
									<li><g:link controller="secureObject" action="show" id="${soa.secureObject.id}"> ${soa.getObjectAccessName()}</g:link></li>
								</g:each>
								</ul>
							</td>
						</tr>
					</tbody>
					</table>
				</div>
	
				<div class="buttons">
					<g:form>
						<span class="button"><g:actionSubmit class="edit" value="Edit" /></span>
						<span class="button"><g:actionSubmit class="edit" value="Change password" action="edit_pswd" /></span>
					</g:form>
				</div>
	
			</div>
		
		</div>
    </body>
</html>