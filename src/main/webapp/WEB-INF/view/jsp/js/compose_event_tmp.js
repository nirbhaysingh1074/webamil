jQuery(document).ready(function(){$(document.body).on("click","ul.inner_option >li",function(){$("div.priority_check").removeClass("priority_check");$(this).children().children(".green_plain_text_sign").addClass("priority_check");});$(".read_receipt").click(function(){if($(".green_plain_text_read").css("display")=="none"){$(".green_plain_text_read").css("display","block");}else{$(".green_plain_text_read").css("display","none");}});$(document.body).on("click",".drop",function(){if($(".small_to").css("display")=="block"){$(".attach_row").removeClass("small_to");$(".disable_row").css("display","none");}else{$(".attach_row").addClass("small_to");$(".disable_row").css("display","block");}});function auto_to(e){var textarea=$(".enter_email").val();textarea=textarea.replace(";","");textarea=textarea.replace(",","");if(textarea!=""&&textarea!=null){e.preventDefault();var hid_txt=$("#hid_to_id").val();var tocnt="";if(hid_txt==null||hid_txt==""){tocnt=textarea;}else{tocnt=hid_txt+","+textarea;}document.getElementById("hid_to_id").value=tocnt;$(".enter_email").val("");$(".combind_email").append('<div class="vR to_content" id="'+textarea+'"><span class="vN Y7BVp a3q" email="hari@silvereye.co"><div class="vT">'+textarea+'</div><div class="vM closeit_to"></div></span></div>');var n_to=$(".to_content").length;window.get_width=$(".combind_email").width();window.find_other=$(".composed_input").width();var append_width=$(".to_content").width();var countwidth=0;var extracount=0;$(".to_content").each(function(){countwidth+=$(this).width();if(countwidth>=find_other){extracount++;$(".email_id_info_to").removeClass("remove_to_more");}else{$(".email_id_info_to").addClass("remove_to_more");}});$(".email_id_info_to").text(extracount+"");if(!checkEmail(textarea)){$("#"+textarea).addClass("wrong_email");}}else{if(e.which!=9){e.preventDefault();}}}$(".enter_email").keydown(function(e){if((e.which==13||e.which==9||e.which==186||e.which==188)&&($(".ac_over").text()!=null&&$(".ac_over").text()!="")){if(e.which==186||e.which==188){$(".enter_email").val($(".ac_over").text());$(".ac_results").css("display","none");}setTimeout(function(){auto_to(e);},500);}else{if(e.which==13||e.which==9||e.which==186||e.which==188){var textarea=$(".enter_email").val();if(textarea!=""&&textarea!=null){e.preventDefault();var hid_txt=$("#hid_to_id").val();var tocnt="";if(hid_txt==null||hid_txt==""){tocnt=textarea;}else{tocnt=hid_txt+","+textarea;}document.getElementById("hid_to_id").value=tocnt;$(".enter_email").val("");$(".combind_email").append('<div class="vR to_content" id="'+textarea+'"><span class="vN Y7BVp a3q" email="hari@silvereye.co"><div class="vT">'+textarea+'</div><div class="vM closeit_to"></div></span></div>');var n_to=$(".to_content").length;window.get_width=$(".combind_email").width();window.find_other=$(".composed_input").width();var append_width=$(".to_content").width();var countwidth=0;var extracount=0;$(".to_content").each(function(){countwidth+=$(this).width();if(countwidth>=find_other){extracount++;$(".email_id_info_to").removeClass("remove_to_more");}else{$(".email_id_info_to").addClass("remove_to_more");}});$(".email_id_info_to").text(extracount+"");if(!checkEmail(textarea)){$("#"+textarea).addClass("wrong_email");}}else{if(e.which!=9){e.preventDefault();}}}}});$(".enter_email").blur(function(){var textarea=$(".enter_email").val();if(textarea!=""&&textarea!=null){if(checkEmail(textarea)){var textarea=$(".enter_email").val();if(textarea!=""&&textarea!=null){var hid_txt=$("#hid_to_id").val();var tocnt="";if(hid_txt==null||hid_txt==""){tocnt=textarea;}else{tocnt=hid_txt+","+textarea;}document.getElementById("hid_to_id").value=tocnt;$(".enter_email").val("");$(".combind_email").append('<div class="vR to_content" id="'+textarea+'"><span class="vN Y7BVp a3q" email="hari@silvereye.co"><div class="vT">'+textarea+'</div><div class="vM closeit_to"></div></span></div>');var n_to=$(".to_content").length;window.get_width=$(".combind_email").width();window.find_other=$(".composed_input").width();var append_width=$(".to_content").width();var countwidth=0;var extracount=0;$(".to_content").each(function(){countwidth+=$(this).width();if(countwidth>=find_other){extracount++;$(".email_id_info_to").removeClass("remove_to_more");}else{$(".email_id_info_to").addClass("remove_to_more");}});$(".email_id_info_to").text(extracount+"");if(!checkEmail(textarea)){$("#"+textarea).addClass("wrong_email");}}}}});function auto_cc(e){var textarea=$(".enter_email_cc").val();textarea=textarea.replace(";","");textarea=textarea.replace(",","");if(textarea!=""&&textarea!=null){e.preventDefault();var hid_txt=$("#hid_cc_id").val();var cccnt="";if(hid_txt==null||hid_txt==""){cccnt=textarea;}else{cccnt=hid_txt+","+textarea;}document.getElementById("hid_cc_id").value=cccnt;$(".enter_email_cc").val("");$(".combind_email_cc").append('<div class="vR cc_content" id="'+textarea+'"><span class="vN Y7BVp a3q" email="hari@silvereye.co"><div class="vT">'+textarea+'</div><div class="vM closeit_cc"></div></span></div>');var n_to=$(".cc_content").length;window.get_width=$(".combind_email_cc").width();window.find_other=$(".composed_input").width();var append_width=$(".cc_content").width();var countwidth=0;var extracount=0;$(".cc_content").each(function(){countwidth+=$(this).width();if(countwidth>=find_other){extracount++;$(".email_id_info_cc").removeClass("remove_to_more");}else{$(".email_id_info_cc").addClass("remove_to_more");}});$(".email_id_info_cc").text(extracount+"");if(!checkEmail(textarea)){$("#"+textarea).addClass("wrong_email");}}else{if(e.which!=9){e.preventDefault();}}}$(".enter_email_cc").keydown(function(e){if((e.which==13||e.which==9||e.which==186||e.which==188)&&($(".ac_over").text()!=null&&$(".ac_over").text()!="")){if(e.which==186||e.which==188){$(".enter_email_cc").val($(".ac_over").text());$(".ac_results").css("display","none");}setTimeout(function(){auto_cc(e);},500);}else{if(e.which==13||e.which==9||e.which==186||e.which==188){var textarea=$(".enter_email_cc").val();if(textarea!=""&&textarea!=null){e.preventDefault();var hid_txt=$("#hid_cc_id").val();var cccnt="";if(hid_txt==null||hid_txt==""){cccnt=textarea;}else{cccnt=hid_txt+","+textarea;}document.getElementById("hid_cc_id").value=cccnt;$(".enter_email_cc").val("");$(".combind_email_cc").append('<div class="vR cc_content" id="'+textarea+'"><span class="vN Y7BVp a3q" email="hari@silvereye.co"><div class="vT">'+textarea+'</div><div class="vM closeit_cc"></div></span></div>');var n_to=$(".cc_content").length;window.get_width=$(".combind_email_cc").width();window.find_other=$(".composed_input").width();var append_width=$(".cc_content").width();var countwidth=0;var extracount=0;$(".cc_content").each(function(){countwidth+=$(this).width();if(countwidth>=find_other){extracount++;$(".email_id_info_cc").removeClass("remove_to_more");}else{$(".email_id_info_cc").addClass("remove_to_more");}});$(".email_id_info_cc").text(extracount+"");if(!checkEmail(textarea)){$("#"+textarea).addClass("wrong_email");}}else{if(e.which!=9){e.preventDefault();}}}}});$(".enter_email_cc").blur(function(){var textarea=$(".enter_email_cc").val();if(textarea!=""&&textarea!=null){if(checkEmail(textarea)){var textarea=$(".enter_email_cc").val();if(textarea!=""&&textarea!=null){var hid_txt=$("#hid_cc_id").val();var cccnt="";if(hid_txt==null||hid_txt==""){cccnt=textarea;}else{cccnt=hid_txt+","+textarea;}document.getElementById("hid_cc_id").value=cccnt;$(".enter_email_cc").val("");$(".combind_email_cc").append('<div class="vR cc_content" id="'+textarea+'"><span class="vN Y7BVp a3q" email="hari@silvereye.co"><div class="vT">'+textarea+'</div><div class="vM closeit_cc"></div></span></div>');var n_to=$(".cc_content").length;window.get_width=$(".combind_email_cc").width();window.find_other=$(".composed_input").width();var append_width=$(".cc_content").width();var countwidth=0;var extracount=0;$(".cc_content").each(function(){countwidth+=$(this).width();if(countwidth>=find_other){extracount++;$(".email_id_info_cc").removeClass("remove_to_more");}else{$(".email_id_info_cc").addClass("remove_to_more");}});$(".email_id_info_cc").text(extracount+"");if(!checkEmail(textarea)){$("#"+textarea).addClass("wrong_email");}}}}});function auto_bcc(e){var textarea=$(".enter_email_bcc").val();textarea=textarea.replace(";","");textarea=textarea.replace(",","");if(textarea!=""&&textarea!=null){e.preventDefault();var hid_txt=$("#hid_bcc_id").val();var bcccnt="";if(hid_txt==null||hid_txt==""){bcccnt=textarea;}else{bcccnt=hid_txt+","+textarea;}document.getElementById("hid_bcc_id").value=bcccnt;$(".enter_email_bcc").val("");$(".combind_email_bcc").append('<div class="vR bcc_content" id="'+textarea+'"><span class="vN Y7BVp a3q" email="hari@silvereye.co"><div class="vT">'+textarea+'</div><div class="vM closeit_bcc"></div></span></div>');var n_to=$(".bcc_content").length;window.get_width=$(".combind_email_bcc").width();window.find_other=$(".composed_input").width();var append_width=$(".bcc_content").width();var countwidth=0;var extracount=0;$(".bcc_content").each(function(){countwidth+=$(this).width();if(countwidth>=find_other){extracount++;$(".email_id_info_bcc").removeClass("remove_to_more");}else{$(".email_id_info_bcc").addClass("remove_to_more");}});$(".email_id_info_bcc").text(extracount+"");if(!checkEmail(textarea)){$("#"+textarea).addClass("wrong_email");}}else{if(e.which!=9){e.preventDefault();}}}$(".enter_email_bcc").keydown(function(e){if((e.which==13||e.which==9||e.which==186||e.which==188)&&($(".ac_over").text()!=null&&$(".ac_over").text()!="")){if(e.which==186||e.which==188){$(".enter_email_bcc").val($(".ac_over").text());$(".ac_results").css("display","none");}setTimeout(function(){auto_bcc(e);},500);}else{if(e.which==13||e.which==9||e.which==186||e.which==188){var textarea=$(".enter_email_bcc").val();if(textarea!=""&&textarea!=null){e.preventDefault();var hid_txt=$("#hid_bcc_id").val();var bcccnt="";if(hid_txt==null||hid_txt==""){bcccnt=textarea;}else{bcccnt=hid_txt+","+textarea;}document.getElementById("hid_bcc_id").value=bcccnt;$(".enter_email_bcc").val("");$(".combind_email_bcc").append('<div class="vR bcc_content" id="'+textarea+'"><span class="vN Y7BVp a3q" email="hari@silvereye.co"><div class="vT">'+textarea+'</div><div class="vM closeit_bcc"></div></span></div>');var n_to=$(".bcc_content").length;window.get_width=$(".combind_email_bcc").width();window.find_other=$(".composed_input").width();var append_width=$(".bcc_content").width();var countwidth=0;var extracount=0;$(".bcc_content").each(function(){countwidth+=$(this).width();if(countwidth>=find_other){extracount++;$(".email_id_info_bcc").removeClass("remove_to_more");}else{$(".email_id_info_bcc").addClass("remove_to_more");}});$(".email_id_info_bcc").text(extracount+"");if(!checkEmail(textarea)){$("#"+textarea).addClass("wrong_email");}}else{if(e.which!=9){e.preventDefault();}}}}});$(".enter_email_bcc").blur(function(){var textarea=$(".enter_email_bcc").val();if(textarea!=""&&textarea!=null){if(checkEmail(textarea)){var textarea=$(".enter_email_bcc").val();if(textarea!=""&&textarea!=null){var hid_txt=$("#hid_bcc_id").val();var bcccnt="";if(hid_txt==null||hid_txt==""){bcccnt=textarea;}else{bcccnt=hid_txt+","+textarea;}document.getElementById("hid_bcc_id").value=bcccnt;$(".enter_email_bcc").val("");$(".combind_email_bcc").append('<div class="vR bcc_content" id="'+textarea+'"><span class="vN Y7BVp a3q" email="hari@silvereye.co"><div class="vT">'+textarea+'</div><div class="vM closeit_bcc"></div></span></div>');var n_to=$(".bcc_content").length;window.get_width=$(".combind_email_bcc").width();window.find_other=$(".composed_input").width();var append_width=$(".bcc_content").width();var countwidth=0;var extracount=0;$(".bcc_content").each(function(){countwidth+=$(this).width();if(countwidth>=find_other){extracount++;$(".email_id_info_bcc").removeClass("remove_to_more");}else{$(".email_id_info_bcc").addClass("remove_to_more");}});$(".email_id_info_bcc").text(extracount+"");if(!checkEmail(textarea)){$("#"+textarea).addClass("wrong_email");}}}}});$(".new_com_sub").keydown(function(e){if(e.which==9&&e.shiftKey){e.preventDefault();}});$(".enter_email_attachment").keypress(function(e){if(e.which==13||e.which==32){e.preventDefault();var textarea=$(".enter_email_attachment").val();$(".enter_email_attachment").val("");$(".combind_email_attachment").append('<div class="vR"><span class="vN Y7BVp a3q" email="hari@silvereye.co"><div class="vT">'+textarea+'</div><div class="vM closeit"></div></span></div>');}});var composed_height=$(".composed_pages").innerHeight()-$(".all_send").innerHeight();$(document.body).on("click",".small_to",function(){$(".composed_input").addClass("small_to");$(".email_id_info_to").css("display","block");$(".combind_email").addClass("border_to");});$(document.body).on("focus",".to_row",function(){$(".to_row").removeClass("small_to");$(".cc_row").addClass("small_to");$(".full_cc").css("height","32");$(".bcc_row").addClass("small_to");$(".attach_row").addClass("small_to");$(".subject_row").addClass("small_to");$(".email_id_info_to").css("display","none");$(".email_id_info_cc").css("display","block");$(".email_id_info_bcc").css("display","block");});$(document.body).on("click",".to_row",function(){$(".to_row").removeClass("small_to");$(".cc_row").addClass("small_to");$(".full_cc").css("height","32");$(".bcc_row").addClass("small_to");$(".attach_row").addClass("small_to");$(".subject_row").addClass("small_to");$(".email_id_info_to").css("display","none");$(".email_id_info_cc").css("display","block");$(".email_id_info_bcc").css("display","block");});$(document.body).on("focus",".cc_row",function(){$(".to_row").addClass("small_to");$(".cc_row").removeClass("small_to");$(".full_cc").css("height","32");$(".bcc_row").addClass("small_to");$(".attach_row").addClass("small_to");$(".subject_row").addClass("small_to");$(".email_id_info_to").css("display","block");$(".email_id_info_cc").css("display","none");$(".email_id_info_bcc").css("display","block");});$(document.body).on("click",".cc_row",function(){$(".to_row").addClass("small_to");$(".cc_row").removeClass("small_to");$(".full_cc").css("height","32");$(".bcc_row").addClass("small_to");$(".attach_row").addClass("small_to");$(".subject_row").addClass("small_to");$(".email_id_info_to").css("display","block");$(".email_id_info_cc").css("display","none");$(".email_id_info_bcc").css("display","block");});$(document.body).on("focus",".bcc_row",function(){$(".full_cc").css("height","32");$(".to_row").addClass("small_to");$(".cc_row").addClass("small_to");$(".bcc_row").removeClass("small_to");$(".attach_row").addClass("small_to");$(".subject_row").addClass("small_to");$(".email_id_info_to").css("display","block");$(".email_id_info_cc").css("display","block");$(".email_id_info_bcc").css("display","none");});$(document.body).on("click",".bcc_row",function(){$(".full_cc").css("height","32");$(".to_row").addClass("small_to");$(".cc_row").addClass("small_to");$(".bcc_row").removeClass("small_to");$(".attach_row").addClass("small_to");$(".subject_row").addClass("small_to");$(".email_id_info_to").css("display","block");$(".email_id_info_cc").css("display","block");$(".email_id_info_bcc").css("display","none");});$(document.body).on("click",".subject_row",function(){$(".to_row").addClass("small_to");$(".cc_row").addClass("small_to");$(".bcc_row").addClass("small_to");$(".attach_row").addClass("small_to");$(".subject_row").removeClass("small_to");$(".email_id_info_to").css("display","block");$(".email_id_info_cc").css("display","block");$(".email_id_info_bcc").css("display","block");$(".full_cc").css("height","32");$(".combind_email_bcc").addClass("");$(".combind_email_cc").addClass("");});$(document.body).on("focus",".subject_row",function(){$(".to_row").addClass("small_to");$(".cc_row").addClass("small_to");$(".bcc_row").addClass("small_to");$(".attach_row").addClass("small_to");$(".subject_row").removeClass("small_to");$(".email_id_info_to").css("display","block");$(".email_id_info_cc").css("display","block");$(".email_id_info_bcc").css("display","block");$(".full_cc").css("height","32");$(".combind_email_bcc").addClass("");$(".combind_email_cc").addClass("");});$(document.body).on("click",".attach_row",function(){$(".to_row").addClass("small_to");$(".cc_row").addClass("small_to");$(".bcc_row").addClass("small_to");$(".subject_row").addClass("small_to");$(".attach_row").removeClass("small_to");$(".email_id_info_to").css("display","block");$(".email_id_info_cc").css("display","block");$(".email_id_info_bcc").css("display","block");$(".full_cc").css("height","32");$(".combind_email_bcc").addClass("");$(".combind_email_cc").addClass("");});$(document.body).on("focus",".attach_row",function(){$(".to_row").addClass("small_to");$(".cc_row").addClass("small_to");$(".bcc_row").addClass("small_to");$(".subject_row").addClass("small_to");$(".attach_row").removeClass("small_to");$(".email_id_info_to").css("display","block");$(".email_id_info_cc").css("display","block");$(".email_id_info_bcc").css("display","block");$(".full_cc").css("height","32");$(".combind_email_bcc").addClass("");$(".combind_email_cc").addClass("");});$(document.body).on("click",".email_id_info_to",function(){if($(".email_id_info_to").css("display")=="block"){$(".composed_input").removeClass("small_to");$(".email_id_info_to").css("display","none");$(".combind_email").removeClass("border_to");}});$(document.body).on("click",".full_to",function(){if($(".email_id_info_to").css("display")=="block"){$(".composed_input").removeClass("small_to");$(".email_id_info_to").css("display","none");$(".combind_email").removeClass("border_to");}});$(".on_focus").focus(function(){$(".combind_email").append('<div class="vR"><span class="vN Y7BVp a3q" email="hari@silvereye.co"><div class="vT">Hari Om Srivastava</div><div class="vM"></div></span></div>');});$(document.body).on("click",".cke_button__maximize",function(){});$(document.body).on("click",".cc_link",function(){if($(".cc_row").css("display")=="none"){$(".cc_row").addClass("full_row");$(".cc_link").css("display","none");}else{$(".cc_row").removeClass("full_row");}});$(".bcc_link").click(function(){if($(".bcc_hide").css("display")=="none"){$(".bcc_hide").addClass("full_row");$(".green_sign").css("display","block");}else{$(".bcc_hide").removeClass("full_row");$(".green_sign").css("display","none");}});function nphtmlUnescape(value){return String(value).replace(/&quot;/g,'"').replace(/&#39;/g,"'").replace(/&lt;/g,"<").replace(/&gt;/g,">").replace(/&amp;/g,"&");}$(document.body).on("click",".to_content >.vN >.closeit_to",function(){$(this).parent().parent().remove();$(".email_id_info_to").text("");var txt=$(this).parent().children().html();var txt1=txt+",";var txt2=","+txt;var hid_txt=$("#hid_to_id").val();hid_txt=hid_txt.replace(txt2,"");hid_txt=hid_txt.replace(txt1,"");hid_txt=hid_txt.replace(txt,"");document.getElementById("hid_to_id").value=hid_txt;try{txt=nphtmlUnescape(txt);txt1=txt+",";txt2=","+txt;hid_txt=hid_txt.replace(txt2,"");hid_txt=hid_txt.replace(txt1,"");hid_txt=hid_txt.replace(txt,"");document.getElementById("hid_to_id").value=hid_txt;}catch(e){}var append_width=$(".to_content").width();var countwidth=0;var extracount=0;$(".to_content").each(function(){countwidth+=$(this).width();if(countwidth>=find_other){extracount++;$(".email_id_info_to").removeClass("remove_to_more");}else{$(".email_id_info_to").addClass("remove_to_more");}});if(extracount>0){$(".email_id_info_to").text(extracount);}else{$(".email_id_info_to").text("");}});$(document.body).on("click",".cc_content >.vN >.closeit_cc",function(){$(this).parent().parent().remove();$(".email_id_info_cc").text("");var txt=$(this).parent().children().html();var txt1=txt+",";var txt2=","+txt;var hid_txt=$("#hid_cc_id").val();hid_txt=hid_txt.replace(txt2,"");hid_txt=hid_txt.replace(txt1,"");hid_txt=hid_txt.replace(txt,"");document.getElementById("hid_cc_id").value=hid_txt;var append_width=$(".cc_content").width();var countwidth=0;var extracount=0;$(".cc_content").each(function(){countwidth+=$(this).width();if(countwidth>=find_other){extracount++;$(".email_id_info_to").removeClass("remove_to_more");}else{$(".email_id_info_to").addClass("remove_to_more");}});if(extracount>0){$(".email_id_info_cc").text(extracount);}else{$(".email_id_info_cc").text("");}});$(document.body).on("click",".bcc_content >.vN >.closeit_bcc",function(){$(this).parent().parent().remove();$(".email_id_info_bcc").text("");var txt=$(this).parent().children().html();var txt1=txt+",";var txt2=","+txt;var hid_txt=$("#hid_bcc_id").val();hid_txt=hid_txt.replace(txt2,"");hid_txt=hid_txt.replace(txt1,"");hid_txt=hid_txt.replace(txt,"");document.getElementById("hid_bcc_id").value=hid_txt;var append_width=$(".bcc_content").width();var countwidth=0;var extracount=0;$(".bcc_content").each(function(){countwidth+=$(this).width();if(countwidth>=find_other){extracount++;$(".email_id_info_to").removeClass("remove_to_more");}else{$(".email_id_info_to").addClass("remove_to_more");}});if(extracount>0){$(".email_id_info_bcc").text(extracount);}else{$(".email_id_info_bcc").text("");}});});