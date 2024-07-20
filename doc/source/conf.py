project     = 'sphinx_mindmap'
copyright   = '2024, MP'
author      = 'MP'
version     = '0.5'
release     = '0.5.0'

extensions = [
    'sphinx_mindmap',
    'sphinx.ext.githubpages',
]

html_static_path = ['_static']
templates_path   = ['_templates']
exclude_patterns = []

language = 'en'

#html_theme = 'alabaster'
html_theme      = 'sphinx_book_theme'
html_css_files  = ['css/custom.css']
