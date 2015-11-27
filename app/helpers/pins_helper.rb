module PinsHelper

   def sortable(column, title = nil)
    title ||= column.titleize
    css_class = (column == sort_column) ? "current #{sort_direction}" : nil
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
  end

    def currency(number)
      number_to_currency(number, :unit => "", :separator => ".", :delimiter => ",")
    end

     def date(date)
     		if date
      		date.strftime("#{date.day.ordinalize} %b '%y")
      	end
    end

     def fulldate(date)
     		if date
      		date.strftime("#{date.day.ordinalize} %b %Y")
      	end
    end

end

