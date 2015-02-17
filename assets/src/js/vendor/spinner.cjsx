# wrapper for http://fgnass.github.io/spin.js/

Spinner = require('spin.js')
React   = require('react')
ReactSpinner = React.createClass
  displayName: 'ReactSpinner'


  getDefaultProps: ->
    lines: 12,            # The number of lines to draw
    length: 7,            # The length of each line
    width: 5,             # The line thickness
    radius: 10,           # The radius of the inner circle
    rotate: 0,            # Rotation offset
    corners: 1,           # Roundness (0..1)
    color: '#000',        # #rgb or #rrggbb
    direction: 1,         # 1: clockwise, -1: counterclockwise
    speed: 1,             # Rounds per second
    trail: 100,           # Afterglow percentage
    opacity: 1/4,         # Opacity of the lines
    fps: 20,              # Frames per second when using setTimeout()
    zIndex: 2e9,          # Use a high z-index by default
    className: 'spinner', # CSS class to assign to the element
    top: '50%',           # center vertically
    left: '50%',          # center horizontally
    position: 'absolute'  # element position

  componentDidMount: ->
    target       = this.getDOMNode();
    this.spinner = new Spinner(this.props).spin(target);

  render: ->
    <div></div>

  componentWillUnmount: ->
    this.spinner.stop() if this.spinner

module.exports = ReactSpinner
