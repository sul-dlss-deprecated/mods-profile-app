require 'mods_profiler_app/solr_helper'

class ModsController < ApplicationController 
  include ModsProfilerApp::SolrHelper
  
  # get lang data from MODS profiler Solr index
  def index
#    @mods_json = File.expand_path('../boot', __FILE__)
#    @mods_json = File.read(File.join(Rails.root, 'test_support/data/mods_elements.json'))
    solr_fname = 'collection'
    solr_response = get_facet solr_fname
    my_resp = Blacklight::SolrResponse.new(solr_response, {})
    @facet_field = my_resp.facets.select {|f| f.name == solr_fname}.first
    @facet_field
  end
  
  # page for collection
  def collection
    # want top level element counts for docs in collection (?)
  end
end