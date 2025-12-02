### 1. 치톤피드
![logo.png](https://github.com/SeSAC-9rown/chytonpide-web/blob/main/Frame%20(1)%201.png)

### 2. 프로젝트 소개
- 은둔 청년 독거 노인 등 사회적 단절감을 느끼는 사람들을 위한 반려식물 AIoT 프로젝트

### 3. 주요 기능
![feature](https://github.com/SeSAC-9rown/chytonpide-web/blob/main/Figma%201.png)

- 실시간 음성 대화
- 음성 기반 하드웨어 제어
- 식물 질병 여부 예측
- 식물 성장 단계 예측

### 4. 기술 스택

| 구분 | 기술 |
|------|------|
| **Fullstack** | Ruby on Rails 8.1.1 |
| **Database** | PostgreSQL |
| **배포** | Docker + Azure |

### 5. 시스템 아키텍처



### 7. API 엔드포인트
#### Pages

| Method | Endpoint | Helper      | Controller#Action | Login Required | View Required |
| ------ | -------- | ----------- | ----------------- | -------------- | ------------- |
| GET    | /        | root_path   | pages#home        | O              | O             |
| GET    | /log     | log_path    | pages#log         | O              | O             |
| GET    | /mypage  | mypage_path | pages#mypage      | O              | O             |

#### Health

| Method | Endpoint | Helper                  | Controller#Action | Login Required | View Required |
| ------ | -------- | ----------------------- | ----------------- | -------------- | ------------- |
| GET    | /up      | rails_health_check_path | rails/health#show | X              | X             |

#### Sessions

| Method | Endpoint                     | Helper      | Controller#Action | Login Required | View Required |
| ------ | ---------------------------- | ----------- | ----------------- | -------------- | ------------- |
| GET    | /login                       | login_path  | sessions#new      | X              | O             |
| GET    | /auth/google_oauth2/callback | -           | sessions#create   | X              | X             |
| DELETE | /logout                      | logout_path | sessions#destroy  | O              | X             |

#### Users

| Method | Endpoint        | Helper                | Controller#Action | Login Required | View Required |
| ------ | --------------- | --------------------- | ----------------- | -------------- | ------------- |
| GET    | /users/new      | new_user_path         | users#new         | O              | O             |
| POST   | /users          | users_path            | users#create      | O              | X             |
| GET    | /users/:id/edit | edit_user_path(@user) | users#edit        | O              | O             |
| PATCH  | /users/:id      | user_path(@user)      | users#update      | O              | X             |
| DELETE | /users/:id      | -                     | users#destroy     | O              | X             |

#### Device

| Method | Endpoint                    | Helper                       | Controller#Action | Login Required | View Required |
| ------ | --------------------------- | ---------------------------- | ----------------- | -------------- | ------------- |
| GET    | /users/:user_id/device/new  | new_user_device_path(@user)  | device#new        | O              | O             |
| POST   | /users/:user_id/device      | -                            | device#create     | O              | X             |
| GET    | /users/:user_id/device/edit | edit_user_device_path(@user) | device#edit       | O              | O             |
| PATCH  | /users/:user_id/device      | user_device_path(@user)      | device#update     | O              | X             |
| DELETE | /users/:user_id/device      | -                            | device#destroy    | O              | X             |

#### Devices (아두이노용)

| Method | Endpoint             | Helper | Controller#Action | Login Required | View Required |
| ------ | -------------------- | ------ | ----------------- | -------------- | ------------- |
| GET    | /devices/:serial/led | -      | devices#led       | X              | X             |
| GET    | /devices/:serial/lcd | -      | devices#lcd       | X              | X             |
| PATCH  | /devices/:serial     | -      | devices#update    | X              | X             |

#### Kit

| Method | Endpoint                        | Helper                           | Controller#Action | Login Required | View Required |
| ------ | ------------------------------- | -------------------------------- | ----------------- | -------------- | ------------- |
| GET    | /users/:user_id/device/kit/new  | new_user_device_kit_path(@user)  | kits#new          | O              | O             |
| POST   | /users/:user_id/device/kit      | -                                | kits#create       | O              | X             |
| GET    | /users/:user_id/device/kit/edit | edit_user_device_kit_path(@user) | kits#edit         | O              | O             |
| PATCH  | /users/:user_id/device/kit      | user_device_kit_path(@user)      | kits#update       | O              | X             |
| DELETE | /users/:user_id/device/kit      | -                                | kits#destroy      | O              | X             |

#### Logs

| Method | Endpoint                      | Helper                          | Controller#Action | Login Required | View Required |
| ------ | ----------------------------- | ------------------------------- | ----------------- | -------------- | ------------- |
| GET    | /users/:user_id/logs/new      | new_user_log_path(@user)        | logs#new          | O              | O             |
| POST   | /users/:user_id/logs          | -                               | logs#create       | O              | X             |
| GET    | /users/:user_id/logs/:id/edit | edit_user_log_path(@user, @log) | logs#edit         | O              | O             |
| PATCH  | /users/:user_id/logs/:id      | user_log_path(@user, @log)      | logs#update       | O              | X             |
| DELETE | /users/:user_id/logs/:id      | -                               | logs#destroy      | O              | X             |

#### Sensor Data

| Method | Endpoint     | Helper | Controller#Action  | Login Required | View Required |
| ------ | ------------ | ------ | ------------------ | -------------- | ------------- |
| POST   | /sensor_data | -      | sensor_data#create | X              | X             |

### 8. 모델


	- **User**
		- email | provider | uid | name | avatar_url | social_avatar_url
		- *string* | *string* | *string* | *string* | *string* | *string*
	

	- **Device**
		- user | serial | model | led_mode | is_led_on | lcd_face
		- *references* | *string* | *string* | *string* | *boolean* | *string*
	

	- **Kit**
		- device | kind | name | planted_at | watering_interval_days | fertilizer_interval_days
		- *references* | *string* | *string* | *date* | *integer* | *integer*

	- **Log**
		- user | logged_on | content | growth_stage | is_healthy | pla
		- *references* | *date* | *text* | *string* | *boolean* | *decimal*

	- **SensorDatum**
		- serial | temperature | humidity | illuminance
		- *string* | *float* | *float* | *float*

### 9. 개발 환경 실행

```
$env:RAILS_ENV="development"
```

```
rails server
```
