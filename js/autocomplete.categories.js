
/**
 * Function to display autocomplete categories as copied from the JQuery UI website.
 * 
 */

$.widget( "custom.catcomplete", $.ui.autocomplete, {
                _create: function() {
                  this._super();
                  this.widget().menu( "option", "items", "> :not(.ui-autocomplete-category)" );
                },
                _renderMenu: function( ul, items ) {
                  var that = this,
                    currentCategory = "";
                  $.each( items, function( index, item ) {
                    var li;
                    if ( item.category != currentCategory ) {
                      ul.append( "<li class='ui-autocomplete-category'>" + item.category + "</li>" );
                      currentCategory = item.category;
                    }
                    li = that._renderItemData( ul, item );
                    if ( item.category ) {
                      li.attr( "aria-label", item.category + " : " + item.label );
                    }
                  });
                }
});
            /*        $.widget("custom.catcomplete", $.ui.autocomplete, {
                        _renderMenu: function (ul, items) {
                            var self = this,
                            currentCategory = "", itemCount = 0, itemsLength = items.length - 1;
                            $.each(items, function (index, item) {
                                if (item.category != currentCategory) {
                                   // ul.find('.ui-autocomplete-category:last').text(function () { return $(this).text() + ' ' + itemCount });
                                    ul.find('.ui-autocomplete-category:last').text(function () { return $(this).text() });
                                    ul.append("<li class='ui-autocomplete-category'>" + item.category + "</li>");
                                    currentCategory = item.category;
                                    itemCount = 1;
                                }
                                else {
                                    itemCount++;
                                }

                                if (index === itemsLength) {
                                   // ul.find('.ui-autocomplete-category:last').text(function () { return $(this).text() + ' ' + itemCount });
                                    ul.find('.ui-autocomplete-category:last').text(function () { return $(this).text() });
                                }

                                self._renderItem(ul, item);
                            });
                        }
                    });*/ 
