module ApplicationHelper
  def application_name
    "MODS profile experimental app"
  end
  
  # OVERRIDE to display missing facet values as '(absent)'
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

  # OVERRIDE to NOT display if there are ONLY missing values
  # Determine if Blacklight should render the display_facet or not
  #
  # By default, only render facets with items.
  # @param [Blacklight::SolrResponse::Facets::FacetField] display_facet 
  def should_render_facet? display_facet
    # display when show is nil or true
    display = facet_configuration_for_field(display_facet.name).show != false
    return display && display_facet.items.present? && !(display_facet.items.size == 1 && !display_facet.items[0].value)
  end

end
