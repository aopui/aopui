////////////////////////////////////////////////////////////////////////////////
//  Copyright 2010 AOPUI.COM, All rights reserved.
//  Nov 1, 2010
//  @author wushihuan
//	email:wushihuan@163.com
//  @version 0.1
// 新手引导不一定是在程序已启动就有的
////////////////////////////////////////////////////////////////////////////////
package com.aopui.sdk.task
{
	import com.aopui.admiral.MessageAdmiral;
	import com.aopui.message.AllPowerfulMessage;
	import com.aopui.Marshal;
	
	import flash.events.Event;
	
	import org.spicefactory.lib.reflect.ClassInfo;
	import org.spicefactory.lib.reflect.Metadata;
	import org.spicefactory.parsley.core.context.Context;
	import org.spicefactory.parsley.core.context.provider.Provider;
//	import org.spicefactory.parsley.core.context.provider.impl.ContextObjectProvider;
	import org.spicefactory.parsley.core.messaging.MessageReceiverRegistry;
	import org.spicefactory.parsley.core.messaging.receiver.MessageTarget;
//	import org.spicefactory.parsley.core.messaging.receiver.impl.MessageHandler;
	import org.spicefactory.parsley.core.scope.ScopeName;
//	import org.spicefactory.parsley.processor.messaging.receiver.MessageHandler;
//	import org.spicefactory.parsley.processor.messaging.receiver.MessageProcesser;

	public class RookieTask
	{
		[Inject]
		public var context:Context;
		
		[Inject]
		public var messageAdmiral:MessageAdmiral;
		
		[Inject]
		public var marshal:Marshal;	
		
		public function RookieTask()
		{
		}
		
		[Init]
		public function init () : void {
			
//			regMessageHandler(this,"preinitScene","pre_initScene")
		}
		
//		[MessageHandler(selector="pre_initScene")]
//		public function preinitScene(msg:AllPowerfulMessage):void
//		{
//			trace("初始化之前");
//			msg.going();
//		}
		
//		[MessageHandler(selector="end_initScene")]
//		public function endinitScene(msg:AllPowerfulMessage):void
//		{
//			trace("初始化完毕");
//			appViewManager.sceneLayer.stage.dispatchEvent(new Event("removeloader"));
//			//然后是播放屏幕切换动画
//			//这个是第一次读取完全部的数据执行完这个就可以移除loading了
//		}
		
		public function regMessageHandler(methodOwer:Object,handlerName:String,selector:String):void
		{
//			var registry:MessageReceiverRegistry= context.scopeManager.getScope(ScopeName.GLOBAL).messageReceivers;
//			var target:MessageTarget= new MessageProcesser(Provider.forInstance(methodOwer), handlerName,selector);
//			registry.addTarget(target);
//			if(selector.substr(0,4)==Metadata.PRE)				
//				Metadata.addPremessage(selector);
		}
		
		
	}
}