# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.comment-link').click (e) ->
    e.preventDefault();
    $(this).remove();
    com_id = $(this).data('comId')
    console.log(com_id)
    com_type = $(this).data('comType')
    console.log(com_type)
    $('#comments_' + com_type + '_' + com_id).append(commentForm(com_id, com_type))

commentForm = (cid, ctype) ->
     '<form id="new_comment_form_' + ctype + '_' + cid + '" role="form" class="form-inline" action="/' + ctype + 's/' + cid + '/comments" accept-charset="UTF-8" data-remote="true" method="post"><input name="utf8" type="hidden" value="✓"><div class="form-group"><label class="sr-only control-label required" for="comment_body">Body</label><input class="form-control" type="text" name="comment[body]" id="comment_body"></div><input type="submit" name="commit" value="add comment" class="btn btn-success btn-sm"></form>'