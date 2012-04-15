# Google Image Charts

Ruby library for interfacing with Google's Image Chart API. (Part of the Google Image Visualization API.)

Google Image Charts allows a user to enter series data into a query string and retrieve a PNG or SVG image graph. See [http://code.google.com/apis/chart/image/](http://code.google.com/apis/chart/image/) for more information.

Right now only Line Graphs and Pie Charts are supported. Let me know if you would like to contribute!

## Line Graph Example
### Code Sample
	# Load the library
	require 'google-image-charts.rb'
	
	# Populate the chart details
	chartDetails = {
		:title 	=> "Test chart",
		:height => 250,
		:width 	=> 400,
		:data	=> [[4,5,10,6,2,9], [2,2,12,9,11,1]], # Array of data arrays (one for each line)
		:labels	=> ["Series 1", "Series 2"]
	}
	
	# Create the chart
	lineGraph = GoogleImageCharts::LineGraph.new(chartDetails)
	
	# Use it!
	chartUrl = lineGraph.chart_url
	# => "http://chart.apis.google.com/chart?cht=lc&chs=400x250&chd=t:4,5,10,6,2,9%7C2,2,12,9,11,1&chdl=Series%201%7CSeries%202&chdlp=b&chtt=Test%20chart&chco=a&chds=a&chxt=x,y"
	
	imageTag = lineGraph.html_img_tag
	# => "<img src='http://chart.apis.google.com/chart?cht=lc&chs=400x250&chd=t:4,5,10,6,2,9%7C2,2,12,9,11,1&chdl=Series%201%7CSeries%202&chdlp=b&chtt=Test%20chart&chco=a&chds=a&chxt=x,ycht=lc&chs=400x250&chd=t:4,5,10,6,2,9%7C2,2,12,9,11,1&chdl=Series%201%7CSeries%202&chdlp=b&chtt=Test%20chart&chco=a&chds=a&chxt=x,y' alt='Test chart' height='250' width='400' />"
	
	# Make it prettier
	lineGraph.chartColors = ["5CB8E6","E68A00"]

### Result
<div align="center"><img src='http://chart.apis.google.com/chart?cht=lc&chs=400x250&chd=t:4,5,10,6,2,9%7C2,2,12,9,11,1&chdl=Series%201%7CSeries%202&chdlp=b&chtt=Test%20chart&chco=a&chds=a&chxt=x,ycht=lc&chs=400x250&chd=t:4,5,10,6,2,9%7C2,2,12,9,11,1&chdl=Series%201%7CSeries%202&chdlp=b&chtt=Test%20chart&chco=5CB8E6,E68A00&chds=a&chxt=x,y' alt='Test chart' height='250' width='400' /></div>

## Pie Chart Example
### Code Sample
	# Load the library
	require 'google-image-charts.rb'
	
	# Populate the chart details
	chartDetails = {
		:title 	=> "Pie Chart Test",
		:height => 200,
		:width 	=> 200,
		:data	=> [15, 85], 
		:labels	=> ["This Stinks!", "This is awesome!"],
		:colors => ["5CB8E6","E68A00"]
	}
	
	# Create the chart
	pieChart = GoogleImageCharts::PieChart.new(chartDetails)
	
	# Use it!
	chartUrl = pieChart.chart_url
	# => "http://chart.apis.google.com/chart?cht=p&chs=200x200&chd=t:15,85&chdl=This%20Stinks!%7CThis%20is%20awesome!&chdlp=b&chtt=Pie%20Chart%20Test&chco=5CB8E6,E68A00&chds=a"
	
	imageTag = pieChart.html_img_tag
	# => "<img src='http://chart.apis.google.com/chart?cht=p&chs=200x200&chd=t:15,85&chdl=This%20Stinks!%7CThis%20is%20awesome!&chdlp=b&chtt=Pie%20Chart%20Test&chco=5CB8E6,E68A00&chds=acht=p&chs=200x200&chd=t:15,85&chdl=This%20Stinks!%7CThis%20is%20awesome!&chdlp=b&chtt=Pie%20Chart%20Test&chco=5CB8E6,E68A00&chds=a' alt='Pie Chart Test' height='200' width='200' />"

### Result
<div align="center"><img src='http://chart.apis.google.com/chart?cht=p&chs=200x200&chd=t:15,85&chdl=This%20Stinks!%7CThis%20is%20awesome!&chdlp=b&chtt=Pie%20Chart%20Test&chco=5CB8E6,E68A00&chds=acht=p&chs=200x200&chd=t:15,85&chdl=This%20Stinks!%7CThis%20is%20awesome!&chdlp=b&chtt=Pie%20Chart%20Test&chco=5CB8E6,E68A00&chds=a' alt='Pie Chart Test' height='200' width='200' /></div>

## Additional Options

### Larger Charts
As of 0.4 there is support for Google's POST method allowing up to 16K of data to be graphed. Simply set `:usePost = true` in your chartOptions hash and call `get_chart`. Be sure to set your content return type to PNG for this to work in a browser.

### Additional Options
There are plenty of features that this library does not yet make available. If you'd like to use the simplicity of the library, but pass in one of the additional features documented on [https://developers.google.com/chart/image/docs/chart_params](Google's Chart Feature List) you can now pass those as a string into your :additionalOptions element in the chartOptions hash.

Each additional line element should be separated by an '&'

	chartDetails = {
		:title 	=> "Pie Chart Test",
		:height => 200,
		:width 	=> 200,
		:data	=> [15, 85], 
		:labels	=> ["This Stinks!", "This is awesome!"],
		:colors => ["5CB8E6","E68A00"],
		:additionalOptions => "&chls=5" #Makes the line bolder
	}
   