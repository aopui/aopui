/*
* Copyright 2010 AOPUI.COM, All rights reserved.
* Aug 19, 2010
* WUSHIHUAN
*/
package com.aopui.effect.page
{
	import com.aopui.admiral.ResourceAdmiral;
	import com.aopui.ui.BasicUI;
	import com.aopui.ui.Button;
	import com.aopui.ui.ContainBase;
	import com.aopui.ui.Panel;
	import com.aopui.ui.VBox;
	import com.aopui.ui.list.ListBase;
	import com.greensock.TweenLite;
	import com.greensock.easing.Bounce;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	public class ListPageEffect extends Panel implements  IPageEffect
	{	
		private var _contain:ContainBase;
		public function ListPageEffect()
		{
			var x:XML=<layout>
							<VBox id="box1" verticalGap="2"  width="25">
								<Button id="preBtn" width="25.5" height="25" skinClass="previousBtn"/>
								<Button id="prePageBtn" skinClass="previousppageBtn"/>
								<Button id="firstBtn" skinClass="leftAllBtn"/>
							</VBox>
							
							<VBox id="box2" x="100" verticalGap="2" width="25">
								<Button id="nextBtn" skinClass="nextBtn"/>
								<Button id="nextPageBtn" skinClass="nextpageBtn"/>
								<Button id="lastBtn" skinClass="rightAllBtn"/>
							</VBox>
					  </layout>
				this.xml=x;
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
			this._contain=c;
		}
		
		public function addPageBtns():void
		{
			
		}
		
		override public function layout():void
		{
			this.width=_contain.width;
			this.y=_contain.navigationPreHeight;
			$.box1.x=_contain.navigationPreWidth;
			$.box2.x=_contain.width-_contain.navigationPreWidth-$.box2.width-$.box2.getBounds($.box2).left;
		}
		
		public function addNavigation():void
		{
			_contain.defaultAddChild(this);		
			if(!$.preBtn.hasEventListener(MouseEvent.CLICK))
				$.preBtn.addEventListener(MouseEvent.CLICK,pre1);
			if(!$.firstBtn.hasEventListener(MouseEvent.CLICK))
				$.firstBtn.addEventListener(MouseEvent.CLICK,first);
			if(!$.nextBtn.hasEventListener(MouseEvent.CLICK))
				$.nextBtn.addEventListener(MouseEvent.CLICK,next1);
			if(!$.lastBtn.hasEventListener(MouseEvent.CLICK))
				$.lastBtn.addEventListener(MouseEvent.CLICK,last);
		}
		
		public function remNavigation():void
		{
			if(_contain.defaultContains(this))
				_contain.defaultRemoveChild(this);
		}
		
		
		private function pre1(e:Event):void
		{
			if(_contain.contentSpace.x>=0)return;
			//			this.contentSpace.x+=itemWidth;
			TweenLite.to(_contain.contentSpace, .5, {x:_contain.contentSpace.x+_contain.itemWidth, y:_contain.contentSpace.y, ease:Bounce.easeOut});
		}
		
		private function next1(e:Event):void
		{ 
			if(-_contain.contentSpace.x>=_contain.contentSpace.width-_contain.itemWidth*9)return;
			
			//			this.contentSpace.x-itemWidth; 
			TweenLite.to(_contain.contentSpace, .5, {x:_contain.contentSpace.x-_contain.itemWidth, y:_contain.contentSpace.y, ease:Bounce.easeOut});
		}
		
		private function first(e:Event):void
		{
			//			contentSpace.x=0;
			TweenLite.to(_contain.contentSpace, 1, {x:0, y:_contain.contentSpace.y, ease:Bounce.easeOut});
		}
		
		private function last(e:Event):void
		{
			//			contentSpace.x=-(contentSpace.width-itemWidth*9);
			
			TweenLite.to(_contain.contentSpace, 1, {x:-(_contain.contentSpace.width-_contain.itemWidth*9), y:_contain.contentSpace.y, ease:Bounce.easeOut});
		}
		
	}
}