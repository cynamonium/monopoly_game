React        = require('react')

class App
  @boot: ()->
    that = this
    require.ensure([], ->
      that.mount(require('src/js/monopoly/page'))
    )

  @mount: (component)->
    mountNode = document.getElementById('react-container')
    React.render(React.createElement(component, null), mountNode)


# make it global
window.App     = App if window
module.exports = App
