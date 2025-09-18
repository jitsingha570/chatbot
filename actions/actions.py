# This files contains your custom actions which can be used to run
# custom Python code.
#
# See this guide on how to implement these action:
# https://rasa.com/docs/rasa/custom-actions


# This is a simple example for a custom action which utters "Hello World!"

# from typing import Any, Text, Dict, List
#
# from rasa_sdk import Action, Tracker
# from rasa_sdk.executor import CollectingDispatcher
#
#
# class ActionHelloWorld(Action):
#
#     def name(self) -> Text:
#         return "action_hello_world"
#
#     def run(self, dispatcher: CollectingDispatcher,
#             tracker: Tracker,
#             domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:
#
#         dispatcher.utter_message(text="Hello World!")
#
#         return []
from rasa_sdk import Action, Tracker
from rasa_sdk.executor import CollectingDispatcher
from twilio.rest import Client
import os

class ActionSendWhatsApp(Action):
    def name(self):
        return "action_send_whatsapp"

    def run(self, dispatcher: CollectingDispatcher,
            tracker: Tracker,
            domain: dict):

        # Twilio credentials from environment
        account_sid = os.getenv("TWILIO_ACCOUNT_SID")
        auth_token = os.getenv("TWILIO_AUTH_TOKEN")
        from_whatsapp = os.getenv("TWILIO_PHONE_NUMBER")
        to_whatsapp = tracker.get_slot("user_whatsapp_number")  # you can store user's number in slot

        client = Client(account_sid, auth_token)
        message = client.messages.create(
            body="Hello from Rasa WhatsApp bot!",
            from_=f'whatsapp:{from_whatsapp}',
            to=f'whatsapp:{to_whatsapp}'
        )

        dispatcher.utter_message(text="Message sent on WhatsApp!")
        return []
