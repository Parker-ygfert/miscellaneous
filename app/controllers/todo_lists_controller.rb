# frozen_string_literal: true

class TodoListsController < ApplicationController
  before_action :authenticate_user!

  def index
    todo_lists
  end

  def new
    build_todo_list
  end

  def create
    build_todo_list
    save_todo_list || redirect_with_error(:new)
  end

  def edit
    todo_list
  end

  def update
    todo_list
    save_todo_list || redirect_with_error(:edit)
  end

  def destroy
    todo_list
    @todo_list.destroy && back_to_index
  end

  private

  def todo_list_scope
    current_user.todo_lists
  end

  def todo_lists
    @todo_lists ||= todo_list_scope
  end

  def todo_list
    @todo_list ||= todo_list_scope.find params[:id]
  end

  def build_todo_list
    @todo_list ||= todo_list_scope.new(todo_list_params)
  end

  def save_todo_list
    @todo_list.attributes = todo_list_params
    @todo_list.save && back_to_index
  end

  def todo_list_params
    fields = %i[title routine]
    params[:todo_list]&.permit(*fields) || @todo_list&.slice(*fields)
  end

  def back_to_index
    redirect_to todo_lists_path
  end

  def redirect_with_error(action)
    p '-' * 50
    payload = todo_list_params.merge(
      action: action,
      errors: @todo_list.errors.full_messages
    )
    redirect_to(payload)
  end
end
