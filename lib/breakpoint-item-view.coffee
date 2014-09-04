{View} = require 'atom'
debuggerContext = require './debugger'

module.exports =
class BreakpointItemView extends View
  @content: (breakpoint) ->
    @li class: "breakpoint-item-view", =>
      @div class: "details", =>
        @span class: 'number', "#{breakpoint.number}"
        @span class: 'path', "loading..."
        @span class: 'line', "#{breakpoint.line}"

      @div class: "loading", =>
        @span "loading ..."


  initialize: (breakpoint) ->
    @breakpoint = breakpoint
    @scripts = debuggerContext.scripts

    @addClass('loading')

    handleScriptLoad = (script) =>
      @find('.path').text(script.name)
      @removeClass('loading')

    if breakpoint.type is 'scriptId'
      @scripts
        .getById(breakpoint.scriptId)
        .then handleScriptLoad

    else if breakpoint.type is 'scriptName'
      @scripts
        .getByName(breakpoint.scriptName)
        .then handleScriptLoad
