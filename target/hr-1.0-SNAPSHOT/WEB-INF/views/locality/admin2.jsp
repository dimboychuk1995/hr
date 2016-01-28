<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
.a2_noed{display: none;}
.a1_ed{display: none;}
</style>
<div style=" position:relative; float: right; width: 74%;height: 87%;border: 2px solid silver;" >
	<div id="srch_pan">
		<table width="100%">
			<tr>
				<td>Прізвище : <input  class="srchinp" name="pip" title="Введіть Прізвище та натисніть клавішу 'Enter'" /></td>
				<td>Посада : <input  class="srchinp" name="posada" title="Введіть посаду та натисніть клавішу 'Enter'" /></td>
				<td>Табельний № : <input  class="srchinp" name="tabn" size="6" title="Введіть табельний та натисніть клавішу 'Enter'" /></td>
				<td>Телефон : <input class="srchinp" name="tel" title="Введіть телефон та натисніть клавішу 'Enter'" /></td>
				<td><input type="hidden" name="ch" value="" /></td>
			</tr>
		</table>
	</div>
	<div id="dlg">
		<div id="dlg_cont">
		</div>
	</div>
	<div class="tableContainer1">
		<table>
			<tr><td>Прізвище  ім'я по батькові</td><td>телефон</td><td>E-mail</td><td>Посада</td><td>Таб. №</td></tr>
		</table>
	</div>
	<div class="tableContainer">
		<table class="tableContainer">		
		<tbody id="mtabl" class="scrollContent">
		</tbody>
		</table>
	</div>
</div>
	
<div id="sidetree">
<div class="treeheader">&nbsp;</div>
<div id="sidetreecontrol"><a href="?#">&nbsp;Згорнути всі</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="?#">Розгорнути всі</a></div>
<ul id="tree" class="treeview"></ul>
</div>
