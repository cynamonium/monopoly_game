GetJson     = require('get_json')
jQuery      = require('jquery')
FilterStore = require('js/flux/stores/monopoly/filter_store')
_           = require('lodash')


class MonopolyFetcher
  @filter_params: ->
    FilterStore.getParams()

  @responder_response: (responder_class, extra_params={})->
    params              = _.merge(extra_params, {responder_class: responder_class})
    params_with_filters = _.merge(this.filter_params(), params )
    url                 = "/frontend/brand_status_view/responder.json?#{jQuery.param(params_with_filters)}"
    GetJson(url)

  @main_kpi_value: (kpi, dimension = null)->
    params = {kpi: kpi}
    params.dimension = dimension if dimension
    @responder_response('MainKpiData', params)




module.exports = MonopolyFetcher
