class Capital < Finance

  def self.get_overall_values
    capital = Capital.all.pluck(:amount).inject(:+)
    inflow = Inflow.all.pluck(:amount).inject(:+)
    outflow = Outflow.all.pluck(:amount).inject(:+)
    balance = outflow.to_f - inflow.to_f
    {:capital => capital, :inflow => inflow, :outflow => outflow, :balance => balance}
  end
end
