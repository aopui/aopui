/*
* Copyright 2010 AOPUI.COM, All rights reserved.
* 2010-8-24
* Michael
*/
package com.aopui.sdk.preloader
{
	import com.aopui.admiral.ResourceAdmiral;
	import com.aopui.event.DynamicImgEvent;
	import com.aopui.event.EventBase;
	import com.aopui.sdk.preloader.IPreloader;
	import com.aopui.ui.DynamicImg;
	
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	import flash.utils.getDefinitionByName;
	
	public class Preloader extends MovieClip implements IPreloader
	{

		private var FILETYPE:String=".swf";
		private var LoadingBG:Class;
		private var LoadingMcClass:Class;
		private var Logo:Class; 
		private var loadingBg:Object;
		private var loadingMC:Object;
		private var logo:Object;
		private var _loaderLayer:Sprite;
		private var _sceneLayer:Sprite;
		private var _promptLabel:TextField;
		private var timer:Timer;
		private var _preloaderCanvas:Sprite;
		private var loader:DynamicImg=new DynamicImg();
		
		public function Preloader()
		{
			stop();
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			loader.addEventListener(DynamicImgEvent.LOADED,onComp);
			loader.source="loading"+FILETYPE;
		}
		
		private function removeLoader(e:Event):void
		{
			removePreloader();
		}
		private function showLoadingTxt(e:EventBase):void
		{
			var txt:String=e.message.txt;
			this.showPromptLabel(txt);
		}
		
		public function get sceneLayer():Sprite
		{
			return this._sceneLayer;
		}
		
		public function get loaderLayer():Sprite
		{
			return this._loaderLayer;
		}
		
		protected function onEnterFrame(event:Event):void
		{
			if(framesLoaded == totalFrames)
			{
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				removeEventListener(TimerEvent.TIMER,onTime);
				initMain();
			}
		}

		protected function initMain():void
		{
			
			var o:Object=this.stage.loaderInfo;			
			o=o.url.split("/");
//			if(o[0]!="app:")
//			{
				this.nextFrame();
//			}
			o=o[o.length-1].split(".")[0]
//			o=o[o.length-1].replace(".swf","");
			var mainClass:Class = Class(getDefinitionByName(o+""));
			var bootstrape:Object=new mainClass();
			bootstrape.init( this );
		}
		
		public function showProgress( percentage:Number ):void
		{
			if (percentage > 100)
			{
				percentage = 100;
			}
			else if (percentage < 0)
			{
				percentage = 0;
			}			
			try{
			loadingMC.loadingBar.gotoAndStop(int(percentage));
			}catch(o:Object){}
		}
		
		public function showPromptLabel( text:String ):void
		{
			_promptLabel.text = text;
			_promptLabel.x = stage.stageWidth / 2 - _promptLabel.width/2;
		}
		
		public function removePreloader():void
		{
			while(_loaderLayer.numChildren)
			{
				this._loaderLayer.removeChildAt(0);
			}
			
			stage.removeEventListener("removeloader",removeLoader);
			stage.removeEventListener("showLoadingTxt",showLoadingTxt);
			stage.removeEventListener(Event.RESIZE,onResize);
		}		
		
		private function createChildren():void
		{
			this._sceneLayer=new Sprite();
			this._loaderLayer=new Sprite();
			this.addChild(_sceneLayer);
			this.addChild(_loaderLayer);
			
			_preloaderCanvas = new Sprite();
			_loaderLayer.addChild(_preloaderCanvas);
			
			if (loadingBg == null)
			{
				loadingBg = new LoadingBG();
			}
			
			if (loadingMC == null)
			{
				loadingMC = new LoadingMcClass();
			}
			
			if (logo == null)
			{
				logo = new Logo();
			} 	
			
			_promptLabel = new TextField();
			_promptLabel.visible = true;
			_promptLabel.autoSize = TextFieldAutoSize.CENTER;
			_promptLabel.background = false;
			_promptLabel.border = false;
			_promptLabel.embedFonts=false;
			
			var format:TextFormat = new TextFormat();
			format.color = 0xFF0000;
			format.size = 16;
			format.bold = true;
			_promptLabel.defaultTextFormat = format;
			_preloaderCanvas.addChild(Sprite(loadingBg));
			_preloaderCanvas.addChild(Sprite(logo)); 
			_preloaderCanvas.addChild(Sprite(loadingMC));
//			_preloaderCanvas.addChild(_promptLabel);
			onResize(null);
			
/*			if (timer == null)
			{
				timer = new Timer(1000);
				timer.addEventListener(TimerEvent.TIMER, onTimer, false, 0, true);
				timer.start();
				startTime = getTimer();//记录初始下载时间
				oldPerLoaded = 0;
			}*/
		}
		private function onResize(e:Event):void
		{			
			loadingBg.width = stage.stageWidth;
			loadingBg.height = stage.stageHeight;
			logo.x = stage.stageWidth / 2;
			logo.y = stage.stageHeight/2;
			loadingMC.x = stage.stageWidth /2;
			loadingMC.y = stage.stageHeight/2;
			_promptLabel.x = stage.stageWidth / 2 - _promptLabel.width/2;
			_promptLabel.y = loadingMC.y+200;
		}
		private function onTime(t:TimerEvent):void
		{
			showProgress(int(stage.loaderInfo.bytesLoaded/stage.loaderInfo.bytesTotal*100));
		}
		private function onComp(e:Event):void
		{
			LoadingBG=loader.getUI("loadingBg");
			LoadingMcClass=loader.getUI("LoadingMC");
			Logo=loader.getUI("Logo");
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			createChildren();
			showProgress(int(stage.loaderInfo.bytesLoaded/stage.loaderInfo.bytesTotal*100));
			timer=new Timer(1000);
			timer.addEventListener(TimerEvent.TIMER,onTime);
			timer.start();
			stage.addEventListener("removeloader",removeLoader);
			stage.addEventListener("showLoadingTxt",showLoadingTxt);
			stage.addEventListener(Event.RESIZE,onResize);
		}
	}
}