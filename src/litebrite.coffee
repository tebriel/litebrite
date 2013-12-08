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
currentColor = COLORS[COLORS.length - 1]
MAX_SIZE = 31


class LiteCtrl
    constructor: (@$scope, @settings) ->
        @$scope.colors = COLORS
        @$scope.liteGrid = []
        @$scope.settings = @settings

        @$scope.setColor = @setColor
        @$scope.reset = @reset

        @$scope.lightClick = @lightClick

        for row in [0...MAX_SIZE]
            @$scope.liteGrid[row] = []
            for column in [0...MAX_SIZE]
                @$scope.liteGrid[row][column] = @resetCell()

        return
    setColor: (color) =>
        @settings.currentColor = color

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
        if cell.color is @settings.currentColor
            cell.color = 'black'
        else
            cell.color = @settings.currentColor

        cell.isLit = cell.color isnt 'black'

        return

litebriteApp = angular.module 'litebriteApp', []
litebriteApp
    .controller('LiteCtrl', ['$scope', 'settings', LiteCtrl])
    .value('settings', currentColor:'white')
