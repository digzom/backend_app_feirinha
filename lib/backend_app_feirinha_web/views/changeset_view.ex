defmodule BackendAppFeirinhaWeb.ChangesetView do
  use BackendAppFeirinhaWeb, :view
  import Ecto.Changeset, only: [traverse_errors: 2]

  @doc """
  Traverses and translates changeset errors.

  See `Ecto.Changeset.traverse_errors/2` and
  `BackendAppFeirinhaWeb.ErrorHelpers.translate_error/1` for more details.
  """
  defp translate_errors(changeset) do
    # seria bom tentar entender isso aqui
    traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end

  def render("error.json", %{changeset: changeset}) do
    # When encoded, the changeset returns its errors
    # as a JSON object. So we just pass it forward.
    %{errors: translate_errors(changeset)}
  end
end
