package com.njshido.component;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletConfig;
import javax.portlet.PortletPreferences;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import com.liferay.portal.kernel.portlet.DefaultConfigurationAction;
import com.liferay.portal.kernel.servlet.SessionMessages;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.StringPool;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portlet.PortletPreferencesFactoryUtil;

public class ShidoImageSliderConfigurationAction extends DefaultConfigurationAction {
	
	public static final String SHIDO_IMAGE_SLIDER_TRANSITION = "shido_image_slider_transition";
	public static final String SHIDO_IMAGE_SLIDER_PAGER = "shido_image_slider_pager";
	public static final String SHIDO_IMAGE_SLIDER_SPEED = "shido_image_slider_speed";
	public static final String SHIDO_IMAGE_SLIDER_PAUSE = "shido_image_slider_pause";
	public static final String SHIDO_IMAGE_SLIDER_HEIGHT = "shido_image_slider_height";
	
	public static final String SHIDO_IMAGE_SLIDER_URL = "shido_image_slider_url";
	public static final String SHIDO_IMAGE_SLIDER_TITLE = "shido_image_slider_title";
	public static final String SHIDO_IMAGE_SLIDER_LINK = "shido_image_slider_link";
	
	private static final String CONFIG_JSP = "/WEB-INF/config/config.jsp";
	private static final String SUCCESS = "success";
	
	public static final String SHIDO_IMAGE_SLIDER_HEIGHT_DEFAULT_VAL = "400";
	
	@Override
	public String render(PortletConfig portletConfig, RenderRequest renderRequest, RenderResponse renderResponse)
			throws Exception {
		String portletId = renderRequest.getParameter("portletResource");
		PortletPreferences preferences = PortletPreferencesFactoryUtil.getPortletSetup(renderRequest, portletId);
		renderRequest.setAttribute(SHIDO_IMAGE_SLIDER_TRANSITION, preferences.getValue(SHIDO_IMAGE_SLIDER_TRANSITION, StringPool.BLANK));
		renderRequest.setAttribute(SHIDO_IMAGE_SLIDER_PAGER, preferences.getValue(SHIDO_IMAGE_SLIDER_PAGER, StringPool.BLANK));
		renderRequest.setAttribute(SHIDO_IMAGE_SLIDER_SPEED, preferences.getValue(SHIDO_IMAGE_SLIDER_SPEED, StringPool.BLANK));
		renderRequest.setAttribute(SHIDO_IMAGE_SLIDER_PAUSE, preferences.getValue(SHIDO_IMAGE_SLIDER_PAUSE, StringPool.BLANK));
		renderRequest.setAttribute(SHIDO_IMAGE_SLIDER_HEIGHT, preferences.getValue(SHIDO_IMAGE_SLIDER_HEIGHT, StringPool.BLANK));
		renderRequest.setAttribute(SHIDO_IMAGE_SLIDER_URL, preferences.getValues(SHIDO_IMAGE_SLIDER_URL, StringPool.EMPTY_ARRAY));
		renderRequest.setAttribute(SHIDO_IMAGE_SLIDER_TITLE, preferences.getValues(SHIDO_IMAGE_SLIDER_TITLE, StringPool.EMPTY_ARRAY));
		renderRequest.setAttribute(SHIDO_IMAGE_SLIDER_LINK, preferences.getValues(SHIDO_IMAGE_SLIDER_LINK, StringPool.EMPTY_ARRAY));
		return CONFIG_JSP;
	}
	
	@Override
	public void processAction(PortletConfig portletConfig,
			ActionRequest actionRequest, ActionResponse actionResponse)
			throws Exception {
		String portletResource = ParamUtil.getString(actionRequest, "portletResource");
		PortletPreferences preferences = PortletPreferencesFactoryUtil.getPortletSetup(actionRequest, portletResource);
		if (Validator.isNotNull(preferences)) {
			String transition = ParamUtil.getString(actionRequest, SHIDO_IMAGE_SLIDER_TRANSITION);
			String pager = ParamUtil.getString(actionRequest, SHIDO_IMAGE_SLIDER_PAGER);
			String speed = ParamUtil.getString(actionRequest, SHIDO_IMAGE_SLIDER_SPEED);
			String pause = ParamUtil.getString(actionRequest, SHIDO_IMAGE_SLIDER_PAUSE);
			String height = ParamUtil.getString(actionRequest, SHIDO_IMAGE_SLIDER_HEIGHT);
			String[] urls = ParamUtil.getParameterValues(actionRequest, SHIDO_IMAGE_SLIDER_URL);
			String[] titles = ParamUtil.getParameterValues(actionRequest, SHIDO_IMAGE_SLIDER_TITLE);
			String[] links = ParamUtil.getParameterValues(actionRequest, SHIDO_IMAGE_SLIDER_LINK);
			
			preferences.setValue(SHIDO_IMAGE_SLIDER_TRANSITION, transition);
			preferences.setValue(SHIDO_IMAGE_SLIDER_PAGER, pager);
			preferences.setValue(SHIDO_IMAGE_SLIDER_SPEED, speed);
			preferences.setValue(SHIDO_IMAGE_SLIDER_PAUSE, pause);
			preferences.setValue(SHIDO_IMAGE_SLIDER_HEIGHT, height);
			preferences.setValues(SHIDO_IMAGE_SLIDER_URL, urls);
			preferences.setValues(SHIDO_IMAGE_SLIDER_TITLE, titles);
			preferences.setValues(SHIDO_IMAGE_SLIDER_LINK, links);
			preferences.store();
			
			SessionMessages.add(actionRequest, SUCCESS);
		}
		super.processAction(portletConfig, actionRequest, actionResponse);
	}
	
}
