# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $('#players-table').dataTable
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#players-table').data('source')
    sPaginationType: 'bootstrap'
