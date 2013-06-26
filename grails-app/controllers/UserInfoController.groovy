/*************************************************************************
 * tranSMART - translational medicine data mart
 * 
 * Copyright 2008-2012 Janssen Research & Development, LLC.
 * 
 * This product includes software developed at Janssen Research & Development, LLC.
 * 
 * This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License 
 * as published by the Free Software  * Foundation, either version 3 of the License, or (at your option) any later version, along with the following terms:
 * 1.	You may convey a work based on this program in accordance with section 5, provided that you retain the above notices.
 * 2.	You may convey verbatim copies of this program code as you receive it, in any medium, provided that you retain the above notices.
 * 
 * This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS    * FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.
 * 
 *
 ******************************************************************/
  

 /**
 * $Id:  $
 * @author $Author:  $
 * @version $Revision:  $
 */

/**
 * Login Controller
 */
class UserInfoController {
    /**
     * Dependency injection for the springSecurityService.
	 */
    def springSecurityService

	static Map allowedMethods = [edit: 'POST', update: 'POST', edit_pswd: 'POST', update_pswd: 'POST']
	
	def index = {
		redirect action: show, params: params
	}
	
	def show = {
		flash.message = ''
		def person = AuthUser.get(springSecurityService.currentUser.id)
		if ( !springSecurityService.isLoggedIn() || !person || person.username.equals("guest") ) {
			redirect uri: '/login/forceAuth'
			return
		}

		[person: person]
	}
	
	def edit = {
		flash.message = ''
		def person = AuthUser.get(springSecurityService.currentUser.id)
		if ( !springSecurityService.isLoggedIn() || !person || person.username.equals("guest") ) {
			redirect uri: '/login/forceAuth'
			return
		}
		
		return [person: person]
	}
	
	def update = {
		def person = AuthUser.get(springSecurityService.currentUser.id)
		if ( !springSecurityService.isLoggedIn() || !person || person.username.equals("guest") ) {
			redirect uri: '/login/forceAuth'
			return
		}
		
		person.properties = params
		
		if ( params.current_passwd.equals("") ) {
			flash.message = "Please enter your password"
			render view: 'edit', model: [person: person, password_error: true]
			return
		}
		
		def encoded_password = springSecurityService.encodePassword(params.current_passwd)
		if(!encoded_password.equals(person.getPersistentValue("passwd")))	{
			flash.message = "Incorrect password "
			render view: 'edit', model: [person: person, password_error: true]
			return
		}
		
		def msg = new StringBuilder("${person.username} has been updated.  Changed fields include: ")
		def modifiedFieldNames = person.getDirtyPropertyNames()
		for (fieldName in modifiedFieldNames)	{
			def currentValue =person."$fieldName"
			def origValue = person.getPersistentValue(fieldName)
			if (currentValue != origValue)	{
				msg.append(" ${fieldName} ")
			}
		}
		
		if (person.save()) {
			new AccessLog(username: springSecurityService.getPrincipal().username, event:"User Updated",
				eventmessage: msg,
				accesstime:new Date()).save()
			redirect action: show
			return
		}
		else {
			render view: 'edit', model: [person: person]
			return
		}
	}
	
	def edit_pswd = {
		flash.message = ''
		def person = AuthUser.get(springSecurityService.currentUser.id)
		if ( !springSecurityService.isLoggedIn() || !person || person.username.equals("guest") ) {
			redirect uri: '/login/forceAuth'
			return
		}
		
		[person: person]
	}
	
	def update_pswd = {
		def person = AuthUser.get(springSecurityService.currentUser.id)
		if ( !springSecurityService.isLoggedIn() || !person || person.username.equals("guest") ) {
			redirect uri: '/login/forceAuth'
			return
		}
		
		if ( params.current_passwd.equals("") ) {
			flash.message = "Please enter your current password"
			render view: 'edit_pswd', model: [person: person, current_password_error: true]
			return
		}
		
		def encoded_password = springSecurityService.encodePassword(params.current_passwd)
		if(!encoded_password.equals(person.getPersistentValue("passwd")))	{
			flash.message = "Incorrect password "
			render view: 'edit_pswd', model: [person: person, current_password_error: true]
			return
		}
		
		if ( params.passwd.equals("") ) {
			flash.message = "New password cannot be empty"
			render view: 'edit_pswd', model: [person: person, password_error: true]
			return
		}
		
		if ( !params.passwd.equals( params.passwd2 ) ) {
			flash.message = "New passwords don't match"
			render view: 'edit_pswd', model: [person: person, password2_error: true]
			return
		}
		
		person.passwd = springSecurityService.encodePassword(params.passwd)
		
		def msg = new StringBuilder("${person.username} has been updated.  Changed fields include: ")
		def modifiedFieldNames = person.getDirtyPropertyNames()
		for (fieldName in modifiedFieldNames)	{
			def currentValue =person."$fieldName"
			def origValue = person.getPersistentValue(fieldName)
			if (currentValue != origValue)	{
				msg.append(" ${fieldName} ")
			}
		}
		
		if (person.save()) {
			new AccessLog(username: springSecurityService.getPrincipal().username, event:"User Updated",
				eventmessage: msg,
				accesstime:new Date()).save()
			flash.message = "Your password was successfully changed"
			render view: 'show', model: [person: person]
			return
		}
		else {
			render view: 'edit_pswd', model: [person: person]
			return
		}
		
	}
}
