FROM supabase/realtime:v2.28.32

# Set environment variables
ENV PORT=4000
ENV DB_HOST="supabase-postgres.tank.svc"
ENV DB_PORT=5432
ENV DB_USER="postgres"
ENV DB_PASSWORD="TPPQ3jvvPQ4RLoanWnefPeFiLdYly8vr"
ENV DB_NAME="postgres"
ENV DB_AFTER_CONNECT_QUERY='SET search_path TO *realtime'
ENV DB_ENC_KEY=supabaserealtime
ENV API_JWT_SECRET=eac193bbed41516acbccf01c06e2e347af4c796723a25c399abb31a024a5c889
ENV FLY_ALLOC_ID=fly123
ENV FLY_APP_NAME=realtime
ENV SECRET_KEY_BASE=UpNVntn3cDxHJpq99YMc1T1AQgQpc8kfYTuRgBiYa15BLrx8etQoXz3gZv1/u2oq
ENV ERL_AFLAGS="-proto_dist inet_tcp"
ENV ENABLE_TAILSCALE="false"
ENV DNS_NODES="''"

EXPOSE 4000

# Set the healthcheck
HEALTHCHECK --start-period=5s --interval=5s --timeout=5s --retries=3 \
  CMD curl -sSfL --head -o /dev/null -H "Authorization: Bearer ${ANON_KEY}" "http://localhost:4000/api/tenants/realtime-dev/health"

# Start the realtime server
ENTRYPOINT ["/bin/sh", "-c", "/app/bin/migrate && /app/bin/realtime eval 'Realtime.Release.seeds(Realtime.Repo)' && /app/bin/server"]
