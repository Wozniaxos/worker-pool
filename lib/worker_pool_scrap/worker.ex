defmodule WorkerPoolScrap.Worker do
  use GenServer
  use Hound.Helpers

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil)
  end

  def init(_) do
    {:ok, nil}
  end

  def handle_call({:scrap_page, address}, _from, state) do
    Hound.start_session()
    navigate_to(address)
    element = find_element(:class, "single_blog")
    Hound.end_session()
    {:reply, element, state}
  end
end
