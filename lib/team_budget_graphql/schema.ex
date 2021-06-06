defmodule TeamBudgetGraphql.Schema do
  @moduledoc """
  API schemas
  """
  use Absinthe.Schema
  alias TeamBudgetGraphql.Resolvers
  alias TeamBudgetGraphql.Middlewares
  alias TeamBudget.Teams.Data.Team

  import_types(TeamBudgetGraphql.Types)

  import AbsintheErrorPayload.Payload
  import_types(AbsintheErrorPayload.ValidationMessageTypes)

  payload_object(:user_payload, :user)
  payload_object(:login_payload, :session)

  query do
    @desc "Get list of all users"
    field :list_users, list_of(:user) do
      middleware(Middlewares.Authorize, :user)
      resolve(&Resolvers.UserResolver.list_users/3)
    end

    @desc "Get list of all teams from an User"
    field :list_teams, list_of(:team) do
      middleware(Middlewares.Authorize, :user)
      resolve(&Resolvers.TeamResolver.list_teams/3)
    end
  end

  mutation do
    @desc "Create new user"
    field :create_user, :user_payload do
      arg(:user, non_null(:user_input))
      resolve(&Resolvers.UserResolver.create_user/3)
      middleware(&build_payload/2)
    end

    @desc "User sign in with JWT"
    field :login, :login_payload do
      arg(:user, non_null(:login_input))
      resolve(&Resolvers.SessionResolver.login/3)
      middleware(&build_payload/2)
    end

    @desc "Send invite"
    field :send_invite, list_of(:invite) do
      arg(:invites, non_null(list_of(:string)))
      middleware(Middlewares.Authorize, :user)
      middleware(Middlewares.SetTeam)
      resolve(&Resolvers.InviteResolver.send_invite/3)
    end
  end

  def context(context) do
    loader = Dataloader.new() |> Dataloader.add_source(Team, Team.data())
    Map.put(context, :loader, loader)
  end

  def plugins, do: [Absinthe.Middleware.Dataloader | Absinthe.Plugin.defaults()]
end
