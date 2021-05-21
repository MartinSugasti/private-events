class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :owner_user?, only: [:edit, :update, :destroy]
  before_action :possible_guests, only: [:new, :edit]

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
    @invitation = @event.invitations.find_by(guest_id: current_user&.id)
  end

  def new
    @event = current_user.created_events.new
  end

  def create
    @event = current_user.created_events.new(event_params)

    if @event.save
      @event.manage_invitations(invitations_params[:invitations][:guest_ids])

      redirect_to event_path(@event), notice: 'Event was successfully created.'
    else
      possible_guests

      render :new
    end
  end

  def edit
    @event = current_user.created_events.find(params[:id])
  end

  def update
    if @event.update(event_params)
      @event.manage_invitations(invitations_params[:invitations][:guest_ids])

      redirect_to event_path(@event), notice: 'Event was successfully updated.'
    else
      possible_guests

      render :edit
    end
  end

  def destroy
    @event.destroy
  end

  private

  def event_params
    params.require(:event).permit(:title, :location, :start_at, :description)
  end

  def invitations_params
    params.require(:event).permit(invitations: [guest_ids: []])
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def possible_guests
    @guests = User.where.not(id: current_user.id)
  end

  def owner_user?
    return if current_user.id.equal?(@event.creator.id)

    flash[:alert] = 'You do not have authorization to edit this event'
    redirect_to root_path
  end
end
