# Google Image Charts

Ruby library for interfacing with Google's Image Chart API.

See [http://code.google.com/apis/chart/image/](http://code.google.com/apis/chart/image/) for more information.

Right now only Line Graphs and Pie Charts are supported. Let me know if you would like to contribute!

## Line Graph Example
	# Load the library
	require 'google-image-charts.rb'
	
	# Populate the chart details
	chartDetails = {
		:title 	=> "Test chart"
		:height => 250
		:width 	=> 400
		:data	=> [[4,5,10,6,2,9],[2,2,12,9,11,1]] # Array of data arrays (one for each line)
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