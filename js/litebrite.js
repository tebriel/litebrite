var currentColor = 'white';

for (var i=0; i<31; i++){
  $('table').append('<tr></tr>');
}

$('table > tbody > tr').each(function(){
  for (var i=0; i<31; i++){
    $(this).append('<td></td>');
  }
});

$('li').each(function(){
    $(this).css("background",$(this).attr('class'));
});

$('li').click(function(){
  currentColor = $(this).attr('class');
});

$('td').click(function light (){
  $(this).css('background', currentColor);
  $(this).css('box-shadow', 'inset white 0 -1px 7px 1px');
  $(this).attr('status', 'lit');
});

function reset(){
  $('td').each(function(){
    $(this).css('background','black');
    $(this).attr('status','');
  });
};

function highLight(elm){
  if($(elm).attr('status') != 'lit'){
    $(elm).css('background', currentColor);
  }
};

function lowLight(elm){
  if($(elm).attr('status') != 'lit'){
    $(elm).css('background', 'black');
  }
};

$('.reset').click(function(){
  reset();
});

$('td').hover(function(){
  highLight(this) },
  function(){ lowLight(this);
});
