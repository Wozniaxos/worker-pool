defmodule WorkerPoolScrap.Test do
  def start do
    2..20
    |> Enum.map(fn i -> async_call_square_root(i) end)
    |> Enum.each(fn task -> await_and_inspect(task) end)
  end

  defp async_call_square_root(page) do
    Task.async(fn ->
      :poolboy.transaction(
        :worker,
        fn pid -> GenServer.call(pid, {:scrap_page, "https://selleo.com/blog/page/#{page}"}) end
      )
    end)
  end

  defp await_and_inspect(task), do: task |> Task.await(5000) |> IO.inspect()
end
