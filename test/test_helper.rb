# encoding: UTF-8
require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/setup'

require 'adyen'
require 'adyen/matchers'

require 'helpers/test_server'
require 'helpers/test_cards'

require 'pp'

module Adyen::Test
  module EachXMLBackend
    XML_BACKENDS = [Adyen::API::XMLQuerier::NokogiriBackend, Adyen::API::XMLQuerier::REXMLBackend]

    def for_each_xml_backend(&block)
      XML_BACKENDS.each do |xml_backend|
        begin
          Adyen::API::XMLQuerier.stubs(:default_backend).returns(xml_backend.new)
          block.call(xml_backend)
        ensure
          Adyen::API::XMLQuerier.unstub(:default_backend)
        end
      end
    end
  end
end

def setup_api_configuration
  Adyen.configuration.default_api_params = { :merchant_account => 'VanBergenORG' }
  Adyen.configuration.api_username = 'ws@Company.VanBergen'
  Adyen.configuration.api_password = '7phtHzbfnzsp'
  Adyen.configuration.cse_public_key = '10001|AC2CEF7D1BE904AF35B76467927A7044CCFC470E725B4D5327CC143BC5245983A56A4E5B0AC969F7F706F4B4A81B184DE2ECEA229CDBB943E6F7D6AD1623604F66640D1F2FAE1E4AE80EE1E5D4486AA8F553F6CE47BF57C8EFEF745E731AE27DD7B74F8895D41DA8339CC32677E4BD35288EC2FB9A18D46E7E3DFF5C7DD6D756F2223BED29427E5899A5877F0E9D1FAA50C17F8C96BA96DFA79BD04B1116366FFEE33F1BD18B8C3694BACBF8BFC7E2045CB9FFFEFA49AAB18EF1D9E9710A16B7DC67433ABD3A4FD3661CD9F5B1967753E4DC744DD3A1F8C8BED87827EED443CBED06A0D5C86C329406BE452B9A6EB997EE43A9FA7241A74E87AC3FC898F327CD'

  Adyen.configuration.register_form_skin(:testing, 'tifSfXeX', 'testing123', :merchant_account => 'VanBergenORG')
end
