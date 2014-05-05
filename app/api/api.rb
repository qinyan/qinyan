# require 'grape-swagger'
require 'helpers'
require 'formatters'

class API < Grape::API
  format :json
  # prefix "api"
  # version 'v1', using: :param, parameter: "v"
  prefix 'api'
  version 'v1', using: :path

  @@logger = Logger.new('log/api.log') 
  helpers APIHelpers
  before do 
    @_api_begin_at = Time.now
    @@logger.info "#{Time.now.strftime('%Y%m%d%H%M%S')} begin [#{request.request_method}] #{request.path} - #{params}"
    normalize_encode_params
  end

  after do 
    @@logger.info "#{Time.now.strftime('%Y%m%d%H%M%S')} end(code:#{status}) [#{request.request_method}] #{'%0.4f' % ((Time.now - @_api_begin_at)*1000)}ms #{request.path}"
  end

  # Format相关
  content_type :json, "application/json;charset=utf-8"
  formatter :json, PageFormatter
  default_format :json

  resource :products do

    desc "get all products"
    get '/' do
      products = Product.paginate(page: params[:page]|| 1, per_page: 1)
      will_present :products, products
    end

    desc "post user_id"
    params do
      requires :product_id, :type => String, :desc => "product id"
    end
    post '/:product_id' do
      product = Product.find(params[:product_id])
      present product
    end

  end
  # add_swagger_documentation mount_path: "/api_doc", # base_path: 'http://localhost:8080',
  # api_version: "v1", 
  # hide_documentation_path: true
  add_swagger_documentation mount_path: "/api_doc", # base_path: 'http://localhost:8080',
  api_version: "v1", 
  hide_documentation_path: true

end
