class LiteCtrl
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
    MAX_SIZE = 41

    constructor: (@$scope) ->
        @$scope.currentColor = COLORS[COLORS.length - 1]
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

        return

    lightClick: (cell) =>
        if cell.color is @$scope.currentColor
            cell.color = 'black'
        else
            cell.color = @$scope.currentColor

        cell.isLit = cell.color isnt 'black'

        return

LiteBriteD3 = ->
    restrict: 'A'
    scope:
        data: "=lbData"
    link:
        post: (scope, iElement, iAttrs) ->
            console.log d3.merge scope.data
            console.log iElement
            grid = d3.select(iElement[0])
                .attr("width", "600px")
                .attr("height", "600px")
                .append("g")
            radius = 8
            size = 41
            space = 0
            xPosition = (d,i) ->
                shiftWidth = 0
                shifter = Math.floor(i/size) % 2
                if shifter is 1
                    shiftWidth = radius
                result = (((i % 41)+1) * ((radius+space)*2)) + shiftWidth
                console.log result
                return result

            yPosition = (d,i) ->
                return ((Math.floor(i / 41)+1) * ((radius+space)*2)) + space
            grid.selectAll('circle')
                .data(d3.merge scope.data)
                .enter()
                .append('circle')
                .attr('cx', xPosition)
                .attr('cy', yPosition)
                .attr('fill', 'blue')
                .attr('r', "#{radius}px")


            return


litebriteApp = angular.module 'litebriteApp', []
litebriteApp
    .controller('LiteCtrl', ['$scope', LiteCtrl])
    .directive('litebrite', [LiteBriteD3])
