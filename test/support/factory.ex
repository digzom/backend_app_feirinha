defmodule BackendAppFeirinha.Factory do
  use ExMachina.Ecto, repo: BackendAppFeirinha.Repo

  def list_factory do
    %BackendAppFeirinha.Lists.List{
      name: sequence(:name, &"list #{&1}")
    }
  end
end
