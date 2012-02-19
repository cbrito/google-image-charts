
module GoogleImageCharts
  class LineGraph < ChartBase
    
    def initialize(chartOptionsHash)
      super()
      @chartType = "lc" #Line chart
      @chartWidth   = chartOptionsHash[:width]
      @chartHeight  = chartOptionsHash[:height]
      @chartTitle   = chartOptionsHash[:title]
      self.chartData=(chartOptionsHash[:data])  # Should be an array of data arrays
      @chartLabels  = chartOptionsHash[:labels]  # Should be an array of labels
      @chartLabelPosition  = "b"
      
      @chartSpecificOptions << "&chds=a"      # Chart Scale (automatic scaling by Google)
      @chartSpecificOptions << "&chxt=x,y"    # Scale labes for the X and Y axis'
      
    end
  private
    

  end
end