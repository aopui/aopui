/*
* Copyright 2010 AOPUI.COM, All rights reserved.
* Aug 19, 2010
* WUSHIHUAN
*/
package com.aopui.ui.list
{
	import com.aopui.effect.page.TileListPageEffect;
	
	import flash.display.DisplayObject;

	public class TileListBase extends ListBase
	{
		private var _row:int=3;
		private var _cell:int=4;
		private var byTypes:Array=["row","cell"];
		private var byType:String=byTypes[1];
		private var _tileWidth:Number=100;
		private var _tileHeight:Number=100;
		public function TileListBase()
		{
			super();
//			this.navigation=false;
			this.needMask=false;
			this.listType=listTypes[2];
//			this.pageEffect=new TileListPageEffect();			
		}
		
		public function get tileHeight():Number
		{
			return _tileHeight;
		}

		public function set tileHeight(value:Number):void
		{
			_tileHeight = value;
		}

		public function get tileWidth():Number
		{
			return _tileWidth;
		}

		public function set tileWidth(value:Number):void
		{
			_tileWidth = value;
		}

		public function get row():int
		{
			return _row;			
		}

		public function set row(value:int):void
		{
			_row = value;
			byType=byTypes[0];
//			_cell=0;
		}

		public function get cell():int
		{
			return _cell;
			
		}
		
		override public function createRender():void
		{
			super.createRender();			
		}
		override public function layout():void
		{
			super.layout();
			for(var i:int=0;i<randers.length;i++)
			{
				randers[i].width=this._tileHeight;
				randers[i].height=this._tileWidth;
			}
			this.cellLayout();
			if(pageEffect)this.pageEffect.layout();
		}
		
		
		override public function getPageSize():int
		{
			return this._cell*this._row;
		}

		public function set cell(value:int):void
		{
			_cell = value;
			byType=byTypes[1];
//			_row=0;
		}
		
//		public function tileLayout():void
//		{
//			cellLayout();
//		}
		
		private function cellLayout():void
		{
			this.points=[];
			var usedCell:int=this.cell;
			for(var i:int=0;i<randers.length;i++)
			{
				var rander:DisplayObject=randers[i] as DisplayObject;
				var preWidth:Number=.0;
				var prex:Number=.0;
				var preHeight:Number=.0;
				var prey:Number=.0;
				
				var usedHorizonGap:Number=.0;
				var usedVerticalGap:Number=.0;
				var usedMarginLeft:Number=.0;
				var usedmarginTop:Number=.0;
				if(i>0)
				{
					preWidth=randers[i-1].width;
					prex=randers[i-1].x;
					usedHorizonGap=horizonGap;
				}
				if(i%usedCell==0)
				{
					prex=0;
					preWidth=0;
					usedHorizonGap=0;
					usedMarginLeft=marginLeft;
				}
				if(int(i/usedCell)>0)
				{
					usedVerticalGap=verticalGap;
					prey=randers[(int(i/usedCell)-1)*usedCell].y;
					preHeight=getMaxPreHeight((int(i/usedCell)-1)*usedCell,(int(i/usedCell)-1)*usedCell+usedCell-1);
				}
				else
				{
					usedmarginTop=marginTop;
				}
				rander.x=usedMarginLeft+preWidth+prex+usedHorizonGap;
				rander.y=usedmarginTop+prey+preHeight+usedVerticalGap;
				points.push({x:rander.x,y:rander.y});
			}
		}
		private function getMaxPreHeight(startIndex:int,endIndex:int):Number
		{
			var h:Number=0;
			for(var i:int=startIndex;i<=endIndex;i++)
			{
				var rander:DisplayObject=randers[i] as DisplayObject;
				if(h<rander.height)h=rander.height;
			}
			return h;
		}
		
		private function rowLayout():void
		{
			
		}
		
		override protected function HLayout():void
		{
			for(var i:int=0;i<randers.length;i++)
			{
				var rander:DisplayObject=randers[i] as DisplayObject;
				var preWidth:Number=.0;
				var prex:Number=.0;
				var usedHhorizonGap:Number=.0;
				if(i>0)
				{
					preWidth=randers[i-1].width;
					prex=randers[i-1].x;
					usedHhorizonGap=horizonGap;
				}
				rander.x=marginLeft+preWidth+prex+usedHhorizonGap;
				rander.y=marginTop;
			}
		}
		override protected function VLayout():void
		{
			
		}

		override public function set data(d:Object):void
		{
			super.data=d;
			this.removeAllRenderChild();
			this.createRender();
			this.invalidate();
		}
	}
}