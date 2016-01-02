module ApplicationHelper

   def sortable(column, title = nil)
    title ||= column.titleize
    css_class = (column == sort_column) ? "current #{sort_direction}" : nil
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
  end

    def currency(number, string, space = 0)
      if space == 1 
        if string == "EUR" 
          number_to_currency(number, :unit => "€ ", :separator => ".", :delimiter => ",")
        else
          number_to_currency(number, :unit => "£ ", :separator => ".", :delimiter => ",")
        end
      else
        if string == "EUR" 
          number_to_currency(number, :unit => "€", :separator => ".", :delimiter => ",")
        else
          number_to_currency(number, :unit => "£", :separator => ".", :delimiter => ",")
        end
      end
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
