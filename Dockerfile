FROM golang:1.18-alpine AS builde_result
ADD . /app
WORKDIR /app
RUN CGO_ENABLED=0 GOOS=js GOARCH=wasm go build -ldflags="-s -w" -o 2048.wasm \
    && cp $(go env GOROOT)/misc/wasm/wasm_exec.js .

##
## Deploy
##
FROM nginx:1.23.2

WORKDIR /usr/share/nginx/html
COPY --from=builde_result /app/2048.wasm .
COPY --from=builde_result /app/wasm_exec.js .
ADD index.html .
