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
    MAX_SIZE = 31

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

litebriteApp = angular.module 'litebriteApp', []
litebriteApp
    .controller('LiteCtrl', ['$scope', LiteCtrl])
