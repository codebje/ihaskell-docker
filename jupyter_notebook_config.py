import os

c.NotebookApp.ip = '*'
c.NotebookApp.password = os.environ.get('password', '')
c.NotebookApp.open_browser = False
c.NotebookApp.notebook_dir = '/books'
