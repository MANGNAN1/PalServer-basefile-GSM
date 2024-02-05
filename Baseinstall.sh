#!/bin/bash
clear
# 사용자의 홈 디렉토리로 이동합니다.
cd "$HOME" || exit

# 사용자명을 동적으로 가져와 변수에 저장
USERNAME=$(whoami)

# 사용자의 홈 디렉토리 경로를 변수에 저장
USER_HOME="/home/$USERNAME"

echo -e "\e[32m베이스 파일들을 설치합니다.\e[0m"

curl -o Function.sh -O https://raw.githubusercontent.com/MANGNAN1/PalServer-basefile-GSM/main/Function.sh
curl -o Save.sh -O https://raw.githubusercontent.com/MANGNAN1/PalServer-basefile-GSM/main/Save.sh

echo -e "\e[32m완료.\e[0m"

#실행권한 획득
chmod +x $USER_HOME/Function.sh $USER_HOME/Save.sh

# dos2unix 설치 여부 확인
if command -v dos2unix &> /dev/null; then
    echo "dos2unix가 이미 설치되어 있습니다. 넘어갑니다."
else
    # dos2unix 설치
    echo "dos2unix를 설치합니다."
    sudo apt-get update
    sudo apt-get install dos2unix
    echo "dos2unix 설치가 완료되었습니다."
fi

#윈도우sh -> 리눅스sh 변환
echo -e "\e[32msh 파일 변환을 실행합니다.\e[0m"
dos2unix $USER_HOME/Function.sh
dos2unix $USER_HOME/Save.sh
echo -e "\e[32m완료.\e[0m"

#명령어 한글화
# .bashrc 파일에서 명령어 갱신
update_bashrc() {
    # .bashrc 파일 경로
    bashrc_path="$HOME/.bashrc"

    # 기존 명령어 삭제
    sed -i '/# 명령어 한글화/,/# 완료./d' "$bashrc_path"

    # 추가할 내용
    append_text="# 명령어 한글화
    alias 서버시작='./pwserver start'
    alias 서버종료='./pwserver stop'
    alias 서버리붓='./pwserver restart'
    alias 서버확인='source $USER_HOME/Function.sh && Servercheck'
    alias 업데이트='./pwserver update'
    alias 사용법='source $USER_HOME/Function.sh && Manual'
    alias 저장='source $USER_HOME/Function.sh && Save'
    alias 예약='source $USER_HOME/Function.sh && Reserve'
    alias 서버복구='source $USER_HOME/Function.sh && Restore'
    alias 삭제='source $USER_HOME/Function.sh && Delete'
    # 완료.
    "

    # 파일 끝에 내용 추가
    echo "$append_text" >> "$bashrc_path"
    echo -e "\e[32m갱신되었습니다.\e[0m"

    # 변경사항 즉시 적용
    source "$bashrc_path"
}

# 함수 실행
update_bashrc

#새로고침
source ~/.bashrc

sudo timedatectl set-timezone Asia/Seoul

sleep 3
clear

echo -e "\e[32m패키지 다운로드를 완료하였습니다.\e[0m"
echo -e " "
echo -e "\e[32m사용법을 입력하시면 사용가능한 명령어가 나옵니다.\e[0m"
