module ApplicationHelper
  def dateBR(datetime)
    datetime.in_time_zone('America/Sao_Paulo').strftime('%d/%m/%Y %H:%M')
  end
end
