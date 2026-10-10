# v2ray-ws

一键启动 v2ray with websocket，当前版本为 [v5.53.0](https://github.com/v2fly/v2ray-core/releases/tag/v5.53.0)。

```
docker run --rm --name v2ray -p "127.0.0.1:2333:2333" -d ghcr.io/docker-s-images/v2ray-ws:main DOMAIN [PATH] [UUID]
```

- PATH：默认值 `/confusion`，v2ray 服务所支持的路径，也是前置反向代理需要配置的路径。
- UUID：不给值时，将会自动生成一个 UUID 值；如果使用 Docker 的 restart 机制，务必配置此参数以防止重启后 UUID 发生变化。

## Docker Compose

创建 `docker-compose.yaml`：

```yaml
services:
  v2ray:
    image: ghcr.io/docker-s-images/v2ray-ws:main
    platform: linux/amd64
    restart: unless-stopped
    ports:
      - "127.0.0.1:2333:2333"
    command:
      - "vpn.example.com"
      - "/confusion"
      - "c86718ac-8fe2-43e5-8df3-bbe738bf0f24"
```

将 `vpn.example.com` 替换为实际域名，并使用 `uuidgen` 生成自己的 UUID，替换示例中的值。`command` 中的三个参数依次为 DOMAIN、PATH 和 UUID；修改路径时，也需要同步修改反向代理配置。当前镜像使用 amd64 版 V2Ray，因此示例显式指定了平台。

在 `docker-compose.yaml` 所在目录执行：

```sh
docker compose up -d
docker compose logs v2ray
```

客户端配置链接会输出到日志中。服务仅绑定本机 `2333` 端口，需要由反向代理为该域名提供 HTTPS，并将 WebSocket 请求转发到此端口。

## Caddy

```
reverse_proxy /confusion 127.0.0.1:2333
```
