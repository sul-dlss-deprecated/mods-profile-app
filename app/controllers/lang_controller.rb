require 'mods_profiler_app/solr_helper'

class LangController < ApplicationController 
  include ModsProfilerApp::SolrHelper
  
  # get lang data from MODS profiler Solr index
  def index
    @response = get_language_terms
#p @response.facets
    @response
  end
end