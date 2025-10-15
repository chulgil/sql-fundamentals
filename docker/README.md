# SQL Fundamentals - PostgreSQL Docker 환경

이 디렉토리는 SQL 학습을 위한 PostgreSQL 데이터베이스 환경을 Docker로 구성합니다.

## 📋 사전 요구사항

- Docker Desktop 설치 ([다운로드](https://www.docker.com/products/docker-desktop))
- Docker Compose (Docker Desktop에 포함됨)

## 🚀 시작하기

### 1. 서버 시작

```bash
cd docker
./start.sh
```

또는 직접 실행:

```bash
docker-compose up -d
```

### 2. 서버 중지

```bash
./stop.sh
```

또는:

```bash
docker-compose down
```

### 3. 서버 재시작

```bash
./restart.sh
```

또는:

```bash
docker-compose restart
```

## 🔗 접속 정보

### PostgreSQL 데이터베이스
- **Host**: `localhost`
- **Port**: `5432`
- **Database**: `sqldb`
- **Username**: `postgres`
- **Password**: `postgres`

### PgAdmin (웹 관리 도구)
- **URL**: http://localhost:5050
- **Email**: `admin@example.com`
- **Password**: `admin`

#### PgAdmin에서 PostgreSQL 서버 연결하기

1. 브라우저에서 http://localhost:5050 접속
2. Email과 Password로 로그인
3. 좌측 "Servers" 우클릭 → "Register" → "Server" 선택
4. General 탭:
   - Name: `SQL Fundamentals` (원하는 이름)
5. Connection 탭:
   - Host name/address: `postgres` (Docker 네트워크 내부 호스트명)
   - Port: `5432`
   - Username: `postgres`
   - Password: `postgres`
   - Save password 체크
6. "Save" 클릭

## ⚙️ 설정 변경

`.env` 파일을 편집하여 설정을 변경할 수 있습니다:

```env
# PostgreSQL 설정
POSTGRES_DB=sqldb           # 데이터베이스 이름
POSTGRES_USER=postgres      # 사용자 이름
POSTGRES_PASSWORD=postgres  # 비밀번호
POSTGRES_PORT=5432         # 포트 번호

# PgAdmin 설정
PGADMIN_EMAIL=admin@example.com
PGADMIN_PASSWORD=admin
PGADMIN_PORT=5050
```

설정 변경 후 재시작:

```bash
docker-compose down
docker-compose up -d
```

## 📁 디렉토리 구조

```
docker/
├── docker-compose.yml  # Docker Compose 설정 파일
├── .env               # 환경 변수 설정
├── start.sh           # 서버 시작 스크립트
├── stop.sh            # 서버 중지 스크립트
├── restart.sh         # 서버 재시작 스크립트
├── init/              # 초기화 SQL 스크립트
│   ├── 01-init.sql                           # 기본 초기화
│   ├── 02-restore-backup.sh                  # 백업 파일 자동 복원
│   └── dump_postgres_analytics_funda.backup  # 실습용 백업 데이터
└── README.md          # 이 파일
```

## 🗄️ 백업 데이터 복원

`docker/init/` 디렉토리에 있는 `dump_postgres_analytics_funda.backup` 파일은 컨테이너 최초 실행 시 자동으로 복원됩니다.

### 백업 데이터 포함 여부
- ✅ **포함됨**: 기존 백업 파일이 자동으로 복원됩니다.
- 최초 실행 시에만 복원되며, 이후 재시작 시에는 복원되지 않습니다.

### 백업 데이터 다시 복원하기
데이터를 초기 상태로 되돌리려면:

```bash
# 1. 기존 데이터 삭제
docker-compose down -v

# 2. 다시 시작 (백업 자동 복원)
./start.sh
```

## 💡 유용한 명령어

### 로그 확인
```bash
# 전체 로그
docker-compose logs -f

# PostgreSQL만
docker-compose logs -f postgres

# 최근 100줄
docker-compose logs --tail=100 -f
```

### 컨테이너 상태 확인
```bash
docker-compose ps
```

### PostgreSQL 직접 접속 (psql)
```bash
docker-compose exec postgres psql -U postgres -d sqldb
```

### 데이터베이스 백업
```bash
docker-compose exec postgres pg_dump -U postgres sqldb > backup.sql
```

### 데이터베이스 복원
```bash
cat backup.sql | docker-compose exec -T postgres psql -U postgres -d sqldb
```

### 데이터 완전 삭제 (주의!)
```bash
docker-compose down -v  # 볼륨까지 삭제
```

## 🔧 문제 해결

### 포트가 이미 사용 중인 경우
`.env` 파일에서 `POSTGRES_PORT` 또는 `PGADMIN_PORT`를 다른 번호로 변경하세요.

### 컨테이너가 시작되지 않는 경우
```bash
# 기존 컨테이너 완전 제거
docker-compose down -v

# 다시 시작
docker-compose up -d

# 로그 확인
docker-compose logs -f
```

### 데이터베이스 초기화
```bash
# 모든 데이터 삭제 후 재시작
docker-compose down -v
docker-compose up -d
```

## 📚 추가 정보

- PostgreSQL 공식 문서: https://www.postgresql.org/docs/
- PgAdmin 공식 문서: https://www.pgadmin.org/docs/
- Docker Compose 문서: https://docs.docker.com/compose/

