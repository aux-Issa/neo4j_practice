require "json"

class Univ
  include Neo4j::ActiveNode
  id_property :code
  property :name, type: String
  self.mapped_label_name = '大学'
  has_many :out, :faculties, type: :has, unique: true
  validates :name, :presence => true
end

#Jsonからデータを読み込み，配列に格納
File.open(Rails.root + 'app/models/concerns/school.json') do |file|  
  $univs_with_faculties = JSON.load(file)
end 

i=0
while i<=($univs_with_faculties.length - 1) 
  if i.even? || i==0
    #配列から取り出した大学名がUnivModelに無ければ実行
    unless Univ.find_by(name: $univs_with_faculties[i]["大学"])
      uni = Univ.create(name: $univs_with_faculties[i]["大学"])
      uni.faculties = []
      $univs_with_faculties[i+1]["学部"].map do |name|
    #配列から取り出した学部名がFacultyModelに無ければ実行    
        if !Faculty.find_by(name: name)
          #大学に属する学部として，Facultyインスタンスを作成
          uni.faculties << Faculty.create(name: name)
        else
          #テーブルに既存の学部に属する大学として，Univインスタンスを作成
          Faculty.find_by(name: name).univs << uni
        end
      end
    end  
  end 
  i+=1
end 
