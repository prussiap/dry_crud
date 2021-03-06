# encoding: UTF-8

# People Controller
class PeopleController < AjaxController

  self.search_columns = [:name, :children, :rating, :income, :birthdate,
                         :remarks, 'cities.name']

  self.default_sort = 'people.name, countries.code, cities.name'

  self.sort_mappings = { city_id: 'cities.name' }

  if respond_to?(:permitted_attrs)
    self.permitted_attrs = [:name, :children, :city_id, :rating, :income,
                            :birthdate, :gets_up_at, :last_seen, :remarks,
                            :cool, :email, :password]
  end

  private

  def list_entries
    list = super.includes(city: :country)
    if list.respond_to?(:references)
      list = list.references(:cities, :countries)
    end
    list
  end

end