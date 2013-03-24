require 'mods_profiler_app/solr_helper'

class LangController < ApplicationController 
  include ModsProfilerApp::SolrHelper
  
  # get lang data from MODS profiler Solr index
  def index
    solr_response = get_language_terms    
    my_resp = Blacklight::SolrResponse.new(solr_response, {})
    solr_fname = 'language_languageTerm_sim'
    @facet_field = my_resp.facets.select {|f| f.name == solr_fname}.first
p @facet_field   
    @facet_field
  end
end