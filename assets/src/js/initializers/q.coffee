Q              = require('q')
# Exceptions thrown by done will have long stack traces,
# if Q.longStackSupport is set to true. If Q.onerror is set, exceptions will be delivered there instead of thrown in a future turn.
Q.longStackSupport = true
