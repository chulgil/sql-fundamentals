#!/bin/bash

# 색상 정의
BLUE='\033[0;34m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${BLUE}==================================================${NC}"
echo -e "${BLUE}  PostgreSQL Docker 서버 재시작${NC}"
echo -e "${BLUE}==================================================${NC}"

# docker 디렉토리로 이동
cd "$(dirname "$0")"

# Docker Compose로 서비스 재시작
echo -e "\n${GREEN}Docker 컨테이너 재시작 중...${NC}"
docker-compose restart

# 서비스 상태 확인
echo -e "\n${GREEN}서비스 상태 확인 중...${NC}"
sleep 2
docker-compose ps

echo -e "\n${BLUE}==================================================${NC}"
echo -e "${GREEN}✅ PostgreSQL 서버가 재시작되었습니다!${NC}"
echo -e "${BLUE}==================================================${NC}\n"

