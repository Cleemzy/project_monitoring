defmodule PmLoginWeb.ContributorController do
  use PmLoginWeb, :controller

  alias PmLogin.Monitoring
  alias PmLogin.Login
  alias Phoenix.LiveView

  def my_projects(conn, _params) do

    if Login.is_connected?(conn) do
      cond do
        Login.is_contributor?(conn) ->
          # conn
          # |> render("my_projects.html", projects: get_session(conn, :curr_user_id)
          #                                         |> Monitoring.list_projects_by_contributor,
          #                               layout: {PmLoginWeb.LayoutView, "contributor_layout.html"})
          LiveView.Controller.live_render(conn, PmLoginWeb.Project.ContributorProjectsLive, session: %{"projects" => get_session(conn, :curr_user_id) |> Monitoring.list_projects_by_contributor,"curr_user_id" => Login.get_curr_user(conn).id}, router: PmLoginWeb.Router)
        true ->
          conn
            |> Login.not_contributor_redirection
      end
    else
      conn
      |> Login.not_connected_redirection
    end

  end

end
