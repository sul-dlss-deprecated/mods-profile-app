require 'mods_profiler_app/solr_helper'

class LangController < ApplicationController 
  include ModsProfilerApp::SolrHelper
  
  # get lang data from MODS profiler Solr index
  def index
    solr_fname = 'language_languageTerm_sim'
    solr_response = get_facet solr_fname
    my_resp = Blacklight::SolrResponse.new(solr_response, {})
    @facet_field = my_resp.facets.select {|f| f.name == solr_fname}.first
    @facet_field
  end
end