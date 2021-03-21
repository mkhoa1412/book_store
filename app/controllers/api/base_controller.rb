class Api::BaseController < ApplicationController
  include ExceptionHandler
  include Response
  include Pagy::Backend
end
