////////////////////////////////////////////////////////////////////////////////
//  Copyright 2010 AOPUI.COM, All rights reserved.
//  Nov 4, 2010
//  @author wushihuan
//	email:wushihuan@163.com
//  @version 0.1
////////////////////////////////////////////////////////////////////////////////
package client.mainui.view.panel
{
	import com.aopui.ui.Panel;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.binding.utils.BindingUtils;
	
	public class InfoPanel extends Panel
	{
//		[Bindable]
//		public static var model:Object;
		
		public function InfoPanel()
		{
			super();
			var x:XML=<layout width="500" height="40">
						<HBox id="hbox" horizonGap="20" x="5" y="6">
							<Button id="gcoin" text="10000" skinClass="ButtonSkin" icon="GIcon"/>
							<Button id="kcoin" text="100" skinClass="ButtonSkin" icon="KIcon"/>						
							<Field id="exp" label="经验" value="1000"/>
							<Field id="name"/>
						</HBox>
					  </layout>
			this.xml=x;
//			BindingUtils.bindProperty(this,"data",model,"userInfoObj");
		}
		
		private var _data:Object;
		public function set data(d:Object):void
		{if(!d)return;
			setValue("gcoin","text",d.gold);
			setValue("kcoin","text",d.F_coin);
			setValue("exp","value",d.skill_point);
			setValue("exp","label","LV"+d.skill_level);
			if(!d.title)return;
			setValue("name","value",d.title+d.name);
		}
		
		
		public function btnClick(e:Event):void
		{
//			model.testBind+="s";
		}
	}
}