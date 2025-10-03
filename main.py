import grpc
import json
import nest_pb2
import nest_pb2_grpc

ENDPOINT = "clovaspeech-gw.ncloud.com:50051"
SECRET_KEY = "c6bf55cb00484050a8845351d00c3ee8"

def main():
    # 1) 채널/클라이언트/메타데이터
    channel = grpc.secure_channel(ENDPOINT, grpc.ssl_channel_credentials())
    client = nest_pb2_grpc.NestServiceStub(channel)
    metadata = (("authorization", f"Bearer {SECRET_KEY}"),)

    # 2) 최소 Config JSON (먼저 성공 신호 확인)
    config_json = {
        "transcription": {"language": "ko"}
    }

    # 3) 요청 스트림 제너레이터: 첫 메시지로 CONFIG 전송
    def request_iter():
        yield nest_pb2.NestRequest(
            type=nest_pb2.CONFIG,
            # NestRequest.config 는 문자열이 아니라 NestConfig 메시지
            config=nest_pb2.NestConfig(config=json.dumps(config_json)),
        )
        # 이후 오디오 보낼 때는 여기서 DATA 청크들을 yield 하면 됨.

    # 4) 호출 및 응답 확인
    try:
        responses = client.recognize(request_iter(), metadata=metadata)
        for res in responses:
            print("RAW:", res)  # 프로토 전체
            try:
                print("JSON:", json.loads(res.contents))  # 서버 JSON 본문(있다면)
            except Exception:
                print("CONTENTS:", res.contents)
            break  # 첫 응답만 확인
    except grpc.RpcError as e:
        print("RPC_ERROR:", e.code().name, e.details())

if __name__ == "__main__":
    main()
