////////////////////////////////////////////////////////////////////////////////
//  Copyright 2010 AOPUI.COM, All rights reserved.
//  Sep 23, 2010
//  @author wushihuan
//	email:wushihuan@163.com
//  @version 0.1
////////////////////////////////////////////////////////////////////////////////
package com.aopui.model
{
	public class Category
	{
		public function Category()
		{
		}
		public var id:String;
		public var name:String;
		public var otherProperty:Object={};
		public var parent:Category
		public var categories:Array=[]; //存放Category
		public var items:Array=[];//存放Object
		public var used:Boolean=true;
		
		public function getItem(id:String):Object
		{
			var item:Object=getItemFormItemArray(id);
			if(item)return item;
			for each(var c:Category in categories)
			{
				item=c.getItemFormItemArray(id);
				if(item)return item;
			}
			return null;
		}
		
		public function getItemFormItemArray(id:String):Object
		{
			for each(var i:Object in items)
			{
				if(i.nameid==id)
					return i;
			}
			return null;
		}
		
		public function addItem(i:Object):void
		{
			this.items.push(i);
		}
		public static function preseXML(xml:Object):Category
		{
			c=new Category();
			return analysisXML(xml);
		}
		
		private static var c:Category;
		private static function analysisXML(xml:Object,parent:Category=null):Category
		{
			var ol:Object=xml.children();
			for each(var o:Object in ol)
			{
				var category:Category=new Category();
					for each(var pn:Object in o.attributes())
					{
						var attName:String=pn.name().localName;
						category.otherProperty[attName]=String(o.attribute(attName));
					}
					if(parent)
						category.parent=parent;
					else
						category.parent=c;
					if(String(o.name())=="category")
					{
						category.id=String(o.@name);
						analysisXML(o,category);
						category.parent.categories.push(category);
					}
					else
					{
						category.id=String(o.@item_id);
						category.parent.items.push(category);
					}
			}			
			return c;
		}
		
		
	}
}