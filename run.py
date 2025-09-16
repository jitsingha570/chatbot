import os
from dotenv import load_dotenv
import subprocess

# Load environment variables
load_dotenv()

# Run rasa
subprocess.run(["rasa", "run", "--enable-api", "--cors", "*"])
