/*
Since this graph object only gets instanciated once, it is acceptable to declare it in this way (this would be too
heavy for an often instanciated object.
 */


var PlayerStatGraph = function(element_id,url) {

    this.url = url;
    this.league = ["a", "b", "c"];
    this.traits = ["runs", "home_runs", "steals", "rbi", "on_base_percentage_plus_slugging", "batting_average" ];

    this.margins = [80, 160, 200, 160];
    this.width = 1280 - this.margins[1] - this.margins[3];
    this.height = 700 - this.margins[0] - this.margins[2];
    this.x = d3.scale.ordinal().domain(this.traits).rangePoints([0, this.width]);
    this.y = {};

    this.line = d3.svg.line();
    this.axis = d3.svg.axis().orient("left");
    this.foreground;

    this.svg = d3.select(element_id).append("svg:svg")
        .attr("width", this.width + this.margins[1] + this.margins[3])
        .attr("height", this.height + this.margins[0] + this.margins[2])
      .append("svg:g")
        .attr("transform", "translate(" + this.margins[3] + "," + this.margins[0] + ")");


    // Returns the path for a given data point.
    this.path = function(d) {
      return this.line(this.traits.map(function(p) { return [this.x(p), this.y[p](d[p])]; }.bind(this)));
    }.bind(this)

    // Handles a brush event, toggling the display of foreground lines.
    this.brush = function () {
        var actives = this.traits.filter(function (p) {
                return !this.y[p].brush.empty();
            }.bind(this)),
            extents = actives.map(function (p) {
                return this.y[p].brush.extent();
            }.bind(this));
        this.foreground.classed("fade", function (d) {
            return !actives.every(function (p, i) {
                return extents[i][0] <= d[p] && d[p] <= extents[i][1];
            }.bind(this));
        });
    }.bind(this);



    this.load = function() {
        d3.json(this.url, function(players) {
            this.players=players;


          // Create a scale and brush for each trait.
          this.traits.forEach(function(d) {
            this.y[d] = d3.scale.linear()
                .domain(d3.extent(players, function(p) { return +p[d]; }))
                .range([this.height, 0]);

            this.y[d].brush = d3.svg.brush()
                .y(this.y[d])
                .on("brush", this.brush);
         }.bind(this));

          // Add foreground lines.
          this.foreground = this.svg.append("svg:g")
              .attr("class", "foreground")
            .selectAll("path")
              .data(players)
            .enter().append("svg:path")
              .attr("d", function(d) { return this.path(d); }.bind(this)).attr("class", "playerline");
//              .attr("class", function(d) { return d.league; });

          // Add a group element for each trait.
          var g = this.svg.selectAll(".trait")
              .data(this.traits)
            .enter().append("svg:g")
              .attr("class", "trait")
              .attr("transform", function(d) { return "translate(" + this.x(d) + ")"; }.bind(this))
              .call(d3.behavior.drag()
              .origin(function(d) { return {x: this.x(d)}; }.bind(this))
              .on("dragstart", dragstart)
              .on("drag", drag)
              .on("dragend", dragend));

          // Add an axis and title.
          g.append("svg:g")
              .attr("class", "axis")
              .attr("id", function(d) { return d })
              .each(function(d) { d3.select('#'+d).call(d3.svg.axis().orient("left").scale(this.y[d])); }.bind(this))
            .append("svg:text")
              .attr("text-anchor", "middle")
              .attr("y", -9)
              .text(String);

          // Add a brush for each axis.
          g.append("svg:g")
              .attr("class", "brush")
              .attr("id", function(d) { return d })
              .each(function(d) { d3.select('#'+d).call(this.y[d].brush); }.bind(this))
            .selectAll("rect")
              .attr("x", -8)
              .attr("width", 16);

          function dragstart(d) {
            i = this.traits.indexOf(d);
          }

          function drag(d) {
            this.x.range()[i] = d3.event.x;
            this.traits.sort(function(a, b) { return this.x(a) - this.x(b); }.bind(this));
            g.attr("transform", function(d) { return "translate(" + this.x(d) + ")"; }.bind(this));
            foreground.attr("d", this.path);
          }

          function dragend(d) {
            this.x.domain(this.traits).rangePoints([0, this.w]);
            var t = d3.transition().duration(500);
            t.selectAll(".trait").attr("transform", function(d) { return "translate(" + this.x(d) + ")"; }.bind(this));
            t.selectAll(".foreground path").attr("d", this.path);
          }
        }.bind(this));
    };
};


$(document).ready(function() {
    var graph;
    if ($('#players_graph').length>0) {
      graph = new PlayerStatGraph("#players_graph","/players.json");
      graph.load()
    }
});






