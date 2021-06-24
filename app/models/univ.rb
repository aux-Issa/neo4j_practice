###### ORIGINAL ############
# class Univ 
#   include Neo4j::ActiveNode
#   property :name, type: String
#   property :created_at, type: DateTime
#   property :updated_at, type: DateTime
# end
###########################

require "json"

class Univ
  include Neo4j::ActiveNode
  id_property :code
  property :name, type: String
  self.mapped_label_name = '大学'
  has_many :out, :faculties, type: :has, unique: true
  validates :name, :presence => true
end


# #Jsonからファイルを読み込み，hashに格納
# File.open(Rails.root + 'app/models/concerns/school.json') do |file|  
#   hash = JSON.load(file)
#   i = 0
#   while i <= hash.length/2
#     if hash[i]["大学"].present? && !Univ.find_by(name: hash[i]["大学"])
#       uni = Univ.create(name:hash[i]["大学"])
#       if hash[i+1]["学部"].present?
#         uni.faculties = hash[i+1]["学部"].map do |name|
#           if !Faculty.find_by(name: name)
#             Faculty.create(name:name)
#           end
#         end
#       end
#     end
#     i += 1
#   end
# end
#Jsonからファイルを読み込み，hashに格納
# File.open(Rails.root + 'app/models/concerns/school.json') do |file|  
#   $hash = JSON.load(file)
# end  
#   i = 0
#   while i <= $hash.length/2
#     if $hash[i]["大学"].present? && !Univ.find_by(name: $hash[i]["大学"])
#       uni = Univ.create(name:$hash[i]["大学"])
#       if $hash[i+1]["学部"].present?
#         uni.faculties = $hash[i+1]["学部"].map do |name|
#           if !Faculty.find_by(name: name)
#             Faculty.create(name:name)
#           end
#         end
#       end
#     end
#     i += 1
#   end
File.open(Rails.root + 'app/models/concerns/school.json') do |file|  
  $univs_with_faculties = JSON.load(file)
end 
i=0
while i<=($univs_with_faculties.length - 1) 
  if i.even? || i==0
    unless Univ.find_by(name: $univs_with_faculties[i]["大学"])
      uni = Univ.create(name: $univs_with_faculties[i]["大学"])
      uni.faculties = []
      $univs_with_faculties[i+1]["学部"].map do |name|
        if !Faculty.find_by(name: name)
          uni.faculties << Faculty.create(name: name)
        else
          Faculty.find_by(name: name).univs <<  $univs_with_faculties[i]["大学"]
        end
      end
    end  
  end 
  i+=1
end 
  #i = 0
  # while i <= $hash.length/2
  #   if $hash[i]["大学"].present? && !Univ.find_by(name: $hash[i]["大学"])
  #     uni = Univ.create(name:$hash[i]["大学"])
  #     if $hash[i+1]["学部"].present?
  #       uni.faculties = $hash[i+1]["学部"].map do |name|
  #         if !Faculty.find_by(name: name)
  #           Faculty.create(name:name)
  #         end
  #       end
  #     end
  #   end
  #   i += 1
  # end
