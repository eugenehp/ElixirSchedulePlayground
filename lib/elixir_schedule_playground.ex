defmodule Schedule do
  @derive [Poison.Encoder]
  defstruct [:monday,:tuesday,:wednesday,:thursday,:friday,:saturday,:sunday]
end

defmodule ElixirSchedulePlayground do

  def test(input \\ "{\"tuesday\":[\"0:10-4:33\",\"11:10-23:59\"],\"thursday\":[\"2:20-4:50\",\"18:01-20:59\"],\"sunday\":[\"0:00-24:00\"]}") do
    
    today_name = String.downcase Timex.Date.day_name Timex.Date.weekday Timex.Date.local

    json  = Poison.decode!(input)
    schedule = json[today_name]
    iterate(schedule)
  end

  def iterate([head|tail]) do
    [from,to] = String.split head, "-"
    [from_hour,from_minute] = String.split from, ":"
    [to_hour,to_minute] = String.split to, ":"

    from_date = to_date(from_hour,from_minute)
    to_date = to_date(to_hour,to_minute)
    now = Timex.Date.now

    # date_format = "{YYYY}-{M}-{D}"
    date_format = "{ISOz}"
    {_,now_str} = Timex.DateFormat.format(now, date_format)
    {_,from_str} = Timex.DateFormat.format(from_date, date_format)
    {_,to_str} = Timex.DateFormat.format(to_date, date_format)

    # IO.puts "#{now_str}: From #{from_str} to #{to_str}"

    # from_date <= now <= to_date
    from_date_now = Timex.Date.compare from_date, now
    now_to_date = Timex.Date.compare now, to_date

    case {from_date_now,now_to_date} do
      {-1,-1} ->
        :true # IO.puts "#{now_str} is in between"
      {0,-1} ->
        :true # IO.puts "#{now_str} is the `from`"
      {-1,0} ->
        :true # IO.puts "#{now_str} is the `to`"
      _ ->
        # :false # IO.puts "none of above"
        if tail do
          iterate(tail)
        end
    end
    
  end

  def iterate(nil) do
    :false
  end

  def iterate([]) do
    :false
  end

  def to_date(hours,minutes) do
    today = {Timex.Date.now.year,Timex.Date.now.month,Timex.Date.now.day }
    {h,_} = Integer.parse(hours)
    {m,_} = Integer.parse(minutes)
    time = {h, m, 0}
    Timex.Date.from({today, time},:utc)
  end

end
