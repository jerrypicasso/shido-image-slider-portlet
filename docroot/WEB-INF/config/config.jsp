<%@page import="com.njshido.component.ShidoImageSliderConfigurationAction" %>
<%@ page pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://liferay.com/tld/security" prefix="liferay-security" %>
<%@ taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme" %>
<%@ taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui" %>
<%@ taglib uri="http://liferay.com/tld/portlet" prefix="liferay-portlet" %>

<portlet:defineObjects />

<liferay-theme:defineObjects />

<%
	String transition = String.valueOf(request.getAttribute(ShidoImageSliderConfigurationAction.SHIDO_IMAGE_SLIDER_TRANSITION));
	String pager = String.valueOf(request.getAttribute(ShidoImageSliderConfigurationAction.SHIDO_IMAGE_SLIDER_PAGER));
	String speed = String.valueOf(request.getAttribute(ShidoImageSliderConfigurationAction.SHIDO_IMAGE_SLIDER_SPEED));
	String pause = String.valueOf(request.getAttribute(ShidoImageSliderConfigurationAction.SHIDO_IMAGE_SLIDER_PAUSE));
	String height = String.valueOf(request.getAttribute(ShidoImageSliderConfigurationAction.SHIDO_IMAGE_SLIDER_HEIGHT));
	
	String[] urls = (String[]) request.getAttribute(ShidoImageSliderConfigurationAction.SHIDO_IMAGE_SLIDER_URL);
	pageContext.setAttribute("urls", urls);
	String[] titles = (String[]) request.getAttribute(ShidoImageSliderConfigurationAction.SHIDO_IMAGE_SLIDER_TITLE);
	pageContext.setAttribute("titles", titles);
	String[] links = (String[]) request.getAttribute(ShidoImageSliderConfigurationAction.SHIDO_IMAGE_SLIDER_LINK);
	pageContext.setAttribute("links", links);
%>
<liferay-ui:success key="success" message="your-configuration-was-saved-sucessfully"/>
<form action="<liferay-portlet:actionURL portletConfiguration='true' />" name="<portlet:namespace/>shido_image_slider_config_form" method="post">
	<input type="button" value="添加条目" onclick="addItem();"/>
	<div style="background:#ddd;padding:20px 0px;opacity:0.8">
		<ul>
			<li>
				<span>高度：</span>
				<input name="<portlet:namespace/><%=ShidoImageSliderConfigurationAction.SHIDO_IMAGE_SLIDER_HEIGHT%>" type="number" style="width:30%;" value="<%=height%>"/>px
			</li>
			<li>
				<span>切换效果：</span>
				<select name="<portlet:namespace/><%=ShidoImageSliderConfigurationAction.SHIDO_IMAGE_SLIDER_TRANSITION%>" style="width:50%;">
					<option value="none" <%="none".equals(transition) ? "selected":"" %> >无</option>
					<option value="fade" <%="fade".equals(transition) ? "selected":"" %> >淡入淡出</option>
					<option value="horizontal" <%="horizontal".equals(transition) ? "selected":"" %> >横向移动</option>
					<option value="vertical" <%="vertical".equals(transition) ? "selected":"" %> >纵向移动</option>
					<option value="kenburns" <%="kenburns".equals(transition) ? "selected":"" %> >平移缩放</option>
				</select>
			</li>
			<li>
				<span>切换速率：</span>
				<input name="<portlet:namespace/><%=ShidoImageSliderConfigurationAction.SHIDO_IMAGE_SLIDER_SPEED%>" type="number" style="width:30%;" value="<%=speed%>"/>毫秒
			</li>
			<li>
				<span>停顿时间：</span>
				<input name="<portlet:namespace/><%=ShidoImageSliderConfigurationAction.SHIDO_IMAGE_SLIDER_PAUSE%>" type="number" style="width:30%;"  value="<%=pause%>"/>毫秒
			</li>
			<li>
				<span>页面符号：</span>
				<input name='<portlet:namespace/><%=ShidoImageSliderConfigurationAction.SHIDO_IMAGE_SLIDER_PAGER%>' 
					type="radio" value="true" <%="true".equals(pager) ? "checked":"" %> />有
				<input name='<portlet:namespace/><%=ShidoImageSliderConfigurationAction.SHIDO_IMAGE_SLIDER_PAGER%>' 
					type="radio" value="false" <%=!"true".equals(pager) ? "checked":"" %>/>无
			</li>
		</ul>
	</div>
	
	<div id="<portlet:namespace />itemsConfigurationPanel" style="padding:20px 0px;">
		<c:forEach items="${urls}" var="url" varStatus="status">
			<ul id="<portlet:namespace/>url_${status.index}">
			   	<li>
			   		<span>图片地址：</span>
			   		<input required type="text" style="width:50%;" value="${url}" name="<portlet:namespace/><%=ShidoImageSliderConfigurationAction.SHIDO_IMAGE_SLIDER_URL%>"/>
			   	</li>
			   	<li>
			   		<span>图片详情：</span>
			   		<input type="text" style="width:50%;" value="${titles[status.index]}" name="<portlet:namespace/><%=ShidoImageSliderConfigurationAction.SHIDO_IMAGE_SLIDER_TITLE%>"/>
			   	</li>
			   	<li>
			   		<span>链接地址：</span>
			   		<input type="text" style="width:50%;" value="${links[status.index]}" name="<portlet:namespace/><%=ShidoImageSliderConfigurationAction.SHIDO_IMAGE_SLIDER_LINK%>"/>
			   	</li>
			   	<li>
			   		<input type="button" value="删除" onclick="removeItem('<portlet:namespace/>url_${status.index}')"/>
			   	</li>
		   	</ul>
		</c:forEach>
	</div>
	<input type="submit" value="save"/>
</form>

<script type="text/javascript">
	function addItem() {
		var itemsConfigurationPanel = $('#<portlet:namespace />itemsConfigurationPanel');
		var section = ['<ul>',
					   '<li><span>图片地址：</span><input type="text" style="width:50%;" name="<portlet:namespace/><%=ShidoImageSliderConfigurationAction.SHIDO_IMAGE_SLIDER_URL%>"/></li>',
					   '<li><span>图片详情：</span><input type="text" style="width:50%;" name="<portlet:namespace/><%=ShidoImageSliderConfigurationAction.SHIDO_IMAGE_SLIDER_TITLE%>"/></li>',
					   '<li><span>链接地址：</span><input type="text" style="width:50%;" name="<portlet:namespace/><%=ShidoImageSliderConfigurationAction.SHIDO_IMAGE_SLIDER_LINK%>"/></li>',
					   '</ul>'];
		itemsConfigurationPanel.append(section.join(''));
	}
	
	function removeItem(id) {
		$('#' + id).remove();
	}
</script>