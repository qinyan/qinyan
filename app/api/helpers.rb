#common helpers for grape APIs

module APIHelpers
  def logger
    API.logger
  end

  # 对客户端提交的未正确进行UTF-8编码的数据进行编码
  def normalize_encode_params
    @env["rack.request.form_hash"] ||= {}
    encode_params_values params if request.form_data? && request.media_type == 'multipart/form-data'
  end

  # 迭代对 params 的 values 进行编码处理
  def encode_params_values(hash)
    return if hash.blank?
    hash.each do |k, v|
      if hash[k].is_a?(Hash)
        encode_params_values(hash[k])
      else
        hash[k].force_encoding(Encoding::UTF_8).encode! if hash[k].is_a?(String)
      end
    end
  end

  def will_present(key, data, options={})
    present :per_page, data.per_page
    present :page, data.current_page
    present key, data, options
  end
end