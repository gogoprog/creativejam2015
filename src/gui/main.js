var pages = {};

var fader;
var nextPageName;
var faderOpacity = 0;

function showPage(name, duration)
{
    nextPageName = name;
    fader.show();
    fader.fadeTo(duration, 1, function() {
        for(var k in pages)
        {
            if(k==nextPageName)
            {
                pages[k].element.show();
            }
            else
            {
                pages[k].element.hide();
            }
        }

        gengine_execute("Application:guiFadeFunction()");

        fader.fadeTo(duration, 0, function() {
            fader.hide();
        });

        gengine_execute("Application.guiFadeFunction = function() end");
    });
}

$(function() {
    var children = $("#main").children().each(function(i) {
        var name = $(this).attr('id');
        pages[name] = {
            element: $(this)
        };
        pages[name].element.hide();
    });

    fader = $('#fader');
    fader.hide();

    $( "#slider" ).slider({
        min:0,
        max:17,
        slide: function( event, ui ) {
            $("#startLevel").html(ui.value);
            gengine_execute("Game.startLevel = " + ui.value);
        }
        });

    gengine_execute("Application:start()")
});

function play()
{
    gengine_execute("Application:play()");
}

function quit()
{
    gengine_execute("gengine.application.quit()");
}

function updateObjects(count)
{
    $("#objects").html(count);
}

function updateLife(count)
{
    $("#life").html(count);
}

function updateGlasses(count)
{
    $("#glasses").html(count);
}

function updateLevel(count)
{
    $("#level").html("Level " + count);
}

function toggleSound()
{
    gengine_execute("Audio:setItIsSoundAllowed()");
}

function toggleMusic()
{
    gengine_execute("Audio:setItIsMusicAllowed()");
}