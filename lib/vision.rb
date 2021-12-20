require 'base64'
require 'json'
require 'net/https'

module Vision
  class << self
    def get_image_data(image_file)
      # APIのURL作成
      api_url = "https://vision.googleapis.com/v1/images:annotate?key=#{ENV['GOOGLE_API_KEY']}"

      # s3から画像をとってくる
      backend = Refile::S3.new(access_key_id: ENV['S3_ACCESS_KEY_ID'], secret_access_key: ENV['S3_SECRET_ACCESS_KEY'], region: 'ap-northeast-1', bucket: 'portfoliomarks', prefix: 'store' )
      image = backend.read(image_file.file_id)
      # 画像をbase64にエンコード
      base64_image = Base64.encode64(image)

      # APIリクエスト用のJSONパラメータ
      params = {
        requests: [{
          image: {
            content: base64_image
          },
          features: [
            {
              type: 'SAFE_SEARCH_DETECTION'
            },
            {
              type: 'LANDMARK_DETECTION',
              maxResults: 10
            }
          ]
        }]
      }.to_json

      # Google Cloud Vision APIにリクエスト
      uri = URI.parse(api_url)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri)
      request['Content-Type'] = 'application/json'
      response = https.request(request, params)
      response_body = JSON.parse(response.body)
      # APIレスポンス出力
      if (error = response_body['responses'][0]['error']).present?
        raise error['message']
      elsif !response_body['responses'][0]['safeSearchAnnotation'].value?('VERY_UNLIKELY' || 'UNLIKELY')
        "画像が不適切です"
      elsif response_body.values[0][0]["landmarkAnnotations"].nil?
          [nil,nil]
      else
        [response_body.values[0][0]["landmarkAnnotations"][0]["locations"][0]["latLng"]["latitude"], response_body.values[0][0]["landmarkAnnotations"][0]["locations"][0]["latLng"]["longitude"]]
      end
    end
  end
end