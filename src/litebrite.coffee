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
        cell.color = 'blue'
        cell.boxShadow = ''
        cell.isLit = false

        return cell

    reset: =>
        for row in @$scope.liteGrid
            for cell in row
                @resetCell cell

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

            grid = d3.select(iElement[0])
                .attr("width", "600px")
                .attr("height", "600px")
                .append("g")
            radius = 8
            size = 41
            space = 0

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
                return

            onMouseleave = (d, i) ->
                return


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
