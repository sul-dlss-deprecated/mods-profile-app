# NAOMI_MUST_COMMENT_THIS_MODULE
module ModsProfilerApp::SolrHelper
  
   # NAOMI_MUST_COMMENT_THIS_METHOD
  def get_language_terms
    path = blacklight_config.solr_path
    # want to pass in fq=collection:blah argument
    params = {:rows => 0, 'facet.limit'.to_sym => -1, 'facet.field'.to_sym => 'language_languageTerm_sim'} 
    response = blacklight_solr.get(path, :params=> params)
    response
  rescue Errno::ECONNREFUSED => e
    raise Blacklight::Exceptions::ECONNREFUSED.new("Unable to connect to Solr instance using #{blacklight_solr.inspect}")    
  end
  
  def blacklight_solr
    Blacklight.solr
  end
  
end