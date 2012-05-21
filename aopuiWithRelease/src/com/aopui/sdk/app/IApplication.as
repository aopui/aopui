/*
* Copyright 2010 AOPUI.COM, All rights reserved.
* 2010-8-25
* Michael
*/
package com.aopui.sdk.app
{
	import flash.display.Sprite;
	import flash.system.ApplicationDomain;
	
	import org.spicefactory.parsley.core.context.Context;

	public interface IApplication
	{
		function get serviceUrl():String;
		
		function get baseUrl():String;
		
		function get uid():String;
		
		function get sessionId():String;
		
		function get context():Context;
		
		/**
		 * 启动某个模块
		 */
		function startModule(moduleId:String):void;
		
		function get applicationDomain():ApplicationDomain;
		
		/**
		 * 获取整个舞台根场景
		 */
		function get scene():Sprite;
		
		function get width():Number;
		
		function get height():Number;
	}
}