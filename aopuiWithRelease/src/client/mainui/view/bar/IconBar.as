package client.mainui.view.bar
{
	import com.aopui.event.EventBase;
	import com.aopui.event.GroupEvent;
	import com.aopui.ui.Button;
	import com.aopui.ui.ButtonBar;
	import com.aopui.ui.Panel;

	public class IconBar extends Panel
	{

		public function IconBar()
		{
			super();			
			var x:XML=<layout y="-30">
						<ButtonBar id="toolBar" renderClass="Button" eventListener={GroupEvent.GROUP_CLICK+",onBarClick"}>
							<Button skinClass="ButtonSkin" text="编辑"  cmd="edit" toolTip="编辑"/>
							<Button skinClass="ButtonSkin" text="游戏"  cmd="play" toolTip="游戏"/>
						</ButtonBar>
					  </layout>;
			this.xml=x;
		}
		public function onBarClick(e:EventBase):void
		{
			var toolId:String=e.message.target.cmd;
			model.state=toolId;
		}
	}
}