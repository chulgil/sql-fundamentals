-- SQL Fundamentals 실습을 위한 초기 설정
-- 이 스크립트는 컨테이너 최초 실행 시 자동으로 실행됩니다.

-- 확장 기능 설치 (필요한 경우)
-- CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
-- CREATE EXTENSION IF NOT EXISTS "pg_trgm";

-- 샘플 스키마 생성 (선택사항)
-- CREATE SCHEMA IF NOT EXISTS practice;

-- 데이터베이스 설정
ALTER DATABASE sqldb SET timezone TO 'Asia/Seoul';

-- 기본 사용자 권한 설정
-- GRANT ALL PRIVILEGES ON DATABASE sqldb TO postgres;

-- 초기화 완료 메시지
DO $$
BEGIN
    RAISE NOTICE '===========================================';
    RAISE NOTICE ' SQL Fundamentals 데이터베이스 초기화 완료';
    RAISE NOTICE '===========================================';
END $$;

