class InvitationsController < ApplicationController
  def update
    @invitation = Invitation.find(params[:id])

    if @invitation.update(invitation_params)
      redirect_to event_path(@invitation.event), notice: 'Invitation was successfully updated.'
    else
      redirect_to event_path(@invitation.event), notice: 'Invitation could not been updated.'
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:status)
  end
end
