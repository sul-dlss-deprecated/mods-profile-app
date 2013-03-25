#require 'mods_profiler_app/solr_helper'

class ModsController < ApplicationController 
#  include ModsProfilerApp::SolrHelper
  
  # get lang data from MODS profiler Solr index
  def index
#    @mods_json = File.expand_path('../boot', __FILE__)
    @mods_json = File.read(File.join(Rails.root, 'test_support/data/mods_elements.json'))
  end
end