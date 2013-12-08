COLORS = [
    'black'
    'blue'
    'cyan'
    'green'
    'yellow'
    'orange'
    'red'
    'purple'
    'magenta'
    'pink'
    'white'
    'reset'
]
currentColor = COLORS[COLORS.length - 2]
MAX_SIZE = 31


for color in COLORS
    $('#colorBox > ul').append "<li class=\"#{color}\"></li>"

$('li.reset').text 'RESET'

for i in [0...MAX_SIZE]
    $('#tables').append '<table><tbody><tr></tr></tbody></table>'

$('table > tbody > tr').each ->
    for i in [0...MAX_SIZE]
        $(@).append '<td></td>'

    return

$('table:even').each ->
    $(@).find('tbody')
        .find('tr')
        .prepend('<td style="width:5px, border:none"></td>')

    return

$('li').each ->
    $(@).css "background", $(@).attr('class')
    return


$('li').click ->
    currentColor = $(@).attr 'class'

    return

$('td').click ->
    $(@).css background: currentColor, boxShadow: ''
    if currentColor isnt 'black'
        $(@).css 'box-shadow', 'inset white 0px -1px 7px 1px'
        $(@).attr 'status', 'lit'

    return

reset = ->
    $('td').each ->
        $(@).css background: 'black', boxShadow: ''
        $(@).attr 'status', ''
        return

highLight = (elm) ->
    if $(elm).attr('status') isnt 'lit'
        $(elm).css 'background', currentColor

    return

lowLight = (elm) ->
    if $(elm).attr('status') isnt 'lit'
        $(elm).css 'background', 'black'

    return

$('.reset').click ->
    reset()
    return

$('td').hover (-> highLight(@)), (-> lowLight(@))
