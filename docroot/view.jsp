<%@ page pageEncoding="utf-8"%>
<%@page import="com.liferay.portal.kernel.util.StringPool"%>
<%@page import="javax.portlet.PortletPreferences"%>
<%@page import="com.njshido.component.ShidoImageSliderConfigurationAction" %>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://liferay.com/tld/security" prefix="liferay-security"%>
<%@ taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme"%>
<%@ taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui"%>

<portlet:defineObjects />

<%
	PortletPreferences preferences = renderRequest.getPreferences();
	String transition = preferences.getValue(ShidoImageSliderConfigurationAction.SHIDO_IMAGE_SLIDER_TRANSITION, StringPool.BLANK);
	String pager = preferences.getValue(ShidoImageSliderConfigurationAction.SHIDO_IMAGE_SLIDER_PAGER, StringPool.BLANK);
	String speed = preferences.getValue(ShidoImageSliderConfigurationAction.SHIDO_IMAGE_SLIDER_SPEED, StringPool.BLANK);
	String pause = preferences.getValue(ShidoImageSliderConfigurationAction.SHIDO_IMAGE_SLIDER_PAUSE, StringPool.BLANK);
	String height = preferences.getValue(ShidoImageSliderConfigurationAction.SHIDO_IMAGE_SLIDER_HEIGHT, 
			ShidoImageSliderConfigurationAction.SHIDO_IMAGE_SLIDER_HEIGHT_DEFAULT_VAL);
	
	String[] urls = preferences.getValues(ShidoImageSliderConfigurationAction.SHIDO_IMAGE_SLIDER_URL, StringPool.EMPTY_ARRAY);
	pageContext.setAttribute("urls", urls);
	String[] titles = preferences.getValues(ShidoImageSliderConfigurationAction.SHIDO_IMAGE_SLIDER_TITLE, StringPool.EMPTY_ARRAY);
	pageContext.setAttribute("titles", titles);
	String[] links = preferences.getValues(ShidoImageSliderConfigurationAction.SHIDO_IMAGE_SLIDER_LINK, StringPool.EMPTY_ARRAY);
	pageContext.setAttribute("links", links);
%>
<div id="<portlet:namespace/>shido-image-slider" class="shido-image-slider">
	<ul style="margin:0 !important">
		<c:forEach items="${urls}" var="url" varStatus="status">
			<li style="height: <%= height%>px;">
				<div style="height:100%;width:100%;
					background-image:url(${url});
					background-repeat:no-repeat;
					background-position:center center;">
					<a href="${links[status.index]}" style="display:block;height:100%;text-decoration:none;">
						<span style="display:block;position:absolute;text-align:center;top:50%;width:100%;
							color:#fff;font-size:50px;font-family:Microsoft Yahei;">${titles[status.index]}</span>
		        	</a>
				</div>
		    </li>
		</c:forEach>
	</ul>
</div>

<script type="text/javascript">
	$(document).ready(function() {
		$("#<portlet:namespace/>shido-image-slider").slippry({
			transition: '<%=transition%>',
			useCSS: true,
			speed: <%=speed%>,
			pause: <%=pause%>,
			auto: true,
			autoHover: false,
			preload: 'visible',
			pager: <%=pager%>
		});
	});
</script>
