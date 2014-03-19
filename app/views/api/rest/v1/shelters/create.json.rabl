object @shelter

attributes :id,
           :awo_id,
           :address,
           :city,
           :fax,
           :name,
           :state,
           :phone,
           :zip

node(:animal_count) { |shelter| shelter.animals.count }
