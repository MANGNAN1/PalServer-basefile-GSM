# 함수 정의: Manual 출력
Manual() {
  echo -e "\e[96m╔════════════════════════════════════════╗\e[0m"
  echo -e "\e[96m║  입력 가능한 명령어                    ║\e[0m"
  echo -e "\e[96m║  \e[92m서버시작                              ║\e[0m"
  echo -e "\e[96m║  \e[91m서버종료                              ║\e[0m"
  echo -e "\e[96m║  \e[93m서버리붓                              ║\e[0m"
  echo -e "\e[96m║  \e[98m서버복구                              ║\e[0m"  
  echo -e "\e[96m║  \e[94m업데이트                              ║\e[0m"
  echo -e "\e[96m║  \e[95m예약                                  ║\e[0m"
  echo -e "\e[96m╚════════════════════════════════════════╝\e[0m"
}

# 예약 함수
Reserve() {

#예약 설명서 에코
    echo -e "\e[96m╔══════════════════════════════════════════════╗\e[0m"
    echo -e "\e[96m║  자동백업 예약을 추가하려면 '1'              ║\e[0m"    
    echo -e "\e[96m║  자동리붓 예약을 추가하려면 '2'              ║\e[0m"
    echo -e "\e[96m║  모든 예약을 제거하려면 '3'                  ║\e[0m"
    echo -e "\e[96m║  예약 리스트를 보시려면 '4'                  ║\e[0m"
    echo -e "\e[96m║  취소하려면 'c'                              ║\e[0m"
    echo -e "\e[96m╚══════════════════════════════════════════════╝\e[0m"

# 사용자로부터 입력 받기
read -p "명령어를 입력하세요: " action

if [ "$action" == "1" ]; then

    # 사용자명을 동적으로 가져와 변수에 저장
    USERNAME=$(whoami)

    # 사용자의 홈 디렉토리 경로를 변수에 저장
    USER_HOME="/home/$USERNAME"
    
    # 존재하는 크론탭 내용을 가져와 변수에 저장
    EXISTING_CRONTAB=$(crontab -l 2>/dev/null)

    # 삭제할 크론탭 예약을 포함한 문자열
    TARGET_CRON="Save"
    
    # 새로운 크론탭 예약을 추가할 표현식
    NEW_CRONTAB="$USER_HOME/Save.sh >> $USER_HOME/logfile.log 2>&1"

    echo -e "\e[96m╔═══════════════════════════════════════════════════════════╗\e[0m"
    echo -e "\e[96m║ \e[93m* * * * *  실행할 명령어                                  ║\e[0m"
    echo -e "\e[96m║                                                           ║\e[0m"
    echo -e "\e[96m║ \e[92m┌───────────────────── 분 (0 - 59)                        ║\e[0m"
    echo -e "\e[96m║ \e[92m│ ┌─────────────────── 시 (0 - 23)                        ║\e[0m"
    echo -e "\e[96m║ \e[92m│ │ ┌───────────────── 일 (1 - 31)                        ║\e[0m"
    echo -e "\e[96m║ \e[92m│ │ │ ┌─────────────── 월 (1 - 12)                        ║\e[0m"
    echo -e "\e[96m║ \e[92m│ │ │ │ ┌───────────── 요일 (0 - 6)                       ║\e[0m"
    echo -e "\e[96m║ \e[92m│ │ │ │ │                                                 ║\e[0m"
    echo -e "\e[96m║ \e[92m* * * * * │                                               ║\e[0m"
    echo -e "\e[96m║ \e[92mEX) 0 */12 * * * = 00시 기준 12시간마다 저장 00시 12시    ║\e[0m"    
    echo -e "\e[96m║ \e[92mEX) 0 */8 * * * = 00시 기준 8시간마다 저장 00시 8시 16시  ║\e[0m"  
    echo -e "\e[96m║ \e[92mEX) 0 * * * * = 매시 0분 마다 저장                        ║\e[0m"   
    echo -e "\e[96m║ \e[92mEX) 0,30 * * * * = 매시 0분, 30분 마다 저장               ║\e[0m"      
    echo -e "\e[96m╚═══════════════════════════════════════════════════════════╝\e[0m" 
    
    # 사용자로부터 cron 표현식 입력 받기
    read -p "Cron 표현식을 입력하세요 (EX: 0,30 * * * *): " cron_expression

# 기존 크론탭에 삭제할 예약이 있는지 확인
if [[ -n "$EXISTING_CRONTAB" && "$EXISTING_CRONTAB" == *"$TARGET_CRON"* ]]; then
    # 삭제할 예약이 포함된 줄을 크론탭에서 제외하고 설정
    (echo "$EXISTING_CRONTAB" | grep -v "$TARGET_CRON") | crontab -
    #echo "기존에 존재하던 리붓 예약이 삭제되었습니다."
  	(crontab -l ; echo "$cron_expression $NEW_CRONTAB") | crontab -
  	echo "백업 예약이 추가되었습니다."	
else
  	(crontab -l ; echo "$cron_expression $NEW_CRONTAB") | crontab -
  	echo "백업 예약이 추가되었습니다."
fi

elif [ "$action" == "2" ]; then

    # 사용자명을 동적으로 가져와 변수에 저장
    USERNAME=$(whoami)

    # 사용자의 홈 디렉토리 경로를 변수에 저장
    USER_HOME="/home/$USERNAME"
    
    # 존재하는 크론탭 내용을 가져와 변수에 저장
    EXISTING_CRONTAB=$(crontab -l 2>/dev/null)

    # 삭제할 크론탭 예약을 포함한 문자열
    TARGET_CRON="Restart"
    
    # 새로운 크론탭 예약을 추가할 표현식
    NEW_CRONTAB="./pwserver Restart >> $USER_HOME/logfile.log 2>&1"

    echo -e "\e[96m╔═══════════════════════════════════════════════════════════╗\e[0m"
    echo -e "\e[96m║ \e[93m* * * * *  실행할 명령어                                  ║\e[0m"
    echo -e "\e[96m║                                                           ║\e[0m"
    echo -e "\e[96m║ \e[92m┌───────────────────── 분 (0 - 59)                        ║\e[0m"
    echo -e "\e[96m║ \e[92m│ ┌─────────────────── 시 (0 - 23)                        ║\e[0m"
    echo -e "\e[96m║ \e[92m│ │ ┌───────────────── 일 (1 - 31)                        ║\e[0m"
    echo -e "\e[96m║ \e[92m│ │ │ ┌─────────────── 월 (1 - 12)                        ║\e[0m"
    echo -e "\e[96m║ \e[92m│ │ │ │ ┌───────────── 요일 (0 - 6)                       ║\e[0m"
    echo -e "\e[96m║ \e[92m│ │ │ │ │                                                 ║\e[0m"
    echo -e "\e[96m║ \e[92m* * * * * │                                               ║\e[0m"
    echo -e "\e[96m║ \e[92mEX) 0 */12 * * * = 00시 기준 12시간마다 저장 00시 12시    ║\e[0m"    
    echo -e "\e[96m║ \e[92mEX) 0 */8 * * * = 00시 기준 8시간마다 저장 00시 8시 16시  ║\e[0m"  
    echo -e "\e[96m║ \e[92mEX) 0 * * * * = 매시 0분 마다 저장                        ║\e[0m"   
    echo -e "\e[96m║ \e[92mEX) 0,30 * * * * = 매시 0분, 30분 마다 저장               ║\e[0m"      
    echo -e "\e[96m╚═══════════════════════════════════════════════════════════╝\e[0m"    
    
    # 사용자로부터 cron 표현식 입력 받기
    read -p "Cron 표현식을 입력하세요 (EX: 0 */12 * * *): " cron_expression

# 기존 크론탭에 삭제할 예약이 있는지 확인
if [[ -n "$EXISTING_CRONTAB" && "$EXISTING_CRONTAB" == *"$TARGET_CRON"* ]]; then
    # 삭제할 예약이 포함된 줄을 크론탭에서 제외하고 설정
    (echo "$EXISTING_CRONTAB" | grep -v "$TARGET_CRON") | crontab -
    #echo "기존에 존재하던 리붓 예약이 삭제되었습니다."
  	(crontab -l ; echo "$cron_expression $NEW_CRONTAB") | crontab -
  	echo "리붓 예약이 추가되었습니다."	

else
  	(crontab -l ; echo "$cron_expression $NEW_CRONTAB") | crontab -
  	echo "리붓 예약이 추가되었습니다."
fi
    
elif [ "$action" == "3" ]; then
    #Crontab list
    crontab -r
    echo "작업이 제거되었습니다."

elif [ "$action" == "4" ]; then
    crontab -l

elif [[ "$action" == "ㅊ" || "$action" == "c" ]]; then
    return 0
else
    echo "올바른 명령을 입력하세요."
fi
}

# 파일 저장 함수
Save() {
SAVE_DIR="$HOME/backup/saved"
MAX_BACKUPS=30

if [ ! -d "$SAVE_DIR" ]; then
    mkdir -p "$SAVE_DIR" || { echo -e "\e[91m디렉터리 생성 실패: $SAVE_DIR\e[0m"; exit 1; }
fi

# 사용자명을 동적으로 가져와 변수에 저장
USERNAME=$(whoami)

# 사용자의 홈 디렉토리 경로를 변수에 저장
USER_HOME="/home/$USERNAME"

# 현재 날짜와 시간으로 저장 파일명 설정 (월일시간분)
SAVE_NAME="$(date +%m%d%H%M).tar.gz"
SAVE_PATH="$SAVE_DIR/$SAVE_NAME"
FOLDER_PATH="$USER_HOME/serverfiles/Pal/Saved"

# 폴더 압축과 에러 로그 기록
tar -czf "$SAVE_PATH" "$FOLDER_PATH"

if [ $? -eq 0 ]; then
    echo -e "\e[32m저장이 완료되었습니다: $SAVE_PATH\e[0m"

    # 저장 폴더와 하위 폴더에 모든 권한 부여
    chmod -R 777 "$SAVE_DIR" || { echo -e "\e[91m권한 변경 실패: $SAVE_DIR\e[0m"; exit 1; }

    # 백업 데이터 개수가 MAX_BACKUPS를 넘으면 가장 오래된 데이터 삭제
    while [ $(ls -1 "$SAVE_DIR" | grep -c '.tar.gz') -gt $MAX_BACKUPS ]; do
        OLDEST_FILE=$(ls -1t "$SAVE_DIR" | grep '.tar.gz' | tail -n 1)
        rm -f "$SAVE_DIR/$OLDEST_FILE"
        echo -e "\e[33m가장 오래된 백업 데이터 삭제: $OLDEST_FILE\e[0m"
    done
    
else
    echo -e "\e[91m저장 중 오류가 발생했습니다. 로그를 확인하세요: $HOME/backup/error.log\e[0m"
    exit 1
fi
}

# 서버 구동 확인
Servercheck() {

# 찾고자 하는 프로세스의 이름
process_name="PalServer-Linux-Test"

# ps 명령어로 프로세스 확인하고 grep으로 검색
if ps aux | grep -v grep | grep "$process_name" > /dev/null
then
    echo "서버가 구동중입니다."
else
    echo "서버가 구동중이지 않습니다."
    echo ""
fi
}

# 서버 백업데이터 복구
Restore() {

# 설명서
echo -e "\e[96m╔═════════════════════════════════════════════════════════════════════╗\e[0m"
echo -e "\e[96m║\e[1m 서버 데이터 복구 작업 전 설명드립니다. \e[0m                             \e[96m║\e[0m"
echo -e "\e[96m║\e[1m 서버 데이터 복구 시 반드시 서버가 OFF상태여야합니다.\e[0m                \e[96m║\e[0m"
echo -e "\e[96m║                                                                     \e[96m║\e[0m"
echo -e "\e[96m║\e[1m 현재 보관 중인 상위 5개의 백업 데이터 리스트를 확인합니다.         \e[0m \e[96m║\e[0m"
echo -e "\e[96m║\e[1m EX) 02041546.tar.gz \e[0m                                                \e[96m║\e[0m"
echo -e "\e[96m║\e[1m 원하시는 날짜 EX) 02041546 를 입력하시면 그 데이터로 복구을 합니다.\e[0m \e[96m║\e[0m"
echo -e "\e[96m╚═════════════════════════════════════════════════════════════════════╝\e[0m"

# 찾고자 하는 프로세스의 이름
process_name="PalServer-Linux-Test"

# ps 명령어로 프로세스 확인하고 grep으로 검색
if ps aux | grep -v grep | grep "$process_name" > /dev/null
then
    echo "서버가 구동중입니다. 복구 시스템을 종료합니다."
    return 1    
else
    echo "서버가 구동중이지 않습니다. 복구 시스템을 계속 진행합니다."
    echo ""
fi

# 사용자명을 동적으로 가져와 변수에 저장
USERNAME=$(whoami)

# 사용자의 홈 디렉토리 경로를 변수에 저장
USER_HOME="/home/$USERNAME"

BACKUP_DIR="$USER_HOME/backup/saved"

# 최신 5개의 파일 리스트 표시
echo "최신 5개의 복구 데이터 리스트:"
ls -t "$BACKUP_DIR" | head -n 5

# 사용자로부터 날짜 입력 받기
read -p "복구할 데이터의 날짜를 입력하세요 (MMDDHHMM): " restore_date

# 입력 받은 날짜에 해당하는 복구 데이터 찾기
restore_file="$BACKUP_DIR/$restore_date.tar.gz"

# 복구 데이터가 존재하는지 확인
if [ -f "$restore_file" ]; then
    # 복구 작업 수행
    echo "선택한 날짜의 복구 데이터를 찾았습니다. 복구을 시작합니다..."
    # 복구 명령어를 여기에 추가
    tar -xzf "$restore_file" -C /
    sleep 2
    echo "복구완료."
else
    echo "해당 날짜의 복구 데이터를 찾을 수 없습니다. 복구을 종료합니다."
fi
}

# 구동기 삭제
Delete() {
    # 사용자에게 y 또는 n으로 답변을 받는 함수
    ask_yes_no() {
        while true; do
            read -p "$1 (y/n): " answer
            case $answer in
                [Yy]* ) return 0;;  # 사용자가 y로 응답
                [Nn]* ) return 1;;  # 사용자가 n으로 응답
                * ) echo "y 또는 n으로 답하세요.";;
            esac
        done
    }
    # 사용자에게 y 또는 n으로 묻기
    if ask_yes_no "작업을 진행하시겠습니까?"; then
        rm ~/Save.sh
        rm ~/logfile.log
        rm ~/Function.sh
        rm ~/Baseinstall.sh
    else
        return 1
    fi      
}
