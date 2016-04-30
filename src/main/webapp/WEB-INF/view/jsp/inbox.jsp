<%@page import="webmail.wsdl.VCFLdapDirAtt"%>
<%@page import="java.util.Collections"%>
<%@page import="webmail.bean.NPCompare"%>
<%@page import="java.util.List"%>
<%@page import="webmail.wsdl.GetVCFLdapDirResponse"%>
<%@page import="webmail.webservice.client.WebmailClient"%>
<%@page import="org.jivesoftware.smack.tcp.XMPPTCPConnection"%>
<%@page import="org.jivesoftware.smack.XMPPConnection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.jivesoftware.smack.packet.Presence"%>
<%@page import="org.jivesoftware.smack.RosterEntry"%>
<%@page import="java.util.Collection"%>
<%@page import="org.jivesoftware.smack.Roster"%>
<%@page import="webmail.bean.MailAccSetting"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>


<script type="text/javascript">
function keyPresChatSearch(e) {
	 var charKeyCode = e.keyCode ? e.keyCode : e.which;
	
	 if(charKeyCode == 13)
	    {
		 getAllUserListChat();
	    }
}

function getAllUserListChat()
	{
	var serchCnt=$("#serchCntId").val();
	if(serchCnt!=null && serchCnt!="")
		{
		document.getElementById('action_gif').style.display= 'block';
		$.ajax({
			type : "GET",
			url : "${pageContext.request.contextPath}/getAllUserListChat",
			data : {
				
				'serchCnt' : serchCnt
			},
			success : function(data) {
			$("#np_chat_searchajax").html(data);
			$("#np_chat_search").hide();
			$("#np_chat_searchajax").show();
			document.getElementById('action_gif').style.display= 'none';
		}
		});
		}
	}
	function getChatBox(username) {
		var box = null;
		var chatname = username.split("name");
		var userchatid = username.split("@");

		var imagesrc = document.getElementById(chatname[0] + "presence").src;
		var imagesp = imagesrc.split("images/");
		var image = imagesp[1];

		var id = "#" + userchatid[0] + "open_chat_box";
		$("#appendchatdiv").append(
				"<div id='"+userchatid[0]+"open_chat_box'></div>");

		$(id).append("<div id='"+userchatid[0]+"chat_div'></div>");
		var chatdivid = "#" + userchatid[0] + "chat_div";

		box = $(chatdivid).chatbox({
			/*
				unique id for chat box
			 */
			id : "me",
			user : {
				key : "value"
			},
			/*
				Title for the chat box
			 */
			title : chatname[0],
			imagenm : image,
			/*
				messageSend as name suggest,
				this will called when message sent.
			 */
			messageSent : function(id, user, msg) {
				$(chatdivid).chatbox("option", "boxManager").addMsg(id, msg,chatdivid);
			}
		});
	}
</script>
<script language="javascript">
	function onloadmethod() {
		dwr.engine.setActiveReverseAjax(true);
		document.getElementById("onlineradio").checked = true;
	}
</script>

<script type="text/javascript">
	function updateChatBox(msglist) {
		var id = "#" + msglist[0] + "chat_div";
		id=id.replace('.','\\.');
		var boxid = msglist[0] + "chatboxcreated";
		
		var elementExists = document.getElementById(boxid);
		boxid=boxid.replace('.','\\.');
		var isvis = $("#" + boxid).is(":visible");
		if (elementExists == null) {
			document.getElementById(msglist[2] + "name").click();
		} else if (!isvis) {
			document.getElementById(boxid).style.display = "block";
		}
		var chk=0;
		try
		{
		var hid_id=$("#"+boxid).children('.new_header_top').children('span').children('.hid_chat_nm').html();
		if(hid_id==msglist[4])
			{
			$(id).append(msglist[3]);
			chk=1;
			}
		else
			{
			$(id).append(msglist[1]);
			chk=1;
			$("#"+boxid).children('.new_header_top').children('span').children('.hid_chat_nm').html(msglist[4]);
			}
		}
		catch (e) {
			if(chk==0)
				$(id).append(msglist[1]);
			// TODO: handle exception
		}
		var divid = msglist[0] + "chat_div";
		//divid=divid.replace('.','\\.');
		var divv = document.getElementById(divid);
		if (divv.scrollHeight > divv.clientHeight) {
			divv.scrollTop = divv.scrollHeight;
		}
	}
</script>

<script type="text/javascript">
	function removeLastAppended(anyid) {
	//	alert("yo");
		var id = "#" + anyid;
		$(id).remove();
	}
</script>

<script type="text/javascript">
	function sendBuddyInvite() {
		var buddyId = $("#buddyInvite").attr('val');
	//	alert(buddyId);
		$.ajax({
			url : "${pageContext.request.contextPath}/inviteBuddy",
			data : {
				buddyJID : buddyId,
			},
			success : function(data) {
				$("#buddyInvite").val("");
				showmsg("success",data);
			}
		});
	}
</script>

<script type="text/javascript">
	function friendRequest(from) {
		var acceptfrom = from.split("acceptbtn");
		$.ajax({
			url : "${pageContext.request.contextPath}/respondFrndReq",
			data : {
				fromJID : acceptfrom[0],
			},
			success : function(data) {
				showmsg('success',data);
			}
		});
	}
</script>

<script type="text/javascript">
	function friendDeny(from) {
		var acceptfrom = from.split("denybtn");
		$.ajax({
			url : "${pageContext.request.contextPath}/denyFrndReq",
			data : {
				fromJID : acceptfrom[0],
			},
			success : function(data) {
				showmsg('success',data);
			}
		});
	}
</script>

<script type="text/javascript">
	function createChatRow(addDivs) {
		//alert("sdfasd");
		
		$(".chat_inner_content").html(addDivs);
		//document.getElementById("test").innerHTML = addDivs;
	}
</script>

<script type="text/javascript">
	function closeConnection() {
		$.ajax({
			url : "${pageContext.request.contextPath}/logoutChat",
			success : function(data) {
			}
		});

	}
</script>

<script type="text/javascript">
	function reconnectConnection() {
		$.ajax({
			url : "${pageContext.request.contextPath}/reconnectChat",
			success : function(data) {
			}
		});

	}
</script>

<script type="text/javascript">
	function changePresence(pres) {
		//var pres = document.getElementById("statusChangeSelect").value;
	//	alert(pres);
		if(pres=="offline"){
		$("img.online_green_1").attr("src","chat/offline.png");
		}else if(pres=="online"){
			$("img.online_green_1").attr("src","chat/green.png");
	}else if(pres=="dnd"){
		$("img.online_green_1").attr("src","chat/block.png");
}else if(pres=="away"){
	$("img.online_green_1").attr("src","chat/busy.png");}
		$.ajax({
			url : "${pageContext.request.contextPath}/changedPresence",
			data : {
				presmode : pres,
			},
			success : function(data) {
			}
		});
	}
</script>

<script type="text/javascript">
	function getAltImage(imgid) {
		var pic = document.getElementById(imgid);
		pic.src = "images/blank_man.jpg"
	}
</script>





<script type="text/javascript">
function sendresponse(id)
{
    var respond_to =$('#hid_cal_inv_from').val();
    var uuid = $('#hid_cal_inv_uuid').val();
   
    document.getElementById('mail_sending').style.display= 'block';
    $.ajax({
        type: "POST",
        url: "${pageContext.request.contextPath}/sendInvitationResponse",
        data: {'respond_to':respond_to,'reply_status':id,'uuid':uuid},
        success: function (data) 
        {
              document.getElementById('mail_sending').style.display= 'none';
              var success = generate_in('alert');
              $.noty.setText(success.options.id, "Response mail send successfully !");
              setTimeout(function () {  $.noty.close(success.options.id); }, 5000);
         }
        });
}


</script>
<script type="text/javascript">
function saveEDMSMailAttachByName(uid,nm) {
		document.getElementById('action_gif').style.display= 'block';
		$.ajax({
			type : "GET",
			url : "${pageContext.request.contextPath}/saveEDMSMailAttachByName",
			data : {
				'uid' : uid,'nm':nm
				},
			contentType : "application/json",
			success : function(data) {
				
				document.getElementById('action_gif').style.display= 'none';
				if(data=="true" || data=="TRUE")
					{
					var success = generate_in('alert');
					 $.noty.setText(success.options.id, "Saved successfully.");
					 setTimeout(function () {  $.noty.close(success.options.id); }, 4000);
					}
			}	
			
		});
		
}

function viewMailAttachByName(uid,nm)
{
	//alert(uid+"---"+nm);
var arr=nm.split(".");
var ext=arr[arr.length-1];
if(ext=="png" || ext=="PNG" || ext=="jpg" || ext=="JPG" || ext=="jpeg" || ext=="JPEG" || ext=="gif" || ext=="GIF")
	{
	//window.target="_blank";
	//window.location = "${pageContext.request.contextPath}/viewattachment?uid="+uid+"&nm="+nm;
	// window.location="http://www.smkproduction.eu5.org"; 
	var uri = nm;
	var res = encodeURIComponent(uri);
	window.open("${pageContext.request.contextPath}/viewattachment?uid="+uid+"&nm="+res,'_blank');
	/* $.ajax({
		type : "GET",
		url : "${pageContext.request.contextPath}/viewIMGMailAttachByName",
		data : {
			'uid' : uid,'nm':nm
			},
		contentType : "application/json",
		success : function(data) {
			
			alert(data);
			var str="<img src='data:image/jpg;base64,"+data+" ' />";
			$("#hid_img_disp").show();
			$("#hid_img_disp").html(str);
			//window.open('${pageContext.request.contextPath}/js/web/viewer.html?file='+data, '_blank');
		}	
		
	}); */
	}
else
	{
	$.ajax({
		type : "GET",
		url : "${pageContext.request.contextPath}/viewMailAttachByName",
		data : {
			'uid' : uid,'nm':nm
			},
		contentType : "application/json",
		success : function(data) {
			
		//	alert(data);
		if(data=="notsupported")
			{
			var success = generate_in('alert');
				 $.noty.setText(success.options.id, "File format not supported to view");
				 setTimeout(function () {  $.noty.close(success.options.id); }, 4000);
			}
		else
			{
			var uri = data;
			var res = encodeURIComponent(uri);
			window.open('${pageContext.request.contextPath}/js/web/viewer.html?file='+res, '_blank');
			}
		}	
		
	});
	}
}
function getUnreadMailCountInbox() {
	
	$.ajax({
		type : "GET",
		url : "${pageContext.request.contextPath}/getUnreadMailCountInbox",
		data : {
			'fdr' : 'inbox'
			},
		contentType : "application/json",
		success : function(data) {
			
			$("#hid_unread_inbox").val(data);
			
		}
	});
}
function getAllMailCountCurrent(folderPath){
	//alert("meeeeeeeeeeeeeeeeeeeSub="+folderPath);
	 $.ajax({
         type: "GET",
         url: "${pageContext.request.contextPath}/getAllMailCountInfolderDiv",
         data: {'path':folderPath},
         contentType: "application/json",
         success: function (data) {
        	 var arr=data.split("$");
           
           document.getElementById("hid_pagi_allmail").value=arr[1];
           var all=parseInt(arr[1]);
           var msg="";
           if(all>0)
        	   {
        	var pcnt=parseInt(document.getElementById("hid_pagi_pcnt").value);
        	var cntlmt=parseInt($("#hid_mail_list_limit").val());
        	pcnt--;
        	var start=pcnt*cntlmt+1;
        	var end=start+cntlmt-1;
        	if(end>all)
        		{
        		end =all;
        		}
        	 	msg=start+" - "+end +" of "+all;
        	   }
           else
        	   {
        	   msg=folderPath+" is empty.";
        	   }
           $("#pagination_div").html(msg);
           $("#pagination_div").attr('title', msg);
         }
     });
	
}
/* 

function notifyMe(fid, sub) {
	  if (!window.Notification) {
	    alert('Desktop notifications not available in your browser.'); 
	    return;
	  }

	  if (window.Notification.permission !== "granted")
		  window.Notification.requestPermission();
	  else {
	    var notification = new Notification('New mail Notification', {
	     	icon: 'images/logo_login.png',
	    	body: "Form: "+fid+"\nSubject: "+sub,
	    });

	  
	    
	  }

	}  */

function autoWebmailInboxRefreshNP(sub, fid) {
//alert("all");
	
		var cnt=0; 
var hid_dnoti="New mail notifications on";
	try
	{
	hid_dnoti=$("#hid_dnoti").val();
	}
	catch (e) {
		// TODO: handle exception
	}

	$.ajax({
		type : "GET",
		url : "${pageContext.request.contextPath}/getUnreadMailCountInbox",
		data : {
			'fdr' : 'inbox'
			},
		contentType : "application/json",
		success : function(data) {
			
			cnt=parseInt(data);
		 $("#hid_unread_inbox").val(cnt);
			var pfldr=document.getElementById('hid_active_fldr').value	;
			
			if( ( $('#hid_open_setting').val()!="true" ) && ($('#hid_open_search').val()!="true")) //&& ($('#div_for_compose').css('display')!='block' || $('#div_for_compose').css('display')=='none'))
				{
				
				if(pfldr=="INBOX" || pfldr=="Inbox" || pfldr=="inbox")
				{
					//getAllMailCountCurrent(pfldr);
					
					
					
					 $.ajax({
         type: "GET",
         url: "${pageContext.request.contextPath}/getAllMailCountInfolderDiv",
         data: {'path':pfldr},
         contentType: "application/json",
         success: function (data) {
        	 var arr=data.split("$");
           var msg="";
           document.getElementById("hid_pagi_allmail").value=arr[1];
           var all=parseInt(arr[1]);
          
         
			if(all>0)
       	   {
			var start='0';    //''+sml;
			var end=parseInt($("#hid_mail_list_limit").val());
			var pcnt=parseInt(document.getElementById("hid_pagi_pcnt").value);
			var pview=document.getElementById("hid_previewPane").value;
			if(pcnt==1)
				{
				
	        	if(end>all)
	        		{
	        		end =all;
	        		}
	        	end=end-1;
	        	$.ajax({
					type : "GET",
					url : "${pageContext.request.contextPath}/getMailInbox",
					data : {
						'folder' : pfldr,
						'start' : start,
						'end' : end,
						'pview' : pview
					},
					contentType : "application/json",
					success : function(data) {
						// $("#fileSystem").html(data);
						// alert(data);
						window.prevflg="true";
						window.nextflg="true";
						start++;
						end++;
						msg=start+" - "+end +" of "+all;
						$("#unread_inbox").html("("+cnt+")");
						  $("#pagination_div").html(msg);
				           $("#pagination_div").attr('title', msg);
						
						$("#inb_cnt_div").html(data);
						$(".small_image_flag").css("color",$("#hid_mail_bgColor").val());
		            	$(".new_flag_color").css("color",$("#hid_mail_bgColor").val());
						//document.getElementById('action_gif').style.display= 'none';
						//notifyMe(fid, sub)
						
						try
						{
						if(hid_dnoti=="New mail notifications on")
							{
							if (!window.Notification) {
								  //  alert('Desktop notifications not available in your browser.'); 
								    return;
								  }

								  if (window.Notification.permission !== "granted")
									  window.Notification.requestPermission();
								  else {
								    var notification = new Notification('New mail Notification', {
								     	icon: 'images/logo_login.png',
								    	body: "Form: "+fid+"\nSubject: "+sub,
								    });

								  
								    
								  }
							}
						}
						catch (e) {
							// TODO: handle exception
						}
						
					}
				});
				}
			else
				{
				
	        	var cntlmt=parseInt($("#hid_mail_list_limit").val());
	        	pcnt--;
	        	start=pcnt*cntlmt;
	        	end=start+cntlmt;
	        	if(end>all)
	        		{
	        		end =all;
	        		}
	        	end--;
	        	$.ajax({
					type : "GET",
					url : "${pageContext.request.contextPath}/getMailInbox",
					data : {
						'folder' : pfldr,
						'start' : start,
						'end' : end,
						'pview' : pview
					},
					contentType : "application/json",
					success : function(data) {
						// $("#fileSystem").html(data);
						// alert(data);
						window.prevflg="true";
						window.nextflg="true";
						start++;
						end++;
						msg=start+" - "+end +" of "+all;
						$("#unread_inbox").html("("+cnt+")");
						  $("#pagination_div").html(msg);
				           $("#pagination_div").attr('title', msg);
						
						$("#inb_cnt_div").html(data);
						$(".small_image_flag").css("color",$("#hid_mail_bgColor").val());
		            	$(".new_flag_color").css("color",$("#hid_mail_bgColor").val());
						//document.getElementById('action_gif').style.display= 'none';
						//notifyMe(fid, sub)
						try
						{
							if(hid_dnoti=="New mail notifications on")
							{
							if (!window.Notification) {
								//    alert('Desktop notifications not available in your browser.'); 
								    return;
								  }

								  if (window.Notification.permission !== "granted")
									  window.Notification.requestPermission();
								  else {
								    var notification = new Notification('New mail Notification', {
								     	icon: 'images/logo_login.png',
								    	body: "Form: "+fid+"\nSubject: "+sub,
								    });

								  }
								    
								  }
						}
						catch (e) {
							// TODO: handle exception
						}
					}
				});
				}
			
       	   }
         
         
         
         }
     });
					
					
				}
				else
					{
					$("#unread_inbox").html("("+cnt+")");
					//notifyMe(fid, sub)
					try
						{
						if(hid_dnoti=="New mail notifications on")
						{
						
						if (!window.Notification) {
								//    alert('Desktop notifications not available in your browser.'); 
								    return;
								  }

								  if (window.Notification.permission !== "granted")
									  window.Notification.requestPermission();
								  else {
								    var notification = new Notification('New mail Notification', {
								     	icon: 'images/logo_login.png',
								    	body: "Form: "+fid+"\nSubject: "+sub,
								    });

								  }
								    
								  }
						}
						catch (e) {
							// TODO: handle exception
						}
					}		
				}
			else
				{
				$("#unread_inbox").html("("+cnt+")");
				//notifyMe(fid, sub)
				try
						{
					if(hid_dnoti=="New mail notifications on")
					{		 
					if (!window.Notification) {
								//    alert('Desktop notifications not available in your browser.'); 
								    return;
								  }

								  if (window.Notification.permission !== "granted")
									  window.Notification.requestPermission();
								  else {
								    var notification = new Notification('New mail Notification', {
								     	icon: 'images/logo_login.png',
								    	body: "Form: "+fid+"\nSubject: "+sub,
								    });

								  }
								    
								  }
						}
						catch (e) {
							// TODO: handle exception
						}
				}
			
			
			
			
			
			
			
		}
			
			
		
	
	});
	}

	function getWebmailInbox( fdrname)
	{
		if($('#div_for_compose').css('display')=='block')
		{
			backFromComposeNew();
		}
		 else if($('#div_for_setting').css('display')=='block')
			{
			 document.getElementById('action_gif').style.display= 'block';
			 location.href ="${pageContext.request.contextPath}/inbox";
			} 
		else
			{
			
			if($('#div_full_pg_disp').css('display') == "block")	
			{
			backToMailList();
			}
			
			if(fdrname=="Junk" || fdrname=="junk")
				{
				$('#li_spam').prop('title', 'Not Spam');
				$("#img_spam").attr("src", "images/safe.png")
				}
			else
				{
				$('#li_spam').prop('title', 'Report Spam');
				$("#img_spam").attr("src", "images/restriction.png")
				}
			
	document.getElementById('div_for_setting').style.display='none';
	noneMail();
	document.getElementById('div_for_compose').style.display='none';
	var pview=document.getElementById("hid_previewPane").value;
	//alert(pview)
	document.getElementById('div_for_inbox').style.display=  'block'; 
	
	$('#hid_open_search').val("false");
	document.getElementById("hid_dt_sorting").value="up";
	document.getElementById("hid_pagi_pcnt").value='1';
	document.getElementById("dt_sorting").innerHTML="<img src='images/down_date.png'>";
	var pfldr=document.getElementById('hid_active_fldr').value
	document.getElementById('hid_active_fldr').value=fdrname;
	document.getElementById('mail_pagi').style.display= 'block';
    document.getElementById('search_pagi').style.display= 'none';
    document.getElementById('hid_pagi_search_allmail').value="";
    document.getElementById('hid_pagi_search_pcnt').value="";
    document.getElementById('hid_pagi_search_type').value="";
	//document.getElementById(pfldr).className = "";
	//document.getElementById(fdrname).className = "active_mailbox";
	
	var start='0';
	var end=$("#hid_mail_list_limit").val();
	document.getElementById('action_gif').style.display= 'block';
		$.ajax({
					type : "GET",
					url : "${pageContext.request.contextPath}/getMailInbox",
					data : {
						'folder' : fdrname,
						'start' : start,
						'end' : end,
						'pview' : pview
					},
					contentType : "application/json",
					success : function(data) {
						// $("#fileSystem").html(data);
						// alert(data);
						if(data=="<$expire$>")
						{
						location.href ="${pageContext.request.contextPath}/inbox";
						}
						else
							{
						window.prevflg="true";
						window.nextflg="true";
						
						if(fdrname=="Sent" || fdrname=="sent" || fdrname=="Drafts" || fdrname=="drafts")
							{
							$("#div_from").html("TO");
							}
						else
							{
							$("#div_from").html("FROM");
							}
						$("#inb_cnt_div").html(data);
						$(".small_image_flag").css("color",$("#hid_mail_bgColor").val());
		            	$(".new_flag_color").css("color",$("#hid_mail_bgColor").val());
						document.getElementById('action_gif').style.display= 'none';
						getAllMailCount(fdrname);
						if(fdrname=="INBOX" || fdrname=="Inbox" || fdrname=="inbox")
						{
						inboxUnread();
						}
					}}
				});

	}
	
	}
	
	function getWebmailInboxDesc( )
	{
		
		var fdrname=document.getElementById('hid_active_fldr').value;
		//alert("down"+fdrname);
		document.getElementById("hid_pagi_pcnt").value='1';
		var start='0';
		var end=$("#hid_mail_list_limit").val();
		document.getElementById('action_gif').style.display= 'block';
		$.ajax({
					type : "GET",
					url : "${pageContext.request.contextPath}/getMailInboxDesc",
					data : {
						'folder' : fdrname,
						'start' : start,
						'end' : end
					},
					contentType : "application/json",
					success : function(data) {
						// $("#fileSystem").html(data);
						// alert(data);
						if(fdrname=="Sent" || fdrname=="sent" || fdrname=="Drafts" || fdrname=="drafts")
							{
							$("#div_from").html("TO");
							}
						else
							{
							$("#div_from").html("FROM");
							}
						$("#inb_cnt_div").html(data);
						document.getElementById('action_gif').style.display= 'none';
						getAllMailCount(fdrname);
					}
				});

	}
	
	
	function getAllMailCount(folderPath){
		//alert("meeeeeeeeeeeeeeeeeeeSub="+folderPath);
		 $.ajax({
	         type: "GET",
	         url: "${pageContext.request.contextPath}/getAllMailCountInfolderDiv",
	         data: {'path':folderPath},
	         contentType: "application/json",
	         success: function (data) {
	        	 var arr=data.split("$");
	            $("#pagination_div").html(arr[0]);
	            $("#pagination_div").attr('title', arr[0]);
	           document.getElementById("hid_pagi_allmail").value=arr[1];
	         }
	     });
		
	}
	
	
	
	function refreshInbox() {
		
		var fdrname=document.getElementById('hid_active_fldr').value;
	//	getWebmailInbox(fdrname);
		
	
		if($('#div_for_compose').css('display')=='block')
		{
			backFromComposeNew();
		}
		 else if($('#div_for_setting').css('display')=='block')
			{
			 document.getElementById('action_gif').style.display= 'block';
			 location.href ="${pageContext.request.contextPath}/inbox";
			} 
		else
			{
			
			if($('#div_full_pg_disp').css('display') == "block")	
			{
			backToMailList();
			}
			
	document.getElementById('div_for_setting').style.display='none';
	noneMail();
	document.getElementById('div_for_compose').style.display='none';
	var pview=document.getElementById("hid_previewPane").value;
		//alert(pview)
	document.getElementById('div_for_inbox').style.display=  'block'; 
	
		//document.getElementById("hid_dt_sorting").value="up";
		//document.getElementById("hid_pagi_pcnt").value='1';
		//document.getElementById("dt_sorting").innerHTML="<img src='images/down_date.png'>";
//	var pfldr=document.getElementById('hid_active_fldr').value
//	document.getElementById('hid_active_fldr').value=fdrname;
	document.getElementById('mail_pagi').style.display= 'block';
    document.getElementById('search_pagi').style.display= 'none';
    document.getElementById('hid_pagi_search_allmail').value="";
    document.getElementById('hid_pagi_search_pcnt').value="";
    document.getElementById('hid_pagi_search_type').value="";
	//document.getElementById(pfldr).className = "";
	//document.getElementById(fdrname).className = "active_mailbox";
	
	
	
	
	
	
	var pcnt=parseInt(document.getElementById("hid_pagi_pcnt").value);
	var allml=parseInt(document.getElementById("hid_pagi_allmail").value);
	var cntlmt=parseInt($("#hid_mail_list_limit").val());
	pcnt=pcnt-1
	var sml=pcnt*cntlmt;
	var all=pcnt*cntlmt;
	if(all>=allml)
		{
		pcnt=pcnt-1
		var sml=pcnt*cntlmt;
		var all=pcnt*cntlmt;
		}
	  document.getElementById('hid_pagi_pcnt').value=(pcnt+1);
	var start=''+sml;
	var end=$("#hid_mail_list_limit").val();
	

		document.getElementById('action_gif').style.display= 'block';
		$.ajax({
					type : "GET",
					url : "${pageContext.request.contextPath}/getMailInbox",
					data : {
						'folder' : fdrname,
						'start' : start,
						'end' : end,
						'pview' : pview
					},
					contentType : "application/json",
					success : function(data) {
						// $("#fileSystem").html(data);
						// alert(data);
						if(data=="<$expire$>")
				{
					location.href ="${pageContext.request.contextPath}/inbox";
				}
						else
							{
						
						window.prevflg="true";
						window.nextflg="true";
						if(fdrname=="Sent" || fdrname=="sent" || fdrname=="Drafts" || fdrname=="drafts")
							{
							$("#div_from").html("TO");
							}
						else
							{
							$("#div_from").html("FROM");
							}
						$("#inb_cnt_div").html(data);
						
						$("#fldr_"+fdrname).addClass('active_left_tree');
						$(".active_left_tree").css("border-left","3px solid "+$("#hid_mail_bgColor").val());
						
						$(".small_image_flag").css("color",$("#hid_mail_bgColor").val());
		            	$(".new_flag_color").css("color",$("#hid_mail_bgColor").val());
						document.getElementById('action_gif').style.display= 'none';
						//getAllMailCount(fdrname);
						getAllMailCountCurrent(fdrname);
						if(fdrname=="INBOX" || fdrname=="Inbox" || fdrname=="inbox")
						{
						inboxUnread();
						}
					}}
				});

	} 
	}
	
	function getWebmailInboxRefresh() {
		//	alert(fdrname);
		window.prevflg="true";
		window.nextflg="true";
		var fdrname=document.getElementById('hid_active_fldr').value;
		//alert(fdrname)
		var pview=document.getElementById("hid_previewPane").value;
		try
		{
		if(fdrname!=null && fdrname!="" && fdrname!="inbox" && fdrname!="INBOX")
			{
			var fnm=fdrname.replace(/ /g, '_');
			$('#fldr_INBOX').removeClass('active_left_tree');
			$('#fldr_INBOX').css('border-left-color','#fff');
			$('#fldr_'+fnm).addClass('active_left_tree');
			$(".active_left_tree").css("border-left","3px solid "+$("#hid_mail_bgColor").val());
			}
			
		}
		catch (err) {
			// TODO: handle exception
		}
		//alert(pview);
		/* if($("#hid_previewPane").val()=="Vertical view")
		{
		shiftViewLeft();
		}
	else
		{
		toggleViewPanel();
		} */
		
		if(fdrname=="Junk" || fdrname=="junk")
		{
		$('#li_spam').prop('title', 'Not Spam');
		$("#img_spam").attr("src", "images/safe.png")
		}
	else
		{
		$('#li_spam').prop('title', 'Report Spam');
		$("#img_spam").attr("src", "images/restriction.png")
		}
		
		
	var start='0';
	var end=$("#hid_mail_list_limit").val();

	
	document.getElementById('mail_pagi').style.display= 'block';
    document.getElementById('search_pagi').style.display= 'none';
	document.getElementById('div_progress').style.display= 'block';
	document.getElementById('action_gif').style.display= 'block';
			$.ajax({
						type : "GET",
						url : "${pageContext.request.contextPath}/getMailInbox",
						data : {
							'folder' : fdrname,
							'start' : start,
							'end' : end,
							'pview' : pview
						},
						contentType : "application/json",
						success : function(data) {
							// $("#fileSystem").html(data);
							//alert(data);
							//var fdrname=document.getElementById('hid_active_fldr').value;
							if(fdrname=="Sent" || fdrname=="sent" || fdrname=="Drafts" || fdrname=="drafts")
							{
							$("#div_from").html("TO");
							}
						else
							{
							$("#div_from").html("FROM");
							}
							$("#inb_cnt_div").html(data);
							$(".small_image_flag").css("color",$("#hid_mail_bgColor").val());
			            	$(".new_flag_color").css("color",$("#hid_mail_bgColor").val());
							//document.getElementById(fdrname).className = "active_mailbox";
							document.getElementById('action_gif').style.display= 'none';
							window.myinbox="true";
							if(window.myhead=="true")
								{
								document.getElementById('div_progress').style.display= 'none';
								}
							

							getUnreadMailCountInbox();
							
							
							//setInterval(function(){autoWebmailInboxRefresh()}, 60000);	
						}
					});

		}
	
	
	function flagActionDisp(id) {
		//alert(id);
		//alert(fclas)
		var fclas=$("#hid_mail_disp_flg").val();
	//	alert(fclas)
		document.getElementById('action_gif').style.display= 'block';
		
		//alert('hello');
		var flg_id = "div_flag_" + id;
		var left_flg_id = "left_div_flag_" + id;
		var disp_flg_id = "flag_div_disp_" + id;
		var fdrname=document.getElementById('hid_active_fldr').value;
		var type = 'set';
		var chk_nm="stared";
		if (fclas == "true") 
		{
			type = 'remove';
			chk_nm="unstared";
		}
		
		$.ajax({
			type : "GET",
			url : "${pageContext.request.contextPath}/webmailFlagAtion",
			data : {
				'folder' : fdrname,
				'flagtp' : type,
				'uid' : id
			},
			contentType : "application/json",			
			success : function(data) {
				if (fclas == "true") {
					document.getElementById(flg_id).className = 'small_image';
					document.getElementById(disp_flg_id).className = 'bottom_flag';
					document.getElementById(left_flg_id).className = 'new_flag';
					$(".small_image").css("color","#c8c8c8");
					$(".new_flag").css("color","#c8c8c8");
					$(".bottom_flag").css("color","#c8c8c8");
					$("#hid_mail_disp_flg").val("false");
					//$("#"+left_flg_id ).html("<img src='images/star_gray.png' />");
				} else {
					$("#hid_mail_disp_flg").val("true");
					document.getElementById(flg_id).className = 'small_image_flag';
					document.getElementById(disp_flg_id).className = 'bottom_flag_red';
					document.getElementById(left_flg_id).className = 'new_flag_color';
					//$("#"+left_flg_id ).html("<img src='images/star-flag.png' />");
					$(".small_image_flag").css("color",$("#hid_mail_bgColor").val());
		        	$(".new_flag_color").css("color",$("#hid_mail_bgColor").val());
		        	$(".bottom_flag_red").css("color",$("#hid_mail_bgColor").val());
				}
				document.getElementById('action_gif').style.display= 'none';
				
				try
				{
					var nm=$('#chk_id_'+id).attr('name');
					var nm_arr=nm.split('-');
					$('#chk_id_'+id).attr('name',nm_arr[0]+"-"+chk_nm);
				}
				catch (e) {
					// TODO: handle exception
				}
			}
		}); 
		
	}

	
	
	
	function flagAction(id) {
		//alert('hii');
		document.getElementById('action_gif').style.display= 'block';
		
		//alert('hello');
		var flg_id = "div_flag_" + id;
		var left_flg_id = "left_div_flag_" + id;
		var disp_flg_id = "flag_div_disp_" + id;
		//var fdrname = 'inbox';
		var fdrname=document.getElementById('hid_active_fldr').value;
		var type = 'set';
		var chk_nm='stared'
		var y = document.getElementById(flg_id).className;
		if (y == 'small_image_flag') 
		{
			type = 'remove';
			chk_nm='unstared'
		}
		
		$.ajax({
			type : "GET",
			url : "${pageContext.request.contextPath}/webmailFlagAtion",
			data : {
				'folder' : fdrname,
				'flagtp' : type,
				'uid' : id
			},
			contentType : "application/json",			
			success : function(data) {
				
				document.getElementById('action_gif').style.display= 'none';
			
				
							if (y == 'small_image_flag')
							{
							document.getElementById(flg_id).className ='small_image';
							document.getElementById(left_flg_id).className ='new_flag';
							 $(".small_image").css("color","#c8c8c8"); 
							$(".new_flag").css("color","#c8c8c8");
							//$("#"+left_flg_id ).html("<img src='images/star_gray.png' />");
							try {
									document.getElementById(disp_flg_id).className = 'bottom_flag';
									$(".bottom_flag").css("color","#c8c8c8");
									}
									catch(err) {
    
									}
								
						   } 
						else 
							{
							document.getElementById(flg_id).className = 'small_image_flag';
							document.getElementById(left_flg_id).className = 'new_flag_color';
							$(".small_image_flag").css("color",$("#hid_mail_bgColor").val());
				        	$(".new_flag_color").css("color",$("#hid_mail_bgColor").val());
							//$("#"+left_flg_id ).html("<img src='images/star-flag.png' />");
							try {
									document.getElementById(disp_flg_id).className = 'bottom_flag_red';
									$(".bottom_flag_red").css("color",$("#hid_mail_bgColor").val());
									}
									catch(err) {
    								
									}
							}
							
							try
							{
								var nm=$('#chk_id_'+id).attr('name');
								var nm_arr=nm.split('-');
								$('#chk_id_'+id).attr('name',nm_arr[0]+"-"+chk_nm);
							}
							catch (e) {
								// TODO: handle exception
							}		
							
			}
		});
		
	}

	
	
	
	 $(document.body).on('click', '.row_content' ,function(event){
	//	alert(this.id);
		var id=this.id;
		if(id!=null && id!="")
			{
			var arr=id.split("_");
			if(arr[1]!=null)
				{
				getMailCnt(arr[1]);
				}
			} 
		event.stopPropagation();
		});
	
	
	$(document.body).on('click', '.npflag_mail' ,function(event){
		//alert(this.id);
		 var id=this.id;
		if(id!=null && id!="")
			{
			var arr=id.split("_");
			//alert(arr[arr.length-1]);
		 if(arr[arr.length-1]!=null)
				{
				flagAction(arr[arr.length-1]);
				} 
			} 
		event.stopPropagation();
		
		
		});
	
 	$(document.body).on('click', '.mail_checked' ,function(event){
		//alert(this.id);
	
		selMailCountInPanel();
		
		//event.stopPropagation();
		
		
		}); 
	
	//$('.row_delete').click(function(event){
		$(document.body).on('click', '.row_delete' ,function(event){
		//alert(this.id);
		 var id=this.id;
		if(id!=null && id!="")
			{
			var arr=id.split("_");
			if(arr[1]!=null)
				{
				moveTrash(arr[1]);
				}
			}
		event.stopPropagation();
		
		
		});
	
	function moveTrash(id) {
		//alert(id);
		//var msg='Are you sure you want to delete this mail?';
		var fdrname = document.getElementById('hid_active_fldr').value;
		if(fdrname=="Trash" || fdrname=="trash")
			{
			var msg="Are you sure you want to delete this mail permanently?";
			 $('.web_dialog_overlay').show(); 
			 mail_del_conf('confirm',msg,id);
			
			}
		else
			{
			mailDelete(id);
			}
		
		
	}
	
function mailDelete(id)
	{
		 $("#action_gif").css("display","block");
         var fdrname = document.getElementById('hid_active_fldr').value;
 		$.ajax({
 					type : "GET",
 					url : "${pageContext.request.contextPath}/webmailMoveToTrash",
 					data : {
 						'folder' : fdrname,
 						'uid' : id
 					},
 					contentType : "application/json",
 					success : function(data) {
 						/* var elem = document.getElementById("div_" + id);
 						elem.parentNode.removeChild(elem); */
 						if(data=="true")
 							{
 						try
 						{
 							var arrd=id.split("-");
 							var msg="";
 	 						if(arrd.length==1)
 	 							{
 	 							 msg="Message successfully deleted.";
 	 							}
 	 						else
 	 							{
 	 							 msg="Messages successfully deleted.";
 	 							}
 	 						}
 	 						catch (e) {
 								// TODO: handle exception
 							}
 						/* var arr=id.split("-");
 						for(i=0;i<arr.length; i++)
 							{
 							var elem = document.getElementById("div_" + arr[i]);
 							elem.parentNode.removeChild(elem);
 							} */
 						//document.getElementById('action_gif').style.display = "none";
 						/* $('.tag_main').css('display','none');
 						$('.folder_view').css('display','none');
 						$('#div_search_tool').css('display','none'); */

 				
 						
 						
						if($("#hid_open_search").val()!="true")
						{
    					 $.ajax({
    				         type: "GET",
    				         url: "${pageContext.request.contextPath}/getAllMailCountInfolderDiv",
    				         data: {'path':fdrname},
    				         contentType: "application/json",
    				         success: function (data) {
    				        	 var arr=data.split("$");
    				           
    				           document.getElementById("hid_pagi_allmail").value=arr[1];
    				       // refreshInbox(); refresh inbox here
    				       
    				       
    				       
    				       
		
		var fdrname=document.getElementById('hid_active_fldr').value;
	//	getWebmailInbox(fdrname);
		
	
		if($('#div_for_compose').css('display')=='block')
		{
			backFromComposeNew();
		}
		 else if($('#div_for_setting').css('display')=='block')
			{
			 document.getElementById('action_gif').style.display= 'block';
			 location.href ="${pageContext.request.contextPath}/inbox";
			} 
		else
			{
			
			if($('#div_full_pg_disp').css('display') == "block")	
			{
			backToMailList();
			}
			
	document.getElementById('div_for_setting').style.display='none';
	//noneMail();
	document.getElementById('div_for_compose').style.display='none';
	var pview=document.getElementById("hid_previewPane").value;
		//alert(pview)
	document.getElementById('div_for_inbox').style.display=  'block'; 
	
		//document.getElementById("hid_dt_sorting").value="up";
		//document.getElementById("hid_pagi_pcnt").value='1';
		//document.getElementById("dt_sorting").innerHTML="<img src='images/down_date.png'>";
//	var pfldr=document.getElementById('hid_active_fldr').value
//	document.getElementById('hid_active_fldr').value=fdrname;
	document.getElementById('mail_pagi').style.display= 'block';
    document.getElementById('search_pagi').style.display= 'none';
    document.getElementById('hid_pagi_search_allmail').value="";
    document.getElementById('hid_pagi_search_pcnt').value="";
    document.getElementById('hid_pagi_search_type').value="";
	//document.getElementById(pfldr).className = "";
	//document.getElementById(fdrname).className = "active_mailbox";
	
	
	
	
	
	
	var pcnt=parseInt(document.getElementById("hid_pagi_pcnt").value);
	var allml=parseInt(document.getElementById("hid_pagi_allmail").value);
	var cntlmt=parseInt($("#hid_mail_list_limit").val());
	pcnt=pcnt-1
	var sml=pcnt*cntlmt;
	var all=pcnt*cntlmt;
	if(all>=allml)
		{
		pcnt=pcnt-1
		var sml=pcnt*cntlmt;
		var all=pcnt*cntlmt;
		}
	  document.getElementById('hid_pagi_pcnt').value=(pcnt+1);
	var start=''+sml;
	var end=$("#hid_mail_list_limit").val();
	

		document.getElementById('action_gif').style.display= 'block';
		$.ajax({
					type : "GET",
					url : "${pageContext.request.contextPath}/getMailInbox",
					data : {
						'folder' : fdrname,
						'start' : start,
						'end' : end,
						'pview' : pview
					},
					contentType : "application/json",
					success : function(data) {
						// $("#fileSystem").html(data);
						// alert(data);
						if(data=="<$expire$>")
				{
					location.href ="${pageContext.request.contextPath}/inbox";
				}
						else
							{
							$('.tag_main').css('display','none');
	 						$('.folder_view').css('display','none');
	 						$('#div_search_tool').css('display','none');
							noneMail();
						window.prevflg="true";
						window.nextflg="true";
						if(fdrname=="Sent" || fdrname=="sent" || fdrname=="Drafts" || fdrname=="drafts")
							{
							$("#div_from").html("TO");
							}
						else
							{
							$("#div_from").html("FROM");
							}
						$("#inb_cnt_div").html(data);
						
						$("#fldr_"+fdrname).addClass('active_left_tree');
						$(".active_left_tree").css("border-left","3px solid "+$("#hid_mail_bgColor").val());
						
						$(".small_image_flag").css("color",$("#hid_mail_bgColor").val());
		            	$(".new_flag_color").css("color",$("#hid_mail_bgColor").val());
						document.getElementById('action_gif').style.display= 'none';
						//getAllMailCount(fdrname);
						getAllMailCountCurrent(fdrname);
						if(fdrname=="INBOX" || fdrname=="Inbox" || fdrname=="inbox")
						{
						inboxUnread();
						}
						if(fdrname=="Drafts" || fdrname=="DRAFTS" || fdrname=="drafts" )
	   					{
	   						getDraftMailCount();
	   					//getUnreadMailCountInbox()
	   					}
						
						
						 $("#action_gif").css("display","none");
	 						var success = generate_in('alert');
	    					 $.noty.setText(success.options.id, msg);
	    					 setTimeout(function () {  $.noty.close(success.options.id); }, 5000);
					}}
				});

	} 
    				       
    				       
    				       
    				       
    				       
    				       
    				       
    				       
    				       
    				       
    				       
    				       
    				       
    	   					/* getAllMailCountCurrent(fdrname)
    	   					if(fdrname=="inbox" || fdrname=="INBOX" || fdrname=="Inbox" )
    	   					{
    	   					inboxUnread()
    	   					//getUnreadMailCountInbox()
    	   					} 
    	   					if(fdrname=="Drafts" || fdrname=="DRAFTS" || fdrname=="drafts" )
    	   					{
    	   						getDraftMailCount();
    	   					//getUnreadMailCountInbox()
    	   					}  */
    				         }
    				     });
						}
						else
							{
							var arr=id.split("-");
	 						for(i=0;i<arr.length; i++)
	 							{
	 							var elem = document.getElementById("div_" + arr[i]);
	 							elem.parentNode.removeChild(elem);
	 							}
	 						//document.getElementById('action_gif').style.display = "none";
	 						$('.tag_main').css('display','none');
	 						$('.folder_view').css('display','none');
	 						$('#div_search_tool').css('display','none');

	 						// $("#fileSystem").html(data);
	 						// alert(data);
	 						// $("#inb_cnt_div").html(data);
	 						
	 						 $("#action_gif").css("display","none");
	 						var success = generate_in('alert');
	    					 $.noty.setText(success.options.id, msg);
	    					 setTimeout(function () {  $.noty.close(success.options.id); }, 5000);
							}
						
    					 
 							}	
 					}
 				});
	}
	
	function mail_del_conf(type,msg,id) {
	   	//alert(id);
	         var n = noty({
	           text        : msg,
	           type        : type,
	           theme       : 'relax',
	           dismissQueue: false,
	           layout      : 'center',
	           theme       : 'defaultTheme',
	           buttons     : (type != 'confirm') ? false : [
	               {addClass: 'btn btn-primary', text: 'Yes', onClick: function ($noty) {
	   				
	                 $noty.close();
	               
	                 $('.web_dialog_overlay').hide(); 
	                 
	                 mailDelete(id);
	                 
	                 
	                
	               }
	               },
	               {addClass: 'btn btn-danger', text: 'No', onClick: function ($noty) {
	                   $noty.close();
	                   $('.web_dialog_overlay').hide(); 
	               
	               }
	               }
	           ]
	       });
	      
	           
	           //console.log(type + ' - ' + n.options.id);
	           return n; 
	            
	       }
	
	$(document).ready(function(){ 		 
    $('#hid_del_email').change( function() {  
 	   //alert($("#hid_del").attr("data-id")); 
 	var r =$('#hid_del_email').val();
 	var id=$("#hid_del_email").attr("data-mailuid");
 	
 //	alert("change r="+r);
// 	alert("change fldnm="+fldnm);
 	if (r == "true") {
		
 		
document.getElementById('action_gif').style.display= 'block';
		
		var fdrname = document.getElementById('hid_active_fldr').value;
		$.ajax({
					type : "GET",
					url : "${pageContext.request.contextPath}/webmailMoveToTrash",
					data : {
						'folder' : fdrname,
						'uid' : id
					},
					contentType : "application/json",
					success : function(data) {
						/* var elem = document.getElementById("div_" + id);
						elem.parentNode.removeChild(elem); */
						
						
						var arr=id.split("-");
						for(i=0;i<arr.length; i++)
							{
							var elem = document.getElementById("div_" + arr[i]);
							elem.parentNode.removeChild(elem);
							}
						//document.getElementById('action_gif').style.display = "none";
						$('.tag_main').css('display','none');
						$('.folder_view').css('display','none');
						$('#div_search_tool').css('display','none');

						// $("#fileSystem").html(data);
						// alert(data);
						// $("#inb_cnt_div").html(data);
						var msg="";
						if(arr.length==1)
							{
							 msg="Message successfully deleted.";
							}
						else
							{
							 msg="Messages successfully deleted.";
							}
						var success = generate_in('alert');
   					 $.noty.setText(success.options.id, msg);
   					 setTimeout(function () {  $.noty.close(success.options.id); }, 5000);


   					 $.ajax({
   				         type: "GET",
   				         url: "${pageContext.request.contextPath}/getAllMailCountInfolderDiv",
   				         data: {'path':fdrname},
   				         contentType: "application/json",
   				         success: function (data) {
   				        	 var arr=data.split("$");
   				           
   				           document.getElementById("hid_pagi_allmail").value=arr[1];
   				        refreshInbox();
   	   					getAllMailCountCurrent(fdrname)
   	   					if(fdrname=="inbox" || fdrname=="INBOX" || fdrname=="Inbox" )
   	   					{
   	   					inboxUnread()
   	   					//getUnreadMailCountInbox()
   	   					} 
   	   					if(fdrname=="Drafts" || fdrname=="DRAFTS" || fdrname=="drafts" )
   	   					{
   	   						getDraftMailCount();
   	   					//getUnreadMailCountInbox()
   	   					} 
   				         }
   				     });
   					 
   					 
   					
					}
				});
 		
	}
 });
	});		
	
	function generate_in(type) {
        var n = noty({
            text        : type,
            type        : type,
            dismissQueue: false,
            layout      : 'topCenter',
            theme       : 'defaultTheme'
        });
      
        return n;
    }
    
    function generate_conf(type,id,uid) {
   	 //alert(id);
         var n = noty({
           text        : type,
           type        : type,
           theme       : 'relax',
           dismissQueue: false,
           layout      : 'center',
           theme       : 'defaultTheme',
           buttons     : (type != 'confirm') ? false : [
               {addClass: 'btn btn-primary', text: 'Yes', onClick: function ($noty) {
   				
                 $noty.close();
                // alert(foldernm);
                 $("#"+id).attr("data-mailuid", uid);
                 $('#'+id).val("true").trigger('change');
                 $('.web_dialog_overlay').hide(); 
               }
               },
               {addClass: 'btn btn-danger', text: 'No', onClick: function ($noty) {
                   $noty.close();
                   $('#'+id).val("");
                   $("#"+id).attr("data-mailuid", "");
                   $('.web_dialog_overlay').hide(); 
                /*  var n1 = noty({
                       text        : 'You clicked "Cancel" button',
                       type        : 'error',
                       dismissQueue: false,
                       layout      : 'topCenter',
                       theme       : 'defaultTheme'
                   });
                  setTimeout(function () { $.noty.close(n1.options.id); }, 2000); */
               }
               }
           ]
       });
      
           
           //console.log(type + ' - ' + n.options.id);
           return n; 
            
       }


   
    
    
    
	
    function moveToFolderAll(folder_dest) {
		//alert(id);
		if(folder_dest=="Drafts" || folder_dest=="DRAFTS" || folder_dest=="drafts" )
			{
			var error = generate_in('error');
				 $.noty.setText(error.options.id, "Destination folder is not valid.");
				 setTimeout(function () {  $.noty.close(error.options.id); }, 5000);
			}
		else
			{
			var fdrname = document.getElementById('hid_active_fldr').value;
			if(fdrname==folder_dest)
				{
				var error = generate_in('error');
				 $.noty.setText(error.options.id, "Source and Destination folder must be different.");
				 setTimeout(function () {  $.noty.close(error.options.id); }, 5000);
				}
			else
				{
				//  if ($('.tab_first_content').css('display') == "block")
				if($('#div_full_pg_disp').css('display') == "block")	
					{
					backToMailList();
					}
				
		var ids=getSelectdMailUid();
		if(ids==null || ids=="")
		{
			ids=$("#hid_mail_disp_count").val();
		}
		//alert(ids);
		
		document.getElementById('action_gif').style.display= 'block';
		
		
		// msg="Selected mail(s) has been moved to "+folder_dest+".";
		msg="Message(s) moved successfully.";
		
		$.ajax({
					type : "GET",
					url : "${pageContext.request.contextPath}/webmailMoveToFolder",
					data : {
						'folder' : fdrname,
						'folder_dest' : folder_dest,
						'uid' : ids
					},
					contentType : "application/json",
					success : function(data) {
						if(data!="false")
							{
						/* var arr=ids.split("-");
						for(i=0;i<arr.length; i++)
							{
							var elem = document.getElementById("div_" + arr[i]);
							elem.parentNode.removeChild(elem);
							}
						
						$('.tag_main').css('display','none');
						$('.folder_view').css('display','none');
						$('#div_search_tool').css('display','none');

					// document.getElementById('mail_spam').style.display = "block";
					//	 setTimeout( "jQuery('#mail_spam').hide();",3000 ); 
						 
						var success = generate_in('alert');
	   					 $.noty.setText(success.options.id, msg);
	   					 setTimeout(function () {  $.noty.close(success.options.id); }, 5000); */
	   					 
	   					if($("#hid_open_search").val()!="true")
	   						{
	   					$.ajax({
	   				         type: "GET",
	   				         url: "${pageContext.request.contextPath}/getAllMailCountInfolderDiv",
	   				         data: {'path':fdrname},
	   				         contentType: "application/json",
	   				         success: function (data) {
	   				        	 
	   				        	/* var arr1=ids.split("-");
	   				        	var cntlmt=parseInt($("#hid_mail_list_limit").val());
	   				        	if(arr1.length < cntlmt)
	   				        		{
	   								for(i=0;i<arr1.length; i++)
	   								{
	   								var elem = document.getElementById("div_" + arr1[i]);
	   								elem.parentNode.removeChild(elem);
	   								}
	   				        		} */
	   							/* $('.tag_main').css('display','none');
	   							$('.folder_view').css('display','none');
	   							$('#div_search_tool').css('display','none'); */

	   							/* document.getElementById('mail_spam').style.display = "block";
	   							 setTimeout( "jQuery('#mail_spam').hide();",3000 ); */
	   							 
	   							
	   				        	 
	   				        	 
	   				        	 var arr=data.split("$");
	   				           
	   				           document.getElementById("hid_pagi_allmail").value=arr[1];
	   				       // refreshInbox(); refresh inbox here
	   				       
	   				       
		
		var fdrname=document.getElementById('hid_active_fldr').value;
	//	getWebmailInbox(fdrname);
		
	
		if($('#div_for_compose').css('display')=='block')
		{
			backFromComposeNew();
		}
		 else if($('#div_for_setting').css('display')=='block')
			{
			 document.getElementById('action_gif').style.display= 'block';
			 location.href ="${pageContext.request.contextPath}/inbox";
			} 
		else
			{
			
			if($('#div_full_pg_disp').css('display') == "block")	
			{
			backToMailList();
			}
			
	document.getElementById('div_for_setting').style.display='none';
	//noneMail();
	document.getElementById('div_for_compose').style.display='none';
	var pview=document.getElementById("hid_previewPane").value;
		//alert(pview)
	document.getElementById('div_for_inbox').style.display=  'block'; 
	
		//document.getElementById("hid_dt_sorting").value="up";
		//document.getElementById("hid_pagi_pcnt").value='1';
		//document.getElementById("dt_sorting").innerHTML="<img src='images/down_date.png'>";
//	var pfldr=document.getElementById('hid_active_fldr').value
//	document.getElementById('hid_active_fldr').value=fdrname;
	document.getElementById('mail_pagi').style.display= 'block';
    document.getElementById('search_pagi').style.display= 'none';
    document.getElementById('hid_pagi_search_allmail').value="";
    document.getElementById('hid_pagi_search_pcnt').value="";
    document.getElementById('hid_pagi_search_type').value="";
	//document.getElementById(pfldr).className = "";
	//document.getElementById(fdrname).className = "active_mailbox";
	
	
	
	
	
	
	var pcnt=parseInt(document.getElementById("hid_pagi_pcnt").value);
	var allml=parseInt(document.getElementById("hid_pagi_allmail").value);
	var cntlmt=parseInt($("#hid_mail_list_limit").val());
	pcnt=pcnt-1
	var sml=pcnt*cntlmt;
	var all=pcnt*cntlmt;
	if(all>=allml)
		{
		pcnt=pcnt-1
		var sml=pcnt*cntlmt;
		var all=pcnt*cntlmt;
		}
	  document.getElementById('hid_pagi_pcnt').value=(pcnt+1);
	var start=''+sml;
	var end=$("#hid_mail_list_limit").val();
	

		document.getElementById('action_gif').style.display= 'block';
		$.ajax({
					type : "GET",
					url : "${pageContext.request.contextPath}/getMailInbox",
					data : {
						'folder' : fdrname,
						'start' : start,
						'end' : end,
						'pview' : pview
					},
					contentType : "application/json",
					success : function(data) {
						// $("#fileSystem").html(data);
						// alert(data);
						if(data=="<$expire$>")
				{
					location.href ="${pageContext.request.contextPath}/inbox";
				}
						else
							{
						
							$('.tag_main').css('display','none');
   							$('.folder_view').css('display','none');
   							$('#div_search_tool').css('display','none');
   							noneMail();
						window.prevflg="true";
						window.nextflg="true";
						if(fdrname=="Sent" || fdrname=="sent" || fdrname=="Drafts" || fdrname=="drafts")
							{
							$("#div_from").html("TO");
							}
						else
							{
							$("#div_from").html("FROM");
							}
						$("#inb_cnt_div").html(data);
						
						$("#fldr_"+fdrname).addClass('active_left_tree');
						$(".active_left_tree").css("border-left","3px solid "+$("#hid_mail_bgColor").val());
						
						$(".small_image_flag").css("color",$("#hid_mail_bgColor").val());
		            	$(".new_flag_color").css("color",$("#hid_mail_bgColor").val());
						document.getElementById('action_gif').style.display= 'none';
						//getAllMailCount(fdrname);
						getAllMailCountCurrent(fdrname);
						if(fdrname=="INBOX" || fdrname=="Inbox" || fdrname=="inbox")
						{
						inboxUnread();
						}
						if(fdrname=="Drafts" || fdrname=="DRAFTS" || fdrname=="drafts" )
	   					{
	   						getDraftMailCount();
	   					//getUnreadMailCountInbox()
	   					}
						var success = generate_in('alert');
	   					 $.noty.setText(success.options.id, msg);
	   					 setTimeout(function () {  $.noty.close(success.options.id); }, 5000);
					}}
				});

	} 
	   				        
	   				        
	   				        
	   				        
	   				        
	   				        
	   				        
	   				        
	   				        
	   				        
	   				        
	   				        
	   				        
	   				        
	   				        
	   				        
	   				        
	   				        
	   				        
	   	   					/* getAllMailCountCurrent(fdrname)
	   	   					if(fdrname=="inbox" || fdrname=="INBOX" || fdrname=="Inbox" )
	   	   					{
	   	   					inboxUnread()
	   	   					//getUnreadMailCountInbox()
	   	   					} 
	   	   					if(fdrname=="Drafts" || fdrname=="DRAFTS" || fdrname=="drafts" )
	   	   					{
	   	   						getDraftMailCount();
	   	   					//getUnreadMailCountInbox()
	   	   					}  */
	   	   					
	   	   				/* var success = generate_in('alert');
		   					 $.noty.setText(success.options.id, msg);
		   					 setTimeout(function () {  $.noty.close(success.options.id); }, 5000); */
	   				         }
	   				     });
	   						}
	   					else
	   						{
	   						var arr=ids.split("-");
							for(i=0;i<arr.length; i++)
								{
								var elem = document.getElementById("div_" + arr[i]);
								elem.parentNode.removeChild(elem);
								}
							
							$('.tag_main').css('display','none');
							$('.folder_view').css('display','none');
							$('#div_search_tool').css('display','none');

							/* document.getElementById('mail_spam').style.display = "block";
							 setTimeout( "jQuery('#mail_spam').hide();",3000 ); */
							 
							var success = generate_in('alert');
		   					 $.noty.setText(success.options.id, msg);
		   					 setTimeout(function () {  $.noty.close(success.options.id); }, 5000);
		   					document.getElementById('action_gif').style.display = "none";
	   						}
	   					
	   					
	   					 
	   					/* getAllMailCountCurrent(fdrname)
	   					if(fdrname=="inbox" || fdrname=="INBOX" || fdrname=="Inbox" )
	   					{
	   					inboxUnread()
	   					//getUnreadMailCountInbox()
	   					}  */
							}
						else
							{
							document.getElementById('action_gif').style.display = "none";
							}
					}
				});
			}
			}
	}
    
	
	
	
	function moveSpamAll() {
		//alert(id);
		var ids=getSelectdMailUid();
		if(ids==null || ids=="")
		{
			ids=$("#hid_mail_disp_count").val();
		}
		//alert(ids);
		
		document.getElementById('action_gif').style.display= 'block';
		var folder_dest="";
		var fdrname = document.getElementById('hid_active_fldr').value;
		var msg="";
		if(fdrname=="Junk" || fdrname=="JUNK" || fdrname=="junk" )
			{
			folder_dest="Inbox";
			// msg="Selected mail(s) has been moved to Inbox.";
			msg="The message has been marked as safe.";
			}
		else
			{
			folder_dest="Junk";
			//msg="Selected mail(s) has been moved to Junk.";
			msg="The message has been marked as spam.";
			}
		$.ajax({
					type : "GET",
					url : "${pageContext.request.contextPath}/webmailMoveToJunk",
					data : {
						'folder' : fdrname,
						'folder_dest' : folder_dest,
						'uid' : ids
					},
					contentType : "application/json",
					success : function(data) {
						var arr=ids.split("-");
						for(i=0;i<arr.length; i++)
							{
							var elem = document.getElementById("div_" + arr[i]);
							elem.parentNode.removeChild(elem);
							}
						document.getElementById('action_gif').style.display = "none";
						$('.tag_main').css('display','none');
						$('.folder_view').css('display','none');
						$('#div_search_tool').css('display','none');

						/* document.getElementById('mail_spam').style.display = "block";
						 setTimeout( "jQuery('#mail_spam').hide();",3000 ); */
						var success = generate_in('alert');
	   					 $.noty.setText(success.options.id, msg);
	   					 setTimeout(function () {  $.noty.close(success.options.id); }, 5000);
	   					if($("#hid_open_search").val()!="true")
	   						{
	   					getAllMailCountCurrent(fdrname)
	   					if(fdrname=="inbox" || fdrname=="INBOX" || fdrname=="Inbox" || fdrname=="Junk" || fdrname=="JUNK" || fdrname=="junk"  )
	   					{
	   					inboxUnread()
	   					}
	   						}
					}
				});
	}
	
	function moveSpamAllDisp() {
		//document.getElementById('action_gif').style.display= 'block';
		backToMailList();
		moveSpamAll();
	}
	
	function moveTrashAll() {
		//alert(id);
		var ids=getSelectdMailUid();
		if(ids==null || ids=="")
		{
			ids=$("#hid_mail_disp_count").val();
		}
		//var msg="Are you sure you want to delete all selected mails?";
		var fdrname = document.getElementById('hid_active_fldr').value;
		if(fdrname=="Trash" || fdrname=="trash")
			{
			var msg="Are you sure you want to delete all selected mails permanently?";
			$('.web_dialog_overlay').show(); 
			 mail_del_conf('confirm',msg,ids);
			}
		else
			{
			mailDelete(ids);
			}
		
		
	}
	function moveTrashAllDisp() {
		//document.getElementById('action_gif').style.display= 'block';
		backToMailList();
		moveTrashAll();
	}
	
</script>
<script type="text/javascript">
function dtSorting()
{
	//alert('hi');
	var dt_sort_val=document.getElementById("hid_dt_sorting").value;
	document.getElementById("hid_pagi_pcnt").value='1';
	//var fdrnm=document.getElementById('hid_active_fldr').value;
	//alert(fdrnm);
	if(dt_sort_val=="up")
		{
		document.getElementById("hid_dt_sorting").value="down";
		document.getElementById("dt_sorting").innerHTML="<img src='images/up_date.png'>";
		getWebmailInboxDesc( );
		}
	else
		{
		document.getElementById("hid_dt_sorting").value="up";
		document.getElementById("dt_sorting").innerHTML="<img src='images/down_date.png'>";
		getWebmailInboxRefresh()
		}
	
}
</script>

<script type="text/javascript">
function toggle(source) {
	
	var cnt=0;
	
	var pview=document.getElementById("hid_previewPane").value;
	var left_css="row_content ";
	
		if(pview=="Vertical view")
			{
			left_css=left_css+"left_view_mess ";
			}
		else
			{
			left_css=left_css+"pading_main ";
			}
	
  checkboxes1 = document.getElementsByName('unseen-stared');
  for(var i=0, n=checkboxes1.length;i<n;i++) {
    checkboxes1[i].checked = source.checked;
    if(source.checked==true)
    	{
    	document.getElementById("div_"+(checkboxes1[i].value)).className=left_css+"selected_row";
    	}
    else
    	{
    	document.getElementById("div_"+(checkboxes1[i].value)).className=left_css;
    	}
    cnt++;
  }

  checkboxes2 = document.getElementsByName('seen-unstared');
  for(var i=0, n=checkboxes2.length;i<n;i++) {
    checkboxes2[i].checked = source.checked;
    if(source.checked==true)
	{
	document.getElementById("div_"+(checkboxes2[i].value)).className=left_css+"selected_row";
	}
else
	{
	document.getElementById("div_"+(checkboxes2[i].value)).className=left_css;
	}
    cnt++;
  }
  
  checkboxes3 = document.getElementsByName('unseen-unstared');
  for(var i=0, n=checkboxes3.length;i<n;i++) {
    checkboxes3[i].checked = source.checked;
    if(source.checked==true)
	{
	document.getElementById("div_"+(checkboxes3[i].value)).className=left_css+"selected_row";
	}
else
	{
	document.getElementById("div_"+(checkboxes3[i].value)).className=left_css;
	}
    cnt++;
  }
  
  checkboxes4 = document.getElementsByName('seen-stared');
  for(var i=0, n=checkboxes4.length;i<n;i++) {
    checkboxes4[i].checked = source.checked;
    if(source.checked==true)
	{
	document.getElementById("div_"+(checkboxes4[i].value)).className=left_css+"selected_row";
	}
else
	{
	document.getElementById("div_"+(checkboxes4[i].value)).className=left_css;
	}
    cnt++;
	}
  
  if(source.checked==true)
	{
	 if(cnt>0)
		 {
	 document.getElementById('div_search_tool').style.display = "block";
	  if(cnt>1)
	 	 {
	 	 document.getElementById("div_hid_opt1").className="hidden_option disable";
	 	 document.getElementById("div_hid_opt2").className="hidden_option disable";
	 	 }
	  $('.tag_main').css('display','block');
	  $('.folder_view').css('display','block');
		 }
	 else
	  {
	  document.getElementById('div_search_tool').style.display = "none";
	  $('.tag_main').css('display','none');
		$('.folder_view').css('display','none');
	  }
	}
  else
	  {
	  document.getElementById('div_search_tool').style.display = "none";
	  $('.tag_main').css('display','none');
		$('.folder_view').css('display','none');
	  }
  selMailCountInPanel();
  return cnt;
}

function toggleNP(source) {
	
	var cnt=0;
	
	var pview=document.getElementById("hid_previewPane").value;
	var left_css="row_content ";
	
		if(pview=="Vertical view")
			{
			left_css=left_css+"left_view_mess ";
			}
		else
			{
			left_css=left_css+"pading_main ";
			}
	
  checkboxes1 = document.getElementsByName('unseen-stared');
  for(var i=0, n=checkboxes1.length;i<n;i++) {
    checkboxes1[i].checked = source.checked;
    if(source.checked==true)
    	{
    	document.getElementById("div_"+(checkboxes1[i].value)).className=left_css+"selected_row";
    	}
    else
    	{
    	document.getElementById("div_"+(checkboxes1[i].value)).className=left_css;
    	}
    cnt++;
  }

  checkboxes2 = document.getElementsByName('seen-unstared');
  for(var i=0, n=checkboxes2.length;i<n;i++) {
    checkboxes2[i].checked = source.checked;
    if(source.checked==true)
	{
	document.getElementById("div_"+(checkboxes2[i].value)).className=left_css+"selected_row";
	}
else
	{
	document.getElementById("div_"+(checkboxes2[i].value)).className=left_css;
	}
    cnt++;
  }
  
  checkboxes3 = document.getElementsByName('unseen-unstared');
  for(var i=0, n=checkboxes3.length;i<n;i++) {
    checkboxes3[i].checked = source.checked;
    if(source.checked==true)
	{
	document.getElementById("div_"+(checkboxes3[i].value)).className=left_css+"selected_row";
	}
else
	{
	document.getElementById("div_"+(checkboxes3[i].value)).className=left_css;
	}
    cnt++;
  }
  
  checkboxes4 = document.getElementsByName('seen-stared');
  for(var i=0, n=checkboxes4.length;i<n;i++) {
    checkboxes4[i].checked = source.checked;
    if(source.checked==true)
	{
	document.getElementById("div_"+(checkboxes4[i].value)).className=left_css+"selected_row";
	}
else
	{
	document.getElementById("div_"+(checkboxes4[i].value)).className=left_css;
	}
    cnt++;
	}
  
  if(source.checked==true)
	{
	 if(cnt>0)
		 {
	 document.getElementById('div_search_tool').style.display = "block";
	  if(cnt>1)
	 	 {
	 	 document.getElementById("div_hid_opt1").className="hidden_option disable";
	 	 document.getElementById("div_hid_opt2").className="hidden_option disable";
	 	 }
	  $('.tag_main').css('display','block');
	  $('.folder_view').css('display','block');
		 }
	 else
	  {
	  document.getElementById('div_search_tool').style.display = "none";
	  $('.tag_main').css('display','none');
		$('.folder_view').css('display','none');
	  }
	}
  else
	  {
	  document.getElementById('div_search_tool').style.display = "none";
	  $('.tag_main').css('display','none');
		$('.folder_view').css('display','none');
	  }
  //selMailCountInPanel();
  return cnt;
}

function allMail()
{
//alert('all');
 document.getElementById("allmail").checked = true;
 var cnt=parseInt(toggle(document.getElementById("allmail")) );
 
if(cnt>0)
	{
 document.getElementById('div_search_tool').style.display = "block";
 if(cnt>1)
	 {
	 document.getElementById("div_hid_opt1").className="hidden_option disable";
	 document.getElementById("div_hid_opt2").className="hidden_option disable";
	 }
 	selMailCountInPanel();
	}
}

function noneMail()
{
//alert('none');
 document.getElementById("allmail").checked = false;
 var cnt=toggle(document.getElementById("allmail")) ;
 document.getElementById('div_search_tool').style.display = "none";
 selMailCountInPanel();
}

function noneMailDisplay()
{
//alert('none');
 document.getElementById("allmail").checked = false;
 var cnt=toggleNP(document.getElementById("allmail")) ;
 document.getElementById('div_search_tool').style.display = "none";
// selMailCountInPanelDisplay();
}

function seenMail()
{
 noneMail()
 var pview=document.getElementById("hid_previewPane").value;
	var left_css="row_content ";
	
		if(pview=="Vertical view")
			{
			left_css=left_css+"left_view_mess ";
			}
		else
			{
			left_css=left_css+"pading_main ";
			}
 var cnt=0;
 //var source=document.getElementById("allmail");
 checkboxes2 = document.getElementsByName('seen-unstared');
  for(var i=0, n=checkboxes2.length;i<n;i++) 
  {
    checkboxes2[i].checked = true;
   	document.getElementById("div_"+(checkboxes2[i].value)).className=left_css+"selected_row";
	cnt++;
  }
  
    checkboxes4 = document.getElementsByName('seen-stared');
  for(var i=0, n=checkboxes4.length;i<n;i++)
  {
    checkboxes4[i].checked = true;
    document.getElementById("div_"+(checkboxes4[i].value)).className=left_css+"selected_row";
    cnt++;
	}
 // alert(cnt);
  if(cnt>0)
	  {
	  document.getElementById("allmail").checked = true;
 document.getElementById('div_search_tool').style.display = "block";
 if(cnt>1)
	 {
	 document.getElementById("div_hid_opt1").className="hidden_option disable";
	 document.getElementById("div_hid_opt2").className="hidden_option disable";
	 }
 selMailCountInPanel();
	  }
}

function unseenMail()
{
noneMail()
var cnt=0;
var pview=document.getElementById("hid_previewPane").value;
var left_css="row_content ";

	if(pview=="Vertical view")
		{
		left_css=left_css+"left_view_mess ";
		}
	else
		{
		left_css=left_css+"pading_main ";
		}
checkboxes1 = document.getElementsByName('unseen-stared');
  for(var i=0, n=checkboxes1.length;i<n;i++) 
  {
    checkboxes1[i].checked = true;
    document.getElementById("div_"+(checkboxes1[i].value)).className=left_css+"selected_row";
    cnt++;
  }

  
  checkboxes3 = document.getElementsByName('unseen-unstared');
  for(var i=0, n=checkboxes3.length;i<n;i++) 
  {
    checkboxes3[i].checked = true;
    document.getElementById("div_"+(checkboxes3[i].value)).className=left_css+"selected_row";
    cnt++;
  }
  //alert(cnt);
   if(cnt>0)
	  {
	  document.getElementById("allmail").checked = true;
  document.getElementById('div_search_tool').style.display = "block";
 if(cnt>1)
	 {
	 document.getElementById("div_hid_opt1").className="hidden_option disable";
	 document.getElementById("div_hid_opt2").className="hidden_option disable";
	 }
 selMailCountInPanel();
	  }
}


function staredMail()
{
noneMail();
var cnt=0;
var pview=document.getElementById("hid_previewPane").value;
var left_css="row_content ";

	if(pview=="Vertical view")
		{
		left_css=left_css+"left_view_mess ";
		}
	else
		{
		left_css=left_css+"pading_main ";
		}
checkboxes1 = document.getElementsByName('unseen-stared');
  for(var i=0, n=checkboxes1.length;i<n;i++) 
  {
    checkboxes1[i].checked = true;
    document.getElementById("div_"+(checkboxes1[i].value)).className=left_css+"selected_row";
    cnt++;
  }

 
  checkboxes4 = document.getElementsByName('seen-stared');
  for(var i=0, n=checkboxes4.length;i<n;i++) 
  {
    checkboxes4[i].checked = true;
    document.getElementById("div_"+(checkboxes4[i].value)).className=left_css+"selected_row";
    cnt++;
	}
//alert(cnt);
 if(cnt>0)
	  {
	  document.getElementById("allmail").checked = true;
document.getElementById('div_search_tool').style.display = "block";
 if(cnt>1)
	 {
	 document.getElementById("div_hid_opt1").className="hidden_option disable";
	 document.getElementById("div_hid_opt2").className="hidden_option disable";
	 }
 selMailCountInPanel();
	  }
}


function unstaredMail()
{
noneMail();
var cnt=0;
var pview=document.getElementById("hid_previewPane").value;
var left_css="row_content ";

	if(pview=="Vertical view")
		{
		left_css=left_css+"left_view_mess ";
		}
	else
		{
		left_css=left_css+"pading_main ";
		}

 checkboxes2 = document.getElementsByName('seen-unstared');
  for(var i=0, n=checkboxes2.length;i<n;i++) 
  {
    checkboxes2[i].checked = true;
    document.getElementById("div_"+(checkboxes2[i].value)).className=left_css+"selected_row";
    cnt++;
  }
  
  checkboxes3 = document.getElementsByName('unseen-unstared');
  for(var i=0, n=checkboxes3.length;i<n;i++) 
  {
    checkboxes3[i].checked = true;
    document.getElementById("div_"+(checkboxes3[i].value)).className=left_css+"selected_row";
    cnt++;
  }
 // alert(cnt);
 
  if(cnt>0)
	  {
	  document.getElementById("allmail").checked = true;
 document.getElementById('div_search_tool').style.display = "block";
 if(cnt>1)
	 {
	 document.getElementById("div_hid_opt1").className="hidden_option disable";
	 document.getElementById("div_hid_opt2").className="hidden_option disable";
	 }
	 
 selMailCountInPanel();
	  }
}



function getSelectdMailUid()
{
var checkedValue = ""; 
var inputElements1 = document.getElementsByName('unseen-stared');
for(var i=0; inputElements1[i]; ++i){
      if(inputElements1[i].checked){
			if(checkedValue == "")
			{
			checkedValue = inputElements1[i].value;
			}
			else
			{
			checkedValue =checkedValue+"-"+ inputElements1[i].value;
			}
          
      }
}

var inputElements2 = document.getElementsByName('unseen-unstared');
for(var i=0; inputElements2[i]; ++i){
      if(inputElements2[i].checked){
			if(checkedValue == "")
			{
			checkedValue = inputElements2[i].value;
			}
			else
			{
			checkedValue =checkedValue+"-"+ inputElements2[i].value;
			}
          
      }
}

var inputElements3 = document.getElementsByName('seen-unstared');
for(var i=0; inputElements3[i]; ++i){
      if(inputElements3[i].checked){
			if(checkedValue == "")
			{
			checkedValue = inputElements3[i].value;
			}
			else
			{
			checkedValue =checkedValue+"-"+ inputElements3[i].value;
			}
          
      }
}


var inputElements4 = document.getElementsByName('seen-stared');
for(var i=0; inputElements4[i]; ++i){
      if(inputElements4[i].checked){
			if(checkedValue == "")
			{
			checkedValue = inputElements4[i].value;
			}
			else
			{
			checkedValue =checkedValue+"-"+ inputElements4[i].value;
			}
          
      }
}

//alert("hi"+checkedValue);
return checkedValue;
}



function setSetectedMailUnRead() {
	var smail= getSelectdMailUid();
	if(smail==null || smail=="")
	{
		smail=$("#hid_mail_disp_count").val();
	}
	//alert(smail);
	
	document.getElementById('action_gif').style.display= 'block';

	//alert('hello');
	
	var fdrname = document.getElementById('hid_active_fldr').value;
	
	//var y = document.getElementById(flg_id).className;
	
	$.ajax({
		type : "GET",
		url : "${pageContext.request.contextPath}/webmailUnReadAtion",
		data : {
			'folder' : fdrname,
			'uid' : smail
		},
		contentType : "application/json",			
		success : function(data) {
			
			var arr=smail.split("-");
			for(i=0;i<arr.length;i++)
				{
				
				try
				{
					var nm=$('#chk_id_'+arr[i]).attr('name');
					//nm= nm.replace("unstared", "stared");	
					var nm_arr=nm.split('-');
					$('#chk_id_'+arr[i]).attr('name',"unseen-"+nm_arr[1]);
				}
				catch (e) {
					// TODO: handle exception
				}
				
				
				var flg_id = "div_unread_" + arr[i];
				//document.getElementById(flg_id).className = 'row_left unread_message';
				$('#'+flg_id).addClass('unread_message');
				}
			document.getElementById('action_gif').style.display= 'none';
			if(fdrname=="inbox" || fdrname=="INBOX" || fdrname=="Inbox" )
			{
			inboxUnread()
			}
				

		}
	});
	
}

function setSetectedMailUnReadDisp() {
	
	//document.getElementById('action_gif').style.display= 'block';
	//backToMailList();
	 setSetectedMailUnRead();
	
}

function setSetectedMailRead() {
	var smail= getSelectdMailUid();
	if(smail==null || smail=="")
	{
		smail=$("#hid_mail_disp_count").val();
	}
	//alert(smail);
	
	document.getElementById('action_gif').style.display= 'block';

	//alert('hello');
	
	var fdrname = document.getElementById('hid_active_fldr').value;
	
	//var y = document.getElementById(flg_id).className;
	
	$.ajax({
		type : "GET",
		url : "${pageContext.request.contextPath}/webmailReadAtion",
		data : {
			'folder' : fdrname,
			'uid' : smail
		},
		contentType : "application/json",			
		success : function(data) {
			
			var arr=smail.split("-");
			for(i=0;i<arr.length;i++)
				{
				
				try
				{
					var nm=$('#chk_id_'+arr[i]).attr('name');
					//nm= nm.replace("unstared", "stared");	
					var nm_arr=nm.split('-');
					$('#chk_id_'+arr[i]).attr('name',"seen-"+nm_arr[1]);
				}
				catch (e) {
					// TODO: handle exception
				}
				
				var flg_id = "div_unread_" + arr[i];
				document.getElementById(flg_id).className = 'row_left';
				var pview=document.getElementById("hid_previewPane").value;
				if(pview=="Vertical view")
						{
					$('#'+flg_id).addClass('left_view_con');
						}
				}
				document.getElementById('action_gif').style.display= 'none';
				if(fdrname=="inbox" || fdrname=="INBOX" || fdrname=="Inbox" )
				{
				inboxUnread()
				}

		}
	});
	
}


function setSetectedMailReadDisp() {
	
	//document.getElementById('action_gif').style.display= 'block';
	//backToMailList();
	setSetectedMailRead();
	
}


function setSetectedMailFlag() {
	var smail= getSelectdMailUid();
	if(smail==null || smail=="")
	{
		smail=$("#hid_mail_disp_count").val();
	}
	document.getElementById('action_gif').style.display= 'block';

	var fdrname = document.getElementById('hid_active_fldr').value;
	var type = 'set';
	
	$.ajax({
		type : "GET",
		url : "${pageContext.request.contextPath}/webmailFlagAtion",
		data : {
			'folder' : fdrname,
			'flagtp' : type,
			'uid' : smail
		},
		contentType : "application/json",			
		success : function(data) {
			var arr=smail.split("-");
			for(i=0;i<arr.length;i++)
				{
				var pview=document.getElementById("hid_previewPane").value;
				try
				{
					var nm=$('#chk_id_'+arr[i]).attr('name');
					//nm= nm.replace("unstared", "stared");	
					var nm_arr=nm.split('-');
					$('#chk_id_'+arr[i]).attr('name',nm_arr[0]+"-stared");
				}
				catch (e) {
					// TODO: handle exception
				}
				if(pview=="Vertical view")
						{
					    var flg_id = "left_div_flag_" + arr[i];
					  // $("#"+flg_id).html("<img src='images/star-flag.png'>");
					    document.getElementById(flg_id).className = 'new_flag_color';
						$(".new_flag_color").css("color",$("#hid_mail_bgColor").val());
						var disp_flg_id = "flag_div_disp_" + arr[i];
						try {
							document.getElementById(disp_flg_id).className = 'bottom_flag_red';
							$(".bottom_flag_red").css("color",$("#hid_mail_bgColor").val());
							}
							catch(err) {
							
							}

						 }
					else
						{
						var flg_id = "div_flag_" + arr[i];
						document.getElementById(flg_id).className = 'small_image_flag';
						$(".small_image_flag").css("color",$("#hid_mail_bgColor").val());
						var disp_flg_id = "flag_div_disp_" + arr[i];
						try {
							document.getElementById(disp_flg_id).className = 'bottom_flag_red';
							$(".bottom_flag_red").css("color",$("#hid_mail_bgColor").val());
							}
							catch(err) {
							
							}
						} 
				
				
				}
				document.getElementById('action_gif').style.display= 'none';

		}
	});
	
}


function setSetectedMailFlagDisp() {
	
//	document.getElementById('action_gif').style.display= 'block';
//	backToMailList();
	setSetectedMailFlag();
}



function setSetectedMailUnFlag() {
	var smail= getSelectdMailUid();
	if(smail==null || smail=="")
	{
		smail=$("#hid_mail_disp_count").val();
	}
	document.getElementById('action_gif').style.display= 'block';

	var fdrname = document.getElementById('hid_active_fldr').value;
	var type = 'remove';
	
	$.ajax({
		type : "GET",
		url : "${pageContext.request.contextPath}/webmailFlagAtion",
		data : {
			'folder' : fdrname,
			'flagtp' : type,
			'uid' : smail
		},
		contentType : "application/json",			
		success : function(data) {
			
			var arr=smail.split("-");
			for(i=0;i<arr.length;i++)
				{
				
				try
				{
					var nm=$('#chk_id_'+arr[i]).attr('name');
					//nm= nm.replace("stared", "unstared");	
					var nm_arr=nm.split('-');
					$('#chk_id_'+arr[i]).attr('name',nm_arr[0]+"-unstared");
				}
				catch (e) {
					// TODO: handle exception
				}
				var pview=document.getElementById("hid_previewPane").value;
				if(pview=="Vertical view")
						{
					    var flg_id = "left_div_flag_" + arr[i];
					    document.getElementById(flg_id).className ='new_flag';
					    $(".new_flag").css("color","#c8c8c8");
					 /*   $("#"+flg_id).html("<img src='images/star-flag.png'>"); */
					    var disp_flg_id = "flag_div_disp_" + arr[i];

					    try {
					    		document.getElementById(disp_flg_id).className = 'bottom_flag';
					    		$(".bottom_flag").css("color","#c8c8c8");
					    		}
					    	catch(err) {
					        
					    		}
						}
					else
						{
						var flg_id = "div_flag_" + arr[i];
						document.getElementById(flg_id).className = 'small_image';
						$(".small_image").css("color","#c8c8c8");
						 var disp_flg_id = "flag_div_disp_" + arr[i];

						    try {
						    		document.getElementById(disp_flg_id).className = 'bottom_flag';
						    		$(".bottom_flag").css("color","#c8c8c8");
						    		}
						    	catch(err) {
						        
						    		}
						}
				
				
				}
				document.getElementById('action_gif').style.display= 'none';

		}
	});
	
}


function setSetectedMailUnFlagDisp() {
	
	//document.getElementById('action_gif').style.display= 'block';
	//backToMailList();
	setSetectedMailUnFlag();
}

</script>

<script type="text/javascript">
function pagiNextPage() {
	
	//alert(window.nextflg);
if( window.nextflg!="false" )
{
	
	window.nextflg="false";
	var pcnt=parseInt(document.getElementById("hid_pagi_pcnt").value);
	var allml=parseInt(document.getElementById("hid_pagi_allmail").value);
	var cntlmt=parseInt($("#hid_mail_list_limit").val());
	 var lmt=pcnt+1;
	 var sml=pcnt*cntlmt;
	var all=pcnt*cntlmt;
	if(all<=allml)
		{
		noneMail();
		//alert(all);
		var s=(pcnt*cntlmt)+1;
		var e=(pcnt*cntlmt)+cntlmt;
		if(e>allml)
			{
			e=allml;
			}
		document.getElementById("pagination_div").innerHTML=''+s+" - "+e+" of "+allml;
		 $("#pagination_div").attr('title', ''+s+" - "+e+" of "+allml);
		document.getElementById("hid_pagi_pcnt").value=lmt;
		var dtsort=document.getElementById("hid_dt_sorting").value;
		var path="getMailInbox";
		if(dtsort=="down")
			{
			path="getMailInboxDesc";
			}
	var pfldr=document.getElementById('hid_active_fldr').value;
	//document.getElementById('hid_active_fldr').value=fdrname;
	//document.getElementById(pfldr).className = "";
	//document.getElementById(fdrname).className = "active_mailbox";
	var start=''+sml;
	var end=$("#hid_mail_list_limit").val();
	var pview=document.getElementById("hid_previewPane").value;
	document.getElementById('action_gif').style.display= 'block';
		$.ajax({
					type : "GET",
					url : "${pageContext.request.contextPath}/"+path,
					data : {
						'folder' : pfldr,
						'start' : start,
						'end' : end,
						'pview' : pview
					},
					contentType : "application/json",
					success : function(data) {
						// $("#fileSystem").html(data);
						// alert(data);
						$("#inb_cnt_div").html(data);
						document.getElementById('action_gif').style.display= 'none';
						window.nextflg="true";
						if($("#hid_previewPane").val()=="Vertical view")
						{
						shiftViewLeft();
						}
					    else
						{
						toggleViewPanel();
						}
						$(".small_image_flag").css("color",$("#hid_mail_bgColor").val());
		            	$(".new_flag_color").css("color",$("#hid_mail_bgColor").val());
									
						//getAllMailCount(pfldr);
					}
				});
		
		
		}
	
	}
	
}


function pagiPrevPage() {
	
	//alert(window.prevflg);
	if( window.prevflg!="false" )
	{
		
		window.prevflg="false";
	var pcnt=parseInt(document.getElementById("hid_pagi_pcnt").value);
	var allml=parseInt(document.getElementById("hid_pagi_allmail").value);
	var cntlmt=parseInt($("#hid_mail_list_limit").val());
	 var lmt=pcnt-1;
	 var sml=(lmt*cntlmt)-cntlmt;
	var all=lmt*cntlmt;
	if(all>0)
		{
		noneMail();
		var s=(lmt*cntlmt)-cntlmt+1;
		var e=(lmt*cntlmt);
		if(e>allml)
			{
			e=allml;
			}
		document.getElementById("pagination_div").innerHTML=''+s+" - "+e+" of "+allml;
		$("#pagination_div").attr('title', ''+s+" - "+e+" of "+allml);
		document.getElementById("hid_pagi_pcnt").value=lmt;
		var dtsort=document.getElementById("hid_dt_sorting").value;
		var path="getMailInbox";
		if(dtsort=="down")
			{
			path="getMailInboxDesc";
			}
		var pfldr=document.getElementById('hid_active_fldr').value
		var start=''+sml;
		var end=$("#hid_mail_list_limit").val();
		document.getElementById('action_gif').style.display= 'block';
		var pview=document.getElementById("hid_previewPane").value;
		$.ajax({
					type : "GET",
					url : "${pageContext.request.contextPath}/"+path,
					data : {
						'folder' : pfldr,
						'start' : start,
						'end' : end,
						'pview' : pview
					},
					contentType : "application/json",
					success : function(data) {
						$("#inb_cnt_div").html(data);
						document.getElementById('action_gif').style.display= 'none';
						window.prevflg="true";
						if($("#hid_previewPane").val()=="Vertical view")
						{
						shiftViewLeft();
						}
					    else
						{
						toggleViewPanel();
						}
						$(".small_image_flag").css("color",$("#hid_mail_bgColor").val());
		            	$(".new_flag_color").css("color",$("#hid_mail_bgColor").val());
						//getAllMailCount(pfldr);
					}
				});
		}
		
		}
	
}
</script>

<script type="text/javascript">
function getMailCnt(uid) 
{
	
	//alert(uid);
	noneMailDisplay();
	$('.tag_main').css('display','block');
	$('.folder_view').css('display','block');
	 var fdrname = document.getElementById('hid_active_fldr').value;
	if(fdrname=="Drafts" || fdrname=="drafts" || fdrname=="DRAFTS")
		{

		/* 	var hid_to=document.getElementById("hid_draft_to_"+uid).value ;
			var hid_cc=document.getElementById("hid_draft_cc_"+uid).value ;
			var hid_bcc=document.getElementById("hid_draft_bcc_"+uid).value ;
			var hid_sub=document.getElementById("hid_draft_sub_"+uid).value ;
			var hid_cnt=document.getElementById("hid_draft_cnt_"+uid).value ;
			
			var attch=($( "#hid_draft_attach_status_"+uid ).val()).trim();
			var array_name = new Array();
			var array_size = new Array();
			var tmp_cnt=$( "#hid_draft_attach_cnt_"+uid ).val();
			var cnt=0;
			if(tmp_cnt!=null && tmp_cnt!="")
				{
				cnt=parseInt(tmp_cnt);
				}
			if(attch=="yes" || attch=="Yes" || attch=="YES")
				{
				
				for(i=1;i<= cnt;i++)
					{
					var flnm_id="hid_draft_attach_name_"+uid+"_"+i;
					var flsz_id="hid_draft_attach_size_"+uid+"_"+i;
					array_name[i-1]=($( "#"+flnm_id ).val());
					array_size[i-1]=($( "#"+flsz_id ).val());
					}
				
				}
			 */
			
			//alert(hid_cnt);
			document.getElementById('action_gif').style.display= 'block';
			var requestPage="${pageContext.request.contextPath}/draftToComposeOpen";
			jQuery.post(requestPage,
		                            {
		                 'draft_mail_uid': uid, 'fdrname': fdrname
		            }, 
		                    function( data ) {
		            	document.getElementById('div_for_inbox').style.display= 'none';
		            	document.getElementById('div_for_compose').style.display= 'block';
		            	document.getElementById('action_gif').style.display= 'none';
		             $( "#div_for_compose" ).html( data );
		             
		            });
			
		}
	else
		{
		
		var maildraft=$("#mailDraft_"+uid).val();
		if(maildraft=="true")
			{
			document.getElementById('action_gif').style.display= 'block';
			var requestPage="${pageContext.request.contextPath}/draftToComposeOpen";
			jQuery.post(requestPage,
		                            {
		                 			'draft_mail_uid': uid, 'fdrname': fdrname
		            				}, 
		                    function( data ) {
		            	document.getElementById('div_for_inbox').style.display= 'none';
		            	document.getElementById('div_for_compose').style.display= 'block';
		            	document.getElementById('action_gif').style.display= 'none';
		             $( "#div_for_compose" ).html( data );
		             
		            });
			}
		else
			{
	var pview=document.getElementById("hid_previewPane").value;
	document.getElementById('action_gif').style.display= 'block';
	document.getElementById('div_search_tool').style.display = "block";
	
	document.getElementById("div_hid_opt1").className="hidden_option";
	document.getElementById("div_hid_opt2").className="hidden_option";
	$("#hid_mail_disp_count").val(uid);
	// document.getElementById("chk_id_"+uid).checked = true;
	/* var str= document.getElementById("unread_inbox").innerHTML;
		var res = str.substr(1, (str.length-2));
		var num=parseInt(res);
		num--;
		if(num!=0)
			{
			res="("+ num+")";
			}
		else
			{
			res="";
			}
		*/
	if(pview=="Vertical view")
		{
		//selMailCountInPanel();
		document.getElementById("div_"+uid).className="row_content selected_row left_view_mess";
		
		$.ajax({
			type : "GET",
			url : "${pageContext.request.contextPath}/getMailContentByUid",
			data : {
				'folder' : fdrname,
				'uid' : uid
			},
			contentType : "application/json",
			success : function(data) {
				if(data=="<$expire$>")
				{
					location.href ="${pageContext.request.contextPath}/inbox";
				}
				else if(data=="<nps>")
				{
				showmsg("alert","Message not found");
				document.getElementById('action_gif').style.display= 'none';
				}
			else
				{
				//alert(data);
				data = data.replace(/\.mail_content/g, '.mail_content_np');
				//alert(data);
				document.getElementById('hid_no_cnt').style.display= 'none';
				document.getElementById('div_left_cnt').style.display= 'block';
				document.getElementById('action_gif').style.display= 'none';
				$("#div_left_cnt").html(data);
				$(".bottom_flag_red").css("color",$("#hid_mail_bgColor").val());
				//document.getElementById("unread_inbox").innerHTML=res;
				document.getElementById("div_unread_"+uid).className ="row_left left_view_con";
				$(".mail_content_1 a").attr("target","_blank");
				
				
				
				//var inline=parseInt($('#hid_inline_sz').val())-parseInt($('#hid_attch_sz').val())
				var inline=parseInt($('#hid_inline_sz').val());
				if(inline>0)
					{
					
					// var i=1;
					 $('.mail_content_1 img').each(function(){
						 var str = $(this).attr('src');
					
						  if ( str.startsWith("cid:"))
				    	   {
							  str=str.replace("cid:","");
							  str = str.replace(/@/g, '_');
							  str = str.replace(/\./g, '_');
							  $(this).attr('src',$('#'+str).val());
				   		  // $(this).removeAttr('width');
						  // $(this).removeAttr('height');
				    	   //i++;
				    	   
				    	   } 
						
						 });
					
					
					}
				 
				
				
				
				
				if(fdrname=="inbox" || fdrname=="INBOX" || fdrname=="Inbox" )
				{
				inboxUnread()
				}
				
				try
				{
				var nm=$('#chk_id_'+uid).attr('name');
				var nm_arr=nm.split('-');
				$('#chk_id_'+uid).attr('name',"seen-"+nm_arr[1]);
			}
			catch (e) {
				// TODO: handle exception
			}
			
			
		
			var rulesForCssText = function (styleContent) { 
			var doc = document.implementation.createHTMLDocument(''),styleElement = document.createElement('style');
			styleElement.textContent = styleContent;doc.body.appendChild(styleElement);
			return styleElement.sheet.cssRules;
			};
			$('.mail_content_1 style').each(function(){
				var modfieddCss = '';
				var currentCss =  rulesForCssText($(this).html());
				
				$(this).html('');
				for(var i =0; i< currentCss.length;i++)
				{
					if(currentCss[i].cssRules != undefined && currentCss[i].media != undefined)
						{
						var media ='';media += '@media ' + currentCss[i].media[0] +'{';for(var j =0; j< currentCss[i].cssRules.length;j++){media+= '.mail_content_1 '  + currentCss[i].cssRules[j].cssText;}media+='}';
						modfieddCss+= media;
						}
					else
						{
						modfieddCss+= '.mail_content_1 '  + currentCss[i].cssText; 
						} 
				}
				$(this).html(modfieddCss);
				}); 
			}
			}
		});
		}
	else
		{
		var ur_scc="row_left";
		document.getElementById("div_"+uid).className="row_content selected_row pading_main";
		
		$.ajax({
			type : "GET",
			url : "${pageContext.request.contextPath}/getMailContentFullPageByUid",
			data : {
				'folder' : fdrname,
				'uid' : uid
			},
			/*  contentType : "application/json", */
			contentType : 'application/json; charset=UTF-8',
			success : function(data) {
				if(data=="<$expire$>")
				{
					location.href ="${pageContext.request.contextPath}/inbox";
				}
				else if(data=="<nps>")
				{
				showmsg("alert","Message not found");
				document.getElementById('action_gif').style.display= 'none';
				}
				else
					{
				data = data.replace(/\.mail_content/g, '.mail_content_np');
				document.getElementById('div_half_pg_disp').style.display= 'none';
				document.getElementById('div_full_pg_disp').style.display= 'block';
				document.getElementById('action_gif').style.display= 'none';
				$("#div_full_pg_disp").html(data);
				$(".bottom_flag_red").css("color",$("#hid_mail_bgColor").val());
				$('.mail_content').css('height',left_scollx-109);
				document.getElementById("div_unread_"+uid).className ="row_left";
				$(".mail_content_1 a").attr("target","_blank");
				
			
			//	var inline=parseInt($('#hid_inline_sz').val())-parseInt($('#hid_attch_sz').val())
			var inline=parseInt($('#hid_inline_sz').val());
				if(inline>0)
					{
					
					 var i=1;
					 $('.mail_content_1 img').each(function(){
						 var str = $(this).attr('src');
					
						  if ( str.startsWith("cid:"))
				    	   {
							str=str.replace("cid:","");
							str = str.replace(/@/g, '_');
							  str = str.replace(/\./g, '_');
							$(this).attr('src',$('#'+str).val());
				   		   /* $(this).removeAttr('width');
						   $(this).removeAttr('height');
				    	   i++; */
				    	   
				    	   } 
						
						 });
					
					
					
					
					
					
					
					/* var i=1;
				var iimg=$('.mail_content_1 img').ready(function() {
				});
				var len = iimg.length;
				var j=0;
				 while (j<len) {
				       // images[i].src = images[i].alt;
				       alert(iimg[j].src);
				       var str=iimg[j].src;
				       if (str.startsWith("cid:"))
				    	   {
				    	   iimg[j].src=$('#inline_img_'+i).val();
				    	  
				    	   i++;
				    	   if(i>inline)
				    		   {
				    		   break;
				    		   }
				    	   }
				       j++;
				    } */
				
					}
				 
				 
				 
				 
				if(fdrname=="inbox" || fdrname=="INBOX" || fdrname=="Inbox" )
				{
				inboxUnread()
				}
				try
				{
				var nm=$('#chk_id_'+uid).attr('name');
				var nm_arr=nm.split('-');
				$('#chk_id_'+uid).attr('name',"seen-"+nm_arr[1]);
			}
			catch (e) {
				// TODO: handle exception
			}
			
			

			var rulesForCssText = function (styleContent) { 
			var doc = document.implementation.createHTMLDocument(''),styleElement = document.createElement('style');
			styleElement.textContent = styleContent;doc.body.appendChild(styleElement);
			return styleElement.sheet.cssRules;
			};
			$('.mail_content_1 style').each(function(){
				var modfieddCss = '';
				var currentCss =  rulesForCssText($(this).html());
				
				$(this).html('');
				for(var i =0; i< currentCss.length;i++)
				{
					if(currentCss[i].cssRules != undefined && currentCss[i].media != undefined)
					{
						var media ='';media += '@media ' + currentCss[i].media[0] +'{';for(var j =0; j< currentCss[i].cssRules.length;j++){media+= '.mail_content_1 '  + currentCss[i].cssRules[j].cssText;}media+='}';
						modfieddCss+= media;
						}
					else {
						modfieddCss+= '.mail_content_1 '  + currentCss[i].cssText; 
						} 
					}$(this).html(modfieddCss);}); 
					}
			}
		});
		
		
		}
			}
		}
}

function inboxUnread() {
	
	$.ajax({
		type : "GET",
		url : "${pageContext.request.contextPath}/getUnreadMailCountInfolderDiv",
		data : {
			'fdr' : 'inbox'
			
		},
		contentType : "application/json",
		success : function(data) {
			
			$("#unread_inbox").html(data);
			
			
		}
	});
	
}


function panelView(val) {
	document.getElementById("hid_previewPane").value=val;
}



function selMailCountInPanel()
{
	
	var msg="No";
	var cnt=0;
	var inputElements1 = document.getElementsByName('unseen-stared');
	for(var i=0; inputElements1[i]; ++i){
	      if(inputElements1[i].checked){
				cnt++;
	          
	      }
	}

	var inputElements2 = document.getElementsByName('unseen-unstared');
	for(var i=0; inputElements2[i]; ++i){
	      if(inputElements2[i].checked){
	    	  cnt++;
	          
	      }
	}

	var inputElements3 = document.getElementsByName('seen-unstared');
	for(var i=0; inputElements3[i]; ++i){
	      if(inputElements3[i].checked){
	    	  cnt++;
	          
	      }
	}


	var inputElements4 = document.getElementsByName('seen-stared');
	for(var i=0; inputElements4[i]; ++i){
	      if(inputElements4[i].checked){
	    	  cnt++;
	          
	      }
	}

	if(cnt>0)
		{
		msg=""+cnt;
		if(cnt==1)
			{
			var rem_uid=$("#hid_mail_disp_count").val();
			if(rem_uid!=null && rem_uid!="")
				{
			//	alert(rem_uid);
				$('#div_'+rem_uid).removeClass('selected_row');
				$("#hid_mail_disp_count").val("");
				}
			}
		$('.tag_main').css('display','block');
		$('.folder_view').css('display','block');
		}
	if(cnt==0)
		{
		$('.tag_main').css('display','none');
		$('.folder_view').css('display','none');
		}
	//alert(cnt)
	document.getElementById("span_con").innerHTML=msg;
	document.getElementById("div_left_cnt").style.display= 'none';
	document.getElementById("hid_no_cnt").style.display= 'block';
}


</script>

<script type="text/javascript">
function downloadAttach(uid,name) {
	//alert("uid="+uid);
	//alert("name="+name);
	var fdrname = document.getElementById('hid_active_fldr').value;
	$.ajax({
		type : "GET",
		url : "${pageContext.request.contextPath}/downloadMailAttachByName",
		data : {
			'folder' : fdrname,
			'uid' : uid,
			'name' : name
		},
		contentType : "application/json",
		success : function(data) {
			//alert(data)
			//document.getElementById('hid_no_cnt').style.display= 'nopenReply()one';
			//$("#div_left_cnt").html(data);
			
		}
	});
}

function backToMailList() {
	try
	{
	document.getElementById('div_half_pg_disp').style.display= 'block';
	document.getElementById('div_full_pg_disp').style.display= 'none';
	}
	catch (e) {
		// TODO: handle exception
	}
}
</script>

<script type="text/javascript">
function mailCompose() {
	//alert('hi');
	document.getElementById('action_gif').style.display= 'block';
	var requestPage="${pageContext.request.contextPath}/composeMailView";
	jQuery.get(requestPage,
            /*                  {
                    'path' : folderPath
            }, */
          {
            	cache: true 
          },
                    function( data ) {
            	document.getElementById('div_for_inbox').style.display= 'none';
            	document.getElementById('div_for_compose').style.display= 'block';
            	document.getElementById('action_gif').style.display= 'none';
             $( "#div_for_compose" ).html( data );
             $("#hid_to_mail_uid").val("");
             $("#hid_upload_file_size").val("");
             
             var cntt ="";
             if($('#hid_editor_type').val()!="plain")
     		{
             cntt = CKEDITOR.instances['editor1'].getData();
     		}
             else
            	 {
            	 cntt = $('#editor1').val();
            	 }
             
              var miliSecond = 30*1000;
             $("#hid_active_compose").val("true");
            // setTimeout(function(){ ckadd(); }, 1000); 
             setTimeout(function(){ autoDraftSetTime(cntt,false); }, miliSecond); 
            
            
             
            }
	);
}

/* function ckadd() {
	var ck_sign=$("#ck_sign").val();
  	//alert(cntt)
  	var cntt = CKEDITOR.instances['editor1'].getData();
  	cntt="<br><div style='padding-left: 5px; border-left: #1010ff 2px solid;  margin-left: 5px;  width: 98%;'>"+cntt+"</div>";
  	cntt=cntt+"<br>"+ck_sign;
  	var oEditor = CKEDITOR.instances;
	oEditor.editor1.setData(cntt); 
     
} */

function autoDraftSetTime(cntt, sts) {
	var act_com= $("#hid_active_compose").val();
	//alert(act_com);
	if(act_com!=null && act_com!="")
		{
		var new_cntt="";
		if($('#hid_editor_type').val()!="plain")
 		{
		 new_cntt=  CKEDITOR.instances['editor1'].getData();
 		}
		else
			{
			new_cntt=  $('#editor1').val();
			}
	// alert(cntt)
	 //alert(new_cntt)
	 if(sts== true)
		 {
	if(cntt==new_cntt)
		{
		console.info('same');
		
		}
	else
		{
		console.info('not same');
		 mailSaveInDraft()
		
		}
		 }
	
	 	var miliSecond = 30*1000;
	 	setTimeout(function(){ autoDraftSetTime(new_cntt, true); }, miliSecond);
		}
	
}
 
 
 
function backFromCompose() {
	
	$("#hid_active_compose").val("");
		$("#hid_to_draft_mail_uid").val("");
		$("#hid_to_mail_uid").val("");
		
		document.getElementById('div_for_inbox').style.display=  'block'; 
		document.getElementById('div_for_compose').style.display='none'; 
}
	
	
function backFromComposeNew() {
	//alert("hi")
	
	
	
	  $('.web_dialog_overlay').show(); 
		var confirm = generate_savedraft('confirm');
   	$.noty.setText(confirm.options.id, 'Do you want to save your message in Draft?');
	
}


function discardCompose(){
	 $('.web_dialog_overlay').show(); 
		var confirm = generate_backcomp('confirm');
  	$.noty.setText(confirm.options.id, 'Do you want to discard your message?');
}


function delImage(){
	 $('.web_dialog_overlay').show(); 
		var confirm = generate_delImage('confirm');
 	$.noty.setText(confirm.options.id, 'Do you want to remove your picture?');
}


function generate_delImage(type) {
	 //  alert(id);
   var n = noty({
     text        : type,
     type        : type,
     theme       : 'relax',
     dismissQueue: false,
     layout      : 'center',
     theme       : 'defaultTheme',
     buttons     : (type != 'confirm') ? false : [
         {addClass: 'btn btn-primary', text: 'Yes', onClick: function ($noty) {
			 $noty.close();
			 $('.web_dialog_overlay').hide(); 
			 document.getElementById('action_gif').style.display= 'block';
			 $.ajax({
		         type: "POST",
		         url: "${pageContext.request.contextPath}/delDPImage",
		        
		        /*  contentType: "application/json", */
		         success: function (data) {
		        	 
		        	 var mid=$("#hid_logedin_id").val();
		 	    	var sml_id=mid+"nomyimage";
		 	    	var big_id="big_"+mid+"nomyimage";
		 	    	var set_id="set_"+mid+"nomyimage";
		 	    	try
		 	    	{
		 	    	document.getElementById(sml_id).src="images/blank_man.jpg";
		 	    	document.getElementById(big_id).src="images/blank_man.jpg";
		 	    	document.getElementById("chat_id_bd").src="chat/photo.jpg";
		 	    	document.getElementById("chat_id").src="chat/photo.jpg";
		 	    	
		 	    		document.getElementById(set_id).src="images/blank_man.jpg";
		 	    	}
		 	    	catch(err) {
		 	    		
		 	    	}
		 	    	 
		 	    	document.getElementById('action_gif').style.display= 'none';
		         }
			 });
}
         },
         {addClass: 'btn btn-danger', text: 'No', onClick: function ($noty) {

			 $noty.close();
			 $('.web_dialog_overlay').hide(); 
        
		}
         }
     ]
 });

     
     //console.log(type + ' - ' + n.options.id);
     return n; 
      
 }

function generate_savedraft(type) {
	 //  alert(id);
    var n = noty({
      text        : type,
      type        : type,
      theme       : 'relax',
      dismissQueue: false,
      layout      : 'center',
      theme       : 'defaultTheme',
      buttons     : (type != 'confirm') ? false : [
          {addClass: 'btn btn-primary', text: 'Yes', onClick: function ($noty) {
			 $noty.close();
			 
			 

				//alert("hi")
				var to=document.getElementById("hid_to_id").value;
				
				var uid=document.getElementById("hid_to_mail_uid").value;
				
				var cc=document.getElementById("hid_cc_id").value;
				
				
				var bcc=document.getElementById("hid_bcc_id").value;
				
				
				var sub=document.getElementById("sub_id").value;
				
				var texttype="html";
				var cntt ="";
				if($('#hid_editor_type').val()!="plain")
		 		{
				var cntt = CKEDITOR.instances['editor1'].getData();
		 		}
				else
					{
					var cntt = $('#editor1').val();
					texttype="plain";
					}
				
				if(!((to==null || to=="") && (cc==null || cc=="") && (bcc==null || bcc=="") && (sub==null || sub=="") && (cntt==null || cntt=="")))
				{
					window.draftProgress=false;
					$.ajax({
				         type: "POST",
				         url: "${pageContext.request.contextPath}/mailSaveInDraft",
				         data: {'uid': uid,'to':to, 'cc':cc, 'bcc':bcc, 'sub':sub, 'cntt':cntt, 'texttype': texttype },
				        /*  contentType: "application/json", */
				         success: function (data) {
				            
				            window.draftProgress=true;
				           // alert(data);
				            
				            getDraftMailCount();
				             
				            $('.web_dialog_overlay').hide(); 
				            $("#hid_active_compose").val("");
				      		$("#hid_to_draft_mail_uid").val("");
				      		$("#hid_to_mail_uid").val("");
				      		
				      		document.getElementById('div_for_inbox').style.display=  'block'; 
				      		document.getElementById('div_for_compose').style.display='none'; 
				      		if($("#search_pagi").css('display')=='none')
				      		{
				      		var fdrname=document.getElementById('hid_active_fldr').value;
				      		//alert(fdrname)
				      		$('.active_left_tree').css('border-left-color','#fff');
							$('.active_left_tree').removeClass('active_left_tree');
							$("#fldr_"+fdrname).addClass('active_left_tree');
							$(".active_left_tree").css("border-left","3px solid "+$("#hid_mail_bgColor").val());
							if(fdrname=="Drafts" || fdrname=="drafts")
						  		getWebmailInbox( fdrname);
				      		}
				         }
				     });
				}
				else
					{
					 $('.web_dialog_overlay').hide(); 
			         $("#hid_active_compose").val("");
			   		$("#hid_to_draft_mail_uid").val("");
			   		$("#hid_to_mail_uid").val("");
			   		
			   		document.getElementById('div_for_inbox').style.display=  'block'; 
			   		document.getElementById('div_for_compose').style.display='none';
			   		if($("#search_pagi").css('display')=='none')
		      		{
			   		var fdrname=document.getElementById('hid_active_fldr').value;
			   		//alert(fdrname)
			   		$('.active_left_tree').css('border-left-color','#fff');
					$('.active_left_tree').removeClass('active_left_tree');
					$("#fldr_"+fdrname).addClass('active_left_tree');
					$(".active_left_tree").css("border-left","3px solid "+$("#hid_mail_bgColor").val());
					if(fdrname=="Drafts" || fdrname=="drafts")
				  		getWebmailInbox( fdrname);
					}
					}
			 
        
          }
          },
          {addClass: 'btn btn-danger', text: 'No', onClick: function ($noty) {

 			 $noty.close();
         
 			 
 		var duid=	 $("#hid_to_draft_mail_uid").val();
 		var muid=  		$("#hid_to_mail_uid").val();
 			// alert("duid="+duid);
 			// alert("muid="+muid);
 			 
 			 if(duid!="" || muid!="" )
 				 {
 				 var uid=duid;
 				 if(muid!=null && muid!="")
 					 {
 				 	if(uid!=null && uid!="")
 					 {
 				 		uid=uid+"-"+muid;
 					 }
 				 	else
 				 		{
 				 		uid=muid;
 				 		}
 					 }
 				 document.getElementById('action_gif').style.display= 'block';
 				 var requestPage="${pageContext.request.contextPath}/deleteDraftMail";
 					jQuery.get(requestPage,
 				                            {
 				                    'uid' : uid
 				            },
 				                    function( data ) {
 				            	 $('.web_dialog_overlay').hide(); 
 						         $("#hid_active_compose").val("");
 						  		$("#hid_to_draft_mail_uid").val("");
 						  		$("#hid_to_mail_uid").val("");
 						  		document.getElementById('action_gif').style.display= 'none';
 						  		document.getElementById('div_for_inbox').style.display=  'block'; 
 						  		document.getElementById('div_for_compose').style.display='none';
 						  		getDraftMailCount();
 						  		
 						  		if($("#search_pagi").css('display')=='none')
 						  			{
 							  		var fdrname=document.getElementById('hid_active_fldr').value;
 							  		//alert(fdrname)
 							  		$('.active_left_tree').css('border-left-color','#fff');
 									$('.active_left_tree').removeClass('active_left_tree');
 									$("#fldr_"+fdrname).addClass('active_left_tree');
 									$(".active_left_tree").css("border-left","3px solid "+$("#hid_mail_bgColor").val());
 							  		if(fdrname=="Drafts" || fdrname=="drafts")
 							  		getWebmailInbox( fdrname);
 						  			}
 				            });
 				 
 				 }
 			 else
 				 {
 				  $('.web_dialog_overlay').hide(); 
 			        $("#hid_active_compose").val("");
 			  		$("#hid_to_draft_mail_uid").val("");
 			  		$("#hid_to_mail_uid").val("");
 			  		
 			  		document.getElementById('div_for_inbox').style.display=  'block'; 
 			  		document.getElementById('div_for_compose').style.display='none';
 			  		if($("#search_pagi").css('display')=='none')
 		  			{
 			  		var fdrname=document.getElementById('hid_active_fldr').value;
 			  		//alert(fdrname)
 			  		$('.active_left_tree').css('border-left-color','#fff');
 					$('.active_left_tree').removeClass('active_left_tree');
 					$("#fldr_"+fdrname).addClass('active_left_tree');
 					$(".active_left_tree").css("border-left","3px solid "+$("#hid_mail_bgColor").val());
 		  			}
 				 }
        
           
           
          }
          }
      ]
  });
 
      
      //console.log(type + ' - ' + n.options.id);
      return n; 
       
  }

function generate_backcomp(type) {
	 //  alert(id);
    var n = noty({
      text        : type,
      type        : type,
      theme       : 'relax',
      dismissQueue: false,
      layout      : 'center',
      theme       : 'defaultTheme',
      buttons     : (type != 'confirm') ? false : [
          {addClass: 'btn btn-primary', text: 'Yes', onClick: function ($noty) {
			 $noty.close();
        
			 
		var duid=	 $("#hid_to_draft_mail_uid").val();
		var muid=  		$("#hid_to_mail_uid").val();
			// alert("duid="+duid);
			// alert("muid="+muid);
			 
			 if(duid!="" || muid!="" )
				 {
				 var uid=duid;
				 if(muid!=null && muid!="")
					 {
				 	if(uid!=null && uid!="")
					 {
				 		uid=uid+"-"+muid;
					 }
				 	else
				 		{
				 		uid=muid;
				 		}
					 }
				 document.getElementById('action_gif').style.display= 'block';
				 var requestPage="${pageContext.request.contextPath}/deleteDraftMail";
					jQuery.get(requestPage,
				                            {
				                    'uid' : uid
				            },
				                    function( data ) {
				            	 $('.web_dialog_overlay').hide(); 
						         $("#hid_active_compose").val("");
						  		$("#hid_to_draft_mail_uid").val("");
						  		$("#hid_to_mail_uid").val("");
						  		document.getElementById('action_gif').style.display= 'none';
						  		document.getElementById('div_for_inbox').style.display=  'block'; 
						  		document.getElementById('div_for_compose').style.display='none';
						  		getDraftMailCount();
						  		
						  		if($("#search_pagi").css('display')=='none')
						  			{
							  		var fdrname=document.getElementById('hid_active_fldr').value;
							  		//alert(fdrname)
							  		$('.active_left_tree').css('border-left-color','#fff');
									$('.active_left_tree').removeClass('active_left_tree');
									$("#fldr_"+fdrname).addClass('active_left_tree');
									$(".active_left_tree").css("border-left","3px solid "+$("#hid_mail_bgColor").val());
							  		if(fdrname=="Drafts" || fdrname=="drafts")
							  		getWebmailInbox( fdrname);
						  			}
				            });
				 
				 }
			 else
				 {
				  $('.web_dialog_overlay').hide(); 
			        $("#hid_active_compose").val("");
			  		$("#hid_to_draft_mail_uid").val("");
			  		$("#hid_to_mail_uid").val("");
			  		
			  		document.getElementById('div_for_inbox').style.display=  'block'; 
			  		document.getElementById('div_for_compose').style.display='none';
			  		if($("#search_pagi").css('display')=='none')
		  			{
			  		var fdrname=document.getElementById('hid_active_fldr').value;
			  		//alert(fdrname)
			  		$('.active_left_tree').css('border-left-color','#fff');
					$('.active_left_tree').removeClass('active_left_tree');
					$("#fldr_"+fdrname).addClass('active_left_tree');
					$(".active_left_tree").css("border-left","3px solid "+$("#hid_mail_bgColor").val());
		  			}
				 }
       
         /*
           $('.web_dialog_overlay').hide(); 
         $("#hid_active_compose").val("");
  		$("#hid_to_draft_mail_uid").val("");
  		$("#hid_to_mail_uid").val("");
  		
  		document.getElementById('div_for_inbox').style.display=  'block'; 
  		document.getElementById('div_for_compose').style.display='none'; */ 
          }
          },
          {addClass: 'btn btn-danger', text: 'No', onClick: function ($noty) {
              $noty.close();
           
              $('.web_dialog_overlay').hide(); 
       /*      var n1 = noty({
                  text        : 'You clicked "Cancel" button',
                  type        : 'error',
                  dismissQueue: false,
                  layout      : 'topCenter',
                  theme       : 'defaultTheme'
              });
             setTimeout(function () { $.noty.close(n1.options.id); }, 2000); */
          }
          }
      ]
  });
 
      
      //console.log(type + ' - ' + n.options.id);
      return n; 
       
  }



</script>
<script type="text/javascript">
function addTag() {
	var tagnm="";
	document.getElementById('action_gif').style.display= 'block';
	var chktag = document.getElementsByName('my_chk_tag');
	for(var i=0; chktag[i]; ++i)
	{
	      if(chktag[i].checked)
	      {
	    	  if(tagnm=="")
	    		  {
	    		  tagnm=chktag[i].value;
	    		  }
	    	  else
	    		  {
	    		  tagnm=tagnm+"~"+chktag[i].value;
	    		  }
			  	
		}
	}
	var uids="";
	var inputElements1 = document.getElementsByName('unseen-stared');
	for(var i=0; inputElements1[i]; ++i){
	      if(inputElements1[i].checked){
				if(uids=="")
					{
					uids=inputElements1[i].value;
					}
				else
					{
					uids=uids+"-"+inputElements1[i].value;
					}
	          
	      }
	}

	var inputElements2 = document.getElementsByName('unseen-unstared');
	for(var i=0; inputElements2[i]; ++i){
	      if(inputElements2[i].checked){
	    	  if(uids=="")
				{
				uids=inputElements2[i].value;
				}
			else
				{
				uids=uids+"-"+inputElements2[i].value;
				}
	      }
	}

	var inputElements3 = document.getElementsByName('seen-unstared');
	for(var i=0; inputElements3[i]; ++i){
	      if(inputElements3[i].checked){
	    	  if(uids=="")
				{
				uids=inputElements3[i].value;
				}
			else
				{
				uids=uids+"-"+inputElements3[i].value;
				}
	      }
	}


	var inputElements4 = document.getElementsByName('seen-stared');
	for(var i=0; inputElements4[i]; ++i){
	      if(inputElements4[i].checked){
	    	  if(uids=="")
				{
				uids=inputElements4[i].value;
				}
			else
				{
				uids=uids+"-"+inputElements4[i].value;
				}
	      }
	}
	if(uids==null || uids=="")
	{
	uids=$("#hid_mail_disp_count").val();
	}
	//alert("ids="+uids);
	//alert(tagnm)
	$.ajax({
		type : "GET",
		url : "${pageContext.request.contextPath}/setWebmailTag",
		data : {
			'tagsnm' : tagnm,
			'uids' : uids
		},
		contentType : "application/json",
		success : function(data) {
			//alert(data)
			document.getElementById('action_gif').style.display= 'none';
			//document.getElementById('hid_no_cnt').style.display= 'none';
			//$("#div_left_cnt").html(data);
			
		}
	});
}
</script>
<script type="text/javascript">
function remMailTagFull(id) {
	//alert("id="+id);
	document.getElementById('action_gif').style.display= 'block';
	var arr=id.split("-");
	var nm=arr[1];
	var lastarr=nm.split("~");
	var uid=lastarr[0];
	var tagnm=lastarr[1];

	
	$.ajax({
		type : "GET",
		url : "${pageContext.request.contextPath}/removeWebmailTag",
		data : {
			'tagnm' : tagnm,
			'uid' : uid
		},
		contentType : "application/json",
		success : function(data) {
		//	alert(data)
			if(data=="true")
				{
				try
				{
				var id1="full_"+arr[1];
				document.getElementById(id1).remove();
				}
				catch (e) {
					// TODO: handle exception
				}
				try
				{
				var id2="list_"+arr[1];
				document.getElementById(id2).remove();
				}
				catch (e) {
					// TODO: handle exception
				}
				}
			document.getElementById('action_gif').style.display= 'none';
		}
	});
	
	
	
}
function remMailTagHalf(id) {
	//alert("id="+id);
	document.getElementById('action_gif').style.display= 'block';
	var arr=id.split("-");
	var nm=arr[1];
	var lastarr=nm.split("~");
	var uid=lastarr[0];
	var tagnm=lastarr[1];
	
	
	$.ajax({
		type : "GET",
		url : "${pageContext.request.contextPath}/removeWebmailTag",
		data : {
			'tagnm' : tagnm,
			'uid' : uid
		},
		contentType : "application/json",
		success : function(data) {
			//alert(data)
			if(data=="true")
				{
				
				try
				{
				var id1="disp_"+arr[1];
				document.getElementById(id1).remove();
				}
				catch (e) {
					// TODO: handle exception
				}
				try
				{
				var id2="list_"+arr[1];
				document.getElementById(id2).remove();
				}
				catch (e) {
					// TODO: handle exception
				}
				}
			document.getElementById('action_gif').style.display= 'none';
		}
	});
	
	
}
</script>
<script type="text/javascript">
function openSettingTemp() {
	document.getElementById('action_gif').style.display= 'block';
	var requestPage="${pageContext.request.contextPath}/settingOpenTemp";
	jQuery.get(requestPage,
            /*                  {
                    'path' : folderPath
            }, */
                    function( data ) {
            	document.getElementById('div_for_inbox').style.display= 'none';
            	document.getElementById('div_for_setting').style.display= 'block';
            	document.getElementById('action_gif').style.display= 'none';
            //alert(data);
            	$( "#div_for_setting" ).html( data );
            	$(".search_button").css("background-image","none");
    			$(".search_button").css("background-color",$("#hid_mail_bgColor").val());
    			 $('#hid_open_setting').val("true");
             var val = $('#accountSetting').val();
    	     val = val.replace(/\'/g, '\"');
    	     obj = JSON.parse(val);
    	     //alert(val);
    	      var np_pane=true;
    	     var np_dsn=true;
    	      $.each(obj, function(key,value) {
    	    	  
    	    
    	    	  if( value.name=="generalSettingNotification")
	    		  {
	    		  np_dsn=false;
	    		  }
	    	  if( value.name=="previewPane")
    		  {
	    		  np_pane=false;
    		  }

    	                  if ($('input[name="' + value.name + '"][value="' + value.value + '"]').length > 0)
    	                  {
    	                    
    	               $('input[name="' + value.name + '"][value="' + value.value + '"]').prop('checked', true);
    	                  }
    	                  else{
    	               $("[name=" + value.name + "]").val(value.value);
    	                  }
    	                  
    	                }); 
    	      try
    	      {
    	    	  if(np_pane)
    	    		  {
    	    		  $('input[name="previewPane"][value="Vertical view"]').prop('checked', true);
    	    		  }
    	      }
    	      catch (e) {
				// TODO: handle exception
			}
    	      
    	      try
    	      {
    	    	  if(np_dsn)
    	    		  {
    	    		  $('input[name="generalSettingNotification"][value="New mail notifications on"]').prop('checked', true);
    	    		  }
    	      }
    	      catch (e) {
				// TODO: handle exception
			}
             
            });
}



function openSettingProfile() {
	document.getElementById('action_gif').style.display= 'block';
	var requestPage="${pageContext.request.contextPath}/settingOpenTemp";
	jQuery.get(requestPage,
            /*                  {
                    'path' : folderPath
            }, */
                    function( data ) {
            	document.getElementById('div_for_inbox').style.display= 'none';
            	document.getElementById('div_for_setting').style.display= 'block';
            	document.getElementById('action_gif').style.display= 'none';
            //alert(data);
            	$( "#div_for_setting" ).html( data );
            	$(".search_button").css("background-image","none");
    			$(".search_button").css("background-color",$("#hid_mail_bgColor").val());
             var val = $('#accountSetting').val();
    	     val = val.replace(/\'/g, '\"');
    	     obj = JSON.parse(val);
    	     //alert(val);
    	     var np_pane=true;
    	     var np_dsn=true;
    	      $.each(obj, function(key,value) {
    	              
    	    	  if( value.name=="generalSettingNotification")
    	    		  {
    	    		  np_dsn=false;
    	    		  }
    	    	  if( value.name=="previewPane")
	    		  {
    	    		  np_pane=false;
	    		  }
    	    	  
    	                  if ($('input[name="' + value.name + '"][value="' + value.value + '"]').length > 0)
    	                  {
    	                    
    	               $('input[name="' + value.name + '"][value="' + value.value + '"]').prop('checked', true);
    	                  }
    	                  else{
    	               $("[name=" + value.name + "]").val(value.value);
    	                  }
    	                  
    	                }); 
    	      
    	      try
    	      {
    	    	  if(np_pane)
    	    		  {
    	    		  $('input[name="previewPane"][value="Vertical view"]').prop('checked', true);
    	    		  }
    	      }
    	      catch (e) {
				// TODO: handle exception
			}
    	      
    	      try
    	      {
    	    	  if(np_dsn)
    	    		  {
    	    		  $('input[name="generalSettingNotification"][value="New mail notifications on"]').prop('checked', true);
    	    		  }
    	      }
    	      catch (e) {
				// TODO: handle exception
			}
    	      
    	      $('.view_1').removeClass('setting_active');
    	      $('.view_3').addClass('setting_active');
    	      $('#view1').hide();
    	      $('#view3').css("display","block");
    	      $('#view2').hide();
    	      $('#view4').hide();
    	      $('#view5').hide();
    	      $('#view6').hide();
    	      $('#view7').hide();
             
            });
}



function openSettingFilter() {
	document.getElementById('action_gif').style.display= 'block';
	var requestPage="${pageContext.request.contextPath}/settingOpenTemp";
	jQuery.get(requestPage,
            /*                  {
                    'path' : folderPath
            }, */
                    function( data ) {
            	document.getElementById('div_for_inbox').style.display= 'none';
            	document.getElementById('div_for_setting').style.display= 'block';
            	document.getElementById('action_gif').style.display= 'none';
            //alert(data);
            	$( "#div_for_setting" ).html( data );
            	$(".search_button").css("background-image","none");
    			$(".search_button").css("background-color",$("#hid_mail_bgColor").val());
             var val = $('#accountSetting').val();
             var np_pane=true;
    	     var np_dsn=true;
             
    	     val = val.replace(/\'/g, '\"');
    	     obj = JSON.parse(val);
    	     //alert(val);
    	      $.each(obj, function(key,value) {
    	              
    	    	  if( value.name=="generalSettingNotification")
	    		  {
	    		  np_dsn=false;
	    		  }
	    	  if( value.name=="previewPane")
    		  {
	    		  np_pane=false;
    		  }
        
    	    	  
    	    	  if ($('input[name="' + value.name + '"][value="' + value.value + '"]').length > 0)
    	                  {
    	                    
    	               $('input[name="' + value.name + '"][value="' + value.value + '"]').prop('checked', true);
    	                  }
    	                  else{
    	               $("[name=" + value.name + "]").val(value.value);
    	                  }
    	                  
    	                });
    	      
    	      try
    	      {
    	    	  if(np_pane)
    	    		  {
    	    		  $('input[name="previewPane"][value="Vertical view"]').prop('checked', true);
    	    		  }
    	      }
    	      catch (e) {
				// TODO: handle exception
			}
    	      
    	      try
    	      {
    	    	  if(np_dsn)
    	    		  {
    	    		  $('input[name="generalSettingNotification"][value="New mail notifications on"]').prop('checked', true);
    	    		  }
    	      }
    	      catch (e) {
				// TODO: handle exception
			}
    	      
    	      $('.view_1').removeClass('setting_active');
    	      $('.view_5').addClass('setting_active');
    	      $('#view1').hide();
    	      $('#view5').css("display","block");
    	      $('#view2').hide();
    	      $('#view3').hide();
    	      $('#view4').hide();
    	      $('#view6').hide();
    	      $('#view7').hide();
             
            });
}


function backFromSetting() {
	document.getElementById('action_gif').style.display= 'block';
	//document.getElementById('div_for_inbox').style.display=  'block'; 
	//document.getElementById('div_for_setting').style.display='none';
	//getWebmailInboxRefresh();
}
</script>
<script type="text/javascript">
function openReply() 
{
	var cnt= getSelectdMailUid();
	if(cnt==null || cnt=="")
		{
		cnt=$("#hid_mail_disp_count").val();
		}
	
	
	var arr=cnt.split("-");
	if(arr.length==1)
		{
		var uid=arr[0];
		//alert(uid);
	
		var fdrname=document.getElementById('hid_active_fldr').value;
		
		document.getElementById('action_gif').style.display= 'block';
		var requestPage="${pageContext.request.contextPath}/composeMailReply";
		
	
		jQuery.post(requestPage,
	                            {
	                   "uid": uid, "fdrname": fdrname, "repType": "Reply"
	               
	            }, 
	            
	              function( data ) {
	            	document.getElementById('div_for_inbox').style.display= 'none';
	            	document.getElementById('div_for_compose').style.display= 'block';
	            	document.getElementById('action_gif').style.display= 'none';
	             $( "#div_for_compose" ).html( data );
	            // setTimeout(function(){ ckadd(); }, 500); 
	            }
	            
	            
		);
		}
	
}

function openReplyAll() {
	var cnt= getSelectdMailUid();
	if(cnt==null || cnt=="")
	{
	cnt=$("#hid_mail_disp_count").val();
	}
	var arr=cnt.split("-");
	if(arr.length==1)
		{
		var uid=arr[0];
		
		var fdrname=document.getElementById('hid_active_fldr').value;
		document.getElementById('action_gif').style.display= 'block';
		var requestPage="${pageContext.request.contextPath}/composeMailReply";
		jQuery.post(requestPage,
	            {
	                 "uid": uid, "fdrname": fdrname, "repType": "ReplyAll"

	            }, 
	                    function( data ) {
	            	document.getElementById('div_for_inbox').style.display= 'none';
	            	document.getElementById('div_for_compose').style.display= 'block';
	            	document.getElementById('action_gif').style.display= 'none';
	             $( "#div_for_compose" ).html( data );
	            // setTimeout(function(){ ckadd(); }, 500); 
	            });
		}
}


function openForword()
{
	var cnt= getSelectdMailUid();
	if(cnt==null || cnt=="")
	{
	cnt=$("#hid_mail_disp_count").val();
	}
	var arr=cnt.split("-");
	if(arr.length==1)
		{
		var uid=arr[0];

		var fdrname=document.getElementById('hid_active_fldr').value;
		document.getElementById('action_gif').style.display= 'block';
		var requestPage="${pageContext.request.contextPath}/composeMailForword";
		jQuery.post(requestPage,
	            {
	                "uid": uid, "fdrname": fdrname
	            }, 
	                    function( data ) {
	            	document.getElementById('div_for_inbox').style.display= 'none';
	            	document.getElementById('div_for_compose').style.display= 'block';
	            	document.getElementById('action_gif').style.display= 'none';
	             $( "#div_for_compose" ).html( data );
	            //setTimeout(function(){ ckadd(); }, 1000); 
	            });
		}	
}


function openComposeWithTo(hid_to) 
{
	
	
		var uid="";
		var hid_sub="";
		var hid_cnt="" ;
		var fdrname=document.getElementById('hid_active_fldr').value;
		
		document.getElementById('action_gif').style.display= 'block';
		var requestPage="${pageContext.request.contextPath}/openComposeWithTo";
		
	
		jQuery.post(requestPage,
	                            {
	                    'hid_to' : hid_to, "hid_cc": "" , "hid_sub": hid_sub , "hid_cnt": hid_cnt, "hid_attch_status": "No", "uid": uid, "fdrname": fdrname
	               
	            }, 
	            
	              function( data ) {
	            	document.getElementById('div_for_inbox').style.display= 'none';
	            	document.getElementById('div_for_compose').style.display= 'block';
	            	document.getElementById('action_gif').style.display= 'none';
	             $( "#div_for_compose" ).html( data );
	            // setTimeout(function(){ ckadd(); }, 1000); 
	            }
	            
	            
		);
	
	
}


function addInContacts( con_id ) {
	//alert(con_id);
	
	 document.getElementById('action_gif').style.display= 'block';
	  
	  $.post( "${pageContext.request.contextPath}/saveToContactFromInbox", 
			  { 
			 'con_id': con_id
			  },
			  function( data ) {
				//  alert(data);
				  if(data=="true")
					  {
					  	var success = generate_in('alert');
						 $.noty.setText(success.options.id, "Contact added Successfully.");
						 setTimeout(function () {  $.noty.close(success.options.id); }, 5000);
					  }
				  else if(data=="already")
					  {
					  var success = generate_in('alert');
						 $.noty.setText(success.options.id, "Contact already exists.");
						 setTimeout(function () {  $.noty.close(success.options.id); }, 5000);
					  }
				  document.getElementById('action_gif').style.display= 'none';
			  
				  
		});
}

</script>
<script type="text/javascript">
function moveToInbox(uid) {
	
		
		document.getElementById('action_gif').style.display= 'block';
		
		
		$.ajax({
					type : "GET",
					url : "${pageContext.request.contextPath}/webmailMoveToInbox",
					data : {
						'uid' : uid
					},
					contentType : "application/json",
					success : function(data) {
						/* alert('hi'); */
						var elem = document.getElementById("div_" + uid);
						elem.parentNode.removeChild(elem);
						document.getElementById('action_gif').style.display = "none";
						$('.tag_main').css('display','none');
						$('.folder_view').css('display','none');
					    $('#div_search_tool').css('display','none');

						// $("#fileSystem").html(data);
						// alert(data);
						// $("#inb_cnt_div").html(data);
					}
				});
	
}
</script>
</head>
<body>

<%
HttpSession hsbd=request.getSession();
String mcnt=request.getAttribute("MailCount").toString();
String dnoti=hsbd.getAttribute("generalSettingNotification").toString();
String mailid_bd=hsbd.getAttribute("id").toString();
String fname_bd=hsbd.getAttribute("fname").toString();
byte[] jpegBytes2=(byte[])hsbd.getAttribute("img_myurl");
String chat_img_bd="";
if(jpegBytes2!=null)
{
	chat_img_bd= new sun.misc.BASE64Encoder().encode(jpegBytes2);
}

/* String url = (String) request.getAttribute("imageurl");
String imgsrc = url + loggedUser + ".jpg"; */
%>

	<!------/// RIGHT PANNEL ONLY FOR TOOL-------->
<input type="hidden" id="hid_del_email" value="" data-mailuid="" />

	<div class="right-pane">
	<div id="div_for_inbox">
	<div id="div_half_pg_disp" style="display: block">
		<div class="right_top_pannel" >

			<!-------// RIGHT TOP TOOL END HERE -------->
			<div class="for_tool">
				<ul>
					<li>
						<div title="Select" class="tool_inner_box">
							<ul id="menu">
								<li><input class="check_box" type="checkbox" name="all" id="allmail" onclick="toggle(this)"  />
								<a	style="cursor: pointer;" class="sub_menu_link"><img
										src="images/open_sub_menu.png" ></a>
									<ul>
										<li><a style="cursor: pointer;" onclick="allMail()">All</a></li>
										<li><a style="cursor: pointer;" onclick="noneMail()">None</a></li>
										<li><a style="cursor: pointer;" onclick="seenMail()">Read</a></li>
										<li><a style="cursor: pointer;" onclick="unseenMail()">Unread</a></li>
										<li><a style="cursor: pointer;" onclick="staredMail()">Starred</a></li>
										<li><a style="cursor: pointer;" onclick="unstaredMail()">Unstarred</a></li>
									</ul></li>
							  
							</ul>
						</div>
					</li>
					<!-- <li><div onclick="mailCompose()" title="Compose Mail" class="composed_icon"><img src="images/composed_new.png" style="  width: 22px;"></div></li> -->
					<li><div onclick="mailCompose()" title="Compose Mail" class="composed_icon" style="width: 46px; height: 22px; cursor: pointer;">
					<div style="float: left; margin-left: -6px; margin-top: 2px;"><img width="18px" style="    opacity: 0.7;" src="images/plus.png" ></div>
					<div style="margin-left: 8px;" class="more">New</div></div></li>
					<li>
						<div id="div_search_tool" style="width: 308px !important;" class="large_tool search_form_tool">
							<ul>
								<li title="Reply" id="div_hid_opt1" class="hidden_option">
								<a onclick="openReply()" style="cursor: pointer;">
								<img	src="images/back_one.png"></a></li>
								<div class="right_border"></div>
								<li title="Reply All" id="div_hid_opt2" class="hidden_option">
								<a onclick="openReplyAll()" style="cursor: pointer;"><img
										src="images/back_doble.png"></a></li>
								<div class="right_border"></div>
								<ul title="Forward" id="menu" style="width: 39px !important;" class="next_mail">
									<li class="hidden_option"><a onclick="openForword()" style="cursor: pointer;padding: 0px;">
									<img src="images/next.png"></a>
									<!--  <a style="cursor: pointer;"
										class="sub_menu_link" style="padding: 0px;"><img
											src="images/open_sub_menu.png"></a>
										<ul>
											<li><a style="cursor: pointer;">Forward Inline</a></li>
											<li><a style="cursor: pointer;">Forward As Attachment</a></li>
										</ul> -->
										</li>
								</ul>
								<div class="right_border"></div>
								<li title="Delete" ><a onclick="moveTrashAll()" style="cursor: pointer;"><img src="images/tool_delete.png"></a></li>
								<div class="right_border"></div>
								<li id="li_spam" title="Report Spam"><a onclick="moveSpamAll()" style="cursor: pointer;"><img id="img_spam" style="opacity: 0.8;" src="images/restriction.png"></a></li>
								<div class="right_border"></div>
								<ul id="menu" class="next_mail more_arrow">
									<li class="more">More</li>
									<li><a style="cursor: pointer;    height: 20px !important;    width: 20px !important;" class="sub_menu_link"><img
											src="images/open_sub_menu.png" style="    padding-top: 0px;"></a>
										<ul style="margin-left: -27px !important;">
											<li><a style="cursor: pointer;" onclick="setSetectedMailUnRead()">Mark as Unread</a></li>
											<li><a style="cursor: pointer;" onclick="setSetectedMailRead()">Mark as Read</a></li>
											<li><a style="cursor: pointer;" onclick="setSetectedMailFlag()">Add Star</a></li>
											<li><a style="cursor: pointer;" onclick="setSetectedMailUnFlag()">Remove Star</a></li>
											<!-- <li><a style="cursor: pointer;">Add To Task</a></li>
											<li><a style="cursor: pointer;">Create Filter </a></li>
											<li><a style="cursor: pointer;">Add To Task </a></li>
											<li><a style="cursor: pointer;">Create Event </a></li> -->
										</ul></li>
								</ul>
								
							</ul>
						
							
							
							
						</div>
						<!-- <div class="calender_tool">
							<ul id="menu">
								<li><img src="images/tool_calender.png"
									class="four_margin calender_images"></li>
								<li style="margin-left: 12px;"><a style="cursor: pointer;"
									class="sub_menu_link"><img src="images/open_sub_menu.png"></a>
									<ul class="for_calenderand_date">
										<li><a style="cursor: pointer;" onclick="mailCompose()">Compose Messages</a></li>
										<li><a style="cursor: pointer;">Compose SMS</a></li>
										<li><a style="cursor: pointer;">Create Contact</a></li>
										<li><a style="cursor: pointer;">Create Event</a></li>
										<li><a style="cursor: pointer;">Create Task</a></li>

									</ul></li>
							</ul>
							
						</div> -->
							<!-- <div onclick="mailCompose()" class="composed_box_new">
							<img alt="COMPOSE" title="COMPOSE" src="images/composed.png" />
							</div> -->
							
							
							<!---/// TAG STRED HERE --->
                                    <div title="Labels" class="tag_main">
                                        <img src="images/tag_main.png" />
                                        <img src="images/cal-open.png" class="tag_arrow" />
                                    </div>
                                    <!---/// TAG END HERE ---->
                                     <!---/// Movefolder START HERE ---->
                                     <div title="Move To" class="folder_view">
                                                <img src="images/folder_icon.png" class="folder_icon" />
                                                <img src="images/cal-open.png" class="tag_arrow_1" />
                                              </div>
                                     <!---/// movefolder END HERE ---->
                                    
                                    
					</li>
				</ul>
				
				<!---- RIGHT TOOL STARTED HERE ---->
				<!--------/// Main Right Tool Stared Here -------->
				<div class="right_tool_part">
					<div class="right_tool">
						<a onclick="refreshInbox( )"  style="cursor: pointer;"> <img title="Refresh" src="images/reload.png"/>
						</a>
					</div>
					<div title="Settings" onclick="openSettingTemp()" class="right_tool_1" style="cursor: pointer;">
						<ul id="menu">
							<li><img src="images/setting_toll.png" class="four_margin"></li>
							<!-- <li class="right_menu_1"><img
								src="images/open_sub_menu.png"
								style="margin-left: 8px !important;">  <ul class="for_setting">
                                            <li> <a style="cursor: pointer;">Settings</a></li>
                                            <li><a style="cursor: pointer;">Themes</a></li>
                                            <li> <a style="cursor: pointer;">Help</a></li>
                                        </ul></li> -->
						</ul>

					</div>
					<!-- <div class="right_tool_1">
						<ul id="menu">
							<li><img src="images/multi_level.png"> <a style="cursor: pointer;"
								class="sub_menu_link"><img src="images/open_sub_menu.png"
									style="margin-left: 8px;"></a>
								<ul>
									<li><a style="cursor: pointer;" onClick="toggleViewPanel();panelView('offview')">Full view</a></li>
									<li><a style="cursor: pointer;" onClick="shiftViewLeft();panelView('leftview')">Left view</a></li>
									<li><a style="cursor: pointer;" onClick="shiftViewBottom();">Bottom
											view</a></li>
								</ul></li>
								
						</ul>
						<input type="hidden" id="hid_previewPane" value="offview"/>
					</div> -->
					<span id="mail_pagi" style="display: block;float: right;">
					<a  title="Older" style="cursor: pointer;" onclick="pagiNextPage()">
						<div class="right_tool_1">
							<img src="images/next_mail.png" class="next_imag" >
						</div>
					</a> <a title="Newer" style="cursor: pointer;" onclick="pagiPrevPage()">
						<div class="right_tool_1">
							<img src="images/privious_mail.png" class="next_imag" >
						</div>
					</a>
					</span>
					<span id="search_pagi" style="display: none;float: right;">
					<a  title="Older" style="cursor: pointer;" onclick="pagiSearchNextPage()">
						<div class="right_tool_1">
							<img src="images/next_mail.png" class="next_imag" >
						</div>
					</a> <a title="Newer" style="cursor: pointer;" onclick="pagiSearchPrevPage()">
						<div class="right_tool_1">
							<img src="images/privious_mail.png" class="next_imag" >
						</div>
					</a>
					</span>
					
					
					<!-- <span id="search_pagi" style="display: none;">
					<a style="cursor: pointer;" onclick="pagiNextPage()">
						<div class="right_tool_1">
							<img src="images/next_mail.png" class="next_imag" >
						</div>
					</a> <a style="cursor: pointer;" onclick="pagiPrevPage()">
						<div class="right_tool_1">
							<img src="images/privious_mail.png" class="next_imag" >
						</div>
					</a>
					</span> -->
					
					<%
					long mcount=Long.parseLong(mcnt);
					//long end=MailAccSetting.limitMail;
					long end=Integer.parseInt(hsbd.getAttribute("limitMail").toString());
                       
					if(end>mcount)
					{
						end=mcount;
					}
					%>
					<input type="hidden" id="hid_dnoti" value="<%=dnoti %>">
					<input  type="hidden" id="hid_pagi_pcnt" value="1" />
					<input type="hidden" id="hid_pagi_allmail" value="<%=mcount %>">
					<input type="hidden" id="hid_pagi_search_pcnt" value="" />
					<input type="hidden" id="hid_pagi_search_type" value="" />
					<input type="hidden" id="hid_pagi_search_allmail" value="">
					<%
					if(mcount==0)
					{
						 String act_fldrnm= hsbd.getAttribute("active_folder").toString();
					%>
					<div id="pagination_div" class="right_tool_2" title="<%=act_fldrnm %> is Empty "
						style="margin-left: -14px; line-height: 29px;"><%=act_fldrnm %> is Empty </div>
					<%}
					else
					{
					%>
					<div id="pagination_div" class="right_tool_2"  title="1-<%=end %> of <%=mcount %>"
						style="margin-left: -14px; line-height: 29px;">1-<%=end %> of <%=mcount %></div>
						<%} %>
				</div>

				<!-------------------/// Main Right Tool End Here ------------->
			</div>
			<!------ RIGHT TOOL END HERE TOP ---->
<!------/// COLOR OPTION STRED HERE ------------>
                                       <div class="tag_color_option">
                                                                            <ul>

                    <li><a style="cursor: pointer;">Label color:</a></li>
                    <li class="calender_color">
                         <div class="color_1 color_find"><span> &#x2713 </span></div>
                         <div class="color_2 color_find"> <span> &#x2713 </span></div>
                         <div class="color_3 color_find"> <span> &#x2713 </span></div>
                         <div class="color_4 color_find"> <span> &#x2713 </span></div>
                         <div class="color_5 color_find"> <span> &#x2713 </span></div>
                         <div class="color_6 color_find"> <span> &#x2713 </span></div>
                         <div class="clear"></div>
                         <div class="color_7 color_find"> <span> &#x2713 </span></div>
                         <div class="color_8 color_find"> <span> &#x2713 </span></div>
                         <div class="color_9 color_find"> <span> &#x2713 </span></div>
                         <div class="color_10 color_find"> <span> &#x2713 </span></div>
                         <div class="color_11 color_find"> <span> &#x2713 </span></div>
                         <div class="color_12 color_find"> <span> &#x2713 </span></div>
                    
                    
                    </li>
                           <li class="custom_color">
                       <table>
                          <tr>
                              <td><input type="text" class="custom" /></td>
                          </tr>
                       </table>
                    
                    </li>
                    <li class="choose_custom"><a style="cursor: pointer;">Choose custom color</a> <span class="custom_check"> &#x2713 </span></li>
                  </ul>
                                             <div class="clear"></div>
                                       </div>
                                       <!--------/// COLOR OPTION END HERE -------------->
			<div class="top_tool_information">
				<div class="left_function">
					<ul>
						<!-- <li class="flag_heading"><img src="images/black_star.png"></li> -->
						<li class="flag_heading"><!-- <img src="images/star-flag.png"> --><span class="new_star">&#9733;</span></li>
						<li class="form_heading" id="div_from">FROM</li>
						<li>SUBJECT</li>
					</ul>
				</div>
				<div class="right_bortion">
					<ul>
						<li><a style="cursor: pointer;"><img src="images/attachment.png"></a></li>
						<li><a style="cursor: pointer;"><img src="images/tool.png"></a></li>
					</ul>
				</div>
				<div class="right_bortion  date">
					<ul id="menu" class="">
						<li style="height: 23px;">
							<div class="date_div">
								DATE <a style="margin-top: -2px;margin-left: -6px;cursor: pointer;"> <!-- onclick="dtSorting()" -->
								<span id="dt_sorting"><img style="  opacity: 0.6;" src="images/down_date.png"></span>
								</a>
								<input type="hidden" id="hid_dt_sorting" value="up"/>
							</div>
							
						</li>
					</ul>
				</div>
			</div>
		</div>


		<!-----------------------------/// Main Cointer Stared here --------------->
		<div id="widget" class="widget_new">



			<!---------------/// Tab Content Stared Here Off VIEW ---------------------------->
			<div class="mid_tab tab_main_div "> <!--  content11 mCustomScrollbar"> -->


				<div class="mid_tab_1 right_tab">
					<div class="inner_tab_content">

						<!-------/// TAB HEADING FIRST ----->
						<div class="main_tab_first">
							<!-------/// TAB HEADING STARTED HERE ----->


							<!-------/// TAB HEADING END HERE ----->
							<!----/// TAB CONTENT MAIN STARTED HERE ------->

							<!----------// TAB FIRST CONTENT STARED HERE -------->
							<div id="inb_cnt_div" class="tab_first_content"></div>
							<!----------// TAB FIRST CONTENT END HERE -------->
							<div class="clear"></div>
						</div>


						<!-----/// RIGHT MID CONTENT TAB STARED HERE -------->
					</div>
				</div>




			</div>
			<!-----------------/// Tab Content End Here Off VIEW---------------------------->



			<!-------------------/// Right View and Bottom View Tab Stared Here --------------->

			<div class="mail_content">



				<div class="mail_content_1"
					style="width: 48.5%; float: right; display: block; min-height: 75%; max-height: 95%;">

					<div class="mail_left_content">
					
					<div id="hid_no_cnt" style="margin-top: 100px;text-align: center;">
  					
  					<span id="span_con">No</span> message selected<br><br>
  					<%
  					String qper=(String)request.getAttribute("QuotaPer");
  					String ql=(String)request.getAttribute("QuotaLimit");
  					String qu=(String)request.getAttribute("QuotaUses");
  					String qutu="0";
  					String qutl="0";
  					if(qper!=null && !(qper.equals("")) && ql!=null && !(ql.equals(""))  && qu!=null && !(qu.equals("")))
  					{
  						if(((Integer.parseInt(ql))/(1024))>=1024)
  						{
  							qutl=""+((Integer.parseInt(ql))/(1024*1024))+" GB";
  						}
  						else
  						{
  							qutl=""+((Integer.parseInt(ql))/(1024))+" MB";
  						}
  						
  						if(((Integer.parseInt(qu))/(1024))>=1024)
  						{
  							qutu=""+((Integer.parseInt(qu))/(1024*1024))+" GB";
  						}
  						else
  						{
  							qutu=""+((Integer.parseInt(qu))/(1024))+" MB";
  						}
  					}
  					%>
  					<div>
  					You are currently using <%=qutu %>  (<%=qper %> %) of your <%=qutl %><br>
  					<div style="border: 1px solid #c7c7c7;width: 300px;margin-left: auto;margin-right: auto;height: 10px;margin-top: 5px; ">
  					<div  style="height: 95%;background-color: #c7c7c7;width: <%=qper %>%"></div>
  					</div>
  					</div>
  					
  					</div>
					
					
					<div id="div_left_cnt">

					</div>
					</div>

					<!------/// MAIL MID CONTENT ---->
					<div class="clear"></div>


					<div class="clear"></div>
				</div>



			</div>

			<!-------------------/// Right View and Bottom View Tab End Here --------------->

		</div>

		<!--------------------/// Mail Cointer End Here ----------------->
		<div class="clear"></div>
		</div>
		<!--------------------/// Mail full apge display Here ----------------->
		<div id="div_full_pg_disp" style="display: none">
				
		</div>
		
	</div>
	<div id="div_for_compose" style="display: none;">
	</div>
	
	<div id="div_for_setting" style="display: none; position: relative;">
	</div>
	
	
	
	
	<!-- setting start -->
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	<!-- setting end -->
	
	
	</div>
	</div>


	<!-- <div class="for_setting_1">

		<ul id="menu" class="extra_menu">
			<li><a style="cursor: pointer;">&nbsp; </a>
				<ul class="for_setting new_submenu">
					<li><a style="cursor: pointer;">Settings</a></li>
					<li><a style="cursor: pointer;">Themes</a></li>
					<li><a style="cursor: pointer;">Help</a></li>
				</ul></li>
		</ul>

	</div> -->


               <!-------/// CREATE TAG STRED HERER ---->
               <div class="craete_tag">
                    <p>Create Label</p>
                    <input type="text" class="tag_name" /> <div class="tag_sel_option"> <ul><li><div class="color_green test_color"></div> <span></span> <img src="images/cal-open.png" /> </li></ul></div>
                    <div class="select_tag">
                        <ul>
                           <li><div class="color_green color_tag"></div> <span></span>  </li>
                           <li><div class="color_blue color_tag"></div> <span></span>  </li>
                           <li><div class="color_yellow color_tag"></div> <span> </span> </li>
                           <li><div class="color_black color_tag"></div><span>  </span> </li>
                           <li><div class="color_gray color_tag"></div><span></span> </li>
                           <li><div class="color_orange color_tag"></div> <span></span>  </li>
                           <li><div class="color_pink color_tag"></div> <span> </span> </li>
                           <li><div class="color_drak_bl color_tag"></div> <span> </span> </li>
                           <li><div class="color_dar_gree color_tag"></div><span> </span>  </li>
                        
                        </ul>
                    </div>
                    <div class="clear"></div>
                    <div class="tag_can search_button">Cancel</div>
                    <div class="tag_save search_button">Create</div>

                    
               <div class="clear"></div>
               
               </div>
               
               
               
               
      <!-------/// CREATE TAG STRED HERER ---->
               <div class="craete_tag setting_tag">
                    <p>Create Label</p>
                    <input type="text" class="tag_name setting_val" /> <div class="tag_sel_option setting_color"> <ul><li><div class="color_green test_color setting_tag_color"></div> <span></span> <img src="images/cal-open.png" /> </li></ul></div>
                    <div class="select_tag">
                        <ul>
                           <li><div class="color_green color_tag"></div> <span></span>  </li>
                           <li><div class="color_blue color_tag"></div> <span></span>  </li>
                           <li><div class="color_yellow color_tag"></div> <span> </span> </li>
                           <li><div class="color_black color_tag"></div><span>  </span> </li>
                           <li><div class="color_gray color_tag"></div><span></span> </li>
                           <li><div class="color_orange color_tag"></div> <span></span>  </li>
                           <li><div class="color_pink color_tag"></div> <span> </span> </li>
                           <li><div class="color_drak_bl color_tag"></div> <span> </span> </li>
                           <li><div class="color_dar_gree color_tag"></div><span> </span>  </li>
                        
                        </ul>
                    </div>
                    <div class="clear"></div>
                    <div class="setting_tag_cancel search_button">Cancel</div>
                    <div class="setting_tag_save search_button">Create</div>

                    
               <div class="clear"></div>
               
               </div>
               
    <!-------/// CREATE TAG end HERER ---->
               
               
               <div class="web_dialog_overlay"></div>

               <!---////  CREATE TAG END HERE ----->   
               
               
               <div class="pop_for_image_upload" >
                 <h1>Change Your Image <span>X</span></h1>
                      
                      
                       <form id="uploadImage" >
			         
			       
                      <table>
                      
                           <tbody><tr>
                              <td colspan="2"> <input type="file" id="upl1" name="upl1"  /></td>
                           </tr>
                          <tr>
 							<td colspan="2" style="  font-size: 11px; ">
 							Accepted image size is up to 100KB and File type must be png or jpg only. </td>
                           </tr>
                           <tr>
                              <td></td>
                              <td><input type="button" onclick="changeLDAPImg()" value="Upload" class="file_upload search_button"></td>
                           
                           </tr>
                      </tbody></table>
                  </form>
                 </div>
               
               
               
               
               
               
               
               
               
               


<%
if(true)
{

//XMPPConnection connection = (XMPPTCPConnection) hsbd.getAttribute("xmppConnection");

//if(connection!=null&&connection.getUser()!=null){
//	String loggedUser = connection.getUser().split("/")[0];	
//Roster roster = connection.getRoster();
//Collection<RosterEntry> entries = roster.getEntries();
//System.out.println("ROSTER SIZE=" + entries.size());
//Presence presence;
//ArrayList<String> pendingRequests = new ArrayList<String>();
//ArrayList<String> frndRequests = new ArrayList<String>();

%>








	<div class="all_chat_option">
		<div class="chat_info arrow-left">
			<div class="chat_info_left">
				<p class="name">Hariom Srivastava</p>
				<span>hari@silvereye.co</span>
				<p class="com"></p>
			</div>
			<div class="chat_info_right">
				<img src="images/photo_1.jpg" />

			</div>
			<div class="clear"></div>
			<div class="bottom_option">
				<!-------/// Bottom _Left_part--->
				<div class="left_bottom">
					<ul>
						<li><a style="cursor: pointer;">Contact info</a></li>
						<li><a style="cursor: pointer;">Emails</a></li>
					</ul>
				</div>
				<!----------/// Bottom Left Part End --->
				<!--------/// Bottom Right part Stared Here ------>
				<div class="right_bottom">
					<ul>
						<li class="chat_mail"><a style="cursor: pointer;"></a></li>
						<li class="contact_mail"><a style="cursor: pointer;"></a></li>
						<li><a style="cursor: pointer;"></a></li>

					</ul>

				</div>
				<!---------------/// Bottom  Right Part End Here -------->

			</div>

		</div>

		<!-----------------//// Chat Search option Here --------->
		<div class="chat_info_1 arrow-left">
			<div class="chat_info_left">
				<p class="name">Hariom Srivastava</p>
				<span>hari@silvereye.co</span>
			</div>
			<div class="chat_info_right">
				<img src="images/photo_1.jpg" />

			</div>
			<div class="clear"></div>
			<div class="bottom_option">
				<!-------/// Bottom _Left_part--->
				<div class="left_bottom">
					<ul>
						
						<li><a name="" id="chat_search_mail" onclick="getAllEmails(this.name)"
						 style="cursor: pointer;">Emails</a></li>
					</ul>
				</div>
				<!----------/// Bottom Left Part End --->
				<!--------/// Bottom Right part Stared Here ------>
				<div class="right_bottom">
					<ul>
						<li id="chat_mail_plus" class="chat_mail"><a style="cursor: pointer;"></a></li>
						<li   id="" onclick="openComposeWithTo(this.id)" class="contact_mail chat_mail_comp"><a style="cursor: pointer;"></a></li>
						<li><a style="cursor: pointer;"></a></li>

					</ul>

				</div>
				<!---------------/// Bottom  Right Part End Here -------->

			</div>

		</div>
		<!---------------/// Chat Search End Here ----------->
		<!-------/// Chat Search option--------->
		<div class="chat_search">
			<div class="chat_search_option">
				<div class="heading_caht">
					<input type="text" id="serchCntId"  placeholder="Search for people" onkeypress="keyPresChatSearch(event)"/>
					<div class="chat_search_btn" onclick="getAllUserListChat()"></div>
				</div>
				
				<!-----//// Chat Search Content ----->
				<div class="chat_search_content">
				<div id="np_chat_searchajax" style="display: none;"></div>
<div id="np_chat_search">
<%
WebmailClient webmailClient=(WebmailClient)request.getAttribute("webmailClient");
String host=(String)hsbd.getAttribute("host");
String id=(String)hsbd.getAttribute("id");
String ldapurl=(String)hsbd.getAttribute("ldapurl");
String ldpabase=(String)hsbd.getAttribute("ldapbase");
String pass=(String)hsbd.getAttribute("pass");
//System.out.println("!!!!!!!!!!!! ldap dn="+ldpabase);
GetVCFLdapDirResponse getdirres=webmailClient.getLdapDirectory(ldapurl, id, pass, ldpabase, "*");

List<VCFLdapDirAtt> ldapDirList=getdirres.getGetVCFLdapDirByParentFile().getVCFLdapDirListResult().getVCFLdapDirList();

Collections.sort(ldapDirList,new NPCompare());
for(VCFLdapDirAtt ulst : ldapDirList)
{
if(!ulst.getContactEmail().equalsIgnoreCase(id)){

	String photo=ulst.getContactPhoto();
%>


					<!------------//// FIRST ROW --------->
					<div class="cheat_row_11">
						<div class="small_images">
							
							<% if(photo!= null && !(photo.equals("")  ))
		              {
					%>
						  <img src='data:image/jpg;base64,<%=photo %>' class="user_images"  />
		            <%  }
					  else
					  {
						  %>
						 <img src="chat/photo.jpg" class="user_images" />
					  <%}
						%>	
							<!-- <img
								src="chat/green.png" class="online_green"> -->
						</div>
						<div id="serchContactAndFill" class="contact_information">
							<p>
								<strong><%=ulst.getContactName() %></strong><br><span> <%=ulst.getContactEmail() %></span>
							</p>
						</div>

					</div>
					<!-----------/// FIRST ROW -------------->
					
<%} }%>

</div>
				</div>
				<!--------/// Chat Search End -------->
			</div>
		</div>
		<!------------/// Chat Search Option End ------>
		<!-------/// Chat Downarrow option--------->
		<div class="chat_search_11">

			<!-----//// Chat Search Content ----->
			<div class="chat_downarrow">
				<!--------------//// Chat Down Main Page ------------->
				<div class="chat_down_main">
					<div class="chat_down_top">
						<div class="chat_down_left">
							<img style="height: 28px;"
								src="data:image/jpg;base64,<%=chat_img_bd%>" id="chat_id_bd"
								onerror="getAltChatImage(this.id)" />
						</div>
						<div class="chat_down_right">
							<%=fname_bd%>
							<span><%=mailid_bd%></span>
						</div>

						<div class="clear"></div>
					</div>
					<div class="clear"></div>
					<ul>
						<li class="chat_status_menu"><a style="cursor: pointer;">Chat&nbsp;Status
						</a></li>
						<!-- <li class="invites_menu"><a style="cursor: pointer;">Invites</a></li>
						<li class="blocked_menu"><a style="cursor: pointer;">Blocked&nbsp;People
						</a></li>
						<li class="share_your_menu"><a style="cursor: pointer;">
								Share&nbsp;your&nbsp;status </a></li> -->
					</ul>
					<div class="clear"></div>
					<div class="chat_out">Sign out of Chat</div>
				</div>
				<!------------------/// Chat Down Menu End ------------->

			</div>
			<!--------/// Chat Search End -------->
			<!------------/// Chat Sub menu ----------->
			<div class="chat_down_submenu">
				<!-------------// Chat Status box Stared here----------->
				<div class="chat_status">
					<!--------///Chat Haeding ---->
					<div class="chat_subheading">
						<div class="chat_main_menu">
							<img src="images/portlet-remove-icon.png" style="    margin-top: 5px;cursor: pointer;" />
						</div>
						<p>Chat Status</p>
						<div class="clear"></div>
					</div>
					<!-----------/// Chat Heading End Here ----->
					<!----------/// Chat Status Content ------->
					<div class="chat_status_content">
							<ul>
								<li><div style="float: left;    margin-right: 2px;
    margin-top: -2px;" class="online"></div>
							<span>Online</span>
									<input type="radio" name="presenceStatus"
									value="online" style="float: right;    margin-top: 2px !important; " id="onlineradio"
									onclick="changePresence(this.value)" />	
									</li>
								<li><input type="radio" name="presenceStatus"
									value="offline" style="float: right;     margin-top: 2px !important;"  onclick="changePresence(this.value)" /><span>Offline</span>
									<div class="offline" style="float: left;    margin-right: 2px;
    margin-top: -2px;" ></div></li>
								<li><input type="radio" style="float: right;    margin-top: 2px !important; "  name="presenceStatus" value="dnd"
									onclick="changePresence(this.value)" /><span>Busy</span>
									<div class="busy" style="float: left;    margin-right: 2px;
    margin-top: -2px;" ></div></li>
								<li><input type="radio" style="float: right;    margin-top: 2px !important; "  name="presenceStatus" value="away"
									onclick="changePresence(this.value)" /><span>Away</span>
									<div class="away" style="float: left;    margin-right: 2px;
    margin-top: -2px;" ></div></li>
							</ul>
						</div>
					<!-----------/// Chat Status  End Here ----->
				</div>
				<!-------------/// Chat Status Box End Here--------->
				<!-------------// Invites box Stared here----------->
				<div class="Blocked_status">
					<!--------///Chat Haeding ---->
					<div class="chat_subheading">
						<div class="chat_main_menu">
							<img src="images/portlet-remove-icon.png" />
						</div>
						<p>Invites</p>
						<input type="text" id="buddyInvite"/> 
					<!-- 	<input type="button" onclick="sendBuddyInvite()"> -->
						<input type="button" >
						<div class="clear"></div>
					</div>
					<!-----------/// Chat Heading End Here ----->
					<!----------/// Chat Status Content ------->
					<div class="chat_status_content">
						<!----------/// Main ROW Content ---------->
						<div class="chat_row_content">

							<%
							//	for (String pending : pendingRequests) {
							%>
							<%-- <div class="invite_row">
								<div class="invite_left"><%=pending%></div>
							
								<div class="invite_right">
									<a href="#">Unblock</a>
								</div>
								<div class="clear"></div>
							</div> --%>
							<%
								//}
							}
							%>
							<!-------------/// INVITE Row END HERE -------------->
						</div>
						<!----------/// Main Row Content End Here ---------->
						<div class="clear"></div>
					</div>
					<!-----------/// Chat Status  End Here ----->
					<div class="clear"></div>
				</div>
				<!-------------/// Invites Box End Here--------->
				<!-------------// Blocked People  box Stared here----------->
				<div class="Invites_status">
					<!--------///Chat Haeding ---->
					<div class="chat_subheading">
						<div class="chat_main_menu">
							<img src="images/portlet-remove-icon.png" />
						</div>
						<p>Blocked People</p>
						<div class="clear"></div>
					</div>
					<!-----------/// Chat Heading End Here ----->
					<!----------/// Chat Status Content ------->
					<div class="chat_status_content">
						<!----------/// Main ROW Content ---------->
						<div class="chat_row_content">
							<!-----------/// INVITE ROW FIRST STARED HERE ---------->
							<div class="invite_row">
								<!---------------/// INVITE LEFT PART -------->
								<div class="invite_left">Nirbhay</div>
								<!--------------/// INVITE LEFT END HERE -------->
								<!---------------/// INVITE RIGHT PART -------->
								<div class="invite_right">
									<a style="cursor: pointer;">Unblock</a>
								</div>
								<!--------------/// INVITE RIGHT END HERE -------->
								<div class="clear"></div>
							</div>
							<!-------------/// INVITE Row END HERE -------------->
							<!-----------/// INVITE ROW FIRST STARED HERE ---------->
							<div class="invite_row">
								<!---------------/// INVITE LEFT PART -------->
								<div class="invite_left">Nirbhay</div>
								<!--------------/// INVITE LEFT END HERE -------->
								<!---------------/// INVITE RIGHT PART -------->
								<div class="invite_right">
									<a style="cursor: pointer;">Unblock</a>
								</div>
								<!--------------/// INVITE RIGHT END HERE -------->
								<div class="clear"></div>
							</div>
							<!-------------/// INVITE Row END HERE -------------->
							<!-----------/// INVITE ROW FIRST STARED HERE ---------->
							<div class="invite_row">
								<!---------------/// INVITE LEFT PART -------->
								<div class="invite_left">Nirbhay</div>
								<!--------------/// INVITE LEFT END HERE -------->
								<!---------------/// INVITE RIGHT PART -------->
								<div class="invite_right">
									<a style="cursor: pointer;">Unblock</a>
								</div>
								<!--------------/// INVITE RIGHT END HERE -------->
								<div class="clear"></div>
							</div>
							<!-------------/// INVITE Row END HERE -------------->
							<!-----------/// INVITE ROW FIRST STARED HERE ---------->
							<div class="invite_row">
								<!---------------/// INVITE LEFT PART -------->
								<div class="invite_left">Nirbhay</div>
								<!--------------/// INVITE LEFT END HERE -------->
								<!---------------/// INVITE RIGHT PART -------->
								<div class="invite_right">
									<a style="cursor: pointer;">Unblock</a>
								</div>
								<!--------------/// INVITE RIGHT END HERE -------->
								<div class="clear"></div>
							</div>
							<!-------------/// INVITE Row END HERE -------------->
						</div>
						<!----------/// Main Row Content End Here ---------->
					</div>
					<!-----------/// Chat Status  End Here ----->
				</div>
				<!-------------/// Blocked People  Box End Here--------->
				<!-------------// Blocked People  box Stared here----------->
				<div class="Share_status">
					<!--------///Chat Haeding ---->
					<div class="chat_subheading">
						<div class="chat_main_menu">
							<img src="images/portlet-remove-icon.png" />
						</div>
						<p>Share your status</p>
						<div class="clear"></div>
					</div>
					<!-----------/// Chat Heading End Here ----->
					<!----------/// Chat Status Content ------->
					<div class="chat_status_content">


						<!----------/// Chat --------->
						<!----------/// Main ROW Content ---------->
						<div class="chat_row_content">
							<!-----------/// INVITE ROW FIRST STARED HERE ---------->
							<div class="invite_row">

								<!---------------/// INVITE LEFT PART -------->
								<div class="invite_left">Nirbhay</div>
								<!--------------/// INVITE LEFT END HERE -------->
								<!---------------/// INVITE RIGHT PART -------->
								<div class="invite_right">
									<a style="cursor: pointer;">Unblock</a>
								</div>
								<!--------------/// INVITE RIGHT END HERE -------->
								<div class="clear"></div>
							</div>
							<!-------------/// INVITE Row END HERE -------------->
							<!-----------/// INVITE ROW FIRST STARED HERE ---------->
							<div class="invite_row">
								<!---------------/// INVITE LEFT PART -------->
								<div class="invite_left">Nirbhay</div>
								<!--------------/// INVITE LEFT END HERE -------->
								<!---------------/// INVITE RIGHT PART -------->
								<div class="invite_right">
									<a style="cursor: pointer;">Unblock</a>
								</div>
								<!--------------/// INVITE RIGHT END HERE -------->
								<div class="clear"></div>
							</div>
							<!-------------/// INVITE Row END HERE -------------->
							<!-----------/// INVITE ROW FIRST STARED HERE ---------->
							<div class="invite_row">
								<!---------------/// INVITE LEFT PART -------->
								<div class="invite_left">Nirbhay</div>
								<!--------------/// INVITE LEFT END HERE -------->
								<!---------------/// INVITE RIGHT PART -------->
								<div class="invite_right">
									<a style="cursor: pointer;">Unblock</a>
								</div>
								<!--------------/// INVITE RIGHT END HERE -------->
								<div class="clear"></div>
							</div>
							<!-------------/// INVITE Row END HERE -------------->
							<!-----------/// INVITE ROW FIRST STARED HERE ---------->
							<div class="invite_row">
								<!---------------/// INVITE LEFT PART -------->
								<div class="invite_left">Nirbhay</div>

								<!--------------/// INVITE LEFT END HERE -------->
								<!---------------/// INVITE RIGHT PART -------->
								<div class="invite_right">
									<a style="cursor: pointer;">Unblock</a>
								</div>
								<!--------------/// INVITE RIGHT END HERE -------->
								<div class="clear"></div>
							</div>
							<!-------------/// INVITE Row END HERE -------------->
						</div>
						<!----------/// Main Row Content End Here ---------->
						<!----------/// Chat End -------->

					</div>
					<!-----------/// Chat Status  End Here ----->
				</div>
				<!-------------/// Blocked People  Box End Here--------->
			</div>
			<!---------------//// Chat Down Sub Menu ---------->

		</div>
		<!------------/// Chat Downarrow Option End ------>
	</div>
	<div id="appendchatdiv"></div>
	<!-- --CHAT BOX HERE -->
	<div class="main_chat_box">
		<div class="main_inner_box">
			<div class="overflow_chat">
				<div class="overflow_info">
					<div class="overflow_info_content"></div>
					<div class="overflow_info_bottom">
						<!-- <img src="images/chat_icon.png" /> -->
						<div class="count_overflow"></div>
					</div>

				</div>
			</div>
			<div class="inner_chat_box"></div>
		</div>
	</div>
	<!-- CHAT BOX END HERE -->


	<script>
		jQuery(function($) {
			$(window).on('resize', function() {
				var height = $(window).height() - 90;
				//alert(height);
				console.log(height);
				$('#foo').height(height).split({
					orientation : 'horizontal',
					limit : 50
				});
				//$('#foo').css('height',height)
				//  $('.b').height((height / 2)+60);
				$('#b').css('height', (height / 2 + 22));
				//$('.chat_inner_content').height(height / 2);
			}).trigger('resize');
		});
	</script>



</body>
</html>