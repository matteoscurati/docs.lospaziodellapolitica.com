require 'uglifier'

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

###
# Dato configuration
###

activate :dato,
  domain: 'admin-docs.lospaziodellapolitica.com',
  token: '518d104e9d46d8536d8a124898efa5a38115baba501b4ba058',
  base_url: 'https://docs.lospaziodellapolitica.com'

all_articles = dato.articles.sort_by(&:position)

proxy "/index.html", "/templates/index.html", locals: { articles: all_articles }

dato.articles.each do |article|
  proxy "/articles/#{article.slug}.html", "/templates/detail.html", locals: { article: article }
end

# Localization
# activate :i18n

# Slim
Slim::Engine.set_options format: :html
Slim::Engine.set_options pretty: false

# Assets
set :css_dir, 'dist/stylesheets'
set :js_dir, 'dist/javascripts'
set :images_dir, 'dist/images'

# External pipeline
activate :external_pipeline,
  name: :gulp,
  command: build? ? 'gulp build --production' : './node_modules/gulp/bin/gulp.js',
  source: "dist",
  latency: 1

set :url_root, 'https://docs.lospaziodellapolitica.com'

# Build-specific configuration
configure :build do
  ignore 'assets/*'
  activate :gzip
  activate :minify_html, remove_intertag_spaces: true
  activate :asset_hash
  activate :relative_assets
end

#helpers
helpers do
  def markdown(text)
    Tilt['markdown'].new { text }.render(scope=self)
  end
end
