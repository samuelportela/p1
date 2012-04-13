# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $.rails.confirm = (message) ->
    false

  confirmation_window = (link) -> $("<div></div>").dialog(
    autoOpen: false
    modal: true
    width: 350
    height: 150
    resizable: false
    title: $.i18n.prop("confirmation")
    buttons: [
      text: $.i18n.prop("yes")
      click: ->
        $(this).dialog "close"
        $.rails.handleMethod link
    ,
      text: $.i18n.prop("cancel")
      click: ->
        $(this).dialog "close"
    ]
  )

  $("a[data-confirm]").click ->
    question = $(this).attr("data-confirm")
    confirmation_window($(this)).html(question).dialog "open"

  $(".counter").countdown textOnComplete: $.i18n.prop("finished")