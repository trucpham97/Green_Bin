module UsersHelper
  def rank_class(index)
    case index
    when 0
      'gold'
    when 1
      'silver'
    when 2
      'bronze'
    else
      ''
    end
  end
end
