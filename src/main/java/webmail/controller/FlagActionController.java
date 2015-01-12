package webmail.controller;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import webmail.webservice.client.FolderClient;
import webmail.wsdl.RemoveWebmailFlagResponse;
import webmail.wsdl.SetWebmailFlagResponse;
import webmail.wsdl.SetWebmailFlageRequest;


@Controller
public class FlagActionController {


	@Autowired
	private FolderClient folderClient;
	
	@RequestMapping(value = "/webmailFlagAtion", method = RequestMethod.GET)
	@ResponseBody
	public String mailFlagAction(ModelMap map, Principal principal, HttpServletRequest request) 
	{
		boolean status=false;
		String fldrnm= request.getParameter("folder");
		String flagtp= request.getParameter("flagtp");
		String uid= request.getParameter("uid");
		HttpSession hs=request.getSession();
		String host=(String)hs.getAttribute("host");
		String id=(String)hs.getAttribute("id");
		String pass=(String)hs.getAttribute("pass");
		String port=(String)hs.getAttribute("port");
		if(flagtp.equalsIgnoreCase("set"))
		{
			SetWebmailFlagResponse sflag=folderClient.setFlagActionRequest(host, port, id, pass, fldrnm, uid);
			status=sflag.isSetFlagStatus();
		}
		else if(flagtp.equalsIgnoreCase("remove"))
		{
			RemoveWebmailFlagResponse rflag=folderClient.removeFlagActionRequest(host, port, id, pass, fldrnm, uid);
			status=rflag.isRemoveFlagStatus();
		}
		
		return ""+status;
	}
	
}
