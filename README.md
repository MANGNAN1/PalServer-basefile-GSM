##### VM인스턴스 자동 생성 및 방화벽 포트 자동 추가
##### Cloud Shell 콘솔 링크
https://cloud.google.com/shell?_ga=2.70368912.-1479844828.1707022139&hl=ko

#### Cloud Shell 콘솔에 입력
```
#VM인스턴스 생성

gcloud compute instances create palworld \
    --zone=asia-northeast3-a \
    --machine-type=n2-highmem-4 \
    --image-family=ubuntu-2204-lts \
    --image-project=ubuntu-os-cloud \
    --boot-disk-size=15GB

#기존 방화벽 규칙이 존재하는지 확인

FIREWALL_RULE="palworld"
EXISTING_RULE=$(gcloud compute firewall-rules describe $FIREWALL_RULE --format="value(name)" --project=<YOUR_PROJECT_ID> 2>/dev/null)

if [ -n "$EXISTING_RULE" ]; then

    gcloud compute firewall-rules delete $FIREWALL_RULE --quiet --project=<YOUR_PROJECT_ID>
fi

#새로운 방화벽 규칙 추가

gcloud compute firewall-rules create $FIREWALL_RULE \
    --network=default \
    --direction=INGRESS \
    --action=ALLOW \
    --priority=1000 \
    --rules=tcp:27015,tcp:27016,tcp:25575,udp:27015,udp:27016,udp:25575,udp:8211 \
    --source-ranges=0.0.0.0/0
```
-------------------------------------------------------------------------------------------------------------------

서버관리 패키지
```
curl -sSL https://raw.githubusercontent.com/MANGNAN1/PalServer-basefile-GSM/main/Baseinstall.sh -o ~/Baseinstall.sh

chmod +x ~/Baseinstall.sh

source ~/Baseinstall.sh
```
