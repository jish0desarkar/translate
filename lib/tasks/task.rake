require 'csv'

# Gems required 
# Copy the following in GemFIle
#     gem 'csv', '~> 0.0.1'
#     gem 'easy_translate'

# Run 
# rake translate:read 
# This will generate 'translate.csv' which will contain the translated strings




 namespace :translate do
    task read: :environment do

        file = "#{Rails.root}/lib/assets/translate.csv"
        create_csv(file)
        
        end 
end

def create_csv(file)
    api_key = Rails.application.credentials.aws[:api_key]
    headers = ["id", "source", "target", "Brazilian Portuguese", "Turkish","Russian", "Spanish", "German", "French",
        "Portuguese", "Polish", "Chinese (PRC)", "Italian", 'Romanian', "Dutch"]
    
    CSV.open(file, 'w', write_headers: true, headers: headers) do |writer|
        CSV.foreach("./lib/assets/messages.en.csv") do |row| 
              translated_brazilian =  EasyTranslate.translate(row[1], :to => "pt-BR", :key => api_key)
              translated_turkish =  EasyTranslate.translate(row[1], :to => "tr", :key => api_key)
              translated_russian =  EasyTranslate.translate(row[1], :to => "ru", :key => api_key)
              translated_spanish =  EasyTranslate.translate(row[1], :to => "spanish", :key => api_key)
              translated_german =  EasyTranslate.translate(row[1], :to => "german", :key => api_key)
              translated_french =  EasyTranslate.translate(row[1], :to => "french", :key => api_key)
              translated_portuguese =  EasyTranslate.translate(row[1], :to => "portuguese", :key => api_key)
              translated_polish =  EasyTranslate.translate(row[1], :to => "polish", :key => api_key) 
              translated_chinese =  EasyTranslate.translate(row[1], :to => "zh-cn", :key => api_key) 
              translated_italian =  EasyTranslate.translate(row[1], :to => "it", :key => api_key) 
              translated_romanian =  EasyTranslate.translate(row[1], :to => "ro", :key => api_key) 
              translated_dutch =  EasyTranslate.translate(row[1], :to => "nl", :key => api_key)        
              
              writer << [row[0],row[1],row[2],translated_brazilian, translated_turkish, 
              translated_russian, translated_spanish,translated_german,translated_french, translated_portuguese, 
              translated_polish,translated_chinese, translated_italian, translated_romanian, translated_dutch]
        end
     end
end


