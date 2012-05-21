package client.mainui
{
//	import client.mainui.event.ToolChangeEvent;
//	import client.mainui.model.BuddyListModel;
//	import client.mainui.model.ToolBarModel;
//	import client.mainui.view.bar.ToolBar;
//	import client.mainui.view.list.BuddyList;
//	import client.mainui.view.otherPanel.OtherPanel;
	import client.mainui.view.panel.BottomPanel;
	import client.model.Model;
	
	import com.aopui.Marshal;
	import com.aopui.admiral.ItemAdmiral;
	import com.aopui.admiral.ResourceAdmiral;
	import com.aopui.event.EventBase;
	import com.aopui.event.GroupEvent;
	import com.aopui.message.AllPowerfulMessage;
	import com.aopui.model.Category;
	import com.aopui.model.GlobalModel;
	import com.aopui.ui.BasicUI;
	import com.aopui.ui.Panel;
	import com.aopui.ui.VBox;
	import com.greensock.TweenMax;
	
	import flash.events.Event;
	
	import mx.binding.utils.BindingUtils;
	
//	import org.spicefactory.parsley.processor.messaging.receiver.DefaultCommandObserver;
//	import org.spicefactory.parsley.processor.messaging.receiver.MessageProcesser;


	
	public class BasicMainUIMediator
	{
		[MessageDispatcher]
		public var dispatcher:Function;
		
		
		//只需要一个model就行了不要加这多model
		[Inject]
		public var model:Model;
		
		[Inject]
		public var marshal:Marshal;

		protected var _bottomPanel:BottomPanel;
		public function BasicMainUIMediator()
		{
		}

		public function init():void
		{  	
//			MessageProcesser.dispatcher=dispatcher;
//			DefaultCommandObserver.dispacher=dispatcher;
			marshal.sceneLayer.stage.dispatchEvent(new Event("removeloader"));			
//			if(GlobalModel.non_server)
//				dispatcher(AllPowerfulMessage.create("end_user.get_friends"));
		}
		
		public function onStateChanged(state:String):void
		{
			
		}
		
		public function set state(o:Object):void
		{
//			if(model.state=="edit")
//			{
//				_bottomPanel.height=150;
//				
//			}
//			else
//			{
//				_bottomPanel.height=110;
//			}
			if(_bottomPanel)
			{
				_bottomPanel.layout();
				TweenMax.from(_bottomPanel,1,{y:_bottomPanel.stage.stageHeight});
			}
		}
		
		protected function getNormativeItemData(unnormativeData:Object):Array
		{
			var dataTemplete:Object=ItemAdmiral.categories;
			var categories:Array=[];
			var categorie:Category;
			
			for each(var c:Category in dataTemplete)
			{
				var oneItems:Object=unnormativeData[c.id];
				if(oneItems)
				{
					categorie=new Category();
					categorie.id=c.id;
					for(var itemName:String in oneItems)
					{
						var item:Object=c.getItem(itemName);
						if(item&&int(oneItems[itemName].num)>0)
						{
							item["num"]=oneItems[itemName].num;
							categorie.addItem(item);
						}
					}					
					categories.push(categorie);
				}
			}
			return categories;
		}		
		
//		protected function toolChangeHandler(event:ToolChangeEvent):void
//		{
//			model.DNA["cmd"]=event.toolId;
//			toolBarModel.setCurrentToolName(event.toolId);
//			if(event.toolId=="pack")
//			{
//				dispatcher(AllPowerfulMessage.create("open_pack"));
//			}
//			if(event.toolId=="shop")
//			{
//				dispatcher(AllPowerfulMessage.create("open_shop"));
//			}
//			dispatcher(AllPowerfulMessage.create("clicked_"+event.toolId));
//		}
		
		
//		[MessageHandler(selector="BACK_user.get_friends")]
//		public function onBuddyListUpdated(msg:AllPowerfulMessage):void
//		{			
//			var buddyInfos:Array = buddyListModel.buddyInfos;			
//			var resultData:Object=msg.param;
//			buddyInfos.splice(0,buddyInfos.length);//清空数组			
//			for each (var fobj:Object in resultData.data)
//			{                   
//				if (fobj.name == "" || fobj.name == null)
//				{
//					fobj.name = fobj.uid; 
//				}
//			 
//				buddyInfos.push( fobj );
//			}			
//			_buddyListView.data = buddyListModel.buddyInfos;
//			
//		}
		
//		private function buddyListClickHandler(event:EventBase):void
//		{
//			dispatcher(AllPowerfulMessage.create(AllPowerfulMessage.VISIT_FRIEND,event.message.data));
//		}
		
//		[MessageHandler(selector="end_user.get_friends")]
//		public function endInitScene(msg:AllPowerfulMessage):void
//		{
//			if(GlobalModel.non_server)
//				_buddyListView.data=[{},{},{},{},{}];
//			marshal.sceneLayer.stage.dispatchEvent(new Event("removeloader"));
//		}
	}
}