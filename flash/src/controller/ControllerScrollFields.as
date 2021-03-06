﻿package controller {
	import com.digi3studio.Scroller;
	import com.digi3studio.photobooth.form.FieldGroup;
	import com.fastframework.module.d3animate.Animator;
	import com.fastframework.module.d3view.ButtonClip;
	import com.fastframework.module.d3view.IView;
	import com.fastframework.module.d3view.ShowHideView;
	import com.fastframework.module.d3view.events.ButtonClipEvent;

	import flash.display.Sprite;
	import flash.events.Event;


	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class ControllerScrollFields {
		private var fieldGroup:FieldGroup;

//		private var mtForm:MotionTween;
		
		private var mcFormFields:Sprite;
		private var viewPrev:IView;
		private var viewNext:IView;
		
		private var btnPrev:ButtonClip;
		private var btnNext:ButtonClip;
		
		private var scroll:Scroller;

		private var anForm:Animator;

		public function ControllerScrollFields(mcForm : Sprite, fieldGroup:FieldGroup, fieldDisplayCount:int,fieldHeight:Number) {
			btnPrev = new ButtonClip(mcForm['btn_prev']).when(ButtonClipEvent.CLICK,clickPrev);
			btnNext = new ButtonClip(mcForm['btn_next']).when(ButtonClipEvent.CLICK,clickNext);
			
			viewPrev = new ShowHideView(mcForm['btn_prev']);
			viewNext = new ShowHideView(mcForm['btn_next']);

			mcFormFields = mcForm['form_fields'];

			this.fieldGroup = fieldGroup;
			this.scroll = new Scroller(fieldDisplayCount, fieldHeight, mcFormFields.y);
			this.scroll.when(Scroller.EVENT_REACH_FIRST, onScrollToFirst);
			this.scroll.when(Scroller.EVENT_REACH_LAST, onScrollToLast);
			this.scroll.when(Scroller.EVENT_SCROLL,	onScroll);

			anForm = new Animator(mcFormFields, 'y',300);

			fieldGroup.when(FieldGroup.EVENT_ADD_ITEM, onItemCountChange);
			fieldGroup.when(FieldGroup.EVENT_REMOVE_ITEM, onItemCountChange);
		}

		private function clickPrev(e:Event):void{
			scroll.scrollTo(scroll.getScroll()-1);
		}
		
		private function clickNext(e:Event):void{
			scroll.scrollTo(scroll.getScroll()+1);
		}

		private function onScroll(e:Event):void{
			viewPrev.show();
			viewNext.show();
			anForm.to(scroll.currScrollPos());
		}

		private function onScrollToFirst(e:Event) : void {
			viewPrev.hide();
		}

		private function onScrollToLast(e:Event):void{
			viewNext.hide();
		}

		private function onItemCountChange(e:Event) : void {
			scroll.setLineCount(fieldGroup.getCount());
		}
	}
}
