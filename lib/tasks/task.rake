require 'csv'
require 'google/api_client'


 namespace :translate do
    task read: :environment do
        CSV.foreach("./lib/assets/messages.en.csv") do |row|
            record = CsvDatum.where(:csv_id => row[0], :source => row[1], :target => row[2]).first_or_create
            record.save
        end 
    end

    task write: :environment do
        file = "#{Rails.root}/lib/assets/translate.csv"
        create_csv(file)
     end
end



def create_csv(file)
    messages = CsvDatum.all
    api_key = ENV['API_KEY']
    headers = ["id", "source", "target", "Brazilian Portuguese", "Turkish","Russian", "Spanish", "German", "French",
        "Portuguese", "Polish", "Chinese (PRC)", "Italian", 'Romanian', "Dutch"]
    CSV.open(file, 'w', write_headers: true, headers: headers) do |writer|
        messages.each do |message|  
              translated_brazilian =  EasyTranslate.translate(message.source, :to => "pt-BR", :key => api_key)
              translated_turkish =  EasyTranslate.translate(message.source, :to => "tr", :key => api_key)
              translated_russian =  EasyTranslate.translate(message.source, :to => "ru", :key => api_key)
              translated_spanish =  EasyTranslate.translate(message.source, :to => "spanish", :key => api_key)
              translated_german =  EasyTranslate.translate(message.source, :to => "german", :key => api_key)
              translated_french =  EasyTranslate.translate(message.source, :to => "french", :key => api_key)
              translated_portuguese =  EasyTranslate.translate(message.source, :to => "portuguese", :key => api_key)
              translated_polish =  EasyTranslate.translate(message.source, :to => "polish", :key => api_key) 
              translated_chinese =  EasyTranslate.translate(message.source, :to => "zh-cn", :key => api_key) 
              translated_italian =  EasyTranslate.translate(message.source, :to => "it", :key => api_key) 
              translated_romanian =  EasyTranslate.translate(message.source, :to => "ro", :key => api_key) 
              translated_dutch =  EasyTranslate.translate(message.source, :to => "nl", :key => api_key)        
              writer << [message.csv_id.to_s,message.source.to_s,message.target.to_s, 
                translated_brazilian, translated_turkish, translated_russian, translated_spanish,
                 translated_german,translated_french, translated_portuguese, translated_polish,
                translated_chinese, translated_italian, translated_romanian, translated_dutch]
        end
     end
end


