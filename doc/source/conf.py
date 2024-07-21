project     = 'sphinx_mindmap'
copyright   = '2024, MP'
author      = 'MP'
version     = '0.5'
release     = '0.5.0'

extensions = [
    'sphinx_mindmap',
    'sphinx.ext.githubpages',
    'myst_parser'
]

html_static_path = ['_static']
templates_path   = ['_templates']
exclude_patterns = []

language = 'en'

html_theme      = 'sphinx_book_theme'
html_css_files  = ['css/custom.css']

html_theme_options = {
    "path_to_docs": "doc/source",
    "repository_url": "https://github.com/mi-parkes/sphinx_mindmap",
    "repository_branch": "Init",
    "show_navbar_depth": 2,
    "show_toc_level": 1,  
    "use_repository_button": True,
    "use_source_button": True,
    "home_page_in_toc" : True,
    "use_issues_button": True,
    "use_edit_page_button": True, 
}
