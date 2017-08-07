defmodule SnlWeb.AccountView do
  use SnlWeb, :view

  def link_to_show(conn, account) do
    link gettext("Show"), to: account_path(conn, :show, account), class: "button is-small"
  end

  def link_to_edit(conn, account) do
    link gettext("Edit"), to: account_path(conn, :edit, account), class: "button is-small"
  end

  def link_to_delete(conn, account) do
    link gettext("Delete"), to:     account_path(conn, :delete, account),
                            method: :delete,
                            data:   [confirm: gettext("Are you sure?")],
                            class:  "button is-small is-danger"
  end
end
