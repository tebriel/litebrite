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
            grid.selectAll('circle')
                .data(d3.merge scope.data)
                .enter()
                .append('circle')
                .attr('cx', (d, i) -> ((i % 41) * 10) + 2)
                .attr('cy', (d, i) -> (Math.floor(i / 41) * 10) + 2)
                .attr('fill', 'blue')
                .attr('r', "10px")


            return


litebriteApp = angular.module 'litebriteApp', []
litebriteApp
    .controller('LiteCtrl', ['$scope', LiteCtrl])
    .directive('litebrite', [LiteBriteD3])
