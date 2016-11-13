//User Login
$(function() {
   jsxc.init({
      loginForm: {
         form: '#form',
         jid: '#username',
         pass: '#password'
      },
      logoutElement: $('#logout'),
      root: '/jsxc/jsxc',
      xmpp: {
         url: 'http://localhost:5280/http-bind/',
         domain: 'TestDomain',
         resource: 'example'
      }
   });
});

//Events
$(document).on('ready.roster.jsxc', function(){
   $('#content').css('right', $('#jsxc_roster').outerWidth() + parseFloat($('#jsxc_roster').css('right')));
});
$(document).on('toggle.roster.jsxc', function(event, state, duration){
   $('#content').animate({
      right: ((state === 'shown') ? $('#jsxc_roster').outerWidth() : 0) + 'px'
   }, duration);
});
