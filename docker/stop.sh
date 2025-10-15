#!/bin/bash

# 색상 정의
RED='\033[0;31m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}==================================================${NC}"
echo -e "${BLUE}  PostgreSQL Docker 서버 중지${NC}"
echo -e "${BLUE}==================================================${NC}"

# docker 디렉토리로 이동
cd "$(dirname "$0")"

# Docker Compose로 서비스 중지
echo -e "\n${YELLOW}Docker 컨테이너 중지 중...${NC}"
docker-compose down

echo -e "\n${BLUE}==================================================${NC}"
echo -e "${RED}🛑 PostgreSQL 서버가 중지되었습니다.${NC}"
echo -e "${BLUE}==================================================${NC}\n"

