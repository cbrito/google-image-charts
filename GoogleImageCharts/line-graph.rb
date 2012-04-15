
module GoogleImageCharts
  class LineGraph < ChartBase
    
    def initialize(chartOptionsHash)
      super(chartOptionsHash)
      
      @chartType = "lc" #Line chart
      
      
    end
    
    def chartDataFlattened
      # Line graphs are series arrays seperated by pipes
      @chartData.join("|")
    end

  end
end