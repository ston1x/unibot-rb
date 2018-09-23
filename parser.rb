module Parser
  @@days_ru = {
    monday: "Понедельник",
    tuesday: "Вторник",
    wednesday: "Среда",
    thursday: "Четверг",
    friday: "Пятница",
    saturday: "Суббота",
    sunday: "Воскресенье"
  }

  def parse_schedule(url)
    response_plain = open(url).read
    response_sub = response_plain.gsub '&quot;', '"'
    response = JSON.parse response_sub
  end

  def prepare_schedule(day)
    response = parse_schedule(ENV['url'])
    classes = []

    response.each do |lesson|
      classes << lesson if lesson["weekday"] == day && !(lesson["name"].empty?)
    end
    
    format_schedule_today(classes, day)
  end

  def format_schedule_today(classes, day)
    day_ru = @@days_ru[day.to_sym]
    schedule = "#{day_ru}\n"
    today_classes = classes.each do |lesson|
      schedule << "#{lesson['index']}) #{lesson['time']} #{lesson['name']} - кабинет #{lesson['room']}, преподаватель #{lesson['teacher']}\n"
    end
    schedule
  end

  def weekend?
    %w[saturday sunday].include? Date.today.strftime("%A").downcase
  end
end
