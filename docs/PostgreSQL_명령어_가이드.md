# PostgreSQL Docker 명령어 가이드

이 문서는 Docker 환경에서 PostgreSQL을 사용하는 데 필요한 모든 명령어를 정리한 가이드입니다.

## 📑 목차

1. [Docker 관리 명령어](#docker-관리-명령어)
2. [PostgreSQL 접속 방법](#postgresql-접속-방법)
3. [psql 메타 명령어](#psql-메타-명령어)
4. [데이터베이스 조회](#데이터베이스-조회)
5. [테이블 조회](#테이블-조회)
6. [데이터 조회 및 쿼리](#데이터-조회-및-쿼리)
7. [백업 및 복원](#백업-및-복원)
8. [성능 및 모니터링](#성능-및-모니터링)

---

## Docker 관리 명령어

### 서버 시작/중지/재시작

```bash
# 서버 시작
cd docker
./start.sh

# 서버 중지
./stop.sh

# 서버 재시작
./restart.sh
```

### Docker Compose 기본 명령어

```bash
cd docker

# 서비스 시작 (백그라운드)
docker-compose up -d

# 서비스 중지
docker-compose down

# 서비스 중지 (볼륨 포함 - 데이터 삭제 주의!)
docker-compose down -v

# 서비스 재시작
docker-compose restart

# 특정 서비스만 재시작
docker-compose restart postgres
docker-compose restart pgadmin

# 서비스 상태 확인
docker-compose ps

# 로그 확인 (실시간)
docker-compose logs -f

# 특정 서비스 로그만 확인
docker-compose logs -f postgres
docker-compose logs -f pgadmin

# 최근 100줄만 보기
docker-compose logs --tail=100 -f

# 서비스 일시 중지/재개
docker-compose pause
docker-compose unpause
```

### 컨테이너 직접 관리

```bash
# 실행 중인 컨테이너 확인
docker ps

# 모든 컨테이너 확인 (중지된 것 포함)
docker ps -a

# 컨테이너 상세 정보
docker inspect sql-fundamentals-postgres

# 컨테이너 리소스 사용량
docker stats sql-fundamentals-postgres

# 컨테이너 중지
docker stop sql-fundamentals-postgres

# 컨테이너 시작
docker start sql-fundamentals-postgres

# 컨테이너 재시작
docker restart sql-fundamentals-postgres

# 컨테이너 삭제
docker rm sql-fundamentals-postgres
```

### 볼륨 관리

```bash
# 볼륨 목록 확인
docker volume ls

# 특정 볼륨 상세 정보
docker volume inspect docker_postgres_data

# 사용되지 않는 볼륨 삭제
docker volume prune

# 특정 볼륨 삭제 (데이터 삭제 주의!)
docker volume rm docker_postgres_data
```

---

## PostgreSQL 접속 방법

### 1. psql로 직접 접속

```bash
# 기본 접속
docker exec -it sql-fundamentals-postgres psql -U postgres -d sqldb

# 또는 docker-compose 사용
cd docker
docker-compose exec postgres psql -U postgres -d sqldb
```

### 2. 쿼리 한 줄 실행 (접속 없이)

```bash
# 단일 쿼리 실행
docker exec sql-fundamentals-postgres psql -U postgres -d sqldb -c "SELECT version();"

# 여러 명령어 실행
docker exec sql-fundamentals-postgres psql -U postgres -d sqldb -c "\dt" -c "\dn"
```

### 3. SQL 파일 실행

```bash
# 로컬 SQL 파일 실행
cat query.sql | docker exec -i sql-fundamentals-postgres psql -U postgres -d sqldb

# 또는
docker exec -i sql-fundamentals-postgres psql -U postgres -d sqldb < query.sql
```

---

## psql 메타 명령어

psql 접속 후 사용할 수 있는 백슬래시 명령어입니다.

### 도움말

```sql
\?              -- 모든 메타 명령어 도움말
\h              -- SQL 명령어 도움말
\h SELECT       -- 특정 SQL 명령어 도움말
```

### 데이터베이스 관련

```sql
\l              -- 데이터베이스 목록
\l+             -- 데이터베이스 목록 (상세)
\c dbname       -- 다른 데이터베이스로 전환
\conninfo       -- 현재 연결 정보
```

### 스키마 관련

```sql
\dn             -- 스키마 목록
\dn+            -- 스키마 목록 (상세)
```

### 테이블 관련

```sql
\dt             -- 테이블 목록 (현재 스키마)
\dt+            -- 테이블 목록 (상세 - 크기 포함)
\dt *.*         -- 모든 스키마의 테이블
\dt hr.*        -- hr 스키마의 테이블만
\dt nw.*        -- nw 스키마의 테이블만

\d tablename    -- 테이블 구조 보기
\d+ tablename   -- 테이블 구조 상세 보기
\d hr.emp       -- 특정 스키마의 테이블 구조
```

### 인덱스, 뷰, 시퀀스

```sql
\di             -- 인덱스 목록
\di+            -- 인덱스 목록 (상세)
\dv             -- 뷰 목록
\dv+            -- 뷰 목록 (상세)
\ds             -- 시퀀스 목록
\df             -- 함수 목록
\df+            -- 함수 목록 (상세)
```

### 권한 및 사용자

```sql
\du             -- 사용자(Role) 목록
\du+            -- 사용자 목록 (상세)
\dp tablename   -- 테이블 권한 확인
\z tablename    -- 테이블 권한 확인 (동일)
```

### 출력 및 편집

```sql
\x              -- 확장 표시 모드 토글 (세로로 보기)
\x on           -- 확장 표시 모드 켜기
\x off          -- 확장 표시 모드 끄기

\timing         -- 쿼리 실행 시간 측정 토글
\timing on      -- 쿼리 실행 시간 표시 켜기
\timing off     -- 쿼리 실행 시간 표시 끄기

\q              -- psql 종료
\! clear        -- 터미널 화면 지우기
```

### 파일 입출력

```sql
\i filename.sql             -- SQL 파일 실행
\o output.txt               -- 출력을 파일로 리다이렉션
\o                          -- 파일 리다이렉션 종료 (표준 출력으로)

\copy (SELECT * FROM hr.emp) TO '/tmp/emp.csv' CSV HEADER
-- 쿼리 결과를 CSV로 저장
```

---

## 데이터베이스 조회

### 현재 프로젝트의 구조

```sql
-- 모든 스키마 확인
\dn

-- 스키마별 테이블 확인
\dt hr.*
\dt nw.*

-- 모든 사용자 테이블 확인 (시스템 테이블 제외)
SELECT schemaname, tablename 
FROM pg_tables 
WHERE schemaname NOT IN ('pg_catalog', 'information_schema')
ORDER BY schemaname, tablename;
```

### hr 스키마 (인사 관리)

```sql
-- hr 스키마의 모든 테이블
\dt hr.*

-- 테이블 구조 확인
\d hr.emp              -- 직원 테이블
\d hr.dept             -- 부서 테이블
\d hr.salgrade         -- 급여 등급
\d hr.emp_salary_hist  -- 급여 이력
\d hr.emp_dept_hist    -- 부서 이동 이력
```

### nw 스키마 (Northwind)

```sql
-- nw 스키마의 모든 테이블
\dt nw.*

-- 테이블 구조 확인
\d nw.employees        -- 직원
\d nw.customers        -- 고객
\d nw.suppliers        -- 공급업체
\d nw.shippers         -- 배송업체
\d nw.categories       -- 카테고리
\d nw.products         -- 제품
\d nw.orders           -- 주문
\d nw.order_items      -- 주문 상세
```

---

## 테이블 조회

### 테이블 정보

```sql
-- 테이블 크기 확인
SELECT 
    schemaname,
    tablename,
    pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) AS size
FROM pg_tables
WHERE schemaname NOT IN ('pg_catalog', 'information_schema')
ORDER BY pg_total_relation_size(schemaname||'.'||tablename) DESC;

-- 테이블 행 개수 확인
SELECT 'hr.emp' AS table_name, COUNT(*) FROM hr.emp
UNION ALL
SELECT 'hr.dept', COUNT(*) FROM hr.dept
UNION ALL
SELECT 'nw.orders', COUNT(*) FROM nw.orders
UNION ALL
SELECT 'nw.customers', COUNT(*) FROM nw.customers;

-- 컬럼 정보 상세 조회
SELECT 
    column_name,
    data_type,
    character_maximum_length,
    is_nullable,
    column_default
FROM information_schema.columns
WHERE table_schema = 'hr' AND table_name = 'emp'
ORDER BY ordinal_position;
```

### 인덱스 정보

```sql
-- 테이블의 인덱스 확인
\d hr.emp

-- 또는 쿼리로 확인
SELECT
    schemaname,
    tablename,
    indexname,
    indexdef
FROM pg_indexes
WHERE schemaname = 'hr'
ORDER BY tablename, indexname;
```

---

## 데이터 조회 및 쿼리

### 기본 조회 예제

```sql
-- hr.emp 테이블 샘플 데이터
SELECT * FROM hr.emp LIMIT 5;

-- hr.dept 테이블 전체
SELECT * FROM hr.dept;

-- 부서별 직원 수
SELECT d.dname, COUNT(e.empno) as emp_count
FROM hr.dept d
LEFT JOIN hr.emp e ON d.deptno = e.deptno
GROUP BY d.dname
ORDER BY emp_count DESC;

-- 급여 상위 10명
SELECT empno, ename, job, sal, deptno
FROM hr.emp
ORDER BY sal DESC
LIMIT 10;
```

### JOIN 예제

```sql
-- 직원과 부서 정보
SELECT 
    e.empno,
    e.ename,
    e.job,
    e.sal,
    d.dname AS dept_name,
    d.loc AS dept_location
FROM hr.emp e
INNER JOIN hr.dept d ON e.deptno = d.deptno
ORDER BY e.ename;

-- Northwind: 주문과 고객 정보
SELECT 
    o.order_id,
    o.order_date,
    c.company_name,
    c.city,
    c.country
FROM nw.orders o
INNER JOIN nw.customers c ON o.customer_id = c.customer_id
ORDER BY o.order_date DESC
LIMIT 20;
```

### 윈도우 함수 예제

```sql
-- 부서별 급여 순위
SELECT 
    empno,
    ename,
    deptno,
    sal,
    RANK() OVER (PARTITION BY deptno ORDER BY sal DESC) as salary_rank,
    ROW_NUMBER() OVER (PARTITION BY deptno ORDER BY sal DESC) as row_num
FROM hr.emp
ORDER BY deptno, sal DESC;

-- 누적 합계
SELECT 
    empno,
    ename,
    sal,
    SUM(sal) OVER (ORDER BY empno) as cumulative_sal
FROM hr.emp;
```

### 서브쿼리 예제

```sql
-- 평균 급여보다 많이 받는 직원
SELECT empno, ename, job, sal
FROM hr.emp
WHERE sal > (SELECT AVG(sal) FROM hr.emp)
ORDER BY sal DESC;

-- 각 부서에서 가장 높은 급여를 받는 직원
SELECT e.empno, e.ename, e.deptno, e.sal
FROM hr.emp e
WHERE e.sal = (
    SELECT MAX(sal) 
    FROM hr.emp 
    WHERE deptno = e.deptno
)
ORDER BY e.deptno;
```

---

## 백업 및 복원

### 데이터베이스 백업

```bash
# 전체 데이터베이스 백업 (SQL 형식)
docker exec sql-fundamentals-postgres pg_dump -U postgres sqldb > backup_$(date +%Y%m%d_%H%M%S).sql

# 전체 데이터베이스 백업 (커스텀 형식 - 압축)
docker exec sql-fundamentals-postgres pg_dump -U postgres -Fc sqldb > backup_$(date +%Y%m%d_%H%M%S).backup

# 특정 스키마만 백업
docker exec sql-fundamentals-postgres pg_dump -U postgres -n hr sqldb > backup_hr_$(date +%Y%m%d).sql

# 특정 테이블만 백업
docker exec sql-fundamentals-postgres pg_dump -U postgres -t hr.emp sqldb > backup_emp.sql

# 데이터만 백업 (스키마 제외)
docker exec sql-fundamentals-postgres pg_dump -U postgres --data-only sqldb > backup_data_only.sql

# 스키마만 백업 (데이터 제외)
docker exec sql-fundamentals-postgres pg_dump -U postgres --schema-only sqldb > backup_schema_only.sql
```

### 데이터베이스 복원

```bash
# SQL 파일 복원
cat backup.sql | docker exec -i sql-fundamentals-postgres psql -U postgres -d sqldb

# 커스텀 형식 백업 복원
docker exec -i sql-fundamentals-postgres pg_restore -U postgres -d sqldb < backup.backup

# 테이블 삭제 후 복원
docker exec -i sql-fundamentals-postgres pg_restore -U postgres -d sqldb --clean --if-exists < backup.backup

# 특정 테이블만 복원
docker exec -i sql-fundamentals-postgres pg_restore -U postgres -d sqldb -t hr.emp < backup.backup
```

### CSV 내보내기/가져오기

```bash
# 컨테이너 내부에서 CSV 내보내기
docker exec sql-fundamentals-postgres psql -U postgres -d sqldb -c "\copy hr.emp TO '/tmp/emp.csv' CSV HEADER"

# CSV 파일을 로컬로 복사
docker cp sql-fundamentals-postgres:/tmp/emp.csv ./emp.csv

# CSV 파일을 컨테이너로 복사
docker cp ./emp.csv sql-fundamentals-postgres:/tmp/emp.csv

# CSV 가져오기
docker exec sql-fundamentals-postgres psql -U postgres -d sqldb -c "\copy hr.emp FROM '/tmp/emp.csv' CSV HEADER"
```

---

## 성능 및 모니터링

### 현재 실행 중인 쿼리 확인

```sql
-- 실행 중인 쿼리 목록
SELECT 
    pid,
    usename,
    application_name,
    client_addr,
    state,
    query,
    query_start,
    state_change
FROM pg_stat_activity
WHERE state = 'active'
ORDER BY query_start;

-- 오래 실행 중인 쿼리
SELECT 
    pid,
    now() - query_start AS duration,
    state,
    query
FROM pg_stat_activity
WHERE state != 'idle'
ORDER BY duration DESC;
```

### 쿼리 실행 계획 확인

```sql
-- 쿼리 실행 계획
EXPLAIN SELECT * FROM hr.emp WHERE sal > 3000;

-- 실행 계획 + 실제 실행 통계
EXPLAIN ANALYZE SELECT * FROM hr.emp WHERE sal > 3000;

-- 자세한 실행 계획
EXPLAIN (ANALYZE, BUFFERS, VERBOSE) 
SELECT * FROM hr.emp WHERE sal > 3000;
```

### 데이터베이스 통계

```sql
-- 데이터베이스 크기
SELECT 
    datname,
    pg_size_pretty(pg_database_size(datname)) AS size
FROM pg_database
ORDER BY pg_database_size(datname) DESC;

-- 테이블별 크기
SELECT
    schemaname,
    tablename,
    pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) AS total_size,
    pg_size_pretty(pg_relation_size(schemaname||'.'||tablename)) AS table_size,
    pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename) - pg_relation_size(schemaname||'.'||tablename)) AS index_size
FROM pg_tables
WHERE schemaname NOT IN ('pg_catalog', 'information_schema')
ORDER BY pg_total_relation_size(schemaname||'.'||tablename) DESC;

-- 테이블 통계 (행 수, 업데이트 등)
SELECT
    schemaname,
    relname,
    n_live_tup AS row_count,
    n_dead_tup AS dead_rows,
    last_vacuum,
    last_autovacuum,
    last_analyze,
    last_autoanalyze
FROM pg_stat_user_tables
ORDER BY n_live_tup DESC;
```

### 캐시 및 버퍼 통계

```sql
-- 캐시 히트율
SELECT 
    sum(heap_blks_read) as heap_read,
    sum(heap_blks_hit)  as heap_hit,
    sum(heap_blks_hit) / (sum(heap_blks_hit) + sum(heap_blks_read)) * 100 AS cache_hit_ratio
FROM pg_statio_user_tables;

-- 인덱스 사용률
SELECT
    schemaname,
    tablename,
    indexname,
    idx_scan,
    idx_tup_read,
    idx_tup_fetch
FROM pg_stat_user_indexes
ORDER BY idx_scan DESC;
```

### 프로세스 종료

```sql
-- 특정 쿼리 취소 (안전)
SELECT pg_cancel_backend(pid);

-- 특정 프로세스 강제 종료 (주의!)
SELECT pg_terminate_backend(pid);

-- 예: 오래 실행된 쿼리 종료
SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE state = 'active'
  AND now() - query_start > interval '5 minutes';
```

---

## 유용한 팁

### 1. 쿼리 결과를 보기 좋게

```sql
-- 확장 표시 모드 (세로 방향)
\x
SELECT * FROM hr.emp WHERE empno = 7369;
\x

-- 실행 시간 측정
\timing
SELECT COUNT(*) FROM hr.emp;
```

### 2. psql 설정 파일

psql 시작 시 자동 실행할 명령어를 설정하려면:

```bash
# 컨테이너 내부에 .psqlrc 생성
docker exec sql-fundamentals-postgres bash -c "cat > /root/.psqlrc << 'EOF'
\timing on
\x auto
\set PROMPT1 '%n@%/ %R%# '
EOF"
```

### 3. 편리한 별칭 (zsh/bash)

로컬 `~/.zshrc` 또는 `~/.bashrc`에 추가:

```bash
# PostgreSQL 관련 별칭
alias pgsql='docker exec -it sql-fundamentals-postgres psql -U postgres -d sqldb'
alias pgstart='cd ~/Dev/Data/sql-fundamentals/docker && ./start.sh'
alias pgstop='cd ~/Dev/Data/sql-fundamentals/docker && ./stop.sh'
alias pglogs='cd ~/Dev/Data/sql-fundamentals/docker && docker-compose logs -f postgres'
```

적용:
```bash
source ~/.zshrc  # 또는 source ~/.bashrc
```

사용:
```bash
pgsql  # PostgreSQL 접속
```

---

## 문제 해결

### 컨테이너가 시작되지 않는 경우

```bash
# 로그 확인
cd docker
docker-compose logs postgres

# 컨테이너 완전 제거 후 재시작
docker-compose down -v
docker-compose up -d
```

### 포트 충돌

```bash
# 5432 포트 사용 중인 프로세스 확인 (macOS)
lsof -i :5432

# 프로세스 종료
kill -9 <PID>

# 또는 .env 파일에서 다른 포트로 변경
# POSTGRES_PORT=5433
```

### 데이터 초기화

```bash
# 모든 데이터 삭제하고 백업 파일 재복원
cd docker
docker-compose down -v
./start.sh
```

---

## 참고 자료

- [PostgreSQL 공식 문서](https://www.postgresql.org/docs/)
- [psql 명령어 참조](https://www.postgresql.org/docs/current/app-psql.html)
- [SQL 튜토리얼](https://www.postgresql.org/docs/current/tutorial.html)
- [pg_dump 문서](https://www.postgresql.org/docs/current/app-pgdump.html)
- [pg_restore 문서](https://www.postgresql.org/docs/current/app-pgrestore.html)

---

**작성일**: 2025-10-15  
**PostgreSQL 버전**: 18.0  
**프로젝트**: sql-fundamentals

