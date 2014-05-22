# A small hack to allow passing options to associations
class ActiveModel::Serializer
  def include_associations!
    _associations.each_pair do |name, asst|
      include!(name, asst.options) if include?(name)
    end
  end
end

