require 'csv'


 namespace :translate do
    task read: :environment do
        CSV.foreach("./lib/assets/messages.en.csv") do |row|
            record = CsvDatum.where(:csv_id => row[0], :source => row[1], :target => row[2]).first_or_create
            record.save
        end 
    end

    task write: :environment do 
    
        file = "#{Rails.root}/lib/assets/translate.en.csv"

        messages = CsvDatum.all

        headers = ["id", "source", "target"]

        CSV.open(file, 'w', write_headers: true, headers: headers) do |writer|
            messages.each do |message|
                writer << [message.csv_id.to_s, message.source.to_s, message.target.to_s]
            end
        end
    end
end 