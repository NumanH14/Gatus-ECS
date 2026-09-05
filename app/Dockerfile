FROM golang:1.26.3-alpine AS builder

WORKDIR /app

RUN adduser -S appuser && addgroup -S appgroup

COPY . .

RUN go mod download

RUN CGO_ENABLED=0 GOOS=linux go build -o /gatus-ecs

############################
# STEP 2 build a small image
############################

FROM scratch

COPY --from=builder /gatus-ecs /gatus-ecs

COPY --from=builder /app/config/config.yaml /config/config.yaml

COPY --from=builder /etc/passwd /etc/passwd

COPY --from=builder /etc/group /etc/group

USER appuser

EXPOSE 8080

ENTRYPOINT [ "/gatus-ecs" ]

