module ApplicationHelper
  def application_name
    "MODS profile experimental app"
  end
  
  # override
  # Standard display of a facet value in a list. Used in both _facets sidebar
  # partial and catalog/facet expanded list. Will output facet value name as
  # a link to add that to your restrictions, with count in parens. 
  # first arg item is a facet value item from rsolr-ext.
  # options consist of:
  # :suppress_link => true # do not make it a link, used for an already selected value for instance
  def render_facet_value(facet_solr_field, item, options ={})    
    (link_to_unless(options[:suppress_link], 
                    item.value ? item.label : '(absent)',
                    add_facet_params_and_redirect(facet_solr_field, item), 
                    :class=>"facet_select") +
    " " + render_facet_count(item.hits)).html_safe
  end

  
end
