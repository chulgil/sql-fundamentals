#!/bin/bash
# PostgreSQL 백업 파일 자동 복원 스크립트

set -e

BACKUP_FILE="/docker-entrypoint-initdb.d/dump_postgres_analytics_funda.backup"

if [ -f "$BACKUP_FILE" ]; then
    echo "========================================"
    echo "백업 파일 복원 중..."
    echo "========================================"
    
    # pg_restore를 사용하여 백업 복원
    # -U: 사용자명
    # -d: 데이터베이스명
    # --no-owner: 소유자 정보 무시
    # --no-acl: 권한 정보 무시
    pg_restore -U "$POSTGRES_USER" -d "$POSTGRES_DB" \
        --no-owner \
        --no-acl \
        --clean \
        --if-exists \
        "$BACKUP_FILE" 2>&1 || true
    
    echo "========================================"
    echo "✅ 백업 파일 복원 완료!"
    echo "========================================"
else
    echo "⚠️  백업 파일을 찾을 수 없습니다: $BACKUP_FILE"
    echo "    백업 파일을 docker/init/ 디렉토리에 복사하세요."
fi

