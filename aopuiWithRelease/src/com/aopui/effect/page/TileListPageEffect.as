/*
* Copyright 2010 AOPUI.COM, All rights reserved.
* Aug 19, 2010
* WUSHIHUAN
*/
package com.aopui.effect.page
{
	import com.aopui.admiral.ResourceAdmiral;
	import com.aopui.ui.ContainBase;
	import com.aopui.ui.list.ListBase;
	import com.greensock.TweenLite;
	import com.greensock.easing.Bounce;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class TileListPageEffect implements IPageEffect
	{	
		private var _contain:ListBase;
		
		public var preBtn:Sprite;//=new FriendPrevBtnUpSkin();
		public var prePageBtn:Sprite;//=new FriendPrevPageBtnUpSkin();
		public var firstBtn:Sprite;//=new FriendFirstBtnUpSkin();
		public var nextBtn:Sprite;//=new FriendNextBtnUpSkin();
		public var nextPageBtn:Sprite;//=new FriendNextPageBtnUpSkin();
		public var lastBtn:Sprite;//=new FriendLastBtnUpSkin();
		
		public function TileListPageEffect()
		{
			var cls:Class=getUI("PrevBtn");
			preBtn= new cls();
			cls=getUI("PrevPageBtn");
			prePageBtn= new cls();
			cls=getUI("FirstBtn");
			firstBtn= new cls();
			cls=getUI("NextBtn");
			nextBtn=new cls();
			cls=getUI("NextPageBtn");
			nextPageBtn=new cls();
			cls=getUI("LastBtn");
			lastBtn=new cls();
		}
		
		public function getVerticalScrollBarH():Number
		{
			return 0;
		}
		public function getVerticalScrollBarW():Number
		{
			return 0;
		}
		public function getHorizonScrollBarW():Number
		{
			return 0;
		}
		public function getHorizonScrollBarH():Number
		{
			return 0;
		}
		
		public function get contain():ContainBase
		{
			return _contain;
		}
		
		public function set contain(c:ContainBase):void
		{
			this._contain=c as ListBase;
		}
		
		
		public function layout():void
		{
			preBtn.x=_contain.navigationPreWidth;
			preBtn.y=_contain.navigationPreHeight;
			
			prePageBtn.x=_contain.navigationPreWidth+preBtn.width+_contain.navigationHGap;
			prePageBtn.y=_contain.navigationPreHeight;
			
			firstBtn.x=prePageBtn.x+prePageBtn.width+_contain.navigationHGap;
			firstBtn.y=_contain.navigationPreHeight;
			
			nextBtn.x=_contain.width-_contain.navigationPreWidth-nextBtn.width
			nextBtn.y=_contain.navigationPreHeight;
			
			nextPageBtn.x=nextBtn.x-nextPageBtn.width-_contain.navigationHGap;
			nextPageBtn.y=_contain.navigationPreHeight;
			
			lastBtn.x=nextPageBtn.x-lastBtn.width-_contain.navigationHGap;
			lastBtn.y=_contain.navigationPreHeight;
		}
		
		public function addNavigation():void
		{
			if(!_contain.defaultContains(preBtn))_contain.defaultAddChild(preBtn);
			if(!_contain.defaultContains(prePageBtn))_contain.defaultAddChild(prePageBtn);
			if(!_contain.defaultContains(firstBtn))_contain.defaultAddChild(firstBtn);			
			if(!_contain.defaultContains(nextBtn))_contain.defaultAddChild(nextBtn);
			if(!_contain.defaultContains(nextPageBtn))_contain.defaultAddChild(nextPageBtn);
			if(!_contain.defaultContains(lastBtn))_contain.defaultAddChild(lastBtn);			
			if(!preBtn.hasEventListener(MouseEvent.CLICK))preBtn.addEventListener(MouseEvent.CLICK,pre1);
			if(!firstBtn.hasEventListener(MouseEvent.CLICK))firstBtn.addEventListener(MouseEvent.CLICK,first);
			if(!nextBtn.hasEventListener(MouseEvent.CLICK))nextBtn.addEventListener(MouseEvent.CLICK,next1);
			if(!lastBtn.hasEventListener(MouseEvent.CLICK))lastBtn.addEventListener(MouseEvent.CLICK,last);
		}
		
		public function remNavigation():void
		{
			if(_contain.defaultContains(preBtn))_contain.defaultRemoveChild(preBtn);
			if(_contain.defaultContains(prePageBtn))_contain.defaultRemoveChild(prePageBtn);
			if(_contain.defaultContains(firstBtn))_contain.defaultRemoveChild(firstBtn);			
			if(_contain.defaultContains(nextBtn))_contain.defaultRemoveChild(nextBtn);
			if(_contain.defaultContains(nextPageBtn))_contain.defaultRemoveChild(nextPageBtn);
			if(_contain.defaultContains(lastBtn))_contain.defaultRemoveChild(lastBtn);
			
			if(preBtn.hasEventListener(MouseEvent.CLICK))preBtn.removeEventListener(MouseEvent.CLICK,pre1);
			if(firstBtn.hasEventListener(MouseEvent.CLICK))firstBtn.removeEventListener(MouseEvent.CLICK,first);
			if(nextBtn.hasEventListener(MouseEvent.CLICK))nextBtn.removeEventListener(MouseEvent.CLICK,next1);
			if(lastBtn.hasEventListener(MouseEvent.CLICK))lastBtn.removeEventListener(MouseEvent.CLICK,last);
		}
		
		private function setPage(p:int):void
		{
			_contain.pageIndex=p;
			_contain.containRemoveAllChild();
			_contain.randers=[];
			_contain.createRender();
			Object(_contain).TileLayout();
//			_contain.dataingRander();
		}
		
		private function pre1(e:Event):void
		{
			if(_contain.pageIndex>0)
			{
				setPage(_contain.pageIndex-1);
			}
		}
		
		
		
		private function next1(e:Event):void
		{ 
			if(_contain.pageIndex<_contain.getPages()-1)
			{
				setPage(_contain.pageIndex+1);
			}
		}
		
		private function first(e:Event):void
		{
			setPage(0);
		}
		
		private function last(e:Event):void
		{
			setPage(_contain.getPages()-1);
		}
		
		private function getUI(name:String):Class
		{
			return ResourceAdmiral.getUI(name) as Class;
		}
		
	}
}