/*
* Copyright 2010 AOPUI.COM, All rights reserved.
* 2010-8-26
* WUSHIHUAN
*/
package client.command
{
	import com.aopui.admiral.ItemAdmiral;
	import com.aopui.command.InteractionCommandBase;
	import com.aopui.message.AllPowerfulMessage;
	import com.aopui.model.GlobalModel;
	
	import flash.events.Event;
	import flash.net.URLLoader;

	//TODO:统一的管理Command,为锚点做准备  example get_all-data服务器返回了信息， get_all-complete
	//TODO:统一的管理Command 难点,参数的传递，
	//FIXME: 接口scene.get_all  
	public class InitSceneCommand extends InteractionCommandBase
	{
	
		
		public function InitSceneCommand()
		{
			apiMethod = GlobalModel.firstAPI;
		}
		
		override protected function doResult () :Object
		{
//			globalModel.DNA.data=this.resultData;
//			ItemAdmiral.setData(this.resultData.data.store);
//			globalModel.userInfoObj=resultData.data.user;	
//			globalModel.DNA.userInfo =resultData.data.user;
//			dispather(AllPowerfulMessage.createRequest("user.get_friends"));
			dispather(AllPowerfulMessage.create("BACK_"+GlobalModel.firstAPI,resultData));
			return null;
		}
	}
}