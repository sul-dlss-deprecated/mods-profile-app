require 'blacklight/catalog' # for getting facet partials working
require 'mods_profiler_app/solr_helper' # for getting facets

class LangController < ApplicationController 
  include ModsProfilerApp::SolrHelper # for getting facets
  include Blacklight::Configurable # for setting facet fields in Solr response
  include Blacklight::Catalog  # for get_search_results in #index to get facet partials working
  
  # get lang data from MODS profiler Solr index
  def index
    solr_fname = 'language_languageTerm_sim'
    solr_response = get_facet solr_fname
    my_resp = Blacklight::SolrResponse.new(solr_response, {})
    (@response, @document_list) = get_search_results # trying to get facet partials working
    @filters = params[:f] || []  # trying to get facet partials working
    @facet_field = my_resp.facets.select {|f| f.name == solr_fname}.first
  end
  
  configure_blacklight do |config|
    ## Default parameters to send to solr for all search-like requests. See also SolrHelper#solr_search_params
    config.default_solr_params = { 
      :qt => 'search',
      :rows => 20
    }
    # solr fields that will be treated as facets by the blacklight application
    #   The ordering of the field names is the order of the display
    #
    # Setting a limit will trigger Blacklight's 'more' facet values link.
    # * If left unset, then all facet values returned by solr will be displayed.
    # * If set to an integer, then "f.somefield.facet.limit" will be added to
    # solr request, with actual solr request being +1 your configured limit --
    # you configure the number of items you actually want _displayed_ in a page.    
    # * If set to 'true', then no additional parameters will be sent to solr,
    # but any 'sniffed' request limit parameters will be used for paging, with
    # paging at requested limit -1. Can sniff from facet.limit or 
    # f.specific_field.facet.limit solr request params. This 'true' config
    # can be used if you set limits in :default_solr_params, or as defaults
    # on the solr side in the request handler itself. Request handler defaults
    # sniffing requires solr requests to be made with "echoParams=all", for
    # app code to actually have it echo'd back to see it.  
    #
    # :show may be set to false if you don't want the facet to be drawn in the 
    # facet bar
    config.add_facet_field 'collection', :label => 'collection'
    config.add_facet_field 'language_displayLabel_sim', :label => '@displayLabel'
    config.add_facet_field 'language_usage_sim', :label => '@usage', :limit => true
    config.add_facet_field 'language_objectPart_sim', :label => '@objectPart', :limit => true 
    config.add_facet_field 'language_languageTerm_sim', :label => '<languageTerm>', :limit => true
    config.add_facet_field 'language_languageTerm_type_sim', :label => '<languageTerm @type >', :limit => true
    config.add_facet_field 'language_languageTerm_authority_sim', :label => '<languageTerm @authority >', :limit => true
    config.add_facet_field 'language_scriptTerm_sim', :label => '<scriptTerm>', :limit => true

    # Have BL send all facet field names to Solr, which has been the default
    # previously. Simply remove these lines if you'd rather use Solr request
    # handler defaults, or have no facets.
    config.add_facet_fields_to_solr_request!
  end

end