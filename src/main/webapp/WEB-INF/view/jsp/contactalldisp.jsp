<%@page import="java.util.List"%>
<%@ page language="java" import="webmail.wsdl.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
function getAltImageCon(imgid) {
//	alert('hi');
	 $("#"+imgid).attr('src', 'images/contact_photo.png');
	//var pic =document.getElementById(imgid);
	//pic.src ="images/contact_photo.png"
}

</script>
</head>
<body>
<%
GetFullContactDetailResponse conres=(GetFullContactDetailResponse)  request.getAttribute("GetFullConRes");

%>
<!-- <script src="js/jquery-1.8.3.min.js"></script>
<script src="js/contact_js.js"></script>
<link type="text/css" rel="stylesheet" href="css/contact_css.css" />
  -->
       
    <% 
      List<Byte> photoslst=null;
       String flname=""; 
       String cmpny="";
       String job="";
       String email="";
       String webaddr="";
       String mobwork="";
       String mobhome="";
       String mob="";
       String mobfax="";
       String addrwork="";
       String addrhome="";
       String note="";
       String photo="";
       if(conres.getGetFullContactDetail().getWebamilFullName()!= null && !(conres.getGetFullContactDetail().getWebamilFullName().equals("")  ))
       {
    	   flname=conres.getGetFullContactDetail().getWebamilFullName() ;
       }
       
       if(conres.getGetFullContactDetail().getWebamilCompany()!=null && !(conres.getGetFullContactDetail().getWebamilCompany().equals("")))
       {
    	   cmpny=conres.getGetFullContactDetail().getWebamilCompany();
       }
       
       if(conres.getGetFullContactDetail().getWebamilJob()!=null && !(conres.getGetFullContactDetail().getWebamilJob().equals("")))
       {
    	   job=conres.getGetFullContactDetail().getWebamilJob();
       }
       
       if(conres.getGetFullContactDetail().getWebamilEmail()!=null && !(conres.getGetFullContactDetail().getWebamilEmail().equals("")))
       {
    	   email=conres.getGetFullContactDetail().getWebamilEmail();
       }
       
       if(conres.getGetFullContactDetail().getWebamilWebPage()!= null && !(conres.getGetFullContactDetail().getWebamilWebPage().equals("")))
       {
    	   webaddr=conres.getGetFullContactDetail().getWebamilWebPage();
       }
       
       if(conres.getGetFullContactDetail().getWebamilPhoneWork()!=null && !(conres.getGetFullContactDetail().getWebamilPhoneWork().equals("")))
       {
    	   mobwork=conres.getGetFullContactDetail().getWebamilPhoneWork();
       }
       
       if(conres.getGetFullContactDetail().getWebamilPhoneHome()!=null && !(conres.getGetFullContactDetail().getWebamilPhoneHome().equals("")))
       {
    	   mobhome=conres.getGetFullContactDetail().getWebamilPhoneHome();
       }
       
       if(conres.getGetFullContactDetail().getWebamilPhoneFax()!=null && !(conres.getGetFullContactDetail().getWebamilPhoneFax().equals("")))
       {
    	   mobfax=conres.getGetFullContactDetail().getWebamilPhoneFax();
       }
       
       if(conres.getGetFullContactDetail().getWebamilPhoneMob()!=null && !(conres.getGetFullContactDetail().getWebamilPhoneMob().equals("")))
       {
    	   mob=conres.getGetFullContactDetail().getWebamilPhoneMob();
       }
       
       if(conres.getGetFullContactDetail().getWebmailAddrWork()!=null && !(conres.getGetFullContactDetail().getWebmailAddrWork().equals("")))
       {
    	   addrwork=conres.getGetFullContactDetail().getWebmailAddrWork();
       }
       
       if(conres.getGetFullContactDetail().getWebamilAddrHome()!=null && !(conres.getGetFullContactDetail().getWebamilAddrHome().equals("")))
       {
    	   addrhome=conres.getGetFullContactDetail().getWebamilAddrHome();
       }
       
       if(conres.getGetFullContactDetail().getWebamilNote()!=null && !(conres.getGetFullContactDetail().getWebamilNote().equals("")))
       {
    	   note=conres.getGetFullContactDetail().getWebamilNote();
       }
       if(conres.getGetFullContactDetail().getWebamilPhoto()!=null && !(conres.getGetFullContactDetail().getWebamilPhoto().equals("")))
       {
    	   photo=conres.getGetFullContactDetail().getWebamilPhoto();
       }
       String ph_src="";
       if(photo==null || photo.equals("") || photo.equalsIgnoreCase("null") || photo.length()<50)
       {
    	  ph_src="images/contact_photo.png" ;
       }
       else
       {
    	   ph_src="data:image/jpg;base64,"+photo;
       }
       if(conres.getGetFullContactDetail().getWebamilPhotoByte()!=null && !(conres.getGetFullContactDetail().getWebamilPhotoByte().equals("")))
       {
    	   photoslst=conres.getGetFullContactDetail().getWebamilPhotoByte();
    	   HttpSession conhs=request.getSession();
    	   conhs.setAttribute("ContactPhotoByte", photoslst);
    	//   System.out.println("~~~~~~~~~~~~~~~~~~~~~~~"+photoslst);
       }
      
         %>
          
         <%--  <table>
            <tr>
              <td colspan='3' class='right_info_heading_edit'>Personal Information</td>
            </tr>
            <tr>
              <td class='right_name_first_pop_edit'>Full Name </td>
              <td class='right_text_pop_edit'><input type='text' value='<%=flname %>' />
                <div class='edite_name_edit'>
                  <div class='name_edit_edit'></div>
                  Edit Name</div></td>
              <td rowspan='3'><img style="height: 80px; width: 75px;" src='images/contact_photo.png'/>
                <div class='save_chnage_pop_edit'>Change Image</div></td>
            </tr>
            <tr>
              <td class='right_name_first_pop_edit'>Company</td>
              <td><input type='text'  value='<%=cmpny %>'/></td>
            </tr>
            <tr>
              <td class='right_name_first_pop_edit'>Job Title</td>
              <td><input type='text' value='<%=job %>'/></td>
            </tr>
            <tr class='right_name_first_pop_edit'>
              <td colspan='3' class='right_info_heading_edit'>Internet</td>
            </tr>
            <tr class='right_name_first_pop_edit'>
              <td class='right_name_first_edit'>email</td>
              <td colspan='2'><input type='text' value='<%=email %>' /></td>
            </tr>
            
            <tr class='right_name_first_pop_edit'>
              <td class='right_name_first_edit'>Web page address</td>
              <td colspan='2'><input type='text' value='<%=webaddr %>'/></td>
            </tr>
           <tr class='right_name_first_pop_edit'>
              <td colspan='3' class='right_info_heading_edit'>Phone Number</td>
            </tr>
            <tr class='right_name_first_pop_edit'>
              <td class='right_name_first_edit'>Business</td>
              <td colspan='2'><input type='text' value='<%=mobwork %>' /></td>
            </tr>
            <tr class='right_name_first_pop_edit'>
              <td class='right_name_first_edit'>Home</td>
              <td colspan='2'><input type='text' value='<%=mobhome %>' /></td>
            </tr>
            <tr class='right_name_first_pop_edit'>
              <td class='right_name_first_edit'>Business Fax</td>
              <td colspan='2'><input type='text' value='<%=mobfax %>' /></td>
            </tr>
            <tr class='right_name_first_pop_edit'>
              <td class='right_name_first_edit'>Mobile</td>
              <td colspan='2'><input type='text' value='<%=mob %>' /></td>
            </tr>
            <tr class='right_name_first_pop_edit'>
              <td colspan='3' class='right_info_heading_edit'>Address</td>
            </tr>
            <tr class='right_name_first_pop_edit'>
              <td class='right_name_first_edit'>Business</td>
              <td colspan='2'><input type='text' value='<%=addrwork %>' /> 
              </td>
            </tr>
            <tr class='right_name_first_pop_edit'>
              <td class='right_name_first_edit'>Home</td>
              <td colspan='2'><input type='text' value='<%=addrhome %>' />
              
              </td>
            </tr>
            <tr class='right_name_first_pop_edit'>
              <td colspan='3' class='right_info_heading_edit'>Note</td>
            </tr>
            
            <tr class='right_name_first_pop_edit'>
              <td class='right_name_first_edit'>Note</td>
              <td colspan='2'><input type='text' value='<%=note %>' />
              </td>
            </tr>
          </table>
          
           --%>
       
       
       
          
          <!------------/// RIGHT CONTENT STARED HERE -------------->
          <input type="hidden" id="hid_contact_img_code_edit" />
          <input type="hidden" id="hid_contact_file_name" />
          <table>
            <tr>
              <td colspan="3" class="right_info_heading">Personal Information</td>
            </tr>
            <tr>
              <td class="right_name_first">Full Name </td>
              <td class="right_text"><input type="text" id="fullname"  value="<%=flname %>" />
                <div onclick="editNameOpen()" class="edite_name">
                  <div class="name_edit"></div>
                  Edit Name</div></td>
              <td rowspan="3"><!-- <img src="images/contact_photo.png"/> -->
              <img height='96px' width='96px'  src="<%=ph_src %>" onerror="getAltImageCon(this.id)" id="con_img_id" />
                <div onclick="uploadContactDPEdit()" class="save_chnage">Change Image</div></td>
            </tr>
            <tr>
              <td class="right_name_first">Company</td>
              <td><input type="text" id="company" value="<%=cmpny %>"/></td>
            </tr>
            <tr>
              <td class="right_name_first">Job Title</td>
              <td><input type="text" id="job" value="<%=job %>"/></td>
            </tr>
            <tr class="hide_info">
              <td colspan="3" class="right_info_heading">Internet</td>
            </tr>
            <tr class="hide_info">
              <td class="right_name_first">email</td>
              <td colspan="2"><input id="email" type="text" value="<%=email %>" /></td>
            </tr>
            <tr class="hide_info">
              <td class="right_name_first">WWW</td>
              <td colspan="2"><input type="text" id="web_page" value="<%=webaddr %>"/></td>
            </tr>
            <tr class="hide_info">
              <td colspan="3" class="right_info_heading">Phone Number</td>
            </tr>
            <tr class="hide_info">
              <td class="right_name_first">Business</td>
              <td colspan="2"><input type="text" id="phone_work" value="<%=mobwork %>" /></td>
            </tr>
            <tr class="hide_info">
              <td class="right_name_first">Home</td>
              <td colspan="2"><input type="text" id="phone_home" value="<%=mobhome %>" /></td>
            </tr>
            <tr class="hide_info">
              <td class="right_name_first">Fax</td>
              <td colspan="2"><input type="text"  id="phone_fax"  value="<%=mobfax %>" /></td>
            </tr>
            <tr class="hide_info">
              <td class="right_name_first">Mobile</td>
              <td colspan="2"><input type="text" id="phone_mob" value="<%=mob %>" /></td>
            </tr>
            <tr class="hide_info">
              <td colspan="3" class="right_info_heading">Address</td>
            </tr>
            <tr class="hide_info">
              <td class="right_name_first">Business</td>
              <td colspan="2"><input type="text"  id="addr_work" value="<%=addrwork %>" />
                    <div class="edite_address_edit"><div class="name_edit_edit"></div> Edit Address</div>
              </td>
            </tr>
            <tr class="hide_info">
                    <td class="right_name_first">Home</td>
                    <td colspan="2"><input type="text"   id="addr_home" value="<%=addrhome %>" />
                          <div class="edite_address_edit"><div class="name_edit_edit"></div> Edit Address</div>
                    </td>
            </tr>
            <tr class="right_name_first_pop_edit">
              <td colspan="3" class="right_info_heading_edit">Note</td>
            </tr>
            <tr class="right_name_first_pop_edit">
              <td class="right_name_first_edit">Note As</td>
              <td colspan="2"><textarea  id="note"  class="textarea disabled_textarea" placeholder=" " disabled ><%=note %></textarea>
              
              </td>
            </tr>
          </table>
         
 
</body>
</html>