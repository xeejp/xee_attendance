defmodule AttendanceSystem.Main do
  alias AttendanceSystem.Actions

  @pages ["waiting", "description", "experiment", "result"]
  @sequence ["question1", "question2", "answered"]

  def pages, do: @pages
  def sequence, do: @sequence

  def init do
    %{
      page: "waiting",
      participants: %{},
      joined: 0,
      number: [],
      backup: [],
      max: 2, #入力可能時間
      combo: 5, #必要コンボ数
      time: 0,
      seconds: 5,
      answered: 0,
      question_text: %{}
    }
  end

  def new_participant(data) do
    %{
      question_text: data.question_text,
      active: true,
      joined: 1,
      answered: false,
      number: [],
      timestamp: data.time - data.max - 1,
      snum: "",
    }
  end

  def join(data, id) do
    unless Map.has_key?(data.participants, id) do
      new = new_participant(data)
      new = new |> Map.put(:joined, Map.size(data.participants) + 1)
      data = data |> Map.put(:participants, Enum.into(Enum.map(data.participants, fn {id, map} ->
        {id, Map.put(map, :joined, Map.size(data.participants) + 1)}
      end), %{}))
      put_in(data, [:participants, id], new)
      |> Actions.join(id, new)
    else
      data
    end
  end

  def wrap(data) do
    {:ok, %{"data" => data}}
  end
end