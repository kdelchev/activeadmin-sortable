(function($) {
  $(document).ready(function() {
    $('.handle').closest('tbody').activeAdminSortable();
    $('.handle_up').activeAdminSortUpDown();
    $('.handle_down').activeAdminSortUpDown();
  });

  $.fn.activeAdminSortable = function() {
    this.sortable({
      update: function(event, ui) {
        var url = $('#' + ui.item[0].id)
          .children('td.activeadmin-sortable')
          .children('span.handle')
          .attr('data-sort-url');

        $.ajax({
          url: url,
          type: 'post',
          data: { position: ui.item.index() + 1 },
          success: function() { window.location.reload(); }
        });
      }
    });

    this.disableSelection();
  }

  $.fn.activeAdminSortUpDown = function() {
    $(this).bind('click', function() {
      var url = $(this).attr('data-sort-url');

      $.ajax({
        url: url,
        type: 'post',
        success: function() { window.location.reload(); }
      });
    });
  }
})(jQuery);
