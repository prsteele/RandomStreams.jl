import juliadoc

extensions = ['juliadoc.julia', 'juliadoc.jlhelp']
html_theme_path = [juliadoc.get_theme_dir()]
html_sidebars = juliadoc.default_sidebars()

source_suffix = '.rst'

master_doc = 'index'

project = u'RandomStreams'
AUTHORS = u'James Dong, Stephen Pallone, Patrick Steele'
copyright = u'2015, ' + AUTHORS

primary_domain = 'jl'
highlight_language = 'julia'
html_theme = 'julia'
