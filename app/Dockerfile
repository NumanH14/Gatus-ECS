FROM golang:alpine AS builder

WORKDIR /app

COPY . .

RUN

RUN go mod download

RUN go build -o /gatus-ecs

############################
# STEP 2 build a small image
############################

FROM scratch

COPY --from=builder /gatus-ecs .

EXPOSE 8080

ENTRYPOINT [ "/gatus-ecs" ]

