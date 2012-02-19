require 'uri'

module GoogleImageCharts  

  VERSION = 0.1
  
  class ChartBase
    attr_accessor :chartTitle, :chartWidth, :chartHeight, :chartLabels, :chartColors
    
    @@CHART_URI_BASE = "http://chart.apis.google.com/chart?"
    
    def initialize(chartOptionsHash)
      @chartSpecificOptions = ""  # Should be overridden by child-classes
      
      @chartWidth   = chartOptionsHash[:width]
      @chartHeight  = chartOptionsHash[:height]
      @chartTitle   = chartOptionsHash[:title]
      self.chartData=(chartOptionsHash[:data])  # Should be an array of data arrays
      @chartLabels  = chartOptionsHash[:labels]  # Should be an array of labels
      @chartLabelPosition  = "b" if chartOptionsHash[:labels].nil? == false
    end
    
    def chartData
      @chartData
    end
    
    def chartData=(data)
      @chartData = Array.new
      data.each_index do |index|
        @chartData.push data[index].join(",").to_s
      end
    end
    
    def set_chart_label_position(position)
      @chartLabelPosition = case
                          when position == :top then "t"
                          when position == :left then "l"
                          when position == :right then "r"
                          else "b"
                          end
                            
    end
    
    def chart_url
      chartURL = @@CHART_URI_BASE
      chartURL << "cht="    + @chartType
      chartURL << "&chs="   + @chartWidth.to_s + "x" + @chartHeight.to_s 
      chartURL << "&chd=t:" + @chartData.join("|")    if @chartData.nil? == false # Simple text for now
      chartURL << "&chdl="  + @chartLabels.join("|")  if @chartLabels.nil? == false
      chartURL << "&chdlp="  + @chartLabelPosition    if @chartLabels.nil? == false
      chartURL << "&chtt="  + @chartTitle             if @chartTitle.nil? == false
      chartURL << "&chco="  + @chartColors.join(",")  if @chartColors.nil? == false
      
      chartURL << @chartSpecificOptions
      
      return URI.escape(chartURL)
    end
    
    def html_img_tag
      return "<img src='#{chart_url}' alt='#{@chartTitle}' height='#{@chartHeight}' width='#{@chartWidth}' />"
    end
    
  end
  
  # Load all the chart types
  require 'GoogleImageCharts/line-graph.rb'
  
end

