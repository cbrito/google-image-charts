
module GoogleImageCharts
  class LineGraph < ChartBase
    
    def initialize(chartOptionsHash)
      super(chartOptionsHash)
      
      @chartType = "lc" #Line chart
      
      @chartSpecificOptions << "&chds=a"      # Chart Scale (automatic scaling by Google)
      @chartSpecificOptions << "&chxt=x,y"    # Scale labels for the X and Y axis'
      
    end
    
    def chartDataFlattened
      # Line graphs are series arrays seperated by pipes
      @chartData.join("|")
    end
    
  private
    

  end
end