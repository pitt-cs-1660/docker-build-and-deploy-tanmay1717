# ── Build Stage ───────────────────────────────────────────────────────────────
FROM golang:1.23 AS builder

WORKDIR /app

COPY go.mod .
COPY main.go .
COPY templates/ ./templates/

RUN CGO_ENABLED=0 go build -o Go_lang_server .

# ── Final Stage ───────────────────────────────────────────────────────────────
FROM scratch

COPY --from=builder /app/Go_lang_server    /Go_lang_server
COPY --from=builder /app/templates /templates

ENTRYPOINT ["/Go_lang_server"]
