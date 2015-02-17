_         = require('lodash')

class FilterStoreHandler
  constructor: ->
    @filters = {
      country_values: countries.values,
      brands:         brands
      from:           '2014-11-01'
      to:             '2014-12-31'
    }

  preLoad: (query_data)->


module.exports = FilterStoreHandler
