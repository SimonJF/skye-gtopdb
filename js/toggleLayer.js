      function toggleLayer( whichLayer )      {
        var elem, vis;
        if( document.getElementById ) // this is the way the standards work
          elem = document.getElementById( whichLayer );
        else if( document.all ) // this is the way old msie versions work
            elem = document.all[whichLayer];
        else if( document.layers ) // this is the way nn4 works
          elem = document.layers[whichLayer];
        vis = elem.style;
        // if the style.display value is blank we try to figure it out here
        if(vis.display==''&&elem.offsetWidth!=undefined&&elem.offsetHeight!=undefined)
          vis.display = (elem.offsetWidth!=0&&elem.offsetHeight!=0)?'block':'none';
        vis.display = (vis.display==''||vis.display=='block')?'none':'block';
      }
      
      function toggleLayerAndLink( whichLayer, showLink, hideLink )      {
        var elem, vis, show_link, show_link_vis, hide_link, hide_link_vis;
        if( document.getElementById ){ // this is the way the standards work
          elem = document.getElementById( whichLayer );
          show_link = document.getElementById( showLink );
          hide_link = document.getElementById( hideLink );
        }
        else if( document.all ){ // this is the way old msie versions work
            elem = document.all[whichLayer];
            show_link = document.all[showLink];
            hide_link = document.all[hideLink];
        }
        else if( document.layers ){ // this is the way nn4 works
          elem = document.layers[whichLayer];
          show_link = document.layers[showLink];
          hide_link = document.layers[hideLink];
        }
        vis = elem.style;
        show_link_vis = show_link.style;
        hide_link_vis = hide_link.style;
        
        // if the style.display value is blank we try to figure it out here
        if(vis.display==''&&elem.offsetWidth!=undefined&&elem.offsetHeight!=undefined)
          vis.display = (elem.offsetWidth!=0&&elem.offsetHeight!=0)?'block':'none';
        vis.display = (vis.display==''||vis.display=='block')?'none':'block';
        
      /*  if(show_link_vis.display==''&&show_link.offsetWidth!=undefined&&show_link.offsetHeight!=undefined)
          show_link_vis.display = (show_link.offsetWidth!=0&&show_link.offsetHeight!=0)?'block':'none';
        show_link_vis.display = (show_link_vis.display==''||show_link_vis.display=='block')?'none':'block';
        
        if(hide_link_vis.display==''&&hide_link.offsetWidth!=undefined&&hide_link.offsetHeight!=undefined)
          hide_link_vis.display = (hide_link.offsetWidth!=0&&hide_link.offsetHeight!=0)?'block':'none';
        hide_link_vis.display = (hide_link_vis.display==''||hide_link_vis.display=='block')?'none':'block';*/
        
        if(show_link_vis.display==''&&show_link.offsetWidth!=undefined&&show_link.offsetHeight!=undefined)
          show_link_vis.display = (show_link.offsetWidth!=0&&show_link.offsetHeight!=0)?'inline':'none';
        show_link_vis.display = (show_link_vis.display==''||show_link_vis.display=='inline')?'none':'inline';
        
        if(hide_link_vis.display==''&&hide_link.offsetWidth!=undefined&&hide_link.offsetHeight!=undefined)
          hide_link_vis.display = (hide_link.offsetWidth!=0&&hide_link.offsetHeight!=0)?'inline':'none';
        hide_link_vis.display = (hide_link_vis.display==''||hide_link_vis.display=='inline')?'none':'inline';
	
	/*if(vis.display == 'block')
	  jQuery.cookie(whichLayer, 'show');
	else
	  jQuery.cookie(whichLayer, 'hide');*/
      }

  // these methods use JQuery to toggle on/off the sections on the family page
  
  function toggleSectionsOn() { 
      $('.visibleSection').each(function(i,v){$(this).show()} );
      $('.hiddenSection').each(function(i,v){$(this).hide()} );
  }
  
  function toggleSectionsOff() { 
      $('.visibleSection').each(function(i,v){$(this).hide()} );
      $('.hiddenSection').each(function(i,v){$(this).show()} );
  }

  // this method toggles on a symbol highlighting if a family/target is in the concise guide
    
  function showCGTP() { 
     $('.cgtp').each(function(i,v){$(this).show()} );
  }

