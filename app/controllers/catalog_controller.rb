# -*- encoding : utf-8 -*-
require 'blacklight/catalog'

class CatalogController < ApplicationController  

  include Blacklight::Catalog

  configure_blacklight do |config|
    ## Default parameters to send to solr for all search-like requests. See also SolrHelper#solr_search_params
    config.default_solr_params = { 
      :qt => 'search',
      :rows => 20
    }

    ## Default parameters to send on single-document requests to Solr. These settings are the Blackligt defaults (see SolrHelper#solr_doc_params) or 
    ## parameters included in the Blacklight-jetty document requestHandler.
    #
    #config.default_document_solr_params = {
    #  :qt => 'document',
    #  ## These are hard-coded in the blacklight 'document' requestHandler
    #  # :fl => '*',
    #  # :rows => 1
    #  # :q => '{!raw f=id v=$id}' 
    #}

    # solr field configuration for search results/index views
    config.index.show_link = 'id'
    config.index.record_display_type = 'typeOfResource_sim'

    # solr field configuration for document/show views
    config.show.html_title = 'id'
    config.show.heading = 'id'
    config.show.display_type = 'typeOfResource_sim'

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
    config.add_facet_field 'collection', :label => 'Collection'
    config.add_facet_field 'abstract_sim', :label => '<abstract>', :limit => true
    config.add_facet_field 'accessCondition_sim', :label => '<accessCondition>', :limit => true 
    config.add_facet_field 'classification_sim', :label => '<classification>', :limit => true 
    config.add_facet_field 'extension_sim', :label => '<extension>', :limit => true
    config.add_facet_field 'genre_sim', :label => '<genre>', :limit => true
    config.add_facet_field 'identifier_sim', :label => '<identifier>', :limit => true
    config.add_facet_field 'language_sim', :label => '<language>', :limit => true
    config.add_facet_field 'location_sim', :label => '<location>', :limit => true
    config.add_facet_field 'name_sim', :label => '<name (Top Level)>', :limit => true
    config.add_facet_field 'note_sim', :label => '<note>', :limit => true
    config.add_facet_field 'originInfo_sim', :label => '<originInfo>', :limit => true
    config.add_facet_field 'part_sim', :label => '<part>', :limit => true
    config.add_facet_field 'physicalDescription_sim', :label => '<physicalDescription>', :limit => true
    config.add_facet_field 'recordInfo_sim', :label => '<recordInfo>', :limit => true
    config.add_facet_field 'relatedItem_sim', :label => '<relatedItem>', :limit => true
    config.add_facet_field 'subject_sim', :label => '<subject>', :limit => true
    config.add_facet_field 'tableOfContents_sim', :label => '<tableOfContents>', :limit => true
    config.add_facet_field 'targetAudience_sim', :label => '<targetAudience>', :limit => true
    config.add_facet_field 'titleInfo_sim', :label => '<titleInfo>', :limit => true
    config.add_facet_field 'typeOfResource_sim', :label => '<typeOfResource>', :limit => true
#    config.add_facet_field 'example_pivot_field', :label => 'Pivot Field', :pivot => ['language_sim', 'language_languageTerm_sim']

#    config.add_facet_field 'example_query_facet_field', :label => 'Publish Date', :query => {
#       :years_5 => { :label => 'within 5 Years', :fq => "pub_date:[#{Time.now.year - 5 } TO *]" },
#       :years_10 => { :label => 'within 10 Years', :fq => "pub_date:[#{Time.now.year - 10 } TO *]" },
#       :years_25 => { :label => 'within 25 Years', :fq => "pub_date:[#{Time.now.year - 25 } TO *]" }
#    }


    # Have BL send all facet field names to Solr, which has been the default
    # previously. Simply remove these lines if you'd rather use Solr request
    # handler defaults, or have no facets.
    config.add_facet_fields_to_solr_request!

    # solr fields to be displayed in the index (search results) view
    #   The ordering of the field names is the order of the display 
    config.add_index_field 'titleInfo_sim', :label => '<titleInfo>'
    config.add_index_field 'identifier_sim', :label => '<identifier>'
    config.add_index_field 'typeOfResource_sim', :label => '<typeOfResource>'
    config.add_index_field 'location_sim', :label => '<location>'

    # solr fields to be displayed in the show (single result) view
    #   The ordering of the field names is the order of the display 
    config.add_show_field 'abstract_sim', :label => '<abstract>'
    config.add_show_field 'accessCondition_sim', :label => '<accessCondition>' 
    config.add_show_field 'classification_sim', :label => '<classification>' 
    config.add_show_field 'extension_sim', :label => '<extension>'
    config.add_show_field 'genre_sim', :label => '<genre>'
    config.add_show_field 'identifier_sim', :label => '<identifier>'
    config.add_show_field 'language_sim', :label => '<language>'
    config.add_show_field 'location_sim', :label => '<location>'
    config.add_show_field 'name_sim', :label => '<name (Top Level)>'
    config.add_show_field 'note_sim', :label => '<note>'
    config.add_show_field 'originInfo_sim', :label => '<originInfo>'
    config.add_show_field 'part_sim', :label => '<part>'
    config.add_show_field 'physicalDescription_sim', :label => '<physicalDescription>'
    config.add_show_field 'recordInfo_sim', :label => '<recordInfo>'
    config.add_show_field 'relatedItem_sim', :label => '<relatedItem>'
    config.add_show_field 'subject_sim', :label => '<subject>'
    config.add_show_field 'tableOfContents_sim', :label => '<tableOfContents>'
    config.add_show_field 'targetAudience_sim', :label => '<targetAudience>'
    config.add_show_field 'titleInfo_sim', :label => '<titleInfo>'
    config.add_show_field 'typeOfResource_sim', :label => '<typeOfResource>'

    # "fielded" search configuration. Used by pulldown among other places.
    # For supported keys in hash, see rdoc for Blacklight::SearchFields
    #
    # Search fields will inherit the :qt solr request handler from
    # config[:default_solr_parameters], OR can specify a different one
    # with a :qt key/value. Below examples inherit, except for subject
    # that specifies the same :qt as default for our own internal
    # testing purposes.
    #
    # The :key is what will be used to identify this BL search field internally,
    # as well as in URLs -- so changing it after deployment may break bookmarked
    # urls.  A display label will be automatically calculated from the :key,
    # or can be specified manually to be different. 

    # This one uses all the defaults set by the solr request handler. Which
    # solr request handler? The one set in config[:default_solr_parameters][:qt],
    # since we aren't specifying it otherwise. 
    
    config.add_search_field 'all_text_ti', :label => 'Anywhere'
#    config.add_search_field 'titleInfo_sim', :label => 'Title'
    

    # Now we see how to over-ride Solr request handler defaults, in this
    # case for a BL "search field", which is really a dismax aggregate
    # of Solr search fields. 
=begin    
    config.add_search_field('title') do |field|
      # solr_parameters hash are sent to Solr as ordinary url query params. 
      field.solr_parameters = { :'spellcheck.dictionary' => 'title' }

      # :solr_local_parameters will be sent using Solr LocalParams
      # syntax, as eg {! qf=$title_qf }. This is neccesary to use
      # Solr parameter de-referencing like $title_qf.
      # See: http://wiki.apache.org/solr/LocalParams
      field.solr_local_parameters = { 
        :qf => '$title_qf',
        :pf => '$title_pf'
      }
    end
=end    
    # "sort results by" select (pulldown)
    # label in pulldown is followed by the name of the SOLR field to sort by and
    # whether the sort is ascending or descending (it must be asc or desc
    # except in the relevancy case).
    config.add_sort_field 'timestamp desc', :label => 'timestamp (new to old)'
    config.add_sort_field 'timestamp asc', :label => 'timestamp (old to new)'
    config.add_sort_field 'id asc', :label => 'identifier'
    config.add_sort_field 'score desc, id asc', :label => 'relevance'
  end

end 
