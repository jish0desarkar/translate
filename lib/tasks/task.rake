require 'csv'
require 'google/api_client'
require 'google/cloud/translate'


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
    api_key = 'AIzaSyCWzCo0EwZXCStguLQirsOi9iHPPAifZZw'
    headers = ["id", "source", "target", "spanish", "german", "french", "portuguese", "polish", "mandarin"]
    CSV.open(file, 'w', write_headers: true, headers: headers) do |writer|
        messages.each do |message|  
              translated_spanish =  EasyTranslate.translate(message.source, :to => "spanish", :key => api_key)
              translated_german =  EasyTranslate.translate(message.source, :to => "german", :key => api_key) 
              translated_french =  EasyTranslate.translate(message.source, :to => "french", :key => api_key) 
              translated_portuguese =  EasyTranslate.translate(message.source, :to => "portuguese", :key => api_key) 
              translated_polish =  EasyTranslate.translate(message.source, :to => "polish", :key => api_key) 
              translated_mandarin =  EasyTranslate.translate(message.source, :to => "zh-CN", :key => api_key)        
              writer << [message.csv_id.to_s,message.source.to_s,message.target.to_s, translated_spanish, translated_german, translated_french, translated_portuguese, translated_polish,translated_mandarin]
        end
     end
end

#     task spanish: :environment do 
    
#         file = "#{Rails.root}/lib/assets/translate.sp.csv"
        
#         create_csv(file, 'spanish')
        
#     end
#     task german: :environment do 
    
#         file = "#{Rails.root}/lib/assets/translate.gr.csv"
        
#         create_csv(file, 'german')
        
#     end
#     task french: :environment do 
    
#         file = "#{Rails.root}/lib/assets/translate.fr.csv"
        
#         create_csv(file, 'french')
        
#     end
#     task portuguese: :environment do 
    
#         file = "#{Rails.root}/lib/assets/translate.pr.csv"
        
#         create_csv(file, 'portuguese')
        
#     end
#     task polish: :environment do 
    
#         file = "#{Rails.root}/lib/assets/translate.pl.csv"
        
#         create_csv(file, 'polish')
        
#     end
#     task mandarin: :environment do 
    
#         file = "#{Rails.root}/lib/assets/translate.md.csv"
        
#         create_csv(file, 'zh-CN')
        
#     end
# end 

