from typing import Any, Text, Dict, List
from rasa_sdk import Action, Tracker
from rasa_sdk.executor import CollectingDispatcher
from twilio.rest import Client
import os

class ActionSendWhatsApp(Action):
    def name(self) -> Text:
        return "action_send_whatsapp"

    def run(self, dispatcher: CollectingDispatcher,
            tracker: Tracker,
            domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:

        # Twilio credentials from environment
        account_sid = os.getenv("TWILIO_ACCOUNT_SID")
        auth_token = os.getenv("TWILIO_AUTH_TOKEN")
        from_whatsapp = os.getenv("TWILIO_PHONE_NUMBER")
        to_whatsapp = tracker.get_slot("user_whatsapp_number")

        if not all([account_sid, auth_token, from_whatsapp, to_whatsapp]):
            dispatcher.utter_message(text="Twilio configuration missing. Please check environment variables.")
            return []

        try:
            client = Client(account_sid, auth_token)
            message = client.messages.create(
                body="Hello from Rasa WhatsApp bot!",
                from_=f'whatsapp:{from_whatsapp}',
                to=f'whatsapp:{to_whatsapp}'
            )
            dispatcher.utter_message(text="Message sent successfully on WhatsApp!")
        except Exception as e:
            dispatcher.utter_message(text=f"Failed to send message: {str(e)}")

        return []

class ActionHelloWorld(Action):
    def name(self) -> Text:
        return "action_hello_world"

    def run(self, dispatcher: CollectingDispatcher,
            tracker: Tracker,
            domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:
        
        dispatcher.utter_message(text="Hello World from Action Server!")
        return []

class ActionShowTime(Action):
    def name(self) -> Text:
        return "action_show_time"

    def run(self, dispatcher: CollectingDispatcher,
            tracker: Tracker,
            domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:
        
        import datetime
        current_time = datetime.datetime.now().strftime("%H:%M:%S")
        dispatcher.utter_message(text=f"Current time is: {current_time}")
        return []