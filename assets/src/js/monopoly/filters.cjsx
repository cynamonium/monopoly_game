React           = require('react')
jQuery          = require('jquery')
Reflux          = require('reflux')
FilterCountries = require('./filters/countries')
FilterBrands    = require('./filters/brands')
FilterDateRange = require('./filters/dates')
FilterStore     = require('js/flux/stores/brand_status_view/filter_store')


Filters = React.createClass
  displayName: 'Filters'

  mixins: [Reflux.listenTo(FilterStore, "onFilterStoreChange")],

  componentWillMount: ->
    jQuery(window).scroll(this.stickyFilter)

  onFilterStoreChange: ->
    this.forceUpdate()

  stickyFilter: ->
    if jQuery(window).scrollTop()>130
      jQuery(".main-title").addClass("main-title-sticky")
      jQuery(".main-title").next().addClass("add50-sticky")
    else
      jQuery(".main-title").removeClass("main-title-sticky")
      jQuery(".main-title").next().removeClass("add50-sticky")


  country: ->
    _.find(FilterStore.getCountries(), {selected: true})?.name

  brand: ->
    _.find(FilterStore.getBrands(), {selected: true})?.name

  filter_dropdown: ->
    <div className="view-filter main-filter">
      <div className="btn_view-filter">
        <span>Brand: {this.brand()}</span>
        <span>, Country: {this.country()}</span>
      </div>
      <div className="dropdown dropdown_main-filter">
        <FilterCountries />
        <FilterBrands />
      </div>
    </div>

  date_filter: ->
    <FilterDateRange />

  render: ->
    <div className="view-filters">
      {this.filter_dropdown()}
      {this.date_filter()}
    </div>


module.exports = Filters


