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
      next if lesson["name"].empty?
      classes << lesson if lesson["day"] == day
    end

    return "Пар нет, но лучше проверьте в источнике" if classes.empty? 
    format_schedule(classes, day)
  end

  def format_schedule(classes, day)
    day_ru = @@days_ru[day.to_sym]
    schedule = "#{day_ru}\n"
    today_classes = classes.each_with_index do |lesson, index|
      time_start = lesson["time_start"]
      time_end = lesson["time_end"]
      name = lesson["name"]
      room = lesson["room"]
      teacher = lesson["teacher"]
      schedule << "#{index + 1}) #{time_start}-#{time_end} #{name} - кабинет #{room}, преподаватель #{teacher}\n"
    end
    schedule
  end

  def weekend?
    %w[sunday].include? Date.today.strftime("%A").downcase
  end

  def identify_teacher

  end

  def classes_exist?
    
  end

end

