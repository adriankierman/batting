Batting - Rails Baseball Statistics Site
========================================

# What is Batting

Batting is a baseball statistics site. Its also a quick demo of how rails technologies can make coding productive and make
 a relatively intuitive statistics site for users.

    % http://batting.herokuapp.com

## Design

The site follows the conventions of rails design - it adheres to the Model, View, Controller (MVC) design pattern. In addition
it uses jquery datatables to render tabular data from the database of statistics. We use rspec to perform testing tasks
and d3.js to accomplish a visualization of the data. Datatables data formatting requirements are abstracted out of the
controller as a separate controller helper class so that this functionality can be reused using the ajax-datatables-rails
gem.

We used a separate data loader (called via a rake task). Often difficult statistics problems will require multiple data sources and
various data parsing and cleaning tasks. Since this code can be complex and not used by the rendering portion of the code, it is
good to keep it separate. In this way adding a new data loader for a different data source can be accomplished without too much
difficulty or realignment of the architecture (a new data loader library and a new rake task would be the only major additions).

## Usage Notes

Loading the data into the database, performing validations on the data and pre-computing key statistics is done using a
rake task:

    % rake baseball:upload

## Limitations

A design decision to aggressively validate the data was made to ensure a set of higher quality data points. Rails
validations were used to perform this validation. This was considered acceptable, because accepting dirty data and
adjusting for it was beyond the scope of the project. Normalizing player name and year batting statistics over multiple
years for players was deferred due to time constraints - but can be very easily accomplished.


Wrap Up
-------

Thanks to location inc for the idea for this demo app and the datatables, rails and d3.js teams for the great libraries used.
