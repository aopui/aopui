/*
* Copyright(c) 2010 www.AOPUI.COM, All rights reserved.
* 2010-8-3
* Michael
*/
package com.aopui.sdk.module
{
	import com.aopui.admiral.FontAdmiral;
	import com.aopui.event.EventBase;
	import com.aopui.model.GlobalModel;
	import com.aopui.sdk.app.Application;
	
	import flash.events.EventDispatcher;
	import flash.text.Font;
	import flash.utils.getDefinitionByName;
	
	import org.spicefactory.parsley.asconfig.ActionScriptContextBuilder;
	import org.spicefactory.parsley.context.ContextBuilder;
	import org.spicefactory.parsley.core.bootstrap.ConfigurationProcessor;
	import org.spicefactory.parsley.core.context.Context;
	import org.spicefactory.parsley.xml.XmlConfig;
	import org.spicefactory.parsley.xml.processor.XmlConfigurationProcessor;
	
	public class ModuleAdmiral extends EventDispatcher
	{
		private var _assembler:XML;
		private var _startup:Boolean;											//是否已经载入随机启动模块
		private var _pendingModuleIds:Array = [];								//排队载入的模块Id
		private var _moduleList:Vector.<ModuleInfo> = new Vector.<ModuleInfo>();//所有模块的列表，包括已载入跟载入中的
		private static var _batchToken:uint;//用于区分模块批次的 token
		
		public function ModuleAdmiral( assembler:XML )
		{
			_assembler = assembler;
		}
		
		/**
		 * 载入需要随机启动的插件
		 */
		public function loadStartupModules():void
		{
			if (_startup) return;
			_startup = true;
			var array:Array=[];
			for each (var data:XML in _assembler.children())
			{
				if (data.@startup == "true")
				{
					array.push(data.@id+"");
				}
			}
			batchLoadModules(array);
			
			
		}
		
		/**
		 * 是否正在载入中，需要排队等待
		 * 当有排队的 或者 有没载入完毕的，都会返回true
		 */
		public function get pending():Boolean
		{
			if ( _pendingModuleIds.length > 0 ) return true;
			var moduleInfo:ModuleInfo;
			for (var i:int =0; i<_moduleList.length; i++)
			{
				moduleInfo = _moduleList[i];
				if ( !moduleInfo.ready ) 
					return true;
			}
			return false;
		}
		
		private function getToken():uint
		{
			return ++_batchToken;
		}
		
		
		public function lookupExistedModule(id:String):ModuleInfo
		{
			var moduleInfo:ModuleInfo;
			for (var i:int =0; i<_moduleList.length; i++)
			{
				moduleInfo = _moduleList[i];
				if (moduleInfo.id == id)
					return moduleInfo;
			}
			return null;
		}		
		
		public function batchLoadModules(moduleIds:Array):void
		{
			var id:String;
			
			if ( pending )
			{
				if (moduleIds.length == 1)
					_pendingModuleIds.push( moduleIds[0] );
				else
					_pendingModuleIds.push( moduleIds );
			}	
			else
			{
				var token:uint = getToken();
				for each ( id in moduleIds)
				{
					var module:ModuleInfo = lookupExistedModule( id );
					if ( !module )
					{
						var moduleData:XML = _assembler.children().(@id==id)[0];
						module = new ModuleInfo( moduleData, token);
						_moduleList.push( module );
						module.addEventListener(ModuleCompleteEvent.MODULE_COMPLETE, moduleCompleteHandler);
						module.load();
					}
				}
			}
		}
		
		public function loadModule( moduleId:String ):void
		{
			batchLoadModules([moduleId]);
		}
		
		private function moduleCompleteHandler(event:ModuleCompleteEvent):void
		{
			var token:uint = ModuleInfo(event.currentTarget).token;
			var modules:Vector.<ModuleInfo> = new Vector.<ModuleInfo>();
				this.dispatchEvent(EventBase.createEvent("moduleLoaded",{txt:event.currentTarget.id}));
			var i:int;
			for ( i = 0; i<_moduleList.length; i++)
			{
				if ( _moduleList[i].token == token )
				{
					if ( _moduleList[i].ready )
					{
						modules.push( _moduleList[i] );
					}
					else
					{

						return;
					}
					
				}
			}
			try{
			FontAdmiral.regFont(getDefinitionByName("Strings"));
			}catch(o:Object){}
			var builder:ContextBuilder;
			if (Application.app.context)
			{
				builder = ContextBuilder.newSetup()
							.parent(Application.app.context)
							.domain(Application.app.applicationDomain)
							.newBuilder();
			}
			else
			{
				builder = ContextBuilder.newSetup()
							.domain(Application.app.applicationDomain)
							.newBuilder();
			}
			var processor:ConfigurationProcessor;
			var config:XML;
			[Embed(source="config.xml", mimeType="application/octet-stream")]
			var ConfigClazz:Class;
		
			var sysXML:XML=	XML(new ConfigClazz());
			
//			var sysXML:XML
			/*
			xmlns="http://www.spicefactory.org/parsley"
			xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
			xsi:schemaLocation="http://www.spicefactory.org/parsley http://www.spicefactory.org/parsley/schema/2.3/parsley-core.xsd"
			*/
//			if(GlobalModel.initClass)
//			{
//				for each(var x:* in GlobalModel.initClass.children())
//				{
//					sysXML.appendChild(x);
//				}
//			}
				
			processor = XmlConfig.forInstance(sysXML);
			builder.config(processor);
			
			for (var j:int = 0; j<modules.length; j++)
			{
				if(modules[j].type=="module")
				{
					config = modules[j].instance.initialize();
					if (config)
					{
						processor = XmlConfig.forInstance(config);
						builder.config(processor);
					}
				}
				if(modules[j].type=="font")
				{
						var fontName:String=""+modules[j].id;
						FontAdmiral.regFont(getDefinitionByName(fontName));
				}				
				if(modules[j].type=="xml")
				{
					if(!GlobalModel._dna.xml)
						GlobalModel._dna.xml={};
					GlobalModel._dna.xml[modules[j].id]=modules[j].content;
				}
			}
			var context:Context = builder.build();
			Application(Application.app).context=context;
			if (!Application(Application.app).context)
				Application(Application.app).context = context;
			context.scopeManager.dispatchMessage(new ModulesAllLoadedMessage());
			loadPendingModules();
		}
		
		private function loadPendingModules():void
		{
			if (_pendingModuleIds.length == 0) return;
			var ids:Object = _pendingModuleIds.shift();
			if (ids is Array)
			{
				batchLoadModules( ids as Array);
			}
			else
			{
				loadModule( ids as String );
			}
		}
	}
}