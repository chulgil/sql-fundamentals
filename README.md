# SQL Fundamentals

SQL 학습을 위한 실습 프로젝트입니다. PostgreSQL을 Docker로 실행하고 다양한 SQL 쿼리를 연습할 수 있습니다.

## 📚 프로젝트 구조

```
sql-fundamentals/
├── docker/              # Docker 환경 설정
│   ├── docker-compose.yml
│   ├── start.sh        # 서버 시작
│   ├── stop.sh         # 서버 중지
│   ├── restart.sh      # 서버 재시작
│   ├── init/           # 데이터베이스 초기화 스크립트
│   └── README.md       # Docker 상세 가이드
├── examples/           # SQL 실습 예제
│   ├── Join_GroupBy_실습.sql
│   ├── 서브쿼리_실습.sql
│   ├── window_절_실습.sql
│   └── ...
├── docs/               # 학습 자료
└── backup/             # 데이터베이스 백업
```

## 🚀 빠른 시작

### 1. 사전 요구사항

- [Docker Desktop](https://www.docker.com/products/docker-desktop) 설치

### 2. PostgreSQL 서버 시작

```bash
cd docker
./start.sh
```

### 3. 데이터베이스 접속

#### 방법 1: PgAdmin (웹 UI)
- URL: http://localhost:5050
- Email: `admin@example.com`
- Password: `admin`

#### 방법 2: psql (터미널)
```bash
docker-compose exec postgres psql -U postgres -d sqldb
```

#### 방법 3: DBeaver, DataGrip 등
- Host: `localhost`
- Port: `5432`
- Database: `sqldb`
- Username: `postgres`
- Password: `postgres`

## 📖 학습 내용

### SQL 기초
- SELECT, WHERE, ORDER BY
- JOIN (INNER, LEFT, RIGHT, FULL)
- GROUP BY, HAVING
- 집계 함수 (COUNT, SUM, AVG, MAX, MIN)

### 고급 SQL
- 서브쿼리 (Subquery)
- 윈도우 함수 (Window Functions)
- 분석 함수 (Analytic Functions)
  - ROW_NUMBER, RANK, DENSE_RANK
  - LEAD, LAG
  - FIRST_VALUE, LAST_VALUE
- 날짜/시간 함수

## 📝 실습 예제

`examples/` 디렉토리에서 다양한 SQL 실습 파일을 확인할 수 있습니다:

- `Join_GroupBy_실습.sql` - 조인과 그룹화
- `서브쿼리_실습.sql` - 서브쿼리 활용
- `window_절_실습.sql` - 윈도우 함수
- `순위_Analytic_실습_01.sql` - 순위 분석 함수
- `Aggregate_Analytic_실습.sql` - 집계 분석
- `date_timestamp_interval_실습.sql` - 날짜/시간 처리

## 🛠️ 유용한 명령어

### Docker 관리
```bash
# 서버 시작
./docker/start.sh

# 서버 중지
./docker/stop.sh

# 서버 재시작
./docker/restart.sh

# 로그 확인
cd docker && docker-compose logs -f

# 데이터 초기화
cd docker && docker-compose down -v && ./start.sh
```

### PostgreSQL 명령어
```bash
# psql 접속
docker-compose exec postgres psql -U postgres -d sqldb

# 데이터베이스 백업
docker-compose exec postgres pg_dump -U postgres sqldb > backup.sql

# 데이터베이스 복원
cat backup.sql | docker-compose exec -T postgres psql -U postgres -d sqldb
```

## 📚 참고 자료

- [PostgreSQL 공식 문서](https://www.postgresql.org/docs/)
- [SQL 튜토리얼](https://www.postgresql.org/docs/current/tutorial.html)
- [윈도우 함수 가이드](https://www.postgresql.org/docs/current/tutorial-window.html)

## 📄 라이선스

MIT License

## 👤 작성자

SQL 학습을 위한 실습 프로젝트

