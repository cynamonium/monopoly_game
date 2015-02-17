jQuery    = require('jquery')
SimpleLRU = require('simple-lru')
Q         = require('q')
log       = require('loglevel')


# simple LRU cache to prevent duplicate fetching
cache = new SimpleLRU(100)


realAjax = (url, deferred)->
  jQuery.ajax
    url : url,
    type : 'GET',
    success : (data)->
      # store in cache
      cache.set(url,  data)
      deferred.resolve(data)
    error: (response, status, error)->
      deferred.reject(
        response: response,
        status:   status,
        error:    error )

# @public
# request data with consistent error-handling + client-side caching

## @example
# getJson = require('utils/get_json');
# getJson('/campaign/insights_data').then( function(data){ console.log(data) } )
getJson =  (url)->
  deferred = Q.defer();
  # return from cache
  # this log info makes console unreadable
  if cache.get(url)
    #log.info("getJson|HIT: #{decodeURIComponent(url)}")
    deferred.resolve( cache.get(url) )
  else
    #log.info("getJson|MISS: #{decodeURIComponent(url)}")
    realAjax(url, deferred)

  promise = deferred.promise
  promise.fail( (obj)-> log.debug(obj.response, obj.error, obj.status) )
  return promise


module.exports = getJson
