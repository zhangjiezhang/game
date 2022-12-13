FROM golang:1.18 AS builde_result
WORKDIR /app
RUN apt-get update && apt-get install -y git \
    && git clone https://github.com/zhangjiezhang/game.git  \
    && cd ebiten/examples/2048  \
    && CGO_ENABLED=0 GOOS=js GOARCH=wasm go build -ldflags="-s -w" -o 2048.wasm \
    && cp $(go env GOROOT)/misc/wasm/wasm_exec.js .

##
## Deploy
##
FROM nginx:1.23.2

WORKDIR /usr/share/nginx/html
COPY --from=builde_result /app/ebiten/examples/2048/2048.wasm .
COPY --from=builde_result /app/ebiten/examples/2048/wasm_exec.js .
ADD index.html .
