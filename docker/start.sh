#!/bin/bash

# 색상 정의
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}==================================================${NC}"
echo -e "${BLUE}  PostgreSQL Docker 서버 시작${NC}"
echo -e "${BLUE}==================================================${NC}"

# docker 디렉토리로 이동
cd "$(dirname "$0")"

# init 디렉토리 생성 (없으면)
if [ ! -d "init" ]; then
    mkdir -p init
    echo -e "${YELLOW}init 디렉토리가 생성되었습니다.${NC}"
fi

# Docker Compose로 서비스 시작
echo -e "\n${GREEN}Docker 컨테이너 시작 중...${NC}"
docker-compose up -d

# 서비스 상태 확인
echo -e "\n${GREEN}서비스 상태 확인 중...${NC}"
sleep 3
docker-compose ps

echo -e "\n${BLUE}==================================================${NC}"
echo -e "${GREEN}✅ PostgreSQL 서버가 성공적으로 시작되었습니다!${NC}"
echo -e "${BLUE}==================================================${NC}"
echo -e "\n${YELLOW}📌 접속 정보:${NC}"
echo -e "   PostgreSQL:"
echo -e "     - Host: ${GREEN}localhost${NC}"
echo -e "     - Port: ${GREEN}5432${NC}"
echo -e "     - Database: ${GREEN}sqldb${NC}"
echo -e "     - Username: ${GREEN}postgres${NC}"
echo -e "     - Password: ${GREEN}postgres${NC}"
echo -e "\n   PgAdmin (웹 관리 도구):"
echo -e "     - URL: ${GREEN}http://localhost:5050${NC}"
echo -e "     - Email: ${GREEN}admin@example.com${NC}"
echo -e "     - Password: ${GREEN}admin${NC}"
echo -e "\n${YELLOW}📝 명령어:${NC}"
echo -e "   로그 확인: ${GREEN}docker-compose logs -f${NC}"
echo -e "   서비스 중지: ${GREEN}./stop.sh${NC}"
echo -e "   재시작: ${GREEN}docker-compose restart${NC}"
echo -e "\n${YELLOW}💡 참고:${NC}"
echo -e "   최초 실행 시 백업 데이터가 자동으로 복원됩니다."
echo -e "   복원 로그 확인: ${GREEN}docker-compose logs postgres${NC}"
echo -e "${BLUE}==================================================${NC}\n"

