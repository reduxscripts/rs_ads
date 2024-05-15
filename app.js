$(function () {
    'use strict';
    console.log("STARTED");

    var resname = GetParentResourceName();

    function display(bool) {
        if (bool) {
            $("#alerts").show();
        } else {
            $("#alerts").hide();
        }
    }
  
    // debug only
    display(false);
    
    window.addEventListener('message', function (event) {
        var item = event.data;

        if (item.type === "open") {
            display(item.status);
        }
  
        if (item.type === "close") {
            display(item.status);
        }
  
        if (item.type === 'sendAlert') {
            
            const data = {
                title : item.title,
                text : item.text

            }
          
            sendAlert(data);
        }
  
        
    });
  
    function sendAlert(data) {

        console.log("Alert sent: " + data.title + " " + data.text);
    
        $('#alerts').empty();
        var listItem = $('<div></div>').addClass('w-full flex items-center justify-center py-2')
            .html('<h3 class="text-center text-2xl text-white">' + '<span style="color: yellow;">' + data.title.toUpperCase() + '</span>' + ' || ' + data.text.toUpperCase() + '</h3>')
            .css({position: 'relative', overflow: 'hidden'});
        $('#alerts').append(listItem);
    
        setTimeout(function() {
            listItem.remove();
            display(false);
            $.post('https://'+resname+'/exit', JSON.stringify({}));
            ClearData();
        }, 10000);
        
    }
    
    function ClearData() {
        // Clear all UI data here
        $('#alerts').empty();
    }
});
