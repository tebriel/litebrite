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
]
class LiteCtrl
    MAX_SIZE = 41

    constructor: (@$scope) ->
        @$scope.settings =
            currentColor: COLORS[COLORS.length - 1]
        @$scope.colors = COLORS
        @$scope.liteGrid = []

        @$scope.setColor = @setColor
        @$scope.reset = @reset

        @$scope.lightClick = @lightClick

        for row in [0...MAX_SIZE]
            @$scope.liteGrid[row] = []
            for column in [0...MAX_SIZE]
                @$scope.liteGrid[row][column] = @resetCell()

        return

    resetCell: (cell) ->
        cell ?= {}
        cell.color = 'black'
        cell.boxShadow = ''
        cell.isLit = false

        return cell

    reset: =>
        for row in @$scope.liteGrid
            for cell in row
                @resetCell cell
        @$scope.$broadcast 'reset'

        return

    lightClick: (cell) =>
        if cell.color is @$scope.settings.currentColor
            cell.color = 'black'
        else
            cell.color = @$scope.settings.currentColor

        cell.isLit = cell.color isnt 'black'

        return

LiteBriteD3 = ->
    restrict: 'A'
    scope:
        data: "=lbData"
        settings: "=lbSettings"
    link:
        post: (scope, iElement, iAttrs) ->
            ourData = d3.merge scope.data
            for data, i in ourData
                data.index = i

            # TODO: Don't hardcode size
            grid = d3.select(iElement[0])
                .attr("width", "729px")
                .attr("height", "722px")
                .append("g")
            radius = 7
            size = 41
            space = 1

            xPosition = (d) ->
                shiftWidth = 0
                shifter = Math.floor(d.index/size) % 2
                if shifter is 1
                    shiftWidth = radius
                return (((d.index % 41)+1) * ((radius+space)*2)) + shiftWidth

            yPosition = (d) ->
                return ((Math.floor(d.index / 41)+1) * ((radius+space)*2)) + space
            onMouseover = (d, i) ->
                for color in COLORS
                    showColor = color is scope.settings.currentColor
                    d.elnt.classed color, showColor
                d.elnt.classed 'hover', true
                return

            onMouseleave = (d, i) ->
                for color in COLORS
                    showColor = color is d.color
                    d.elnt.classed color, showColor
                d.elnt.classed 'hover', false
                return

            onMouseClick = (d, i) ->
                d.color = scope.settings.currentColor
                for color in COLORS
                    showColor = color is scope.settings.currentColor
                    d.elnt.classed color, showColor

                d.elnt.classed 'lit', d.color isnt 'black'

                return

            reset = ->
                for data in ourData
                    continue if data.elnt.classed 'black'
                    for color in COLORS
                        data.elnt.classed color, data.color is color
            scope.$on 'reset', reset

            doDrawLiteBrite = ->
                console.log 'ello, govener'
                dataobj = grid.selectAll('circle')
                    .data(ourData)
                colorFunc = (d) ->
                    console.log d.color
                    return d.color
                dataobj
                    .enter()
                    .append('circle')
                    .attr('cx', xPosition)
                    .attr('cy', yPosition)
                    .attr('r', "#{radius}px")
                    .on('mouseover', null)
                    .on('mouseover', onMouseover)
                    .on('mouseleave', onMouseleave)
                    .on('click', onMouseClick)
                    .each( (d) -> d.elnt = d3.select @)
                    .classed('black',true)
                dataobj
                    .exit()
                    .remove()

            doDrawLiteBrite()



            return


litebriteApp = angular.module 'litebriteApp', []
litebriteApp
    .controller('LiteCtrl', ['$scope', LiteCtrl])
    .directive('litebrite', [LiteBriteD3])
