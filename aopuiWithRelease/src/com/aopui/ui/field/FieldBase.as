////////////////////////////////////////////////////////////////////////////////
//  Copyright 2010 AOPUI.COM, All rights reserved.
//  Sep 26, 2010
//  @author wushihuan
//	email:wushihuan@163.com
//  @version 0.1
////////////////////////////////////////////////////////////////////////////////
package com.aopui.ui.field
{
	import com.aopui.ui.HBox;
	import com.aopui.ui.Label;
	
	public class FieldBase extends HBox
	{
		private var _nameLabel:Label=new Label();
		private var _valueLabel:Label=new Label();
		private var _label:String;
		private var _value:String;
		public function FieldBase()
		{
			super();
			this.data=[_nameLabel,_valueLabel];
		}
		
		public function get label():String
		{
			return _label;
		}

		public function set label(value:String):void
		{
			if(value==_label)return;
			_label = value;
			_nameLabel.text=value;
			this.invalidate();
		}

		public function get value():String
		{
			return _value;
		}

		public function set value(value:String):void
		{
			if(value==_value)return;
			_value = value;
			_valueLabel.text=value;
			this.invalidate();
		}

	}
}