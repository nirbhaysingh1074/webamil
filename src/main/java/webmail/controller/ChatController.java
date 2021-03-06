package webmail.controller;

import java.security.Principal;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.jivesoftware.smack.XMPPConnection;
import org.jivesoftware.smack.SmackException.NotConnectedException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import webmail.bean.NPCompare;
import webmail.chatdwr.ScriptSessList;
import webmail.chatdwr.XmppChatClass;
import webmail.webservice.client.WebmailClient;
import webmail.wsdl.GetVCFLdapDirResponse;
import webmail.wsdl.VCFLdapDirAtt;

@Controller
public class ChatController {
	
	@Autowired private ScriptSessList scriptSessList;
	
	@Value ("${xmppDomain}") private String xmppDomain;
	@Value ("${packetReplyTimeout}") private int packetReplyTimeout; // millis
	@Value ("${chatImageFolder}") private String chatImageFolder;
	@Value ("${onlineStatus}") private String onlineStatus;
	@Value ("${awayStatus}") private String awayStatus;
	@Value ("${dndStatus}") private String dndStatus;
	@Autowired
	private WebmailClient webmailClient;
	
	
	
	//
	@RequestMapping(value = "/getAllUserListChat", method = RequestMethod.GET)
    public @ResponseBody String getAllUserListChat( HttpServletRequest request)
    {   
		String serchCnt=request.getParameter("serchCnt");
		String res="";
		HttpSession hs=request.getSession();
		String host=(String)hs.getAttribute("host");
		String id=(String)hs.getAttribute("id");
		String pass=(String)hs.getAttribute("pass");
		String ldapurl=(String)hs.getAttribute("ldapurl");
		String ldpabase=(String)hs.getAttribute("ldapbase");
		//System.out.println("!!!!!!!!!!!! ldap dn="+ldpabase);
		
		
		
		GetVCFLdapDirResponse getdirres=webmailClient.getLdapDirectory(ldapurl, id, pass, ldpabase, serchCnt+"*");
		
		List<VCFLdapDirAtt> ldapDirList=getdirres.getGetVCFLdapDirByParentFile().getVCFLdapDirListResult().getVCFLdapDirList();
		
		Collections.sort(ldapDirList,new NPCompare());
		for(VCFLdapDirAtt ulst : ldapDirList)
		{
			String photo="chat/photo.jpg";
			String email=ulst.getContactEmail();
			String name=ulst.getContactName();
			if(ulst.getContactPhoto()!=null && ulst.getContactPhoto().length()>0)
			{
				photo="data:image/jpg;base64,"+ulst.getContactPhoto();
			}
			
			
			res+="<div class='cheat_row_11'><div class='small_images'> <img src='"+photo+"' class='user_images'>	</div>"+
			"<div id='serchContactAndFill' class='contact_information'><p><strong>"+name+"</strong><br><span>"+email+"</span>	</p></div></div>";				
					
		}
			
		
		return res;
    }
	
	
@RequestMapping(value = "/chatout", produces = "text/html; charset=UTF-8", method = RequestMethod.GET)
	
	public String chatout(ModelMap map, Principal principal, HttpServletRequest request) 
	{
		//System.out.println("compose controller");
	HttpSession hs=request.getSession();
	boolean st=(boolean)hs.getAttribute("chatStatus");
	
	if(st)
	{
	hs.setAttribute("chatStatus",false);
    XMPPConnection xmppChatClass=(XMPPConnection)hs.getAttribute("xmppConnection");
	if(xmppChatClass!=null){
		try {
			xmppChatClass.disconnect();
		} catch (NotConnectedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	}
	return "chatout";
		//return new ModelAndView("chatContent", map);
	}
	
	
@RequestMapping(value = "/openChatBody", produces = "text/html; charset=UTF-8", method = RequestMethod.GET)
	
	public ModelAndView openChatBody(ModelMap map, Principal principal, HttpServletRequest request) 
	{
	HttpSession hs=request.getSession();
	boolean st=(boolean)hs.getAttribute("chatStatus");

	if(st)
	{
		map.addAttribute("webmailClient", webmailClient);
		//return "chatContent";
		return new ModelAndView("chatContent", map);
	}
	else
	{
		return new ModelAndView("chatout", map);
	}
	
	
	}


@RequestMapping(value = "/chatSignin", produces = "text/html; charset=UTF-8", method = RequestMethod.GET)

public ModelAndView chatSignin(ModelMap map, Principal principal, HttpServletRequest request) 
{


	HttpSession hs=request.getSession();
	String id = (String) hs.getAttribute("id");
	String pass = (String) hs.getAttribute("pass");
	String chathost=(String) hs.getAttribute("chathost");
	boolean st=true;
	
	try
	{
	XmppChatClass xmppChatClass=new XmppChatClass();
	
	//TODO: SEPERATE THE CONFIGURATION
	String		xmppDomain=id.substring(id.indexOf("@")+1);
	
	xmppChatClass.createConnection(chathost,xmppDomain, packetReplyTimeout, request);
	xmppChatClass.registerListeners(chatImageFolder);
	//xmppChatClass.performLogin(loginUser.getUserid(), loginUser.getPassword(), onlineStatus);
	xmppChatClass.performLogin(id, pass, onlineStatus);
	scriptSessList.listenScriptSession();
	hs.setAttribute("xmppChatClass", xmppChatClass);
	hs.setAttribute("chatStatus",true);
	//map.addAttribute("imageurl", chatImageFolder);
	}
	catch(Exception ex)
	{
		st=false;
		hs.setAttribute("chatStatus",false);
	}
	
	if(st)
	{
		map.addAttribute("webmailClient", webmailClient);
		//return "chatContent";
		return new ModelAndView("chatContent", map);
	}
	else
	{
		return new ModelAndView("chatout", map);
	}
	
}
	
	
	@RequestMapping(value = "/sendChatMessage", method = RequestMethod.GET)
    public @ResponseBody String sendChat(@RequestParam Map<String,String> requestParams, HttpServletRequest request)
    {   
		String message=requestParams.get("message");
		String buddyJID=requestParams.get("buddyJID");
		XmppChatClass xmppChatClass=(XmppChatClass)request.getSession().getAttribute("xmppChatClass");
		xmppChatClass.sendChatMessages(message, buddyJID); 
		return "success";
    }
	
	@RequestMapping(value = "/inviteBuddy", method = RequestMethod.GET)
    public @ResponseBody String sendInvite(@RequestParam(value="buddyJID")String buddyJID, HttpServletRequest request){  
		XmppChatClass xmppChatClass=(XmppChatClass)request.getSession().getAttribute("xmppChatClass");
		xmppChatClass.sendInvite(buddyJID);
		return "Invited Successfully";
    }
	
	@RequestMapping(value = "/respondFrndReq", method = RequestMethod.GET)
    public @ResponseBody String respondToReq(@RequestParam(value="fromJID")String fromJID, HttpServletRequest request){ 
		XmppChatClass xmppChatClass=(XmppChatClass)request.getSession().getAttribute("xmppChatClass");
		xmppChatClass.acceptFrndReq(fromJID);
		return "Friend Request Accepted Successfully!";
    }
	
	@RequestMapping(value = "/denyFrndReq", method = RequestMethod.GET)
    public @ResponseBody String denyToReq(@RequestParam(value="fromJID")String fromJID, HttpServletRequest request){ 
		XmppChatClass xmppChatClass=(XmppChatClass)request.getSession().getAttribute("xmppChatClass");
		xmppChatClass.denyFrndReq(fromJID);
		return "Friend Request Refused!";
    }
	
	@RequestMapping(value = "/logoutChat", method = RequestMethod.GET)
    public @ResponseBody String closeChat(HttpServletRequest request){  
		System.out.println("in logout chat");
		XmppChatClass xmppChatClass=(XmppChatClass)request.getSession().getAttribute("xmppChatClass");
		xmppChatClass.closeConnection();
		return "successful log out";
    }
	
	@RequestMapping(value = "/reconnectChat", method = RequestMethod.GET)
    public @ResponseBody String reconnectChat(HttpServletRequest request){  
				System.out.println("in reconnectChat");
				HttpSession hs=request.getSession();
				String chathost=(String) hs.getAttribute("chathost");
				XmppChatClass xmppChatClass=new XmppChatClass();
				//TODO: SEPERATE THE CONFIGURATION
				xmppChatClass.createConnection(chathost,xmppDomain, packetReplyTimeout, request);
				xmppChatClass.registerListeners(chatImageFolder);
				//xmppChatClass.performLogin(loginUser.getUserid(), loginUser.getPassword(), onlineStatus);
				xmppChatClass.performLogin("nirbhay@silvereye.in", "yahoo@2009", onlineStatus);
				scriptSessList.listenScriptSession();
				request.getSession().setAttribute("xmppChatClass", xmppChatClass);
		        return "successfully reconnected";
    }
	
	@RequestMapping(value = "/changedPresence", method = RequestMethod.GET)
    public @ResponseBody void changePresenceInfo(@RequestParam(value="presmode")String presmode, HttpServletRequest request){  
		XmppChatClass xmppChatClass=(XmppChatClass)request.getSession().getAttribute("xmppChatClass");
		xmppChatClass.sendChangePresence(presmode, onlineStatus, awayStatus, dndStatus);
    }

}
