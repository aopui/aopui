////////////////////////////////////////////////////////////////////////////////
//  Copyright 2010 AOPUI.COM, All rights reserved.
//  Oct 18, 2010
//  @author wushihuan
//	email:wushihuan@163.com
//  @version 0.1
////////////////////////////////////////////////////////////////////////////////
package com.aopui.admiral
{
	import com.aopui.message.AllPowerfulMessage;
	import com.aopui.sdk.app.Application;	
	import org.spicefactory.lib.reflect.Metadata;
	import org.spicefactory.parsley.core.context.Context;
	import org.spicefactory.parsley.core.context.provider.Provider;
	import org.spicefactory.parsley.core.messaging.MessageProcessor;
	import org.spicefactory.parsley.core.messaging.MessageReceiverRegistry;
	import org.spicefactory.parsley.core.messaging.MessageRouter;
	import org.spicefactory.parsley.core.messaging.impl.DefaultMessageRouter;
	import org.spicefactory.parsley.core.messaging.receiver.MessageTarget;
	import org.spicefactory.parsley.core.scope.ScopeManager;
	import org.spicefactory.parsley.core.scope.ScopeName;
//	import org.spicefactory.parsley.processor.messaging.receiver.MessageProcesser;

	public class MessageAdmiral
	{
		public static var _instance:MessageAdmiral;
		[MessageDispatcher]
		public var dispatcher:Function;
		[Inject]
		public var context:Context;
		
		public function MessageAdmiral()
		{
		}
		
//		public function regMessageHandler(methodOwer:Object,handlerName:String,selector:String):void
//		{
//			var registry:MessageReceiverRegistry= context.scopeManager.getScope(ScopeName.GLOBAL).messageReceivers;
//			var target:MessageTarget= new MessageProcesser(Provider.forInstance(methodOwer), handlerName,selector);
//			registry.addTarget(target);
//			if(selector.substr(0,4)==Metadata.PRE)				
//				Metadata.addPremessage(selector);
//		}
//		
//		[MessageInterceptor(type="com.aopui.message.AllPowerfulMessage")]
//		public function interceptDeleteEvent (processor:MessageProcessor) : void
//		{
//			var premessages:Array=Metadata.premessages;
//			var context:Context=Application.app.context;
//			var messageId:String=processor.message.id;
//			var param:Object=processor.message.param;
//			var msg:AllPowerfulMessage
//			if(processor.message.type=="request")
//			{
//				if(!param)param={};
//				processor.proceed();
//				param.api=messageId;
//				msg=AllPowerfulMessage.create(AllPowerfulMessage.SINGLECMD,param);//这个问题已经解决   没有做Prehandler的不能继续执行了哎。。。。
//				dispatcher(msg);
//				return;
//			}
//			
//			if(messageId==AllPowerfulMessage.SINGLECMD)
//			{
//				processor.proceed();
//				return;
//			}
//			
//			if(messageId.substr(0,4)==Metadata.PRE)
//			{
//				processor.proceed();
//				return;
//			}
//			
//			if(messageId.substr(0,4)==Metadata.END)
//			{
//				processor.proceed();
//				return;
//			}
//			
//			if(premessages.indexOf(Metadata.PRE+messageId)==-1)
//			{
//				processor.proceed();
//				return;
//			}
//			
//			if(param)
//				param.processor=processor;
//			else
//				param={processor:processor};
//			msg=AllPowerfulMessage.create(Metadata.PRE+messageId,param);
//			dispatcher(msg);
//		}	

	}
}