<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title><tiles:insertAttribute name="title" ignore="true" />
	</title>
	<link href="<c:url value="/resources/css/main.css"/>" rel="stylesheet" type="text/css">
	<link href="<c:url value="/resources/css/jquery.treeview.css"/>" rel="stylesheet" type="text/css">
	<link href="<c:url value="/resources/jqthem/jquery-ui-1.8.14.custom.css"/>"	rel="stylesheet" type="text/css">

	<script type="text/javascript" src="<c:url value="/resources/js/jquery-1.6.2.min.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/resources/js/jquery-ui-1.8.16.custom.min.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/resources/js/jquery.treeview.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/resources/js/jquery.tools.min.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/resources/js/jquery.cookie.js"/>"></script>
	<script type="text/javascript">
		var sap_url= "//10.93.1.56:8084/SOAPEmpoyee/PersonSearch";
		//var sap_url= "/STEKEmployee/Employee";
		var mail_to = "Dmytro.Boychuk@oe.if.ua";
		$(document).ready(function() {
			$('#mail_can').click(function(){
				$("#mail_dlg").hide();
			});
			$('#mail_subm').click(function(){
				jQuery.ajax({
					type: "POST",
					url: "/hr/mail?subject="+$("#mt").html()+"&body="+$("#mm").val()+"<br />Примітка: "+$("#mad").val()+"&from=test@oe.if.ua&to="+mail_to,
					dataType: "xml",
					success: function(xml){ alert("Повдомлення надіслано!");  }

				});
				$("#mail_dlg").hide();
			});
			$("input[name='pip']").focus();
			$("input").focus(function(){$(".srchinp").attr("value","");});
		    $("input").tooltip({
				position: "top center",
				offset: [-2, 0],
				effect: "fade",
				opacity: 0.7
			});
			$("#logo").tooltip({
				position: "center left",
				offset: [0, 510],
				effect: "fade",
				opacity: 0.9
			});
			//jQuery.ajax({
			//type: "POST",
			//    url: sap_url,
			//data:  {"task":"JOB_POS"},
			//dataType: "xml",
			// success: function(xml){
			//   	var poslist=new Array();
			//	var ind = 0;
			//   $(xml).find("LONG_TEXT").each(function(){poslist[ind++]=$(this).text();});
			//   $("input[name='posada']").autocomplete({source: poslist});
			// },
			//  error:function (xhr, ajaxOptions, thrownError){AJAXErro (xhr, ajaxOptions, thrownError);}
			//});
			$("#progresbar").show();
			jQuery.ajax({
				type: "POST",
				url: sap_url,
				data:  {"task":"ORG_UNIT_LIST"},
				dataType: "html",
				success: function(xml){
					tree_txt=xml;
					$('#tree').html(tree_txt);
					$('span').click(function(){
						var org_name = $(this).attr('id').substring(3,11);
						$('span').attr('style','');
						$(this).attr('style','background:#00BFFF;');
						if (org_name!='00000103'){
							AJAXGetRezSerch('','',org_name,'','*')};
					});
					$("#tree").treeview({
						collapsed: true,
						animated: "medium",
						control:"#sidetreecontrol",
						persist: "cookie"
					});
					$("#progresbar").hide();
				},
				error:function (xhr, ajaxOptions, thrownError){
					alert(xhr.status);
					alert(thrownError);
				}
			});
			$('input').keydown(function(e) {
				if(e.keyCode == 13) {
					var pip=$("input[name='pip']").attr("value")+'*';
					var posada=$("input[name='posada']").attr("value");
					var tel='*'+$("input[name='tel']").attr("value")+'*';
					if (pip!='*' || posada!=''||tel!='**') {AJAXGetRezSerch('',pip,'',posada,tel)};
				}
			});
		});

		function AJAXGetRezSerch(tabn,pip,org_name,posada,tel){
			$("#progresbar").show();
			chinp=$("input[name='ch']").attr("value");
			jQuery.ajax({
				type: "POST",
				url: sap_url,
				data:  {"task":"COMMUNIC", "employee_id":tabn,"last_name":pip,"first_name":"","org_name":"","job_name":posada,"org_id":org_name,"job_id":"","only_communic":chinp,"tel_ats":tel},
				dataType: "html",
				success: function(xml){
					myparse(xml);
					$("#progresbar").hide();
				},
				error:function (xhr, ajaxOptions, thrownError){AJAXErro (xhr, ajaxOptions, thrownError);}
			});
		};
		function AJAXErro (xhr, ajaxOptions, thrownError){
			$("#progresbar").hide();
			alert(xhr.status);
			alert(thrownError);
		};
		function myparse(xml){
			$('#mtabl').html('');
			$("#dlg_cont").html('');
			$('#mtabl').append(xml);
			$("#dlg_cont").html($(".row:first > td:first > div").html());
			//виділення в дереві орг поточного юзера
			var ps_id = $(".row:first > td:first > div").attr('id');
			$('span').attr('style','');
			$('#sp_'+ps_id).attr('style','background:#00BFFF;');
			$('#sp_'+ps_id).parent('li').parent('ul').attr('style','display: block;');
			$('#sp_'+ps_id).parent('li').parent('ul').parent('li').parent('ul').attr('style','display: block;');
			$('#sp_'+ps_id).parent('li').parent('ul').parent('li').parent('ul').parent('li').parent('ul').attr('style','display: block;');
			$('#sp_'+ps_id).parent('li').parent('ul').parent('li').parent('ul').parent('li').parent('ul').parent('li').parent('ul').attr('style','display: block;');

			$(".row:first").addClass('current');
			$('.badt').click(function(){
				$("#mail_dlg").show();
				$("#mt").html("Невідповідність телефонів");
				$("#mm").html($("#dlg_cont_m > h3").html()+" невідповідний номер телефону. Вірний номер:_    _. Прошу внести зміни!");
				mail_to = "anna.petrash@oe.if.ua";
			});
			$('.bada').click(function(){
				$("#mail_dlg").show();
				$("#mt").html("Невідповідність електронної адреси");
				$("#mm").html($("#dlg_cont_m > h3").html()+" невідповідна електронн адреса. Вірна адреса:_  _. Прошу внести зміни!");
				mail_to = "roman.savchak@oe.if.ua";
			});
			$(".row").click(function(){
				$(".current").removeClass('current');
				$(this).addClass('current');
				$("#dlg_cont").html($(this).children('td:first').children('div').html());
				//виділення в дереві орг поточного юзера
				var ps_id = $(this).children('td:first').children('div').attr('id');
				$('span').attr('style','');
				$('#sp_'+ps_id).attr('style','background:#00BFFF;');
				$('#sp_'+ps_id).parent('li').parent('ul').attr('style','display: block;');
				$('#sp_'+ps_id).parent('li').parent('ul').parent('li').parent('ul').attr('style','display: block;');
				$('#sp_'+ps_id).parent('li').parent('ul').parent('li').parent('ul').parent('li').parent('ul').attr('style','display: block;');
				$('#sp_'+ps_id).parent('li').parent('ul').parent('li').parent('ul').parent('li').parent('ul').parent('li').parent('ul').attr('style','display: block;');
				//var sp_class = $('#sp_'+ps_id).parent('li').attr('class');
				//if(sp_class=='expandable'){
				//	$('#sp_'+ps_id).parent('li').removeClass('expandable');
				//	$('#sp_'+ps_id).parent('li').addClass('collapsable');
				//}


				$('.badt').click(function(){
					$("#mail_dlg").show();
					$("#mt").html("Невідповідність телефонів");
					$("#mm").html($("#dlg_cont_m > h3").html()+" невідповідний номер телефону. Вірний номер:_    _. Прошу внести зміни!!");
					mail_to = "anna.petrash@oe.if.ua";
				});
				$('.bada').click(function(){
					$("#mail_dlg").show();
					$("#mt").html("Невідповідність електронної адреси");
					$("#mm").html($("#dlg_cont_m > h3").html()+" невідповідна електронн адреса. Вірна адреса:_  _. Прошу внести зміни!");
					mail_to = "roman.savchak@oe.if.ua";
				});

			});
		};
		function savefunck(){
			var eml = 	$("#dlg_cont > #dlg_cont_m > input[name='email']").attr('value');
			var at =	$("#dlg_cont > #dlg_cont_t > span > input[name='tel_ats']").attr('value');
			var mis =	$("#dlg_cont > #dlg_cont_t > span > input[name='tel_MISTO']").attr('value');
			var m1 =	$("#dlg_cont > #dlg_cont_t > span > input[name='mob1']").attr('value');
			var m2 =	$("#dlg_cont > #dlg_cont_t > span > input[name='mob2']").attr('value');
			var hom =	$("#dlg_cont > #dlg_cont_t > span > input[name='tel_home']").attr('value');
			var fax =	$("#dlg_cont > #dlg_cont_t > span > input[name='fax']").attr('value');
			var tabln =	$("#dlg_cont > #dlg_cont_f > div:first").html();
			//alert(eml +at+mis+m1+m2+hom+tabln);

			jQuery.ajax({
				type: "POST",
				url: sap_url,
				data:  {"task":"COMMUNIC_UPDATE","email":eml,"ats":at,"misto":mis,"mob1":m1,"mob2":m2,"home":hom,"employee_id":tabln,"fax":fax},
				dataType: "xml",
				success: function(xml){
					alert('Дані збережено!');
				},
				error:function (xhr, ajaxOptions, thrownError){AJAXErro (xhr, ajaxOptions, thrownError);}
			});
		}
	</script>
</head>
<body>
<div style="position:relative; height:100%;">
	<tiles:insertAttribute name="toolbar" />
	<tiles:insertAttribute name="body" />

	<div id="progresbar" style="position: absolute;top: 0px;left: 0px;height: 100%;width: 100%; background-color: silver; display: none;" >
		<div id="progresbar_txt">Зачекайте. Дані завантажуються!</div>
		<div id="progresbar_gif"></div>
	</div>
	<div id="mail_dlg" style="position: absolute;top: 0px;left: 0px;height: 100%;width: 100%; background-color: silver;  display: none;" >
		<div id="progresbar_txt" style="color: black;margin-left: -290px; margin-top: -200px; ">
			<table>
				<tr>
					<td>Тема повідомлення</td>
					<td id="mt">&nbsp;</td>
				</tr>
				<tr>
					<td>Текст повідомлення</td>
					<td><textarea id="mm" rows="5" cols="50"></textarea></td>
				</tr>
				<tr>
					<td>Примітка</td>
					<td><textarea id="mad" rows="5" cols="50"></textarea></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td><button id="mail_subm">Відіслати</button><button id="mail_can">Відміна</button></td>
				</tr>
			</table>
		</div>
	</div>
</div>
</body>
</html>
