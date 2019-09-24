defmodule LiveViewDemo.Kanban do
  import Ecto.Query

  alias LiveViewDemo.Repo
  alias LiveViewDemo.Kanban.{Board, Stage, Card, Position}

  def get_board!(id) do
    stage_query =
      from s in Stage,
        order_by: s.position,
        preload: [
          cards:
            ^from(c in Card,
              order_by: :position
            )
        ]

    Board
    |> preload(stages: ^stage_query)
    |> Repo.get!(id)
  end

  def create_board(attrs) do
    %Board{}
    |> Board.changeset(attrs)
    |> Repo.insert()
  end

  def create_stage(attrs) do
    %Stage{}
    |> Stage.create_changeset(attrs)
    |> Repo.insert()
  end

  def create_card(attrs) do
    %Card{}
    |> Card.create_changeset(attrs)
    |> Repo.insert()
  end
end