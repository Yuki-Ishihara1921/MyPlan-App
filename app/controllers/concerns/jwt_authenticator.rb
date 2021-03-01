module JwtAuthenticator
    require 'jwt'

    SECRET_KEY_BASE = Rails.application.credentials.secret_key_base

    # 暗号化処理
    def encode(user_id)
        # 再ログインまでの期間を6ヶ月に設定^@[]
        expires_in = 6.month.from_now.to_i
        payload = { user_id: user_id, exp: expires_in }
        JWT.encode(payload, SECRET_KEY_BASE, 'HS256')
    end

    # 複合化処理
    def decode(encoded_token)
        decoded_jwt = JWT.decode(encoded_token, SECRET_KEY_BASE, true, { algorithm: 'HS256' })
        decoded_jwt.first
    end
end