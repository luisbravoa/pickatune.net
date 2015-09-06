// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.nav.js
//= require_tree .


function platform() {
    var platform;
    switch (window.navigator.platform) {
        case 'Win32':
        case 'x86':
            platform = 'win32';
            break;
        case 'MacIntel':
            platform = 'mac64';
            break;
        case 'Win64':
        case 'x64':
            platform = 'win64';
            break;
        case 'Linux i686':
            platform = 'linux32';
            break;
        case 'Linux x86_64':
            platform = 'linux64';
            break;
    }
    return platform;
}


$(function () {
    $('#navbar, #main').onePageNav({
        currentClass: "active",
        changeHash: true,
        scrollThreshold: 0.5,
        scrollSpeed: 750,
        filter: ":not(.external)",
        easing: "swing"
    });
});


