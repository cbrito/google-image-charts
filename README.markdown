# Google Image Charts

Ruby library for interfacing with Google's Image Chart API.

See [http://code.google.com/apis/chart/image/](http://code.google.com/apis/chart/image/) for more information.

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
		:data	=> [15, 85], # Array of data arrays (one for each line)
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