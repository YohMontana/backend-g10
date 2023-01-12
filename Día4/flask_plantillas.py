from flask import Flask
from os import environ
from dotenv import load_dotenv
load_dotenv()


app = Flask(__name__)

@app.route("/")
def inicio ():
  return """
    <p>
    Hola desde el backend
    </p>
    <h1>
      Hola
    </h1>
  """



app.run(debug=True)