class LogsController < ApplicationController
    def new
        @log = current_user.logs.build
    end
    
    def create
        @log = current_user.logs.build(log_params)
        
        if @log.save
            redirect_to log_path, notice: '성장 기록이 저장되었습니다!'
        else
            render :new, status: :unprocessable_entity
        end
    end

    private

    def log_params
        params.require(:log).permit(:logged_on, :content, :growth_stage, :is_healthy, :pla, :image)
    end
end