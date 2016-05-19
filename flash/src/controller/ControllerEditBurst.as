package controller {
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * @author Digi3
	 */
	public class ControllerEditBurst {
		private var mcSelects : Vector.<ControllerBurstSelect>;
		private var mcSendPreview:ControllerPreview;
		
		public function ControllerEditBurst(mcEditor:Sprite, mcSendPreview:Sprite, photobooth:PhotoboothStates, burstCount:int):void{
			this.mcSelects = new Vector.<ControllerBurstSelect>();
			this.mcSendPreview = new ControllerPreview(mcSendPreview['mc_preview_capture']);

			for(var i:int = 0;i<burstCount;i++){
				this.mcSelects[i] = new ControllerBurstSelect(mcEditor['mcSelect'+i], i);
				this.mcSelects[i].addEventListener(ControllerBurstSelect.EVENT_DESELECT, onDeselect);
				this.mcSelects[i].addEventListener(ControllerBurstSelect.EVENT_SELECT  , onSelect);
			}
			
			photobooth.addEventListener(PhotoboothStates.EVENT_EDIT, this.onEdit);
		}

		private function onEdit(e:Event):void{
			//copy shot to mcSelects
			for(var i:int = 0; i<this.mcSelects.length; i++){
				this.mcSelects[i].reset();
				this.mcSelects[i].draw(this.mcSendPreview.getBurst(i));
			}
			this.mcSendPreview.reset();
		}

		private function onSelect(e:Event):void{
			var item:ControllerBurstSelect = e.currentTarget as ControllerBurstSelect;
			this.mcSendPreview.select(item.id);
		}

		private function onDeselect(e:Event):void{
			var item:ControllerBurstSelect = e.currentTarget as ControllerBurstSelect;
			this.mcSendPreview.deselect(item.id);
		}

	}
}
import flash.geom.ColorTransform;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.MouseEvent;
class ControllerBurstSelect extends EventDispatcher{
	private static var instances : Vector.<ControllerBurstSelect> = new Vector.<ControllerBurstSelect>();

	public static var EVENT_SELECT:String   = 'EVENT_SELECT';
	public static var EVENT_DESELECT:String = 'EVENT_DESELECT';

	public var view:Sprite;
	public var id:int;
	public var selected:Boolean = true;
	private var bitmap:Bitmap;
	private var icon:MovieClip;
	private var frame:MovieClip;

	public function ControllerBurstSelect(view:Sprite,id:int){
		ControllerBurstSelect.instances.push(this);
		
		this.view  = view;
		this.icon  = this.view['icon_select'];
		this.frame = this.view['mc_overlay'];
		
		this.frame.addChildAt(
			this.bitmap = new Bitmap(new BitmapData(AppConfig.CAMERA_WIDTH, AppConfig.CAMERA_HEIGHT, false, 0xFF000000)),
		0);
		this.id   = id;
		this.view.addEventListener(MouseEvent.MOUSE_DOWN, this.onClick);
	}
	
	private function onClick(e:MouseEvent):void{
		this.toggle();
	}
	
	public function toggle():void{
		//if not selected, no need to verify
		if(this.selected){
			var selectedCount:int = 0;

			for(var i:int=0; i<ControllerBurstSelect.instances.length; i++){
				var ins:ControllerBurstSelect = ControllerBurstSelect.instances[i];
				if(ins.selected){
					selectedCount++;
				}
			}
			if(selectedCount<=2){
				return;
			}
		}
		
		this.selected = !this.selected;
		
		icon.gotoAndPlay(this.selected ? 
			'select':
			'deselect'
		);
		
		frame.transform.colorTransform = this.selected ? 
			new ColorTransform(1, 1, 1, 1, 0, 0, 0, 0) : 
			new ColorTransform(0.3, 0.3, 0.3, 1, 0, 0, 0, 0);
		
		dispatchEvent(new Event(this.selected ? ControllerBurstSelect.EVENT_SELECT : ControllerBurstSelect.EVENT_DESELECT));
	}
	
	public function reset():void{
		if(!this.selected){
			this.toggle();
		}
	}
	
	public function draw(bd:BitmapData):void{
		this.bitmap.bitmapData.draw(bd);
	}
}

class ControllerPreview{
	private var bmps : Vector.<Bitmap>;
	private var view : Sprite;
	public function ControllerPreview(view:Sprite){
		this.view = view;
		this.bmps = new Vector.<Bitmap>();
		
		for(var i:int=0;i<view.numChildren;i++){
			if(view.getChildAt(i) is Bitmap){
				this.bmps.push(view.getChildAt(i));
			}
		}
	}
	
	public function select(id:int):void{
		this.bmps[id].visible = true;
	}
	
	public function deselect(id:int):void{
		this.bmps[id].visible = false;		
	}
	
	public function reset():void{
		for(var i:int=0;i<this.bmps.length;i++){
			this.bmps[i].visible = true;
		}
	}

	public function getBurst(id:int):BitmapData{
		return this.bmps[id].bitmapData;
	}
}