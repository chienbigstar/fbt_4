every 6.hours do
  rake "db:calculator_rate_tour", output: "#{path}/log/lograte.log"
end

every :day, at: "0:00am" do
  rake "db:generate_final_price_tour", output: "#{path}/log/logrule.log"
end
