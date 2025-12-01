class PagesController < ApplicationController
	before_action :require_login
	
	def home
		@device = current_user.device
	end
	  
	
	def log
		# 파라미터로 날짜가 넘어오면 그 날짜, 아니면 오늘 날짜
		@date = params[:date] ? Date.parse(params[:date]) : Date.today
		@first_day    = @date.beginning_of_month
		@last_day     = @date.end_of_month
		@start_wday   = @first_day.wday          # 0=일, 1=월 ...
		@days_in_month = @last_day.day
		
		# 해당 날짜의 로그 가져오기
		@log = Log.find_by(logged_on: @date)
		
		# 이전/다음 날짜 계산
		@prev_date = @date - 1.day
		@next_date = @date + 1.day
		
		# 다음 날짜가 미래면 버튼 비활성화용
		@is_future = @next_date > Date.today
	end
	
	def mypage; end
end