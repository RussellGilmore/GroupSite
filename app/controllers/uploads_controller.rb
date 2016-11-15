class UploadsController < ApplicationController
  def index
    @upload = Upload.new
  end

  def create
    @upload = Upload.new(upload_params)
    # upload status:200 means no error returned
    # upload status:400 means error returned
    if @upload.save
      render json: { message: "success", uploadId: @upload.id }, status: 200
    else
      render json: { error: @upload.errors.full_message.join(", ") }, status: 400
    end
  end

  private
    def upload_params
      params.require(:upload).permit
    end

end
