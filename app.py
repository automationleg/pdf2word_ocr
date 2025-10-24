from flask import Flask, render_template, redirect
import os

app = Flask(__name__, template_folder='.')

@app.route('/')
def home():
    return render_template('/index.html')

@app.route('/n8n')
def n8n():
    n8n_url = os.environ.get('N8N_EDITOR_URL', 'http://127.0.0.1:5678')
    if n8n_url:
        return redirect(n8n_url)
    return "N8N_EDITOR_URL environment variable is not set", 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5500)