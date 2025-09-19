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

        # Get Twilio credentials from environment
        account_sid = os.getenv("TWILIO_ACCOUNT_SID")
        auth_token = os.getenv("TWILIO_AUTH_TOKEN")
        from_whatsapp = os.getenv("TWILIO_PHONE_NUMBER")
        
        # Get user number from slot
        to_whatsapp = tracker.get_slot("phone_number")

        if not all([account_sid, auth_token, from_whatsapp, to_whatsapp]):
            dispatcher.utter_message(text="Twilio configuration missing.")
            return []

        try:
            client = Client(account_sid, auth_token)
            message = client.messages.create(
                body="Hello from Rasa WhatsApp bot!",
                from_=f'whatsapp:{from_whatsapp}',
                to=f'whatsapp:{to_whatsapp}'
            )
            dispatcher.utter_message(text="WhatsApp message sent successfully!")
        except Exception as e:
            dispatcher.utter_message(text=f"Failed to send message: {str(e)}")

        return []