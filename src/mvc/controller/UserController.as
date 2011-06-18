// ActionScript file
package mvc.controller
{
	import flash.events.Event;
	
	import mvc.model.User;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.rpc.events.ResultEvent;
	import mx.states.AddItems;
	
	import org.swizframework.utils.services.ServiceHelper;
	
	import service.UserService;
	
	public class UserController
	{
		[Inject]
		public var userService : UserService;
		
		[Inject]
		public var serviceHelper : ServiceHelper;
		
		[Bindable]
		public var userArray:ArrayCollection = new ArrayCollection();
		
		[Bindable]
		public var currentUser : User;
		
		[PostConstruct]
		/**
		 * [PostConstruct] methods are invoked after all dependencies are injected.
		 * In this example, we set up a default user after the bean is created.
		 */ 
		public function createDefaultUser() : void
		{
			currentUser = new User();
		}
		
		[EventHandler( event="UserEvent.SAVE_USER_REQUESTED", properties="user" )]
		/**
		 * Perform a server request to save the user
		 */ 
		public function saveUser(user:User) : void
		{
			//serviceHelper.executeServiceCall( userService.saveUser( user ), handleSaveUserResult );
			userService.saveUser(user, handleSaveUserResult);
		}
		
		/**
		 * Handle the server call result
		 */ 
		private function handleSaveUserResult( event : ResultEvent ) : void
		{
			// Show an Alert just to make it obvious that the save was successful.
			Alert.show( 'User with \nNickname: ' + currentUser.nickName + '\nFirst Name: ' + currentUser.firstName + ' \nLast Name: ' 
				+ currentUser.lastName + ' ' + '\nentered successfully on \nWhiteboard: ' 
				+ currentUser.selectedBoard + '.');
		}
		
		[EventHandler(event="UserEvent.SAVED_USER", properties="user")]
		public function savedUser(user:User):void
		{
			//FlexGlobals.topLevelApplication.UserForm.txtOutput.text += chat.message;
			userArray.addItem(user);
		}
		
	}
}