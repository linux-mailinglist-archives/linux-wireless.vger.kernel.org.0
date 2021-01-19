Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 525D62FAECB
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Jan 2021 03:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387817AbhASCdo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Jan 2021 21:33:44 -0500
Received: from mga07.intel.com ([134.134.136.100]:58718 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728366AbhASCdj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Jan 2021 21:33:39 -0500
IronPort-SDR: +AlX9cB2hv+v/5CFEdFC/s4wGvd+0PTGcSaR32WUzl0r/6eDgAq/+KQAIYHtANuRIoXdzy/Pb7
 yJQhy9poIlXA==
X-IronPort-AV: E=McAfee;i="6000,8403,9868"; a="242938602"
X-IronPort-AV: E=Sophos;i="5.79,357,1602572400"; 
   d="xz'?yaml'?scan'208";a="242938602"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 18:32:49 -0800
IronPort-SDR: RqhXmcZZPqCgbtwtwEBzrL5bxO/ATztBjQSh7N/C33sRBF1LSZbIfkycKePhSaAlSiJUQON417
 8iP5eLamfBzw==
X-IronPort-AV: E=Sophos;i="5.79,357,1602572400"; 
   d="xz'?yaml'?scan'208";a="573423722"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 18:32:45 -0800
Date:   Tue, 19 Jan 2021 10:48:10 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: [cfg80211]  1180cd89a7:
 hwsim.dpp_config_signed_connector_error_no_dot_2.fail
Message-ID: <20210119024810.GB20473@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gatW/ieO32f1wygP"
Content-Disposition: inline
In-Reply-To: <20210114235918.604bd54a533e.Iacd5916c0e01f71342159f6d419e56dc4c3f07a2@changeid>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Greeting,

FYI, we noticed the following commit (built with gcc-9):

commit: 1180cd89a7ca9add3e086f7f06b76d6114ae8593 ("[PATCH] cfg80211: avoid holding the RTNL when calling the driver")
url: https://github.com/0day-ci/linux/commits/Johannes-Berg/cfg80211-avoid-holding-the-RTNL-when-calling-the-driver/20210115-124633
base: https://git.kernel.org/cgit/linux/kernel/git/jberg/mac80211-next.git master

in testcase: hwsim
version: hwsim-x86_64-537ab94-1_20210101
with following parameters:

	test: group-26
	ucode: 0xe2



on test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz with 32G memory

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):




If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>

2021-01-18 07:15:17 export USER=root
2021-01-18 07:15:17 ./build.sh
Building TNC testing tools
Building wlantest
Building hs20-osu-client
Building hostapd
Building wpa_supplicant
2021-01-18 07:15:55 ./start.sh
2021-01-18 07:15:56 ./run-tests.py ap_acs_vht160_scan_disable
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_acs_vht160_scan_disable 1/1
Test: Automatic channel selection for VHT160 and DISABLE during scan
Starting AP wlan3
Removing BSS wlan3
Starting AP wlan3
Country code at the end: 00
PASS ap_acs_vht160_scan_disable 4.534067 2021-01-18 07:16:01.537145
passed all 1 test case(s)
2021-01-18 07:16:01 ./run-tests.py ap_beacon_rate_ht2
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_beacon_rate_ht2 1/1
Test: Open AP with Beacon frame TX rate HT-MCS 1 in VHT BSS
Starting AP wlan3
Skip test case: Setting Beacon frame TX rate not supported
SKIP ap_beacon_rate_ht2 0.441666 2021-01-18 07:16:02.110637
passed all 0 test case(s)
skipped 1 test case(s)
2021-01-18 07:16:02 ./run-tests.py ap_beacon_rate_legacy
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_beacon_rate_legacy 1/1
Test: Open AP with Beacon frame TX rate 5.5 Mbps
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_beacon_rate_legacy 1.675754 2021-01-18 07:16:03.917328
passed all 1 test case(s)
2021-01-18 07:16:03 ./run-tests.py ap_cipher_bip
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_cipher_bip 1/1
Test: WPA2-PSK with BIP
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_cipher_bip 0.887131 2021-01-18 07:16:04.934558
passed all 1 test case(s)
2021-01-18 07:16:04 ./run-tests.py ap_config_reload_file
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_config_reload_file 1/1
Test: hostapd configuration reload from file
Starting interface wlan3
Connect STA wlan0 to AP
PASS ap_config_reload_file 0.962365 2021-01-18 07:16:06.026662
passed all 1 test case(s)
2021-01-18 07:16:06 ./run-tests.py ap_csa_1_switch
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_csa_1_switch 1/1
Test: AP Channel Switch, one switch
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_csa_1_switch 1.827291 2021-01-18 07:16:07.983522
passed all 1 test case(s)
2021-01-18 07:16:08 ./run-tests.py ap_ft_gcmp_256
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_ft_gcmp_256 1/1
Test: WPA2-PSK-FT AP with GCMP-256 cipher
Starting AP wlan3
Starting AP wlan4
Connect to first AP
Connect STA wlan0 to AP
Roam to the second AP
Roam back to the first AP
PASS ap_ft_gcmp_256 2.07804 2021-01-18 07:16:10.192471
passed all 1 test case(s)
2021-01-18 07:16:10 ./run-tests.py ap_ft_internal_rrb_check
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_ft_internal_rrb_check 1/1
Test: RRB internal delivery only to WPA enabled BSS
Starting AP wlan3
Starting AP wlan4
Connect STA wlan0 to AP
PASS ap_ft_internal_rrb_check 2.233382 2021-01-18 07:16:12.558592
passed all 1 test case(s)
2021-01-18 07:16:12 ./run-tests.py ap_ft_over_ds_ocv
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_ft_over_ds_ocv 1/1
Test: WPA2-PSK-FT AP over DS
Starting AP wlan3
Starting AP wlan4
Connect to first AP
Connect STA wlan0 to AP
Roam to the second AP
Roam back to the first AP
PASS ap_ft_over_ds_ocv 1.985539 2021-01-18 07:16:14.675448
passed all 1 test case(s)
2021-01-18 07:16:14 ./run-tests.py ap_ft_ptk_rekey_ap
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_ft_ptk_rekey_ap 1/1
Test: WPA2-PSK-FT PTK rekeying triggered by AP after roam
Starting AP wlan3
Starting AP wlan4
Connect to first AP
Connect STA wlan0 to AP
Roam to the second AP
Roam back to the first AP
PASS ap_ft_ptk_rekey_ap 4.055358 2021-01-18 07:16:18.861389
passed all 1 test case(s)
2021-01-18 07:16:18 ./run-tests.py ap_hs20_auto_interworking
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_hs20_auto_interworking 1/1
Test: Hotspot 2.0 connection with auto_interworking=1
Starting AP wlan3
PASS ap_hs20_auto_interworking 5.074748 2021-01-18 07:16:24.059931
passed all 1 test case(s)
2021-01-18 07:16:24 ./run-tests.py ap_hs20_eap_unknown
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_hs20_eap_unknown 1/1
Test: Hotspot 2.0 connection with unknown EAP method
Starting AP wlan3
PASS ap_hs20_eap_unknown 0.537017 2021-01-18 07:16:24.721301
passed all 1 test case(s)
2021-01-18 07:16:24 ./run-tests.py ap_hs20_req_conn_capab
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_hs20_req_conn_capab 1/1
Test: Hotspot 2.0 network selection with req_conn_capab
Starting AP wlan3
Not used in home network
Used in roaming network
Verify that req_conn_capab does not prevent connection if no other network is available
Additional req_conn_capab checks
Starting AP wlan4
PASS ap_hs20_req_conn_capab 1.826074 2021-01-18 07:16:26.672368
passed all 1 test case(s)
2021-01-18 07:16:26 ./run-tests.py ap_ht_op_class_116
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_ht_op_class_116 1/1
Test: HT40 on operationg class 116
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_ht_op_class_116 1.597179 2021-01-18 07:16:28.394175
passed all 1 test case(s)
2021-01-18 07:16:28 ./run-tests.py ap_open_sta_enable_disable
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_sta_enable_disable 1/1
Test: AP with open mode and wpa_supplicant ENABLE/DISABLE_NETWORK
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan5 to AP
PASS ap_open_sta_enable_disable 0.947414 2021-01-18 07:16:29.466205
passed all 1 test case(s)
2021-01-18 07:16:29 ./run-tests.py ap_open_sta_ps
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_sta_ps 1/1
Test: Station power save operation
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_open_sta_ps 1.413355 2021-01-18 07:16:31.004311
passed all 1 test case(s)
2021-01-18 07:16:31 ./run-tests.py ap_pmf_beacon_protection_mismatch
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_pmf_beacon_protection_mismatch 1/1
Test: WPA2-PSK Beacon protection MIC mismatch
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_pmf_beacon_protection_mismatch 2.418877 2021-01-18 07:16:33.547344
passed all 1 test case(s)
2021-01-18 07:16:33 ./run-tests.py ap_pmf_sta_sa_query_no_response
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_pmf_sta_sa_query_no_response 1/1
Test: WPA2-PSK AP with station using SA Query and getting no response
Connect STA wlan0 to AP
PASS ap_pmf_sta_sa_query_no_response 4.726932 2021-01-18 07:16:38.398962
passed all 1 test case(s)
2021-01-18 07:16:38 ./run-tests.py ap_vendor_elements
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vendor_elements 1/1
Test: WPA2-PSK AP with vendor elements added
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_vendor_elements 0.93081 2021-01-18 07:16:39.454313
passed all 1 test case(s)
2021-01-18 07:16:39 ./run-tests.py ap_vlan_file_parsing
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vlan_file_parsing 1/1
Test: hostapd vlan_file/mac_file parsing
Starting AP wlan3
PASS ap_vlan_file_parsing 0.413193 2021-01-18 07:16:39.992167
passed all 1 test case(s)
2021-01-18 07:16:40 ./run-tests.py ap_wpa2_eap_ext_enable_network_while_connected
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_ext_enable_network_while_connected 1/1
Test: WPA2-Enterprise interactive identity entry and ENABLE_NETWORK
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan0 to AP
PASS ap_wpa2_eap_ext_enable_network_while_connected 1.867019 2021-01-18 07:16:41.983238
passed all 1 test case(s)
2021-01-18 07:16:42 ./run-tests.py ap_wpa2_eap_fast_eap_sim_ext
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_fast_eap_sim_ext 1/1
Test: WPA2-Enterprise connection using EAP-FAST/EAP-SIM and external GSM auth
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_fast_eap_sim_ext 0.888133 2021-01-18 07:16:42.999438
passed all 1 test case(s)
2021-01-18 07:16:43 ./run-tests.py ap_wpa2_eap_fast_eap_vendor
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_fast_eap_vendor 1/1
Test: WPA2-Enterprise connection using EAP-FAST/EAP-vendor
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_fast_eap_vendor 0.860354 2021-01-18 07:16:43.984111
passed all 1 test case(s)
2021-01-18 07:16:44 ./run-tests.py ap_wpa2_eap_peap_eap_sim
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_peap_eap_sim 1/1
Test: WPA2-Enterprise connection using EAP-PEAP/EAP-SIM
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_peap_eap_sim 0.88753 2021-01-18 07:16:45.000410
passed all 1 test case(s)
2021-01-18 07:16:45 ./run-tests.py ap_wpa2_eap_peap_eap_sim_ext
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_peap_eap_sim_ext 1/1
Test: WPA2-Enterprise connection using EAP-PEAP/EAP-SIM and external GSM auth
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_peap_eap_sim_ext 0.894483 2021-01-18 07:16:46.019412
passed all 1 test case(s)
2021-01-18 07:16:46 ./run-tests.py ap_wpa2_eap_tls_intermediate_ca_ocsp_revoked
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_tls_intermediate_ca_ocsp_revoked 1/1
Test: EAP-TLS with intermediate server/user CA and OCSP on revoked server certificate
openssl ocsp -reqout /tmp/lkp/tmpk1baiyd4 -issuer auth_serv/iCA-server/cacert.pem -sha256 -cert auth_serv/iCA-server/server-revoked.pem -no_nonce -text
openssl result:
OCSP Request Data:
    Version: 1 (0x0)
    Requestor List:
        Certificate ID:
          Hash Algorithm: sha256
          Issuer Name Hash: FAB1B86F06B383391C5EFAA640F93045D4B1BD99310D7336B3702F491F8E1B1A
          Issuer Key Hash: A3384E272FD776BC182DFA0C742314020C6FCA51238325C0B8CBC7F98B904112
          Serial Number: 5C9DE4A6D17A49C88375E75768F77216B2AEB783


openssl ocsp -index auth_serv/iCA-server/index.txt -rsigner auth_serv/iCA-server/cacert.pem -rkey auth_serv/iCA-server/private/cakey.pem -CA auth_serv/iCA-server/cacert.pem -issuer auth_serv/iCA-server/cacert.pem -verify_other auth_serv/iCA-server/cacert.pem -trust_other -ndays 7 -reqin /tmp/lkp/tmpk1baiyd4 -resp_no_certs -respout /tmp/lkp/tmp890wf73z -text
openssl result:
OCSP Request Data:
    Version: 1 (0x0)
    Requestor List:
        Certificate ID:
          Hash Algorithm: sha256
          Issuer Name Hash: FAB1B86F06B383391C5EFAA640F93045D4B1BD99310D7336B3702F491F8E1B1A
          Issuer Key Hash: A3384E272FD776BC182DFA0C742314020C6FCA51238325C0B8CBC7F98B904112
          Serial Number: 5C9DE4A6D17A49C88375E75768F77216B2AEB783
OCSP Response Data:
    OCSP Response Status: successful (0x0)
    Response Type: Basic OCSP Response
    Version: 1 (0x0)
    Responder Id: C = FI, O = w1.fi, CN = Server Intermediate CA
    Produced At: Jan 18 07:16:46 2021 GMT
    Responses:
    Certificate ID:
      Hash Algorithm: sha256
      Issuer Name Hash: FAB1B86F06B383391C5EFAA640F93045D4B1BD99310D7336B3702F491F8E1B1A
      Issuer Key Hash: A3384E272FD776BC182DFA0C742314020C6FCA51238325C0B8CBC7F98B904112
      Serial Number: 5C9DE4A6D17A49C88375E75768F77216B2AEB783
    Cert Status: revoked
    Revocation Time: May  3 15:20:10 2020 GMT
    This Update: Jan 18 07:16:46 2021 GMT
    Next Update: Jan 25 07:16:46 2021 GMT

    Signature Algorithm: sha256WithRSAEncryption
         3e:9f:20:52:3a:50:f1:95:59:eb:07:11:35:9e:99:e5:34:8d:
         c0:1c:48:49:6b:c2:21:69:ff:12:f3:8d:67:89:1f:58:7b:0b:
         40:98:29:c6:1f:fb:b0:54:96:e2:e3:65:0e:04:bf:19:80:41:
         8c:a4:ca:ae:3c:a4:14:2e:16:68:3a:03:35:03:f9:2c:aa:5c:
         32:fa:ba:c4:74:dd:78:a0:7f:77:28:53:78:f4:59:ef:3e:d1:
         e4:12:05:e5:ab:50:db:ce:d4:d1:24:88:28:64:d0:2c:58:4c:
         9b:9e:aa:9b:00:23:8f:a6:b1:3b:43:ca:f5:a5:bb:f7:2c:b3:
         93:65:b1:64:34:f5:81:13:1f:61:07:be:9f:6f:63:cc:1d:69:
         1d:a0:08:bd:1f:76:05:20:c9:11:da:17:06:d1:f8:7c:e4:30:
         52:11:37:0c:d1:66:a9:b6:06:66:7d:c0:e7:40:df:c5:22:4a:
         cb:ea:d9:46:7b:98:b6:fa:37:7a:03:cf:32:09:03:73:64:6e:
         98:18:ef:f6:33:90:85:0e:aa:fc:92:7a:af:87:f1:9a:3a:dc:
         a6:75:22:44:95:db:11:17:53:d0:0f:41:87:99:78:29:18:e6:
         e0:f1:d5:f6:34:7a:7b:2e:76:92:8f:37:fe:a8:8a:14:d5:1f:
         78:85:51:90


Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_tls_intermediate_ca_ocsp_revoked 0.847318 2021-01-18 07:16:46.992710
passed all 1 test case(s)
2021-01-18 07:16:47 ./run-tests.py ap_wpa2_eap_ttls_eap_mschapv2_server_oom
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_ttls_eap_mschapv2_server_oom 1/1
Test: WPA2-Enterprise connection using EAP-TTLS/EAP-MSCHAPv2 - server OOM
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
PASS ap_wpa2_eap_ttls_eap_mschapv2_server_oom 1.932255 2021-01-18 07:16:49.057195
passed all 1 test case(s)
2021-01-18 07:16:49 ./run-tests.py ap_wpa2_eap_ttls_server_cert_eku_client_server
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_ttls_server_cert_eku_client_server 1/1
Test: WPA2-Enterprise using EAP-TTLS and server cert with client and server EKU
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_ttls_server_cert_eku_client_server 0.82954 2021-01-18 07:16:50.012288
passed all 1 test case(s)
2021-01-18 07:16:50 ./run-tests.py ap_wpa2_eap_ttls_server_cert_hash
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_ttls_server_cert_hash 1/1
Test: WPA2-Enterprise connection using EAP-TTLS and server certificate hash
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
PASS ap_wpa2_eap_ttls_server_cert_hash 1.454199 2021-01-18 07:16:51.590287
passed all 1 test case(s)
2021-01-18 07:16:51 ./run-tests.py ap_wpa2_gtk_initial_rsc_tkip
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_gtk_initial_rsc_tkip 1/1
Test: Initial group cipher RSC (TKIP)
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_gtk_initial_rsc_tkip 10.99963 2021-01-18 07:17:02.713745
passed all 1 test case(s)
2021-01-18 07:17:02 ./run-tests.py ap_wpa2_in_different_bridge
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_in_different_bridge 1/1
Test: hostapd behavior with interface in different bridge
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_in_different_bridge 1.567197 2021-01-18 07:17:04.405404
passed all 1 test case(s)
2021-01-18 07:17:04 ./run-tests.py ap_wps_er_http_client
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wps_er_http_client 1/1
Test: WPS ER and HTTP client special cases
HTTP server received: GET /foo.xml HTTP/1.1
HTTP header: Cache-Control: no-cache
HTTP header: Pragma: no-cache
HTTP header: Accept: text/xml, application/xml
HTTP header: User-Agent: wpa_supplicant
HTTP header: Host: 127.0.0.1:12345
HTTP server received: POST /wps_control HTTP/1.1
HTTP header: Host: 127.0.0.1:12345
HTTP header: Content-Type: text/xml; charset="utf-8"
HTTP header: Content-Length: 280
HTTP header: SOAPACTION: "urn:schemas-wifialliance-org:service:WFAWLANConfig:1#GetDeviceInfo"
HTTP server received: SUBSCRIBE /wps_event HTTP/1.1
HTTP header: HOST: 127.0.0.1:12345
HTTP header: CALLBACK: <http://127.0.0.1:49152/event/44733469/1>
HTTP header: NT: upnp:event
HTTP header: TIMEOUT: Second-1800
Event URL: http://127.0.0.1:49152/event/44733469/1
HTTP server received: GET /foo.xml HTTP/1.1
HTTP header: Cache-Control: no-cache
HTTP header: Pragma: no-cache
HTTP header: Accept: text/xml, application/xml
HTTP header: User-Agent: wpa_supplicant
HTTP header: Host: 127.0.0.1:12345
HTTP server received: GET /foo.xml HTTP/1.1
HTTP header: Cache-Control: no-cache
HTTP header: Pragma: no-cache
HTTP header: Accept: text/xml, application/xml
HTTP header: User-Agent: wpa_supplicant
HTTP header: Host: 127.0.0.1:12345
PASS ap_wps_er_http_client 7.081419 2021-01-18 07:17:11.611378
passed all 1 test case(s)
2021-01-18 07:17:11 ./run-tests.py ap_wps_invalid_assoc_req_elem
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wps_invalid_assoc_req_elem 1/1
Test: WPS and invalid IE in Association Request frame
Starting AP wlan3
PASS ap_wps_invalid_assoc_req_elem 2.895211 2021-01-18 07:17:14.631352
passed all 1 test case(s)
2021-01-18 07:17:14 ./run-tests.py dbus_tdls_oom
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dbus_tdls_oom 1/1
Test: D-Bus TDLS operations during OOM
No dbus module available
Skip test case: No dbus module available
SKIP dbus_tdls_oom 0.040761 2021-01-18 07:17:14.795969
passed all 0 test case(s)
skipped 1 test case(s)
2021-01-18 07:17:14 ./run-tests.py dfs_radar_chanlist_vht80
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dfs_radar_chanlist_vht80 1/1
Test: DFS chanlist when radar is detected and VHT80 configured
Starting AP wlan3 on DFS channel
Starting AP wlan3
Trigger a simulated radar event
Connect STA wlan0 to AP
Country code at the end: 00
PASS dfs_radar_chanlist_vht80 5.656441 2021-01-18 07:17:20.577178
passed all 1 test case(s)
2021-01-18 07:17:20 ./run-tests.py dpp_config_dpp_gen_prime256v1
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_config_dpp_gen_prime256v1 1/1
Test: Generate DPP Config Object for DPP network (P-256)
dev0 displays QR Code
dev1 scans QR Code and initiates DPP Authentication
DPP authentication did not succeed (Responder)
Traceback (most recent call last):
  File "./run-tests.py", line 533, in main
    t(dev, apdev)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_dpp.py", line 859, in test_dpp_config_dpp_gen_prime256v1
    configurator=True)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_dpp.py", line 394, in run_dpp_qr_code_auth_unicast
    stop_responder=stop_responder)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_dpp.py", line 3875, in wait_auth_success
    raise Exception("DPP authentication did not succeed (Responder)")
Exception: DPP authentication did not succeed (Responder)
FAIL dpp_config_dpp_gen_prime256v1 5.083848 2021-01-18 07:17:25.789959
passed 0 test case(s)
skipped 0 test case(s)
failed tests: dpp_config_dpp_gen_prime256v1
2021-01-18 07:17:25 ./run-tests.py dpp_config_dpp_gen_secp384r1_secp384r1
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_config_dpp_gen_secp384r1_secp384r1 1/1
Test: Generate DPP Config Object for DPP network (P-384 + P-384)
dev0 displays QR Code
dev1 scans QR Code and initiates DPP Authentication
PASS dpp_config_dpp_gen_secp384r1_secp384r1 0.2373 2021-01-18 07:17:26.158406
passed all 1 test case(s)
2021-01-18 07:17:26 ./run-tests.py dpp_config_no_csign
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_config_no_csign 1/1
Test: DPP Config Object error - no csign
dev0 displays QR Code
dev1 scans QR Code and initiates DPP Authentication
PASS dpp_config_no_csign 2.175501 2021-01-18 07:17:28.459757
passed all 1 test case(s)
2021-01-18 07:17:28 ./run-tests.py dpp_config_signed_connector_error_no_dot_2
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_config_signed_connector_error_no_dot_2 1/1
Test: DPP Config Object signedConnector error - no dot(2)
dev0 displays QR Code
dev1 scans QR Code and initiates DPP Authentication
DPP authentication did not succeed (Responder)
Traceback (most recent call last):
  File "./run-tests.py", line 533, in main
    t(dev, apdev)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_dpp.py", line 1144, in test_dpp_config_signed_connector_error_no_dot_2
    run_dpp_config_error(dev, apdev, build_conf_obj(signed_connector=conn))
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_dpp.py", line 1056, in run_dpp_config_error
    require_conf_failure=conf_failure)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_dpp.py", line 394, in run_dpp_qr_code_auth_unicast
    stop_responder=stop_responder)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_dpp.py", line 3875, in wait_auth_success
    raise Exception("DPP authentication did not succeed (Responder)")
Exception: DPP authentication did not succeed (Responder)
FAIL dpp_config_signed_connector_error_no_dot_2 5.086732 2021-01-18 07:17:33.674045
passed 0 test case(s)
skipped 0 test case(s)
failed tests: dpp_config_signed_connector_error_no_dot_2
2021-01-18 07:17:33 ./run-tests.py dpp_pkex_curve_mismatch
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_pkex_curve_mismatch 1/1
Test: DPP and PKEX with mismatching curve
PASS dpp_pkex_curve_mismatch 2.094433 2021-01-18 07:17:35.898156
passed all 1 test case(s)
2021-01-18 07:17:35 ./run-tests.py dpp_proto_auth_resp_r_auth_mismatch
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_proto_auth_resp_r_auth_mismatch 1/1
Test: DPP protocol testing - R-auth mismatch in Auth Resp
PASS dpp_proto_auth_resp_r_auth_mismatch 2.105385 2021-01-18 07:17:38.128631
passed all 1 test case(s)
2021-01-18 07:17:38 ./run-tests.py dpp_qr_code_keygen_fail
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_qr_code_keygen_fail 1/1
Test: DPP QR Code and keygen failure
PASS dpp_qr_code_keygen_fail 0.044825 2021-01-18 07:17:38.298837
passed all 1 test case(s)
2021-01-18 07:17:38 ./run-tests.py dpp_two_initiators
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_two_initiators 1/1
Test: DPP and two initiators
Unexpected result: <3>DPP-FAIL Configurator rejected configuration
Traceback (most recent call last):
  File "./run-tests.py", line 533, in main
    t(dev, apdev)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_dpp.py", line 4464, in test_dpp_two_initiators
    "DPP-FAIL Already in DPP authentication exchange - ignore new one")
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_dpp.py", line 52, in wait_dpp_fail
    raise Exception("Unexpected result: " + ev)
Exception: Unexpected result: <3>DPP-FAIL Configurator rejected configuration
FAIL dpp_two_initiators 0.073818 2021-01-18 07:17:38.497817
passed 0 test case(s)
skipped 0 test case(s)
failed tests: dpp_two_initiators
2021-01-18 07:17:38 ./run-tests.py ext_password_eap
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ext_password_eap 1/1
Test: External password storage for EAP password
Starting AP wlan3
Connect STA wlan0 to AP
PASS ext_password_eap 0.973908 2021-01-18 07:17:39.606010
passed all 1 test case(s)
2021-01-18 07:17:39 ./run-tests.py fils_sk_pfs_26
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START fils_sk_pfs_26 1/1
Test: FILS SK with PFS (DH group 26)
Starting AP as-erp
Starting AP wlan3 (old add_ap argument type)
Connect STA wlan0 to AP
PASS fils_sk_pfs_26 1.159497 2021-01-18 07:17:40.890428
passed all 1 test case(s)
2021-01-18 07:17:40 ./run-tests.py fst_sta_start_session_bad_session_id
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START fst_sta_start_session_bad_session_id 1/1
Test: FST STA start session - bad session id
Starting AP wlan3 (old add_ap argument type)
Starting AP wlan4 (old add_ap argument type)
Connect STA wlan5 to AP
Connect STA wlan6 to AP
Success. Bad parameter was detected (Session ID)
PASS fst_sta_start_session_bad_session_id 2.137155 2021-01-18 07:17:43.152090
passed all 1 test case(s)
2021-01-18 07:17:43 ./run-tests.py grpform_go_neg_stopped
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START grpform_go_neg_stopped 1/1
Test: GO Negotiation stopped after TX start
wlan1: Trying to discover peer 02:00:00:00:00:00
PASS grpform_go_neg_stopped 1.050386 2021-01-18 07:17:44.327727
passed all 1 test case(s)
2021-01-18 07:17:44 ./run-tests.py hapd_ctrl_eapol_reauth_errors
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START hapd_ctrl_eapol_reauth_errors 1/1
Test: hostapd and EAPOL_REAUTH errors
Starting AP wlan3
PASS hapd_ctrl_eapol_reauth_errors 0.438384 2021-01-18 07:17:44.891352
passed all 1 test case(s)
2021-01-18 07:17:44 ./run-tests.py he80plus80
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START he80plus80 1/1
Test: HE with 80+80 MHz channel width
Starting AP wlan3
Starting AP wlan4
Connect STA wlan1 to AP
PASS he80plus80 1.904203 2021-01-18 07:17:46.921377
passed all 1 test case(s)
2021-01-18 07:17:46 ./run-tests.py he_wifi_generation
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START he_wifi_generation 1/1
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan5 to AP
Country code at the end: 00
PASS he_wifi_generation 2.032662 2021-01-18 07:17:49.079441
passed all 1 test case(s)
2021-01-18 07:17:49 ./run-tests.py ibss_rsn_tkip
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ibss_rsn_tkip 1/1
Test: IBSS RSN with TKIP as the cipher
wlan0 waiting for IBSS start/join to complete
wlan1 waiting for IBSS start/join to complete
wlan0 waiting for 4-way handshake completion with wlan1 02:00:00:00:01:00
wlan1 waiting for 4-way handshake completion with wlan0 02:00:00:00:00:00
PASS ibss_rsn_tkip 8.793589 2021-01-18 07:17:57.998127
passed all 1 test case(s)
2021-01-18 07:17:58 ./run-tests.py mesh_secure_gcmp_gmac
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START mesh_secure_gcmp_gmac 1/1
Test: Secure mesh with GCMP-128 and BIP-GMAC-128
PASS mesh_secure_gcmp_gmac 1.291765 2021-01-18 07:17:59.414325
passed all 1 test case(s)
2021-01-18 07:17:59 ./run-tests.py nfc_invalid_ndef_record
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START nfc_invalid_ndef_record 1/1
Test: Invalid NFC NDEF record handling
PASS nfc_invalid_ndef_record 0.042264 2021-01-18 07:17:59.580644
passed all 1 test case(s)
2021-01-18 07:17:59 ./run-tests.py nfc_wps_handover
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START nfc_wps_handover 1/1
Test: Connect to WPS AP with NFC connection handover
Starting AP wlan3
NFC connection handover
PASS nfc_wps_handover 1.328063 2021-01-18 07:18:01.032241
passed all 1 test case(s)
2021-01-18 07:18:01 ./run-tests.py obss_coex_report_handling2
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START obss_coex_report_handling2 1/1
Test: Overlapping BSS scan report handling with obss_interval=1 and no overlap
Starting AP wlan3
Connect STA wlan0 to AP
PASS obss_coex_report_handling2 3.539684 2021-01-18 07:18:04.695368
passed all 1 test case(s)
2021-01-18 07:18:04 ./run-tests.py p2ps_adv_go_persistent_no_peer_entry
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START p2ps_adv_go_persistent_no_peer_entry 1/1
Test: P2PS advertisement as GO having persistent group (no peer entry)
Start GO negotiation wlan0 -> wlan1
wlan1: Trying to discover peer 02:00:00:00:00:00
wlan0: Trying to discover peer 02:00:00:00:01:00
Group formed
PASS p2ps_adv_go_persistent_no_peer_entry 3.303068 2021-01-18 07:18:08.123259
passed all 1 test case(s)
2021-01-18 07:18:08 ./run-tests.py radius_acct_failure_sta_data
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START radius_acct_failure_sta_data 1/1
Test: RADIUS Accounting and failure to get STA data
Starting AP wlan3
Connect STA wlan0 to AP
PASS radius_acct_failure_sta_data 0.828401 2021-01-18 07:18:09.075401
passed all 1 test case(s)
2021-01-18 07:18:09 ./run-tests.py radius_auth_unreachable2
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START radius_auth_unreachable2 1/1
Test: RADIUS Authentication server unreachable (2)
Starting AP wlan3
Connect STA wlan0 to AP
Checking for RADIUS retries
radiusAuthClientAccessRetransmissions: 1
PASS radius_auth_unreachable2 4.796399 2021-01-18 07:18:13.996467
passed all 1 test case(s)
2021-01-18 07:18:14 ./run-tests.py radius_protocol
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START radius_protocol 1/1
Test: RADIUS Authentication protocol tests with a fake server
Starting AP wlan3
Connect STA wlan0 to AP
Received authentication request
Connect STA wlan0 to AP
Received authentication request
Add Message-Authenticator
Use incorrect RADIUS shared secret
Connect STA wlan0 to AP
Received authentication request
Add Message-Authenticator
Received authentication request
Add Message-Authenticator
Connect STA wlan0 to AP
Received authentication request
Add Message-Authenticator
Include two Message-Authenticator attributes
PASS radius_protocol 5.715058 2021-01-18 07:18:19.835399
passed all 1 test case(s)
2021-01-18 07:18:19 ./run-tests.py radius_psk
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START radius_psk 1/1
Test: WPA2 with PSK from RADIUS
Starting AP wlan3
Connect STA wlan0 to AP
Received authentication request
Connect STA wlan1 to AP
Received authentication request
PASS radius_psk 2.119514 2021-01-18 07:18:22.081536
passed all 1 test case(s)
2021-01-18 07:18:22 ./run-tests.py rrm_beacon_req_table_request_oom
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START rrm_beacon_req_table_request_oom 1/1
Test: Beacon request - beacon table mode - request element OOM
Starting AP wlan3
Connect STA wlan0 to AP
PASS rrm_beacon_req_table_request_oom 1.106744 2021-01-18 07:18:23.317311
passed all 1 test case(s)
2021-01-18 07:18:23 ./run-tests.py rrm_link_measurement_oom
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START rrm_link_measurement_oom 1/1
Test: Radio measurement request - link measurement OOM
Skip test case: Required RRM capabilities are not supported
SKIP rrm_link_measurement_oom 0.042312 2021-01-18 07:18:23.483872
passed all 0 test case(s)
skipped 1 test case(s)
2021-01-18 07:18:23 ./run-tests.py rrm_neighbor_rep_req
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START rrm_neighbor_rep_req 1/1
Test: wpa_supplicant ctrl_iface NEIGHBOR_REP_REQUEST
Starting AP wlan3 (old add_ap argument type)
Starting AP wlan4 (old add_ap argument type)
Connect STA wlan0 to AP
Connect STA wlan0 to AP
PASS rrm_neighbor_rep_req 1.496302 2021-01-18 07:18:25.105370
passed all 1 test case(s)
2021-01-18 07:18:25 ./run-tests.py rsn_preauth_processing
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START rsn_preauth_processing 1/1
Test: RSN pre-authentication processing on AP
Starting AP wlan3
Connect STA wlan0 to AP
PASS rsn_preauth_processing 0.863815 2021-01-18 07:18:26.093218
passed all 1 test case(s)
2021-01-18 07:18:26 ./run-tests.py sae_pk_missing_ie
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_pk_missing_ie 1/1
Test: SAE-PK and missing SAE-PK IE in confirm
Starting AP wlan3
Connect STA wlan0 to AP
PASS sae_pk_missing_ie 2.442482 2021-01-18 07:18:28.661495
passed all 1 test case(s)
2021-01-18 07:18:28 ./run-tests.py sae_pk_only
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_pk_only 1/1
Test: SAE-PK only
Starting AP wlan3
Connect STA wlan0 to AP
Starting AP wlan4
PASS sae_pk_only 1.267646 2021-01-18 07:18:30.054381
passed all 1 test case(s)
2021-01-18 07:18:30 ./run-tests.py scan_bss_expiration_count
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_bss_expiration_count 1/1
Test: BSS entry expiration based on scan results without match
Starting AP wlan3
PASS scan_bss_expiration_count 0.827944 2021-01-18 07:18:31.006657
passed all 1 test case(s)
2021-01-18 07:18:31 ./run-tests.py scan_random_mac_connected
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_random_mac_connected 1/1
Test: Random MAC address in scans while connected
Starting AP wlan3
Connect STA wlan0 to AP
Starting AP wlan4
PASS scan_random_mac_connected 1.265154 2021-01-18 07:18:32.397285
passed all 1 test case(s)
2021-01-18 07:18:32 ./run-tests.py sigma_dut_ap_dpp_tcp_enrollee_init
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_ap_dpp_tcp_enrollee_init 1/1
Test: sigma_dut DPP AP as TCP Enrollee/initiator
Skip test case: sigma_dut not available
SKIP sigma_dut_ap_dpp_tcp_enrollee_init 0.11249 2021-01-18 07:18:32.634834
passed all 0 test case(s)
skipped 1 test case(s)
2021-01-18 07:18:32 ./run-tests.py sigma_dut_ap_ent_ft_eap
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_ap_ent_ft_eap 1/1
Test: sigma_dut controlled AP WPA-EAP and FT-EAP
Skip test case: sigma_dut not available
SKIP sigma_dut_ap_ent_ft_eap 0.103295 2021-01-18 07:18:32.863293
passed all 0 test case(s)
skipped 1 test case(s)
2021-01-18 07:18:32 ./run-tests.py sigma_dut_ap_vht40
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_ap_vht40 1/1
Test: sigma_dut controlled AP and VHT40
Skip test case: sigma_dut not available
SKIP sigma_dut_ap_vht40 0.114717 2021-01-18 07:18:33.102823
passed all 0 test case(s)
skipped 1 test case(s)
2021-01-18 07:18:33 ./run-tests.py sigma_dut_client_privacy
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_client_privacy 1/1
Test: sigma_dut client privacy
Starting AP wlan3
Skip test case: sigma_dut not available
SKIP sigma_dut_client_privacy 0.42407 2021-01-18 07:18:33.651346
passed all 0 test case(s)
skipped 1 test case(s)
2021-01-18 07:18:33 ./run-tests.py sigma_dut_dpp_incompatible_roles_resp
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_dpp_incompatible_roles_resp 1/1
Test: sigma_dut DPP roles incompatible (Responder)
Skip test case: sigma_dut not available
SKIP sigma_dut_dpp_incompatible_roles_resp 0.044547 2021-01-18 07:18:33.820884
passed all 0 test case(s)
skipped 1 test case(s)
2021-01-18 07:18:33 ./run-tests.py suite_b_192_rsa_ecdhe_radius_rsa2048_client
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START suite_b_192_rsa_ecdhe_radius_rsa2048_client 1/1
Test: Suite B 192-bit level and RSA (ECDHE) and RSA2048 client
Starting AP wlan4
Starting AP wlan3
Connect STA wlan0 to AP
PASS suite_b_192_rsa_ecdhe_radius_rsa2048_client 1.304394 2021-01-18 07:18:35.251981
passed all 1 test case(s)
2021-01-18 07:18:35 ./run-tests.py tnc_fast
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START tnc_fast 1/1
Test: TNC FAST
Starting AP wlan3
Connect STA wlan0 to AP
PASS tnc_fast 0.847054 2021-01-18 07:18:36.223233
passed all 1 test case(s)
2021-01-18 07:18:36 ./run-tests.py wep_shared_key_auth
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START wep_shared_key_auth 1/1
Test: WEP Shared Key authentication
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
PASS wep_shared_key_auth 1.393089 2021-01-18 07:18:37.743450
passed all 1 test case(s)
2021-01-18 07:18:37 ./run-tests.py wpa2_ocv_vht80plus80
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START wpa2_ocv_vht80plus80 1/1
Test: OCV with VHT80+80 channel
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
PASS wpa2_ocv_vht80plus80 17.401307 2021-01-18 07:18:55.269855
passed all 1 test case(s)
2021-01-18 07:18:55 ./run-tests.py wpas_ctrl_dup_network_global
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START wpas_ctrl_dup_network_global 1/1
Test: wpa_supplicant ctrl_iface DUP_NETWORK (global)
Starting AP wlan3
Connect STA wlan0 to AP
PASS wpas_ctrl_dup_network_global 0.904912 2021-01-18 07:18:56.299437
passed all 1 test case(s)
2021-01-18 07:18:56 ./run-tests.py wpas_ctrl_get_capability
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START wpas_ctrl_get_capability 1/1
Test: wpa_supplicant ctrl_iface GET_CAPABILITY
GET_CAPABILITY key_mgmt iftype=STATION: ['NONE', 'IEEE8021X', 'WPA-EAP', 'WPA-PSK', 'WPA-EAP-SUITE-B', 'WPA-EAP-SUITE-B-192', 'OWE', 'DPP', 'FILS-SHA256', 'FILS-SHA384', 'FT-FILS-SHA256', 'FT-FILS-SHA384', 'FT-PSK', 'FT-EAP', 'SAE']
GET_CAPABILITY key_mgmt iftype=AP_VLAN: ['NONE', 'IEEE8021X', 'WPA-EAP', 'WPA-PSK', 'WPA-EAP-SUITE-B', 'WPA-EAP-SUITE-B-192', 'OWE', 'DPP', 'FILS-SHA256', 'FILS-SHA384', 'FT-FILS-SHA256', 'FT-FILS-SHA384', 'FT-PSK', 'FT-EAP', 'SAE']
GET_CAPABILITY key_mgmt iftype=AP: ['NONE', 'IEEE8021X', 'WPA-EAP', 'WPA-PSK', 'WPA-EAP-SUITE-B', 'WPA-EAP-SUITE-B-192', 'OWE', 'DPP', 'FILS-SHA256', 'FILS-SHA384', 'FT-FILS-SHA256', 'FT-FILS-SHA384', 'FT-PSK', 'FT-EAP', 'SAE']
GET_CAPABILITY key_mgmt iftype=P2P_GO: ['NONE', 'IEEE8021X', 'WPA-EAP', 'WPA-PSK', 'WPA-EAP-SUITE-B', 'WPA-EAP-SUITE-B-192', 'OWE', 'DPP', 'FILS-SHA256', 'FILS-SHA384', 'FT-FILS-SHA256', 'FT-FILS-SHA384', 'FT-PSK', 'FT-EAP', 'SAE']
GET_CAPABILITY key_mgmt iftype=P2P_CLIENT: ['NONE', 'IEEE8021X', 'WPA-EAP', 'WPA-PSK', 'WPA-EAP-SUITE-B', 'WPA-EAP-SUITE-B-192', 'OWE', 'DPP', 'FILS-SHA256', 'FILS-SHA384', 'FT-FILS-SHA256', 'FT-FILS-SHA384', 'FT-PSK', 'FT-EAP', 'SAE']
GET_CAPABILITY key_mgmt iftype=P2P_DEVICE: ['NONE', 'IEEE8021X', 'WPA-EAP', 'WPA-PSK', 'WPA-EAP-SUITE-B', 'WPA-EAP-SUITE-B-192', 'OWE', 'DPP', 'FILS-SHA256', 'FILS-SHA384', 'FT-FILS-SHA256', 'FT-FILS-SHA384', 'FT-PSK', 'FT-EAP', 'SAE']
GET_CAPABILITY key_mgmt iftype=MESH: ['NONE', 'IEEE8021X', 'WPA-EAP', 'WPA-PSK', 'WPA-EAP-SUITE-B', 'WPA-EAP-SUITE-B-192', 'OWE', 'DPP', 'FILS-SHA256', 'FILS-SHA384', 'FT-FILS-SHA256', 'FT-FILS-SHA384', 'FT-PSK', 'FT-EAP', 'SAE']
GET_CAPABILITY key_mgmt iftype=IBSS: ['NONE', 'IEEE8021X', 'WPA-EAP', 'WPA-PSK', 'WPA-EAP-SUITE-B', 'WPA-EAP-SUITE-B-192', 'OWE', 'DPP', 'FILS-SHA256', 'FILS-SHA384', 'FT-FILS-SHA256', 'FT-FILS-SHA384', 'FT-PSK', 'FT-EAP', 'SAE']
GET_CAPABILITY key_mgmt iftype=NAN: ['NONE', 'IEEE8021X', 'WPA-EAP', 'WPA-PSK', 'WPA-EAP-SUITE-B', 'WPA-EAP-SUITE-B-192', 'OWE', 'DPP', 'FILS-SHA256', 'FILS-SHA384', 'FT-FILS-SHA256', 'FT-FILS-SHA384', 'FT-PSK', 'FT-EAP', 'SAE']
GET_CAPABILITY key_mgmt iftype=UNKNOWN: None
PASS wpas_ctrl_get_capability 0.04336 2021-01-18 07:18:56.467729
passed all 1 test case(s)
2021-01-18 07:18:56 ./run-tests.py wpas_ctrl_set_lci_errors
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START wpas_ctrl_set_lci_errors 1/1
Test: wpa_supplicant SET lci error cases
PASS wpas_ctrl_set_lci_errors 0.084169 2021-01-18 07:18:56.702036
passed all 1 test case(s)
2021-01-18 07:18:56 ./run-tests.py wps_ext_cred_proto_encr_type_missing
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START wps_ext_cred_proto_encr_type_missing 1/1
Test: WPS and Credential: Encr Type missing
Starting AP wlan3
PASS wps_ext_cred_proto_encr_type_missing 0.93755 2021-01-18 07:18:57.772048
passed all 1 test case(s)
2021-01-18 07:18:57 ./run-tests.py wps_ext_cred_proto_network_key_missing_open
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START wps_ext_cred_proto_network_key_missing_open 1/1
Test: WPS and Credential: Network Key missing (open)
Starting AP wlan3
PASS wps_ext_cred_proto_network_key_missing_open 0.927873 2021-01-18 07:18:58.824248
passed all 1 test case(s)
2021-01-18 07:18:58 ./run-tests.py wps_ext_proto_ack_m3
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START wps_ext_proto_ack_m3 1/1
Test: WPS and ACK M3
Starting AP wlan3
PASS wps_ext_proto_ack_m3 1.028458 2021-01-18 07:18:59.977247
passed all 1 test case(s)
2021-01-18 07:18:59 ./run-tests.py wps_ext_proto_ack_m3_no_r_nonce
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START wps_ext_proto_ack_m3_no_r_nonce 1/1
Test: WPS and ACK M3 missing R-Nonce
Starting AP wlan3
PASS wps_ext_proto_ack_m3_no_r_nonce 1.027771 2021-01-18 07:19:01.129276
passed all 1 test case(s)
2021-01-18 07:19:01 ./stop.sh
wpa_supplicant/hostapd/hlr_auc_gw did not exit - try to force them to die



To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install job.yaml  # job file is attached in this email
        bin/lkp run     job.yaml



Thanks,
Oliver Sang


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.10.0-rc7-g1180cd89a7ca"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.10.0-rc7 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-9 (Debian 9.3.0-15) 9.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=90300
CONFIG_LD_VERSION=235000000
CONFIG_CLANG_VERSION=0
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
# CONFIG_EXPERT is not set
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
# CONFIG_BPF_LSM is not set
CONFIG_BPF_SYSCALL=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
# CONFIG_BPF_PRELOAD is not set
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
CONFIG_X86_AMD_PLATFORM_DEVICE=y
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_XEN=y
# CONFIG_XEN_PV is not set
CONFIG_XEN_PVHVM=y
CONFIG_XEN_PVHVM_SMP=y
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
# CONFIG_XEN_PVH is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m
CONFIG_X86_THERMAL_VECTOR=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
CONFIG_PERF_EVENTS_AMD_POWER=m
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_I8K=m
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_AMD_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is not set
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_UMIP=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_XONLY is not set
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=y
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
CONFIG_ACPI_APEI_ERST_DEBUG=y
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_PMIC_OPREGION=y
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_AMD_FREQ_SENSITIVITY=m
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_XEN=y
CONFIG_MMCONF_FAM10H=y
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# CONFIG_X86_SYSFB is not set
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
# end of Binary Emulations

#
# Firmware Drivers
#
CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
CONFIG_APPLE_PROPERTIES=y
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_DEV_PATH_PARSER=y
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
# CONFIG_KVM_AMD is not set
CONFIG_KVM_MMU_AUDIT=y
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_OPROFILE=m
CONFIG_OPROFILE_EVENT_MULTIPLEX=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
CONFIG_BLK_WBT=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
CONFIG_BLK_WBT_MQ=y
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_MQ_RDMA=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_CLEANCACHE=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=19
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
# CONFIG_ZSWAP_DEFAULT_ON is not set
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DEVICE=y
CONFIG_DEV_PAGEMAP_OPS=y
CONFIG_HMM_MIRROR=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_FRAME_VECTOR=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_BENCHMARK is not set
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_MAPPING_DIRTY_HELPERS=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_UNIX_DIAG=m
CONFIG_TLS=m
CONFIG_TLS_DEVICE=y
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_USER_COMPAT is not set
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
# CONFIG_SMC is not set
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_NV=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
CONFIG_TCP_CONG_BBR=m
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_ESP_OFFLOAD=m
# CONFIG_INET6_ESPINTCP is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
CONFIG_NETLABEL=y
# CONFIG_MPTCP is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_COMMON=m
CONFIG_NF_LOG_NETDEV=m
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
CONFIG_NF_CT_NETLINK_HELPER=m
CONFIG_NETFILTER_NETLINK_GLUE_CT=y
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_COUNTER=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_OBJREF=m
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
# CONFIG_NFT_XFRM is not set
CONFIG_NFT_SOCKET=m
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
# CONFIG_NFT_REJECT_NETDEV is not set
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
# CONFIG_NETFILTER_XT_TARGET_LED is not set
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
# CONFIG_IP_NF_TARGET_CLUSTERIP is not set
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
# CONFIG_IP6_NF_TARGET_HL is not set
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_TABLES_BRIDGE=m
# CONFIG_NFT_BRIDGE_META is not set
CONFIG_NFT_BRIDGE_REJECT=m
CONFIG_NF_LOG_BRIDGE=m
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
CONFIG_TIPC=m
# CONFIG_TIPC_MEDIA_IB is not set
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_CRYPTO=y
CONFIG_TIPC_DIAG=m
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
# CONFIG_6LOWPAN_NHC is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_IEEE802154_6LOWPAN=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=y
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
# CONFIG_NET_SCH_FQ_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_ETS is not set
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_FQ_CODEL=y
# CONFIG_DEFAULT_SFQ is not set
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="fq_codel"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
# CONFIG_NET_EMATCH_CANID is not set
CONFIG_NET_EMATCH_IPSET=m
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
# CONFIG_NET_ACT_IPT is not set
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_MPLS is not set
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
# CONFIG_NET_ACT_CONNMARK is not set
# CONFIG_NET_ACT_CTINFO is not set
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
# CONFIG_NET_ACT_GATE is not set
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_KVASER_PCIEFD is not set
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
CONFIG_CAN_EMS_PCI=m
# CONFIG_CAN_F81601 is not set
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_PLX_PCI=m
# CONFIG_CAN_SJA1000_ISA is not set
CONFIG_CAN_SJA1000_PLATFORM=m
CONFIG_CAN_SOFTING=m

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# CONFIG_CAN_MCP251XFD is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
# CONFIG_CAN_8DEV_USB is not set
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB2 is not set
# CONFIG_CAN_GS_USB is not set
# CONFIG_CAN_KVASER_USB is not set
# CONFIG_CAN_MCBA_USB is not set
# CONFIG_CAN_PEAK_USB is not set
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

CONFIG_BT=m
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_HIDP=m
CONFIG_BT_HS=y
CONFIG_BT_LE=y
# CONFIG_BT_6LOWPAN is not set
# CONFIG_BT_LEDS is not set
# CONFIG_BT_MSFTEXT is not set
CONFIG_BT_DEBUGFS=y
# CONFIG_BT_SELFTEST is not set

#
# Bluetooth device drivers
#
# CONFIG_BT_HCIBTUSB is not set
# CONFIG_BT_HCIBTSDIO is not set
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_ATH3K=y
# CONFIG_BT_HCIUART_INTEL is not set
# CONFIG_BT_HCIUART_AG6XX is not set
# CONFIG_BT_HCIBCM203X is not set
# CONFIG_BT_HCIBPA10X is not set
# CONFIG_BT_HCIBFUSB is not set
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
# CONFIG_BT_MRVL_SDIO is not set
# CONFIG_BT_MTKSDIO is not set
# end of Bluetooth device drivers

# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_XEN is not set
# CONFIG_NET_9P_RDMA is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_BW is not set
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=m
# CONFIG_XEN_PCIDEV_FRONTEND is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
CONFIG_PCI_HYPERV=m
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=y
CONFIG_PCI_HYPERV_INTERFACE=m

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_PM_QOS_KUNIT_TEST is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_KUNIT_DRIVER_PE_TEST=y
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=y
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SKD is not set
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_XEN_BLKDEV_FRONTEND=m
CONFIG_VIRTIO_BLK=m
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=m
# CONFIG_NVME_RDMA is not set
CONFIG_NVME_FC=m
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
# CONFIG_NVME_TARGET_RDMA is not set
CONFIG_NVME_TARGET_FC=m
CONFIG_NVME_TARGET_FCLOOP=m
# CONFIG_NVME_TARGET_TCP is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=m
CONFIG_PVPANIC=y
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_HDCP is not set
CONFIG_VMWARE_VMCI=m
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=m
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# CONFIG_UACCE is not set
# end of Misc devices

CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_XEN_SCSI_FRONTEND is not set
CONFIG_HYPERV_STORAGE=m
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
# CONFIG_SCSI_GDTH is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_VIRTIO is not set
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
CONFIG_MD_CLUSTER=m
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_WRITECACHE=m
# CONFIG_DM_EBS is not set
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
# CONFIG_DM_MULTIPATH_HST is not set
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
# CONFIG_DM_ZONED is not set
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_ISCSI_TARGET=m
# CONFIG_SBP_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_IFB is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_MACSEC is not set
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_NET_VRF is not set
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_FIRESTREAM is not set
# CONFIG_ATM_ZATM is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_AMBASSADOR is not set
# CONFIG_ATM_HORIZON is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E is not set
# CONFIG_ATM_HE is not set
# CONFIG_ATM_SOLOS is not set

#
# Distributed Switch Architecture drivers
#
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_MDIO=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
# CONFIG_AMD_XGBE is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_NET_VENDOR_AURORA is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
# CONFIG_IXGBE_DCB is not set
CONFIG_IXGBE_IPSEC=y
# CONFIG_IXGBEVF is not set
CONFIG_I40E=y
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
# CONFIG_IGC is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_PRESTERA is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_ROCKER is not set
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLIB=y
# CONFIG_LED_TRIGGER_PHY is not set
# CONFIG_FIXED_PHY is not set

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_AX88796B_PHY is not set
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
# CONFIG_PCS_XPCS is not set
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
CONFIG_USB_RTL8152=y
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
# CONFIG_USB_NET_CDCETHER is not set
# CONFIG_USB_NET_CDC_EEM is not set
# CONFIG_USB_NET_CDC_NCM is not set
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
# CONFIG_USB_NET_CDC_MBIM is not set
# CONFIG_USB_NET_DM9601 is not set
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
# CONFIG_USB_NET_SMSC75XX is not set
# CONFIG_USB_NET_SMSC95XX is not set
# CONFIG_USB_NET_GL620A is not set
# CONFIG_USB_NET_NET1080 is not set
# CONFIG_USB_NET_PLUSB is not set
# CONFIG_USB_NET_MCS7830 is not set
# CONFIG_USB_NET_RNDIS_HOST is not set
# CONFIG_USB_NET_CDC_SUBSET is not set
# CONFIG_USB_NET_ZAURUS is not set
# CONFIG_USB_NET_CX82310_ETH is not set
# CONFIG_USB_NET_KALMIA is not set
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_HSO is not set
# CONFIG_USB_NET_INT51X1 is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_USB_SIERRA_NET is not set
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH9K is not set
# CONFIG_ATH9K_HTC is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
# CONFIG_ATH11K is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_IWLWIFI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
# CONFIG_MT7601U is not set
# CONFIG_MT76x0U is not set
# CONFIG_MT76x0E is not set
# CONFIG_MT76x2E is not set
# CONFIG_MT76x2U is not set
# CONFIG_MT7603E is not set
# CONFIG_MT7615E is not set
# CONFIG_MT7663U is not set
# CONFIG_MT7663S is not set
# CONFIG_MT7915E is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=m
# CONFIG_RTL8192CE is not set
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8723AE is not set
# CONFIG_RTL8723BE is not set
# CONFIG_RTL8188EE is not set
# CONFIG_RTL8192EE is not set
# CONFIG_RTL8821AE is not set
# CONFIG_RTL8192CU is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
CONFIG_MAC80211_HWSIM=m
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set
# CONFIG_WAN is not set
CONFIG_IEEE802154_DRIVERS=m
# CONFIG_IEEE802154_FAKELB is not set
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_IEEE802154_HWSIM is not set
CONFIG_XEN_NETDEV_FRONTEND=y
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_HYPERV_NET is not set
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_POLLDEV=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
# CONFIG_RMI4_F54 is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=64
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK=m
CONFIG_SYNCLINKMP=m
CONFIG_SYNCLINK_GT=m
# CONFIG_ISI is not set
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
# CONFIG_TRACE_SINK is not set
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set
CONFIG_NVRAM=y
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=8192
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
# CONFIG_TCG_XEN is not set
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# end of Character devices

# CONFIG_RANDOM_TRUST_CPU is not set
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
# CONFIG_DP83640_PHY is not set
# CONFIG_PTP_1588_CLOCK_INES is not set
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# CONFIG_PTP_1588_CLOCK_OCP is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=m
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
CONFIG_PINCTRL_INTEL=y
CONFIG_PINCTRL_BROXTON=m
CONFIG_PINCTRL_CANNONLAKE=m
CONFIG_PINCTRL_CEDARFORK=m
CONFIG_PINCTRL_DENVERTON=m
# CONFIG_PINCTRL_EMMITSBURG is not set
CONFIG_PINCTRL_GEMINILAKE=m
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
CONFIG_PINCTRL_LEWISBURG=m
CONFIG_PINCTRL_SUNRISEPOINT=m
# CONFIG_PINCTRL_TIGERLAKE is not set

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_GENERIC=m

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_AMDPT=m
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_XILINX is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

# CONFIG_GPIO_AGGREGATOR is not set
# CONFIG_GPIO_MOCKUP is not set
# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
CONFIG_CHARGER_SMB347=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
# CONFIG_SENSORS_AMD_ENERGY is not set
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_MLXREG_FAN is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX16601 is not set
# CONFIG_SENSORS_MAX20730 is not set
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_MP2975 is not set
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=m
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_PKG_TEMP_THERMAL=m
CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=m
CONFIG_ACPI_THERMAL_REL=m
# CONFIG_INT3406_THERMAL is not set
CONFIG_PROC_THERMAL_MMIO_RAPL=y
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_MLX_WDT is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=m
CONFIG_SP5100_TCO=m
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set
CONFIG_XEN_WDT=m

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=m
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
# CONFIG_MFD_SL28CPLD is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_INTEL_M10_BMC is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_SANYO_DECODER=m
# CONFIG_IR_SHARP_DECODER is not set
CONFIG_IR_MCE_KBD_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_IR_IMON_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_RC_DEVICES=y
# CONFIG_RC_ATI_REMOTE is not set
CONFIG_IR_ENE=m
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_ITE_CIR=m
CONFIG_IR_FINTEK=m
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
# CONFIG_IR_STREAMZAP is not set
CONFIG_IR_WINBOND_CIR=m
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_TTUSBIR is not set
# CONFIG_RC_LOOPBACK is not set
CONFIG_IR_SERIAL=m
CONFIG_IR_SERIAL_TRANSMITTER=y
CONFIG_IR_SIR=m
# CONFIG_RC_XBOX_DVD is not set
# CONFIG_IR_TOY is not set
CONFIG_MEDIA_CEC_SUPPORT=y
# CONFIG_CEC_CH7322 is not set
# CONFIG_CEC_SECO is not set
# CONFIG_USB_PULSE8_CEC is not set
# CONFIG_USB_RAINSHADOW_CEC is not set
CONFIG_MEDIA_SUPPORT=m
# CONFIG_MEDIA_SUPPORT_FILTER is not set
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_PLATFORM_SUPPORT=y
CONFIG_MEDIA_TEST_SUPPORT=y
# end of Media device types

#
# Media core support
#
CONFIG_VIDEO_DEV=m
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=m
# end of Media core support

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2=m
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
# end of Video4Linux options

#
# Media controller options
#
# CONFIG_MEDIA_CONTROLLER_DVB is not set
# end of Media controller options

#
# Digital TV options
#
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set
# end of Digital TV options

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
CONFIG_RADIO_ADAPTERS=y
# CONFIG_RADIO_SI470X is not set
# CONFIG_RADIO_SI4713 is not set
# CONFIG_USB_MR800 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_SHARK is not set
# CONFIG_RADIO_SHARK2 is not set
# CONFIG_USB_KEENE is not set
# CONFIG_USB_RAREMONO is not set
# CONFIG_USB_MA901 is not set
# CONFIG_RADIO_TEA5764 is not set
# CONFIG_RADIO_SAA7706H is not set
# CONFIG_RADIO_TEF6862 is not set
# CONFIG_RADIO_WL1273 is not set
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set
# CONFIG_SDR_PLATFORM_DRIVERS is not set

#
# MMC/SDIO DVB adapters
#
# CONFIG_SMS_SDIO_DRV is not set
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_TEST_DRIVERS is not set

#
# FireWire (IEEE 1394) Adapters
#
# CONFIG_DVB_FIREDTV is not set
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=m

#
# Audio decoders, processors and mixers
#
# CONFIG_VIDEO_TVAUDIO is not set
# CONFIG_VIDEO_TDA7432 is not set
# CONFIG_VIDEO_TDA9840 is not set
# CONFIG_VIDEO_TEA6415C is not set
# CONFIG_VIDEO_TEA6420 is not set
# CONFIG_VIDEO_MSP3400 is not set
# CONFIG_VIDEO_CS3308 is not set
# CONFIG_VIDEO_CS5345 is not set
# CONFIG_VIDEO_CS53L32A is not set
# CONFIG_VIDEO_TLV320AIC23B is not set
# CONFIG_VIDEO_UDA1342 is not set
# CONFIG_VIDEO_WM8775 is not set
# CONFIG_VIDEO_WM8739 is not set
# CONFIG_VIDEO_VP27SMPX is not set
# CONFIG_VIDEO_SONY_BTF_MPX is not set
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
# CONFIG_VIDEO_SAA6588 is not set
# end of RDS decoders

#
# Video decoders
#
# CONFIG_VIDEO_ADV7180 is not set
# CONFIG_VIDEO_ADV7183 is not set
# CONFIG_VIDEO_ADV7604 is not set
# CONFIG_VIDEO_ADV7842 is not set
# CONFIG_VIDEO_BT819 is not set
# CONFIG_VIDEO_BT856 is not set
# CONFIG_VIDEO_BT866 is not set
# CONFIG_VIDEO_KS0127 is not set
# CONFIG_VIDEO_ML86V7667 is not set
# CONFIG_VIDEO_SAA7110 is not set
# CONFIG_VIDEO_SAA711X is not set
# CONFIG_VIDEO_TC358743 is not set
# CONFIG_VIDEO_TVP514X is not set
# CONFIG_VIDEO_TVP5150 is not set
# CONFIG_VIDEO_TVP7002 is not set
# CONFIG_VIDEO_TW2804 is not set
# CONFIG_VIDEO_TW9903 is not set
# CONFIG_VIDEO_TW9906 is not set
# CONFIG_VIDEO_TW9910 is not set
# CONFIG_VIDEO_VPX3220 is not set

#
# Video and audio decoders
#
# CONFIG_VIDEO_SAA717X is not set
# CONFIG_VIDEO_CX25840 is not set
# end of Video decoders

#
# Video encoders
#
# CONFIG_VIDEO_SAA7127 is not set
# CONFIG_VIDEO_SAA7185 is not set
# CONFIG_VIDEO_ADV7170 is not set
# CONFIG_VIDEO_ADV7175 is not set
# CONFIG_VIDEO_ADV7343 is not set
# CONFIG_VIDEO_ADV7393 is not set
# CONFIG_VIDEO_ADV7511 is not set
# CONFIG_VIDEO_AD9389B is not set
# CONFIG_VIDEO_AK881X is not set
# CONFIG_VIDEO_THS8200 is not set
# end of Video encoders

#
# Video improvement chips
#
# CONFIG_VIDEO_UPD64031A is not set
# CONFIG_VIDEO_UPD64083 is not set
# end of Video improvement chips

#
# Audio/Video compression chips
#
# CONFIG_VIDEO_SAA6752HS is not set
# end of Audio/Video compression chips

#
# SDR tuner chips
#
# CONFIG_SDR_MAX2175 is not set
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
# CONFIG_VIDEO_THS7303 is not set
# CONFIG_VIDEO_M52790 is not set
# CONFIG_VIDEO_I2C is not set
# CONFIG_VIDEO_ST_MIPID02 is not set
# end of Miscellaneous helper chips

#
# Camera sensor devices
#
# CONFIG_VIDEO_HI556 is not set
# CONFIG_VIDEO_IMX214 is not set
# CONFIG_VIDEO_IMX219 is not set
# CONFIG_VIDEO_IMX258 is not set
# CONFIG_VIDEO_IMX274 is not set
# CONFIG_VIDEO_IMX290 is not set
# CONFIG_VIDEO_IMX319 is not set
# CONFIG_VIDEO_IMX355 is not set
# CONFIG_VIDEO_OV2640 is not set
# CONFIG_VIDEO_OV2659 is not set
# CONFIG_VIDEO_OV2680 is not set
# CONFIG_VIDEO_OV2685 is not set
# CONFIG_VIDEO_OV2740 is not set
# CONFIG_VIDEO_OV5647 is not set
# CONFIG_VIDEO_OV6650 is not set
# CONFIG_VIDEO_OV5670 is not set
# CONFIG_VIDEO_OV5675 is not set
# CONFIG_VIDEO_OV5695 is not set
# CONFIG_VIDEO_OV7251 is not set
# CONFIG_VIDEO_OV772X is not set
# CONFIG_VIDEO_OV7640 is not set
# CONFIG_VIDEO_OV7670 is not set
# CONFIG_VIDEO_OV7740 is not set
# CONFIG_VIDEO_OV8856 is not set
# CONFIG_VIDEO_OV9640 is not set
# CONFIG_VIDEO_OV9650 is not set
# CONFIG_VIDEO_OV13858 is not set
# CONFIG_VIDEO_VS6624 is not set
# CONFIG_VIDEO_MT9M001 is not set
# CONFIG_VIDEO_MT9M032 is not set
# CONFIG_VIDEO_MT9M111 is not set
# CONFIG_VIDEO_MT9P031 is not set
# CONFIG_VIDEO_MT9T001 is not set
# CONFIG_VIDEO_MT9T112 is not set
# CONFIG_VIDEO_MT9V011 is not set
# CONFIG_VIDEO_MT9V032 is not set
# CONFIG_VIDEO_MT9V111 is not set
# CONFIG_VIDEO_SR030PC30 is not set
# CONFIG_VIDEO_NOON010PC30 is not set
# CONFIG_VIDEO_M5MOLS is not set
# CONFIG_VIDEO_RDACM20 is not set
# CONFIG_VIDEO_RJ54N1 is not set
# CONFIG_VIDEO_S5K6AA is not set
# CONFIG_VIDEO_S5K6A3 is not set
# CONFIG_VIDEO_S5K4ECGX is not set
# CONFIG_VIDEO_S5K5BAF is not set
# CONFIG_VIDEO_SMIAPP is not set
# CONFIG_VIDEO_ET8EK8 is not set
# CONFIG_VIDEO_S5C73M3 is not set
# end of Camera sensor devices

#
# Lens drivers
#
# CONFIG_VIDEO_AD5820 is not set
# CONFIG_VIDEO_AK7375 is not set
# CONFIG_VIDEO_DW9714 is not set
# CONFIG_VIDEO_DW9768 is not set
# CONFIG_VIDEO_DW9807_VCM is not set
# end of Lens drivers

#
# Flash devices
#
# CONFIG_VIDEO_ADP1653 is not set
# CONFIG_VIDEO_LM3560 is not set
# CONFIG_VIDEO_LM3646 is not set
# end of Flash devices

#
# SPI helper chips
#
# CONFIG_VIDEO_GS1662 is not set
# end of SPI helper chips

#
# Media SPI Adapters
#
CONFIG_CXD2880_SPI_DRV=m
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=m

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
CONFIG_MEDIA_TUNER_MSI001=m
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
CONFIG_MEDIA_TUNER_FC0013=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_R820T=m
CONFIG_MEDIA_TUNER_MXL301RF=m
CONFIG_MEDIA_TUNER_QM1D1C0042=m
CONFIG_MEDIA_TUNER_QM1D1B0004=m
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=m
CONFIG_DVB_STB6100=m
CONFIG_DVB_STV090x=m
CONFIG_DVB_STV0910=m
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m
CONFIG_DVB_MXL5XX=m
CONFIG_DVB_M88DS3103=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_TDA18271C2DD=m
CONFIG_DVB_SI2165=m
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24123=m
CONFIG_DVB_MT312=m
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_STV0288=m
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV6110=m
CONFIG_DVB_STV0900=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8261=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_TUNER_ITD1000=m
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TUA6100=m
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
CONFIG_DVB_CX24120=m
CONFIG_DVB_SI21XX=m
CONFIG_DVB_TS2020=m
CONFIG_DVB_DS3000=m
CONFIG_DVB_MB86A16=m
CONFIG_DVB_TDA10071=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
CONFIG_DVB_S5H1432=m
CONFIG_DVB_DRXD=m
CONFIG_DVB_L64781=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_MT352=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m
CONFIG_DVB_DIB9000=m
CONFIG_DVB_TDA10048=m
CONFIG_DVB_AF9013=m
CONFIG_DVB_EC100=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_RTL2832_SDR=m
CONFIG_DVB_SI2168=m
CONFIG_DVB_ZD1301_DEMOD=m
CONFIG_DVB_CXD2880=m

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
CONFIG_DVB_STV0297=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_LGDT3305=m
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LG2160=m
CONFIG_DVB_S5H1409=m
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_S5H1411=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=m
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=m
CONFIG_DVB_MN88443X=m

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
CONFIG_DVB_TUNER_DIB0070=m
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=m
CONFIG_DVB_LNBH25=m
CONFIG_DVB_LNBH29=m
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_A8293=m
CONFIG_DVB_LGS8GL5=m
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m
CONFIG_DVB_HORUS3A=m
CONFIG_DVB_ASCOT2E=m
CONFIG_DVB_HELENE=m

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m
CONFIG_DVB_SP2=m
# end of Customise DVB Frontends

#
# Tools to develop new frontends
#
# CONFIG_DVB_DUMMY_FE is not set
# end of Media ancillary drivers

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_TTM_DMA_PAGE_POOL=y
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_GVT=y
CONFIG_DRM_I915_GVT_KVMGT=m
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
CONFIG_DRM_VMWGFX=m
CONFIG_DRM_VMWGFX_FBCON=y
CONFIG_DRM_GMA500=m
CONFIG_DRM_GMA600=y
CONFIG_DRM_GMA3600=y
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_QXL=m
CONFIG_DRM_BOCHS=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_GM12U320 is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_XEN is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_XEN_FBDEV_FRONTEND is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=m
CONFIG_HID_CHICONY=m
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=m
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
CONFIG_HID_NTI=m
# CONFIG_HID_NTRIG is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=m
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

#
# I2C HID support
#
CONFIG_I2C_HID=m
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=m
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
# end of Intel ISH HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_CDNS3 is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
# CONFIG_USB_SERIAL_AIRCABLE is not set
# CONFIG_USB_SERIAL_ARK3116 is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_CH341 is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_CP210X is not set
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
# CONFIG_USB_SERIAL_GARMIN is not set
# CONFIG_USB_SERIAL_IPW is not set
# CONFIG_USB_SERIAL_IUU is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_METRO is not set
# CONFIG_USB_SERIAL_MOS7720 is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
# CONFIG_USB_SERIAL_MXUPORT is not set
# CONFIG_USB_SERIAL_NAVMAN is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_OTI6858 is not set
# CONFIG_USB_SERIAL_QCAUX is not set
# CONFIG_USB_SERIAL_QUALCOMM is not set
# CONFIG_USB_SERIAL_SPCP8X5 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
# CONFIG_USB_SERIAL_SYMBOL is not set
# CONFIG_USB_SERIAL_TI is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_XIRCOM is not set
# CONFIG_USB_SERIAL_OPTION is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_SERIAL_OPTICON is not set
# CONFIG_USB_SERIAL_XSENS_MT is not set
# CONFIG_USB_SERIAL_WISHBONE is not set
# CONFIG_USB_SERIAL_SSU100 is not set
# CONFIG_USB_SERIAL_QT2 is not set
# CONFIG_USB_SERIAL_UPD78F0730 is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
# CONFIG_USB_ATM is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_STUSB160X is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SPI is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
# CONFIG_MMC_REALTEK_PCI is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
CONFIG_LEDS_CLEVO_MAIL=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=m
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_ACCESSIBILITY is not set
CONFIG_INFINIBAND=m
CONFIG_INFINIBAND_USER_MAD=m
CONFIG_INFINIBAND_USER_ACCESS=m
CONFIG_INFINIBAND_USER_MEM=y
CONFIG_INFINIBAND_ON_DEMAND_PAGING=y
CONFIG_INFINIBAND_ADDR_TRANS=y
CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=y
CONFIG_INFINIBAND_VIRT_DMA=y
# CONFIG_INFINIBAND_MTHCA is not set
# CONFIG_INFINIBAND_EFA is not set
# CONFIG_INFINIBAND_I40IW is not set
# CONFIG_MLX4_INFINIBAND is not set
# CONFIG_INFINIBAND_OCRDMA is not set
# CONFIG_INFINIBAND_USNIC is not set
# CONFIG_INFINIBAND_BNXT_RE is not set
# CONFIG_INFINIBAND_RDMAVT is not set
CONFIG_RDMA_RXE=m
CONFIG_RDMA_SIW=m
CONFIG_INFINIBAND_IPOIB=m
# CONFIG_INFINIBAND_IPOIB_CM is not set
CONFIG_INFINIBAND_IPOIB_DEBUG=y
# CONFIG_INFINIBAND_IPOIB_DEBUG_DATA is not set
CONFIG_INFINIBAND_SRP=m
CONFIG_INFINIBAND_SRPT=m
# CONFIG_INFINIBAND_ISER is not set
# CONFIG_INFINIBAND_ISERT is not set
# CONFIG_INFINIBAND_RTRS_CLIENT is not set
# CONFIG_INFINIBAND_RTRS_SERVER is not set
# CONFIG_INFINIBAND_OPA_VNIC is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=m
CONFIG_EDAC_GHES=y
CONFIG_EDAC_AMD64=m
# CONFIG_EDAC_AMD64_ERROR_INJECTION is not set
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RX6110 is not set
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
# CONFIG_RTC_DRV_RV3029_HWMON is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=m
# CONFIG_INTEL_IDXD is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_XILINX_ZYNQMP_DPDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# end of DMABUF options

CONFIG_DCA=m
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_UIO_HV_GENERIC=m
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_VFIO_MDEV=m
CONFIG_VFIO_MDEV_DEVICE=m
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=m
CONFIG_VIRTIO_MEM=m
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=m
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

#
# Xen driver support
#
# CONFIG_XEN_BALLOON is not set
CONFIG_XEN_DEV_EVTCHN=m
# CONFIG_XEN_BACKEND is not set
CONFIG_XENFS=m
CONFIG_XEN_COMPAT_XENFS=y
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
# CONFIG_XEN_GNTDEV is not set
# CONFIG_XEN_GRANT_DEV_ALLOC is not set
# CONFIG_XEN_GRANT_DMA_ALLOC is not set
CONFIG_SWIOTLB_XEN=y
# CONFIG_XEN_PVCALLS_FRONTEND is not set
CONFIG_XEN_PRIVCMD=m
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
# CONFIG_XEN_UNPOPULATED_ALLOC is not set
# end of Xen driver support

# CONFIG_GREYBUS is not set
# CONFIG_STAGING is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_ALIENWARE_WMI is not set
# CONFIG_HUAWEI_WMI is not set
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m
CONFIG_MXM_WMI=m
# CONFIG_PEAQ_WMI is not set
# CONFIG_XIAOMI_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
CONFIG_EEEPC_LAPTOP=m
CONFIG_EEEPC_WMI=m
CONFIG_DCDBAS=m
CONFIG_DELL_SMBIOS=m
CONFIG_DELL_SMBIOS_WMI=y
# CONFIG_DELL_SMBIOS_SMM is not set
CONFIG_DELL_LAPTOP=m
CONFIG_DELL_RBTN=m
CONFIG_DELL_RBU=m
CONFIG_DELL_SMO8800=m
CONFIG_DELL_WMI=m
CONFIG_DELL_WMI_DESCRIPTOR=m
CONFIG_DELL_WMI_AIO=m
CONFIG_DELL_WMI_LED=m
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
CONFIG_HP_WIRELESS=m
CONFIG_HP_WMI=m
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
CONFIG_SENSORS_HDAPS=m
CONFIG_THINKPAD_ACPI=m
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
# CONFIG_INTEL_ATOMISP2_PM is not set
CONFIG_INTEL_HID_EVENT=m
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_MENLOW is not set
CONFIG_INTEL_OAKTRAIL=m
CONFIG_INTEL_VBTN=m
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
CONFIG_COMPAL_LAPTOP=m
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_I2C_MULTI_INSTANTIATE is not set
CONFIG_MLX_PLATFORM=m
CONFIG_INTEL_IPS=m
CONFIG_INTEL_RST=m
# CONFIG_INTEL_SMARTCONNECT is not set

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_TURBO_MAX_3=y
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
CONFIG_INTEL_PMC_CORE=m
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
# CONFIG_MLXREG_IO is not set
CONFIG_HAVE_CLK=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOASID=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
CONFIG_AMD_IOMMU=y
CONFIG_AMD_IOMMU_V2=m
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
# CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON is not set
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Aspeed SoC drivers
#
# end of Aspeed SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_USB_LGM_PHY is not set
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_BLK=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX_DRIVER=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_DEV_DAX_PMEM_COMPAT=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# HW tracing support
#
CONFIG_STM=m
# CONFIG_STM_PROTO_BASIC is not set
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_TEE is not set
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=m
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_EXT4_KUNIT_TESTS=m
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_ONLINE_REPAIR=y
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
CONFIG_F2FS_FS_SECURITY=y
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_IO_TRACE is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
# CONFIG_ZONEFS_FS is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_SQUASHFS=m
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
CONFIG_MINIX_FS=m
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFS_V4_2_READ_PLUS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_SUNRPC_XPRT_RDMA=m
CONFIG_CEPH_FS=m
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=y
# CONFIG_CEPH_FS_SECURITY_LABEL is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_WEAK_PW_HASH=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SMB_DIRECT is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITY_WRITABLE_HOOKS=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
# CONFIG_SECURITY_INFINIBAND is not set
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_FALLBACK=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_DISABLE=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=9
CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=256
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
# CONFIG_SECURITY_APPARMOR_KUNIT_TEST is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_LSM_RULES=y
# CONFIG_IMA_TEMPLATE is not set
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
# CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
# CONFIG_IMA_WRITE_POLICY is not set
# CONFIG_IMA_READ_POLICY is not set
CONFIG_IMA_APPRAISE=y
# CONFIG_IMA_ARCH_POLICY is not set
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
# CONFIG_IMA_APPRAISE_MODSIG is not set
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# CONFIG_CRYPTO_CURVE25519_X86 is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=m
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ESSIV=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_XXHASH=m
CONFIG_CRYPTO_BLAKE2B=m
# CONFIG_CRYPTO_BLAKE2S is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=m
CONFIG_CRYPTO_POLY1305_X86_64=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD128=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_RMD256=m
CONFIG_CRYPTO_RMD320=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_DES3_EDE_X86_64=m
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SALSA20=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CHACHA20_X86_64=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
# CONFIG_CRYPTO_LIB_BLAKE2S is not set
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=m
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=m
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=m
CONFIG_CRYPTO_DEV_SP_CCP=y
CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
CONFIG_CRYPTO_DEV_SP_PSP=y
# CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
CONFIG_CRYPTO_DEV_NITROX=m
CONFIG_CRYPTO_DEV_NITROX_CNN55XX=m
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
# CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_CORDIC=m
# CONFIG_PRIME_NUMBERS is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_DMA_VIRT_OPS=y
CONFIG_SWIOTLB=y
CONFIG_DMA_COHERENT_POOL=y
CONFIG_DMA_CMA=y
# CONFIG_DMA_PERNUMA_CMA is not set

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=200
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_DIMLIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_SBITMAP=y
# CONFIG_STRING_SELFTEST is not set
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
# end of Generic Kernel Debugging Instruments

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# CONFIG_KASAN is not set
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=m
CONFIG_RCU_SCALE_TEST=m
CONFIG_RCU_TORTURE_TEST=m
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_SAMPLES is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_X86_DECODER_SELFTEST=y
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
CONFIG_KUNIT=y
# CONFIG_KUNIT_DEBUGFS is not set
CONFIG_KUNIT_TEST=m
CONFIG_KUNIT_EXAMPLE_TEST=m
# CONFIG_KUNIT_ALL_TESTS is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
# CONFIG_FAULT_INJECTION_USERCOPY is not set
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
# CONFIG_FAIL_MMC_REQUEST is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=y
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_STRSCPY is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
CONFIG_TEST_BPF=m
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_BITFIELD_KUNIT is not set
CONFIG_SYSCTL_KUNIT_TEST=m
CONFIG_LIST_KUNIT_TEST=m
# CONFIG_LINEAR_RANGES_TEST is not set
# CONFIG_BITS_TEST is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_LIVEPATCH is not set
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_HMM is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='hwsim'
	export testcase='hwsim'
	export category='functional'
	export need_memory='1G'
	export job_origin='/lkp-src/allot/cyclic:p1:linux-devel:devel-hourly/lkp-skl-d04/hwsim-part3.yaml'
	export queue_cmdline_keys=
	export queue='vip'
	export testbox='lkp-skl-d04'
	export tbox_group='lkp-skl-d04'
	export kconfig='x86_64-rhel-8.3'
	export submit_id='600545ea0b9a93557f33d238'
	export job_file='/lkp/jobs/scheduled/lkp-skl-d04/hwsim-group-26-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-1180cd89a7ca9add3e086f7f06b76d6114ae8593-20210118-21887-beklsj-5.yaml'
	export id='4aa1af6cc43caaefc58631fbb859975793c4727b'
	export queuer_version='/lkp/xsang/.src-20210118-105625'
	export model='Skylake'
	export nr_cpu=4
	export memory='32G'
	export nr_ssd_partitions=1
	export nr_hdd_partitions=4
	export hdd_partitions='/dev/disk/by-id/ata-ST1000DM003-1ER162_Z4YB7AEL-part*'
	export ssd_partitions='/dev/disk/by-id/wwn-0x55cd2e404b64c499-part2'
	export rootfs_partition='/dev/disk/by-id/wwn-0x55cd2e404b64c499-part1'
	export brand='Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz'
	export need_kconfig='CONFIG_WLAN=y
CONFIG_CFG80211=m
CONFIG_CFG80211_WEXT=y
CONFIG_MAC80211=m
CONFIG_MAC80211_HWSIM=m
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_DEBUGFS=y
CONFIG_VETH=m
CONFIG_BRIDGE=m'
	export commit='1180cd89a7ca9add3e086f7f06b76d6114ae8593'
	export need_kconfig_hw='CONFIG_E1000E=y
CONFIG_SATA_AHCI'
	export ucode='0xe2'
	export enqueue_time='2021-01-18 16:25:14 +0800'
	export _id='600545f10b9a93557f33d23d'
	export _rt='/result/hwsim/group-26-ucode=0xe2/lkp-skl-d04/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/1180cd89a7ca9add3e086f7f06b76d6114ae8593'
	export user='lkp'
	export compiler='gcc-9'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='d7177688a51bfce76f3a949d3e4091319d482c55'
	export base_commit='7c53f6b671f4aba70ff15e1b05148b10d58c2837'
	export branch='linux-review/Johannes-Berg/cfg80211-avoid-holding-the-RTNL-when-calling-the-driver/20210115-124633'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export result_root='/result/hwsim/group-26-ucode=0xe2/lkp-skl-d04/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/1180cd89a7ca9add3e086f7f06b76d6114ae8593/8'
	export scheduler_version='/lkp/lkp/.src-20210117-232759'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-skl-d04/hwsim-group-26-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-1180cd89a7ca9add3e086f7f06b76d6114ae8593-20210118-21887-beklsj-5.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3
branch=linux-review/Johannes-Berg/cfg80211-avoid-holding-the-RTNL-when-calling-the-driver/20210115-124633
commit=1180cd89a7ca9add3e086f7f06b76d6114ae8593
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/1180cd89a7ca9add3e086f7f06b76d6114ae8593/vmlinuz-5.10.0-rc7-g1180cd89a7ca
max_uptime=2100
RESULT_ROOT=/result/hwsim/group-26-ucode=0xe2/lkp-skl-d04/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/1180cd89a7ca9add3e086f7f06b76d6114ae8593/8
LKP_SERVER=internal-lkp-server
nokaslr
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/1180cd89a7ca9add3e086f7f06b76d6114ae8593/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hwsim_20210101.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/hwsim-x86_64-537ab94-1_20210101.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20201117.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.10.0-rc7-g1180cd89a7ca'
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-9/1180cd89a7ca9add3e086f7f06b76d6114ae8593/vmlinuz-5.10.0-rc7-g1180cd89a7ca'
	export dequeue_time='2021-01-18 16:26:55 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-skl-d04/hwsim-group-26-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-1180cd89a7ca9add3e086f7f06b76d6114ae8593-20210118-21887-beklsj-5.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test test='group-26' $LKP_SRC/tests/wrapper hwsim
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper hwsim
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time hwsim.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--gatW/ieO32f1wygP
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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

--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=hwsim

2021-01-18 07:15:17 export USER=root
2021-01-18 07:15:17 ./build.sh
Building TNC testing tools
Building wlantest
Building hs20-osu-client
Building hostapd
Building wpa_supplicant
2021-01-18 07:15:55 ./start.sh
2021-01-18 07:15:56 ./run-tests.py ap_acs_vht160_scan_disable
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_acs_vht160_scan_disable 1/1
Test: Automatic channel selection for VHT160 and DISABLE during scan
Starting AP wlan3
Removing BSS wlan3
Starting AP wlan3
Country code at the end: 00
PASS ap_acs_vht160_scan_disable 4.534067 2021-01-18 07:16:01.537145
passed all 1 test case(s)
2021-01-18 07:16:01 ./run-tests.py ap_beacon_rate_ht2
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_beacon_rate_ht2 1/1
Test: Open AP with Beacon frame TX rate HT-MCS 1 in VHT BSS
Starting AP wlan3
Skip test case: Setting Beacon frame TX rate not supported
SKIP ap_beacon_rate_ht2 0.441666 2021-01-18 07:16:02.110637
passed all 0 test case(s)
skipped 1 test case(s)
2021-01-18 07:16:02 ./run-tests.py ap_beacon_rate_legacy
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_beacon_rate_legacy 1/1
Test: Open AP with Beacon frame TX rate 5.5 Mbps
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_beacon_rate_legacy 1.675754 2021-01-18 07:16:03.917328
passed all 1 test case(s)
2021-01-18 07:16:03 ./run-tests.py ap_cipher_bip
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_cipher_bip 1/1
Test: WPA2-PSK with BIP
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_cipher_bip 0.887131 2021-01-18 07:16:04.934558
passed all 1 test case(s)
2021-01-18 07:16:04 ./run-tests.py ap_config_reload_file
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_config_reload_file 1/1
Test: hostapd configuration reload from file
Starting interface wlan3
Connect STA wlan0 to AP
PASS ap_config_reload_file 0.962365 2021-01-18 07:16:06.026662
passed all 1 test case(s)
2021-01-18 07:16:06 ./run-tests.py ap_csa_1_switch
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_csa_1_switch 1/1
Test: AP Channel Switch, one switch
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_csa_1_switch 1.827291 2021-01-18 07:16:07.983522
passed all 1 test case(s)
2021-01-18 07:16:08 ./run-tests.py ap_ft_gcmp_256
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_ft_gcmp_256 1/1
Test: WPA2-PSK-FT AP with GCMP-256 cipher
Starting AP wlan3
Starting AP wlan4
Connect to first AP
Connect STA wlan0 to AP
Roam to the second AP
Roam back to the first AP
PASS ap_ft_gcmp_256 2.07804 2021-01-18 07:16:10.192471
passed all 1 test case(s)
2021-01-18 07:16:10 ./run-tests.py ap_ft_internal_rrb_check
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_ft_internal_rrb_check 1/1
Test: RRB internal delivery only to WPA enabled BSS
Starting AP wlan3
Starting AP wlan4
Connect STA wlan0 to AP
PASS ap_ft_internal_rrb_check 2.233382 2021-01-18 07:16:12.558592
passed all 1 test case(s)
2021-01-18 07:16:12 ./run-tests.py ap_ft_over_ds_ocv
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_ft_over_ds_ocv 1/1
Test: WPA2-PSK-FT AP over DS
Starting AP wlan3
Starting AP wlan4
Connect to first AP
Connect STA wlan0 to AP
Roam to the second AP
Roam back to the first AP
PASS ap_ft_over_ds_ocv 1.985539 2021-01-18 07:16:14.675448
passed all 1 test case(s)
2021-01-18 07:16:14 ./run-tests.py ap_ft_ptk_rekey_ap
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_ft_ptk_rekey_ap 1/1
Test: WPA2-PSK-FT PTK rekeying triggered by AP after roam
Starting AP wlan3
Starting AP wlan4
Connect to first AP
Connect STA wlan0 to AP
Roam to the second AP
Roam back to the first AP
PASS ap_ft_ptk_rekey_ap 4.055358 2021-01-18 07:16:18.861389
passed all 1 test case(s)
2021-01-18 07:16:18 ./run-tests.py ap_hs20_auto_interworking
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_hs20_auto_interworking 1/1
Test: Hotspot 2.0 connection with auto_interworking=1
Starting AP wlan3
PASS ap_hs20_auto_interworking 5.074748 2021-01-18 07:16:24.059931
passed all 1 test case(s)
2021-01-18 07:16:24 ./run-tests.py ap_hs20_eap_unknown
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_hs20_eap_unknown 1/1
Test: Hotspot 2.0 connection with unknown EAP method
Starting AP wlan3
PASS ap_hs20_eap_unknown 0.537017 2021-01-18 07:16:24.721301
passed all 1 test case(s)
2021-01-18 07:16:24 ./run-tests.py ap_hs20_req_conn_capab
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_hs20_req_conn_capab 1/1
Test: Hotspot 2.0 network selection with req_conn_capab
Starting AP wlan3
Not used in home network
Used in roaming network
Verify that req_conn_capab does not prevent connection if no other network is available
Additional req_conn_capab checks
Starting AP wlan4
PASS ap_hs20_req_conn_capab 1.826074 2021-01-18 07:16:26.672368
passed all 1 test case(s)
2021-01-18 07:16:26 ./run-tests.py ap_ht_op_class_116
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_ht_op_class_116 1/1
Test: HT40 on operationg class 116
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_ht_op_class_116 1.597179 2021-01-18 07:16:28.394175
passed all 1 test case(s)
2021-01-18 07:16:28 ./run-tests.py ap_open_sta_enable_disable
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_sta_enable_disable 1/1
Test: AP with open mode and wpa_supplicant ENABLE/DISABLE_NETWORK
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan5 to AP
PASS ap_open_sta_enable_disable 0.947414 2021-01-18 07:16:29.466205
passed all 1 test case(s)
2021-01-18 07:16:29 ./run-tests.py ap_open_sta_ps
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_sta_ps 1/1
Test: Station power save operation
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_open_sta_ps 1.413355 2021-01-18 07:16:31.004311
passed all 1 test case(s)
2021-01-18 07:16:31 ./run-tests.py ap_pmf_beacon_protection_mismatch
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_pmf_beacon_protection_mismatch 1/1
Test: WPA2-PSK Beacon protection MIC mismatch
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_pmf_beacon_protection_mismatch 2.418877 2021-01-18 07:16:33.547344
passed all 1 test case(s)
2021-01-18 07:16:33 ./run-tests.py ap_pmf_sta_sa_query_no_response
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_pmf_sta_sa_query_no_response 1/1
Test: WPA2-PSK AP with station using SA Query and getting no response
Connect STA wlan0 to AP
PASS ap_pmf_sta_sa_query_no_response 4.726932 2021-01-18 07:16:38.398962
passed all 1 test case(s)
2021-01-18 07:16:38 ./run-tests.py ap_vendor_elements
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vendor_elements 1/1
Test: WPA2-PSK AP with vendor elements added
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_vendor_elements 0.93081 2021-01-18 07:16:39.454313
passed all 1 test case(s)
2021-01-18 07:16:39 ./run-tests.py ap_vlan_file_parsing
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vlan_file_parsing 1/1
Test: hostapd vlan_file/mac_file parsing
Starting AP wlan3
PASS ap_vlan_file_parsing 0.413193 2021-01-18 07:16:39.992167
passed all 1 test case(s)
2021-01-18 07:16:40 ./run-tests.py ap_wpa2_eap_ext_enable_network_while_connected
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_ext_enable_network_while_connected 1/1
Test: WPA2-Enterprise interactive identity entry and ENABLE_NETWORK
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan0 to AP
PASS ap_wpa2_eap_ext_enable_network_while_connected 1.867019 2021-01-18 07:16:41.983238
passed all 1 test case(s)
2021-01-18 07:16:42 ./run-tests.py ap_wpa2_eap_fast_eap_sim_ext
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_fast_eap_sim_ext 1/1
Test: WPA2-Enterprise connection using EAP-FAST/EAP-SIM and external GSM auth
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_fast_eap_sim_ext 0.888133 2021-01-18 07:16:42.999438
passed all 1 test case(s)
2021-01-18 07:16:43 ./run-tests.py ap_wpa2_eap_fast_eap_vendor
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_fast_eap_vendor 1/1
Test: WPA2-Enterprise connection using EAP-FAST/EAP-vendor
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_fast_eap_vendor 0.860354 2021-01-18 07:16:43.984111
passed all 1 test case(s)
2021-01-18 07:16:44 ./run-tests.py ap_wpa2_eap_peap_eap_sim
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_peap_eap_sim 1/1
Test: WPA2-Enterprise connection using EAP-PEAP/EAP-SIM
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_peap_eap_sim 0.88753 2021-01-18 07:16:45.000410
passed all 1 test case(s)
2021-01-18 07:16:45 ./run-tests.py ap_wpa2_eap_peap_eap_sim_ext
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_peap_eap_sim_ext 1/1
Test: WPA2-Enterprise connection using EAP-PEAP/EAP-SIM and external GSM auth
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_peap_eap_sim_ext 0.894483 2021-01-18 07:16:46.019412
passed all 1 test case(s)
2021-01-18 07:16:46 ./run-tests.py ap_wpa2_eap_tls_intermediate_ca_ocsp_revoked
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_tls_intermediate_ca_ocsp_revoked 1/1
Test: EAP-TLS with intermediate server/user CA and OCSP on revoked server certificate
openssl ocsp -reqout /tmp/lkp/tmpk1baiyd4 -issuer auth_serv/iCA-server/cacert.pem -sha256 -cert auth_serv/iCA-server/server-revoked.pem -no_nonce -text
openssl result:
OCSP Request Data:
    Version: 1 (0x0)
    Requestor List:
        Certificate ID:
          Hash Algorithm: sha256
          Issuer Name Hash: FAB1B86F06B383391C5EFAA640F93045D4B1BD99310D7336B3702F491F8E1B1A
          Issuer Key Hash: A3384E272FD776BC182DFA0C742314020C6FCA51238325C0B8CBC7F98B904112
          Serial Number: 5C9DE4A6D17A49C88375E75768F77216B2AEB783


openssl ocsp -index auth_serv/iCA-server/index.txt -rsigner auth_serv/iCA-server/cacert.pem -rkey auth_serv/iCA-server/private/cakey.pem -CA auth_serv/iCA-server/cacert.pem -issuer auth_serv/iCA-server/cacert.pem -verify_other auth_serv/iCA-server/cacert.pem -trust_other -ndays 7 -reqin /tmp/lkp/tmpk1baiyd4 -resp_no_certs -respout /tmp/lkp/tmp890wf73z -text
openssl result:
OCSP Request Data:
    Version: 1 (0x0)
    Requestor List:
        Certificate ID:
          Hash Algorithm: sha256
          Issuer Name Hash: FAB1B86F06B383391C5EFAA640F93045D4B1BD99310D7336B3702F491F8E1B1A
          Issuer Key Hash: A3384E272FD776BC182DFA0C742314020C6FCA51238325C0B8CBC7F98B904112
          Serial Number: 5C9DE4A6D17A49C88375E75768F77216B2AEB783
OCSP Response Data:
    OCSP Response Status: successful (0x0)
    Response Type: Basic OCSP Response
    Version: 1 (0x0)
    Responder Id: C = FI, O = w1.fi, CN = Server Intermediate CA
    Produced At: Jan 18 07:16:46 2021 GMT
    Responses:
    Certificate ID:
      Hash Algorithm: sha256
      Issuer Name Hash: FAB1B86F06B383391C5EFAA640F93045D4B1BD99310D7336B3702F491F8E1B1A
      Issuer Key Hash: A3384E272FD776BC182DFA0C742314020C6FCA51238325C0B8CBC7F98B904112
      Serial Number: 5C9DE4A6D17A49C88375E75768F77216B2AEB783
    Cert Status: revoked
    Revocation Time: May  3 15:20:10 2020 GMT
    This Update: Jan 18 07:16:46 2021 GMT
    Next Update: Jan 25 07:16:46 2021 GMT

    Signature Algorithm: sha256WithRSAEncryption
         3e:9f:20:52:3a:50:f1:95:59:eb:07:11:35:9e:99:e5:34:8d:
         c0:1c:48:49:6b:c2:21:69:ff:12:f3:8d:67:89:1f:58:7b:0b:
         40:98:29:c6:1f:fb:b0:54:96:e2:e3:65:0e:04:bf:19:80:41:
         8c:a4:ca:ae:3c:a4:14:2e:16:68:3a:03:35:03:f9:2c:aa:5c:
         32:fa:ba:c4:74:dd:78:a0:7f:77:28:53:78:f4:59:ef:3e:d1:
         e4:12:05:e5:ab:50:db:ce:d4:d1:24:88:28:64:d0:2c:58:4c:
         9b:9e:aa:9b:00:23:8f:a6:b1:3b:43:ca:f5:a5:bb:f7:2c:b3:
         93:65:b1:64:34:f5:81:13:1f:61:07:be:9f:6f:63:cc:1d:69:
         1d:a0:08:bd:1f:76:05:20:c9:11:da:17:06:d1:f8:7c:e4:30:
         52:11:37:0c:d1:66:a9:b6:06:66:7d:c0:e7:40:df:c5:22:4a:
         cb:ea:d9:46:7b:98:b6:fa:37:7a:03:cf:32:09:03:73:64:6e:
         98:18:ef:f6:33:90:85:0e:aa:fc:92:7a:af:87:f1:9a:3a:dc:
         a6:75:22:44:95:db:11:17:53:d0:0f:41:87:99:78:29:18:e6:
         e0:f1:d5:f6:34:7a:7b:2e:76:92:8f:37:fe:a8:8a:14:d5:1f:
         78:85:51:90


Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_tls_intermediate_ca_ocsp_revoked 0.847318 2021-01-18 07:16:46.992710
passed all 1 test case(s)
2021-01-18 07:16:47 ./run-tests.py ap_wpa2_eap_ttls_eap_mschapv2_server_oom
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_ttls_eap_mschapv2_server_oom 1/1
Test: WPA2-Enterprise connection using EAP-TTLS/EAP-MSCHAPv2 - server OOM
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
PASS ap_wpa2_eap_ttls_eap_mschapv2_server_oom 1.932255 2021-01-18 07:16:49.057195
passed all 1 test case(s)
2021-01-18 07:16:49 ./run-tests.py ap_wpa2_eap_ttls_server_cert_eku_client_server
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_ttls_server_cert_eku_client_server 1/1
Test: WPA2-Enterprise using EAP-TTLS and server cert with client and server EKU
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_ttls_server_cert_eku_client_server 0.82954 2021-01-18 07:16:50.012288
passed all 1 test case(s)
2021-01-18 07:16:50 ./run-tests.py ap_wpa2_eap_ttls_server_cert_hash
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_ttls_server_cert_hash 1/1
Test: WPA2-Enterprise connection using EAP-TTLS and server certificate hash
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
PASS ap_wpa2_eap_ttls_server_cert_hash 1.454199 2021-01-18 07:16:51.590287
passed all 1 test case(s)
2021-01-18 07:16:51 ./run-tests.py ap_wpa2_gtk_initial_rsc_tkip
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_gtk_initial_rsc_tkip 1/1
Test: Initial group cipher RSC (TKIP)
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_gtk_initial_rsc_tkip 10.99963 2021-01-18 07:17:02.713745
passed all 1 test case(s)
2021-01-18 07:17:02 ./run-tests.py ap_wpa2_in_different_bridge
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_in_different_bridge 1/1
Test: hostapd behavior with interface in different bridge
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_in_different_bridge 1.567197 2021-01-18 07:17:04.405404
passed all 1 test case(s)
2021-01-18 07:17:04 ./run-tests.py ap_wps_er_http_client
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wps_er_http_client 1/1
Test: WPS ER and HTTP client special cases
HTTP server received: GET /foo.xml HTTP/1.1
HTTP header: Cache-Control: no-cache
HTTP header: Pragma: no-cache
HTTP header: Accept: text/xml, application/xml
HTTP header: User-Agent: wpa_supplicant
HTTP header: Host: 127.0.0.1:12345
HTTP server received: POST /wps_control HTTP/1.1
HTTP header: Host: 127.0.0.1:12345
HTTP header: Content-Type: text/xml; charset="utf-8"
HTTP header: Content-Length: 280
HTTP header: SOAPACTION: "urn:schemas-wifialliance-org:service:WFAWLANConfig:1#GetDeviceInfo"
HTTP server received: SUBSCRIBE /wps_event HTTP/1.1
HTTP header: HOST: 127.0.0.1:12345
HTTP header: CALLBACK: <http://127.0.0.1:49152/event/44733469/1>
HTTP header: NT: upnp:event
HTTP header: TIMEOUT: Second-1800
Event URL: http://127.0.0.1:49152/event/44733469/1
HTTP server received: GET /foo.xml HTTP/1.1
HTTP header: Cache-Control: no-cache
HTTP header: Pragma: no-cache
HTTP header: Accept: text/xml, application/xml
HTTP header: User-Agent: wpa_supplicant
HTTP header: Host: 127.0.0.1:12345
HTTP server received: GET /foo.xml HTTP/1.1
HTTP header: Cache-Control: no-cache
HTTP header: Pragma: no-cache
HTTP header: Accept: text/xml, application/xml
HTTP header: User-Agent: wpa_supplicant
HTTP header: Host: 127.0.0.1:12345
PASS ap_wps_er_http_client 7.081419 2021-01-18 07:17:11.611378
passed all 1 test case(s)
2021-01-18 07:17:11 ./run-tests.py ap_wps_invalid_assoc_req_elem
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wps_invalid_assoc_req_elem 1/1
Test: WPS and invalid IE in Association Request frame
Starting AP wlan3
PASS ap_wps_invalid_assoc_req_elem 2.895211 2021-01-18 07:17:14.631352
passed all 1 test case(s)
2021-01-18 07:17:14 ./run-tests.py dbus_tdls_oom
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dbus_tdls_oom 1/1
Test: D-Bus TDLS operations during OOM
No dbus module available
Skip test case: No dbus module available
SKIP dbus_tdls_oom 0.040761 2021-01-18 07:17:14.795969
passed all 0 test case(s)
skipped 1 test case(s)
2021-01-18 07:17:14 ./run-tests.py dfs_radar_chanlist_vht80
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dfs_radar_chanlist_vht80 1/1
Test: DFS chanlist when radar is detected and VHT80 configured
Starting AP wlan3 on DFS channel
Starting AP wlan3
Trigger a simulated radar event
Connect STA wlan0 to AP
Country code at the end: 00
PASS dfs_radar_chanlist_vht80 5.656441 2021-01-18 07:17:20.577178
passed all 1 test case(s)
2021-01-18 07:17:20 ./run-tests.py dpp_config_dpp_gen_prime256v1
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_config_dpp_gen_prime256v1 1/1
Test: Generate DPP Config Object for DPP network (P-256)
dev0 displays QR Code
dev1 scans QR Code and initiates DPP Authentication
DPP authentication did not succeed (Responder)
Traceback (most recent call last):
  File "./run-tests.py", line 533, in main
    t(dev, apdev)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_dpp.py", line 859, in test_dpp_config_dpp_gen_prime256v1
    configurator=True)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_dpp.py", line 394, in run_dpp_qr_code_auth_unicast
    stop_responder=stop_responder)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_dpp.py", line 3875, in wait_auth_success
    raise Exception("DPP authentication did not succeed (Responder)")
Exception: DPP authentication did not succeed (Responder)
FAIL dpp_config_dpp_gen_prime256v1 5.083848 2021-01-18 07:17:25.789959
passed 0 test case(s)
skipped 0 test case(s)
failed tests: dpp_config_dpp_gen_prime256v1
2021-01-18 07:17:25 ./run-tests.py dpp_config_dpp_gen_secp384r1_secp384r1
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_config_dpp_gen_secp384r1_secp384r1 1/1
Test: Generate DPP Config Object for DPP network (P-384 + P-384)
dev0 displays QR Code
dev1 scans QR Code and initiates DPP Authentication
PASS dpp_config_dpp_gen_secp384r1_secp384r1 0.2373 2021-01-18 07:17:26.158406
passed all 1 test case(s)
2021-01-18 07:17:26 ./run-tests.py dpp_config_no_csign
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_config_no_csign 1/1
Test: DPP Config Object error - no csign
dev0 displays QR Code
dev1 scans QR Code and initiates DPP Authentication
PASS dpp_config_no_csign 2.175501 2021-01-18 07:17:28.459757
passed all 1 test case(s)
2021-01-18 07:17:28 ./run-tests.py dpp_config_signed_connector_error_no_dot_2
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_config_signed_connector_error_no_dot_2 1/1
Test: DPP Config Object signedConnector error - no dot(2)
dev0 displays QR Code
dev1 scans QR Code and initiates DPP Authentication
DPP authentication did not succeed (Responder)
Traceback (most recent call last):
  File "./run-tests.py", line 533, in main
    t(dev, apdev)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_dpp.py", line 1144, in test_dpp_config_signed_connector_error_no_dot_2
    run_dpp_config_error(dev, apdev, build_conf_obj(signed_connector=conn))
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_dpp.py", line 1056, in run_dpp_config_error
    require_conf_failure=conf_failure)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_dpp.py", line 394, in run_dpp_qr_code_auth_unicast
    stop_responder=stop_responder)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_dpp.py", line 3875, in wait_auth_success
    raise Exception("DPP authentication did not succeed (Responder)")
Exception: DPP authentication did not succeed (Responder)
FAIL dpp_config_signed_connector_error_no_dot_2 5.086732 2021-01-18 07:17:33.674045
passed 0 test case(s)
skipped 0 test case(s)
failed tests: dpp_config_signed_connector_error_no_dot_2
2021-01-18 07:17:33 ./run-tests.py dpp_pkex_curve_mismatch
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_pkex_curve_mismatch 1/1
Test: DPP and PKEX with mismatching curve
PASS dpp_pkex_curve_mismatch 2.094433 2021-01-18 07:17:35.898156
passed all 1 test case(s)
2021-01-18 07:17:35 ./run-tests.py dpp_proto_auth_resp_r_auth_mismatch
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_proto_auth_resp_r_auth_mismatch 1/1
Test: DPP protocol testing - R-auth mismatch in Auth Resp
PASS dpp_proto_auth_resp_r_auth_mismatch 2.105385 2021-01-18 07:17:38.128631
passed all 1 test case(s)
2021-01-18 07:17:38 ./run-tests.py dpp_qr_code_keygen_fail
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_qr_code_keygen_fail 1/1
Test: DPP QR Code and keygen failure
PASS dpp_qr_code_keygen_fail 0.044825 2021-01-18 07:17:38.298837
passed all 1 test case(s)
2021-01-18 07:17:38 ./run-tests.py dpp_two_initiators
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_two_initiators 1/1
Test: DPP and two initiators
Unexpected result: <3>DPP-FAIL Configurator rejected configuration
Traceback (most recent call last):
  File "./run-tests.py", line 533, in main
    t(dev, apdev)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_dpp.py", line 4464, in test_dpp_two_initiators
    "DPP-FAIL Already in DPP authentication exchange - ignore new one")
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_dpp.py", line 52, in wait_dpp_fail
    raise Exception("Unexpected result: " + ev)
Exception: Unexpected result: <3>DPP-FAIL Configurator rejected configuration
FAIL dpp_two_initiators 0.073818 2021-01-18 07:17:38.497817
passed 0 test case(s)
skipped 0 test case(s)
failed tests: dpp_two_initiators
2021-01-18 07:17:38 ./run-tests.py ext_password_eap
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ext_password_eap 1/1
Test: External password storage for EAP password
Starting AP wlan3
Connect STA wlan0 to AP
PASS ext_password_eap 0.973908 2021-01-18 07:17:39.606010
passed all 1 test case(s)
2021-01-18 07:17:39 ./run-tests.py fils_sk_pfs_26
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START fils_sk_pfs_26 1/1
Test: FILS SK with PFS (DH group 26)
Starting AP as-erp
Starting AP wlan3 (old add_ap argument type)
Connect STA wlan0 to AP
PASS fils_sk_pfs_26 1.159497 2021-01-18 07:17:40.890428
passed all 1 test case(s)
2021-01-18 07:17:40 ./run-tests.py fst_sta_start_session_bad_session_id
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START fst_sta_start_session_bad_session_id 1/1
Test: FST STA start session - bad session id
Starting AP wlan3 (old add_ap argument type)
Starting AP wlan4 (old add_ap argument type)
Connect STA wlan5 to AP
Connect STA wlan6 to AP
Success. Bad parameter was detected (Session ID)
PASS fst_sta_start_session_bad_session_id 2.137155 2021-01-18 07:17:43.152090
passed all 1 test case(s)
2021-01-18 07:17:43 ./run-tests.py grpform_go_neg_stopped
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START grpform_go_neg_stopped 1/1
Test: GO Negotiation stopped after TX start
wlan1: Trying to discover peer 02:00:00:00:00:00
PASS grpform_go_neg_stopped 1.050386 2021-01-18 07:17:44.327727
passed all 1 test case(s)
2021-01-18 07:17:44 ./run-tests.py hapd_ctrl_eapol_reauth_errors
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START hapd_ctrl_eapol_reauth_errors 1/1
Test: hostapd and EAPOL_REAUTH errors
Starting AP wlan3
PASS hapd_ctrl_eapol_reauth_errors 0.438384 2021-01-18 07:17:44.891352
passed all 1 test case(s)
2021-01-18 07:17:44 ./run-tests.py he80plus80
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START he80plus80 1/1
Test: HE with 80+80 MHz channel width
Starting AP wlan3
Starting AP wlan4
Connect STA wlan1 to AP
PASS he80plus80 1.904203 2021-01-18 07:17:46.921377
passed all 1 test case(s)
2021-01-18 07:17:46 ./run-tests.py he_wifi_generation
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START he_wifi_generation 1/1
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan5 to AP
Country code at the end: 00
PASS he_wifi_generation 2.032662 2021-01-18 07:17:49.079441
passed all 1 test case(s)
2021-01-18 07:17:49 ./run-tests.py ibss_rsn_tkip
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ibss_rsn_tkip 1/1
Test: IBSS RSN with TKIP as the cipher
wlan0 waiting for IBSS start/join to complete
wlan1 waiting for IBSS start/join to complete
wlan0 waiting for 4-way handshake completion with wlan1 02:00:00:00:01:00
wlan1 waiting for 4-way handshake completion with wlan0 02:00:00:00:00:00
PASS ibss_rsn_tkip 8.793589 2021-01-18 07:17:57.998127
passed all 1 test case(s)
2021-01-18 07:17:58 ./run-tests.py mesh_secure_gcmp_gmac
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START mesh_secure_gcmp_gmac 1/1
Test: Secure mesh with GCMP-128 and BIP-GMAC-128
PASS mesh_secure_gcmp_gmac 1.291765 2021-01-18 07:17:59.414325
passed all 1 test case(s)
2021-01-18 07:17:59 ./run-tests.py nfc_invalid_ndef_record
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START nfc_invalid_ndef_record 1/1
Test: Invalid NFC NDEF record handling
PASS nfc_invalid_ndef_record 0.042264 2021-01-18 07:17:59.580644
passed all 1 test case(s)
2021-01-18 07:17:59 ./run-tests.py nfc_wps_handover
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START nfc_wps_handover 1/1
Test: Connect to WPS AP with NFC connection handover
Starting AP wlan3
NFC connection handover
PASS nfc_wps_handover 1.328063 2021-01-18 07:18:01.032241
passed all 1 test case(s)
2021-01-18 07:18:01 ./run-tests.py obss_coex_report_handling2
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START obss_coex_report_handling2 1/1
Test: Overlapping BSS scan report handling with obss_interval=1 and no overlap
Starting AP wlan3
Connect STA wlan0 to AP
PASS obss_coex_report_handling2 3.539684 2021-01-18 07:18:04.695368
passed all 1 test case(s)
2021-01-18 07:18:04 ./run-tests.py p2ps_adv_go_persistent_no_peer_entry
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START p2ps_adv_go_persistent_no_peer_entry 1/1
Test: P2PS advertisement as GO having persistent group (no peer entry)
Start GO negotiation wlan0 -> wlan1
wlan1: Trying to discover peer 02:00:00:00:00:00
wlan0: Trying to discover peer 02:00:00:00:01:00
Group formed
PASS p2ps_adv_go_persistent_no_peer_entry 3.303068 2021-01-18 07:18:08.123259
passed all 1 test case(s)
2021-01-18 07:18:08 ./run-tests.py radius_acct_failure_sta_data
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START radius_acct_failure_sta_data 1/1
Test: RADIUS Accounting and failure to get STA data
Starting AP wlan3
Connect STA wlan0 to AP
PASS radius_acct_failure_sta_data 0.828401 2021-01-18 07:18:09.075401
passed all 1 test case(s)
2021-01-18 07:18:09 ./run-tests.py radius_auth_unreachable2
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START radius_auth_unreachable2 1/1
Test: RADIUS Authentication server unreachable (2)
Starting AP wlan3
Connect STA wlan0 to AP
Checking for RADIUS retries
radiusAuthClientAccessRetransmissions: 1
PASS radius_auth_unreachable2 4.796399 2021-01-18 07:18:13.996467
passed all 1 test case(s)
2021-01-18 07:18:14 ./run-tests.py radius_protocol
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START radius_protocol 1/1
Test: RADIUS Authentication protocol tests with a fake server
Starting AP wlan3
Connect STA wlan0 to AP
Received authentication request
Connect STA wlan0 to AP
Received authentication request
Add Message-Authenticator
Use incorrect RADIUS shared secret
Connect STA wlan0 to AP
Received authentication request
Add Message-Authenticator
Received authentication request
Add Message-Authenticator
Connect STA wlan0 to AP
Received authentication request
Add Message-Authenticator
Include two Message-Authenticator attributes
PASS radius_protocol 5.715058 2021-01-18 07:18:19.835399
passed all 1 test case(s)
2021-01-18 07:18:19 ./run-tests.py radius_psk
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START radius_psk 1/1
Test: WPA2 with PSK from RADIUS
Starting AP wlan3
Connect STA wlan0 to AP
Received authentication request
Connect STA wlan1 to AP
Received authentication request
PASS radius_psk 2.119514 2021-01-18 07:18:22.081536
passed all 1 test case(s)
2021-01-18 07:18:22 ./run-tests.py rrm_beacon_req_table_request_oom
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START rrm_beacon_req_table_request_oom 1/1
Test: Beacon request - beacon table mode - request element OOM
Starting AP wlan3
Connect STA wlan0 to AP
PASS rrm_beacon_req_table_request_oom 1.106744 2021-01-18 07:18:23.317311
passed all 1 test case(s)
2021-01-18 07:18:23 ./run-tests.py rrm_link_measurement_oom
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START rrm_link_measurement_oom 1/1
Test: Radio measurement request - link measurement OOM
Skip test case: Required RRM capabilities are not supported
SKIP rrm_link_measurement_oom 0.042312 2021-01-18 07:18:23.483872
passed all 0 test case(s)
skipped 1 test case(s)
2021-01-18 07:18:23 ./run-tests.py rrm_neighbor_rep_req
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START rrm_neighbor_rep_req 1/1
Test: wpa_supplicant ctrl_iface NEIGHBOR_REP_REQUEST
Starting AP wlan3 (old add_ap argument type)
Starting AP wlan4 (old add_ap argument type)
Connect STA wlan0 to AP
Connect STA wlan0 to AP
PASS rrm_neighbor_rep_req 1.496302 2021-01-18 07:18:25.105370
passed all 1 test case(s)
2021-01-18 07:18:25 ./run-tests.py rsn_preauth_processing
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START rsn_preauth_processing 1/1
Test: RSN pre-authentication processing on AP
Starting AP wlan3
Connect STA wlan0 to AP
PASS rsn_preauth_processing 0.863815 2021-01-18 07:18:26.093218
passed all 1 test case(s)
2021-01-18 07:18:26 ./run-tests.py sae_pk_missing_ie
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_pk_missing_ie 1/1
Test: SAE-PK and missing SAE-PK IE in confirm
Starting AP wlan3
Connect STA wlan0 to AP
PASS sae_pk_missing_ie 2.442482 2021-01-18 07:18:28.661495
passed all 1 test case(s)
2021-01-18 07:18:28 ./run-tests.py sae_pk_only
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_pk_only 1/1
Test: SAE-PK only
Starting AP wlan3
Connect STA wlan0 to AP
Starting AP wlan4
PASS sae_pk_only 1.267646 2021-01-18 07:18:30.054381
passed all 1 test case(s)
2021-01-18 07:18:30 ./run-tests.py scan_bss_expiration_count
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_bss_expiration_count 1/1
Test: BSS entry expiration based on scan results without match
Starting AP wlan3
PASS scan_bss_expiration_count 0.827944 2021-01-18 07:18:31.006657
passed all 1 test case(s)
2021-01-18 07:18:31 ./run-tests.py scan_random_mac_connected
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_random_mac_connected 1/1
Test: Random MAC address in scans while connected
Starting AP wlan3
Connect STA wlan0 to AP
Starting AP wlan4
PASS scan_random_mac_connected 1.265154 2021-01-18 07:18:32.397285
passed all 1 test case(s)
2021-01-18 07:18:32 ./run-tests.py sigma_dut_ap_dpp_tcp_enrollee_init
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_ap_dpp_tcp_enrollee_init 1/1
Test: sigma_dut DPP AP as TCP Enrollee/initiator
Skip test case: sigma_dut not available
SKIP sigma_dut_ap_dpp_tcp_enrollee_init 0.11249 2021-01-18 07:18:32.634834
passed all 0 test case(s)
skipped 1 test case(s)
2021-01-18 07:18:32 ./run-tests.py sigma_dut_ap_ent_ft_eap
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_ap_ent_ft_eap 1/1
Test: sigma_dut controlled AP WPA-EAP and FT-EAP
Skip test case: sigma_dut not available
SKIP sigma_dut_ap_ent_ft_eap 0.103295 2021-01-18 07:18:32.863293
passed all 0 test case(s)
skipped 1 test case(s)
2021-01-18 07:18:32 ./run-tests.py sigma_dut_ap_vht40
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_ap_vht40 1/1
Test: sigma_dut controlled AP and VHT40
Skip test case: sigma_dut not available
SKIP sigma_dut_ap_vht40 0.114717 2021-01-18 07:18:33.102823
passed all 0 test case(s)
skipped 1 test case(s)
2021-01-18 07:18:33 ./run-tests.py sigma_dut_client_privacy
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_client_privacy 1/1
Test: sigma_dut client privacy
Starting AP wlan3
Skip test case: sigma_dut not available
SKIP sigma_dut_client_privacy 0.42407 2021-01-18 07:18:33.651346
passed all 0 test case(s)
skipped 1 test case(s)
2021-01-18 07:18:33 ./run-tests.py sigma_dut_dpp_incompatible_roles_resp
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_dpp_incompatible_roles_resp 1/1
Test: sigma_dut DPP roles incompatible (Responder)
Skip test case: sigma_dut not available
SKIP sigma_dut_dpp_incompatible_roles_resp 0.044547 2021-01-18 07:18:33.820884
passed all 0 test case(s)
skipped 1 test case(s)
2021-01-18 07:18:33 ./run-tests.py suite_b_192_rsa_ecdhe_radius_rsa2048_client
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START suite_b_192_rsa_ecdhe_radius_rsa2048_client 1/1
Test: Suite B 192-bit level and RSA (ECDHE) and RSA2048 client
Starting AP wlan4
Starting AP wlan3
Connect STA wlan0 to AP
PASS suite_b_192_rsa_ecdhe_radius_rsa2048_client 1.304394 2021-01-18 07:18:35.251981
passed all 1 test case(s)
2021-01-18 07:18:35 ./run-tests.py tnc_fast
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START tnc_fast 1/1
Test: TNC FAST
Starting AP wlan3
Connect STA wlan0 to AP
PASS tnc_fast 0.847054 2021-01-18 07:18:36.223233
passed all 1 test case(s)
2021-01-18 07:18:36 ./run-tests.py wep_shared_key_auth
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START wep_shared_key_auth 1/1
Test: WEP Shared Key authentication
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
PASS wep_shared_key_auth 1.393089 2021-01-18 07:18:37.743450
passed all 1 test case(s)
2021-01-18 07:18:37 ./run-tests.py wpa2_ocv_vht80plus80
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START wpa2_ocv_vht80plus80 1/1
Test: OCV with VHT80+80 channel
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Connect STA wlan2 to AP
PASS wpa2_ocv_vht80plus80 17.401307 2021-01-18 07:18:55.269855
passed all 1 test case(s)
2021-01-18 07:18:55 ./run-tests.py wpas_ctrl_dup_network_global
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START wpas_ctrl_dup_network_global 1/1
Test: wpa_supplicant ctrl_iface DUP_NETWORK (global)
Starting AP wlan3
Connect STA wlan0 to AP
PASS wpas_ctrl_dup_network_global 0.904912 2021-01-18 07:18:56.299437
passed all 1 test case(s)
2021-01-18 07:18:56 ./run-tests.py wpas_ctrl_get_capability
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START wpas_ctrl_get_capability 1/1
Test: wpa_supplicant ctrl_iface GET_CAPABILITY
GET_CAPABILITY key_mgmt iftype=STATION: ['NONE', 'IEEE8021X', 'WPA-EAP', 'WPA-PSK', 'WPA-EAP-SUITE-B', 'WPA-EAP-SUITE-B-192', 'OWE', 'DPP', 'FILS-SHA256', 'FILS-SHA384', 'FT-FILS-SHA256', 'FT-FILS-SHA384', 'FT-PSK', 'FT-EAP', 'SAE']
GET_CAPABILITY key_mgmt iftype=AP_VLAN: ['NONE', 'IEEE8021X', 'WPA-EAP', 'WPA-PSK', 'WPA-EAP-SUITE-B', 'WPA-EAP-SUITE-B-192', 'OWE', 'DPP', 'FILS-SHA256', 'FILS-SHA384', 'FT-FILS-SHA256', 'FT-FILS-SHA384', 'FT-PSK', 'FT-EAP', 'SAE']
GET_CAPABILITY key_mgmt iftype=AP: ['NONE', 'IEEE8021X', 'WPA-EAP', 'WPA-PSK', 'WPA-EAP-SUITE-B', 'WPA-EAP-SUITE-B-192', 'OWE', 'DPP', 'FILS-SHA256', 'FILS-SHA384', 'FT-FILS-SHA256', 'FT-FILS-SHA384', 'FT-PSK', 'FT-EAP', 'SAE']
GET_CAPABILITY key_mgmt iftype=P2P_GO: ['NONE', 'IEEE8021X', 'WPA-EAP', 'WPA-PSK', 'WPA-EAP-SUITE-B', 'WPA-EAP-SUITE-B-192', 'OWE', 'DPP', 'FILS-SHA256', 'FILS-SHA384', 'FT-FILS-SHA256', 'FT-FILS-SHA384', 'FT-PSK', 'FT-EAP', 'SAE']
GET_CAPABILITY key_mgmt iftype=P2P_CLIENT: ['NONE', 'IEEE8021X', 'WPA-EAP', 'WPA-PSK', 'WPA-EAP-SUITE-B', 'WPA-EAP-SUITE-B-192', 'OWE', 'DPP', 'FILS-SHA256', 'FILS-SHA384', 'FT-FILS-SHA256', 'FT-FILS-SHA384', 'FT-PSK', 'FT-EAP', 'SAE']
GET_CAPABILITY key_mgmt iftype=P2P_DEVICE: ['NONE', 'IEEE8021X', 'WPA-EAP', 'WPA-PSK', 'WPA-EAP-SUITE-B', 'WPA-EAP-SUITE-B-192', 'OWE', 'DPP', 'FILS-SHA256', 'FILS-SHA384', 'FT-FILS-SHA256', 'FT-FILS-SHA384', 'FT-PSK', 'FT-EAP', 'SAE']
GET_CAPABILITY key_mgmt iftype=MESH: ['NONE', 'IEEE8021X', 'WPA-EAP', 'WPA-PSK', 'WPA-EAP-SUITE-B', 'WPA-EAP-SUITE-B-192', 'OWE', 'DPP', 'FILS-SHA256', 'FILS-SHA384', 'FT-FILS-SHA256', 'FT-FILS-SHA384', 'FT-PSK', 'FT-EAP', 'SAE']
GET_CAPABILITY key_mgmt iftype=IBSS: ['NONE', 'IEEE8021X', 'WPA-EAP', 'WPA-PSK', 'WPA-EAP-SUITE-B', 'WPA-EAP-SUITE-B-192', 'OWE', 'DPP', 'FILS-SHA256', 'FILS-SHA384', 'FT-FILS-SHA256', 'FT-FILS-SHA384', 'FT-PSK', 'FT-EAP', 'SAE']
GET_CAPABILITY key_mgmt iftype=NAN: ['NONE', 'IEEE8021X', 'WPA-EAP', 'WPA-PSK', 'WPA-EAP-SUITE-B', 'WPA-EAP-SUITE-B-192', 'OWE', 'DPP', 'FILS-SHA256', 'FILS-SHA384', 'FT-FILS-SHA256', 'FT-FILS-SHA384', 'FT-PSK', 'FT-EAP', 'SAE']
GET_CAPABILITY key_mgmt iftype=UNKNOWN: None
PASS wpas_ctrl_get_capability 0.04336 2021-01-18 07:18:56.467729
passed all 1 test case(s)
2021-01-18 07:18:56 ./run-tests.py wpas_ctrl_set_lci_errors
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START wpas_ctrl_set_lci_errors 1/1
Test: wpa_supplicant SET lci error cases
PASS wpas_ctrl_set_lci_errors 0.084169 2021-01-18 07:18:56.702036
passed all 1 test case(s)
2021-01-18 07:18:56 ./run-tests.py wps_ext_cred_proto_encr_type_missing
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START wps_ext_cred_proto_encr_type_missing 1/1
Test: WPS and Credential: Encr Type missing
Starting AP wlan3
PASS wps_ext_cred_proto_encr_type_missing 0.93755 2021-01-18 07:18:57.772048
passed all 1 test case(s)
2021-01-18 07:18:57 ./run-tests.py wps_ext_cred_proto_network_key_missing_open
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START wps_ext_cred_proto_network_key_missing_open 1/1
Test: WPS and Credential: Network Key missing (open)
Starting AP wlan3
PASS wps_ext_cred_proto_network_key_missing_open 0.927873 2021-01-18 07:18:58.824248
passed all 1 test case(s)
2021-01-18 07:18:58 ./run-tests.py wps_ext_proto_ack_m3
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START wps_ext_proto_ack_m3 1/1
Test: WPS and ACK M3
Starting AP wlan3
PASS wps_ext_proto_ack_m3 1.028458 2021-01-18 07:18:59.977247
passed all 1 test case(s)
2021-01-18 07:18:59 ./run-tests.py wps_ext_proto_ack_m3_no_r_nonce
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START wps_ext_proto_ack_m3_no_r_nonce 1/1
Test: WPS and ACK M3 missing R-Nonce
Starting AP wlan3
PASS wps_ext_proto_ack_m3_no_r_nonce 1.027771 2021-01-18 07:19:01.129276
passed all 1 test case(s)
2021-01-18 07:19:01 ./stop.sh
wpa_supplicant/hostapd/hlr_auc_gw did not exit - try to force them to die

--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/hwsim-part3.yaml
suite: hwsim
testcase: hwsim
category: functional
need_memory: 1G
hwsim:
  test: group-26
job_origin: "/lkp-src/allot/cyclic:p1:linux-devel:devel-hourly/lkp-skl-d04/hwsim-part3.yaml"

#! queue options
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-skl-d04
tbox_group: lkp-skl-d04
kconfig: x86_64-rhel-8.3
submit_id: 6003a3d40d0fe874ca7bf09c
job_file: "/lkp/jobs/scheduled/lkp-skl-d04/hwsim-group-26-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-1180cd89a7ca9add3e086f7f06b76d6114ae8593-20210117-29898-1mppymi-0.yaml"
id: 4fec2e26f526600b2c17e81c61b2e7815c2614cc
queuer_version: "/lkp-src"

#! hosts/lkp-skl-d04
model: Skylake
nr_cpu: 4
memory: 32G
nr_ssd_partitions: 1
nr_hdd_partitions: 4
hdd_partitions: "/dev/disk/by-id/ata-ST1000DM003-1ER162_Z4YB7AEL-part*"
ssd_partitions: "/dev/disk/by-id/wwn-0x55cd2e404b64c499-part2"
rootfs_partition: "/dev/disk/by-id/wwn-0x55cd2e404b64c499-part1"
brand: Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz

#! include/category/functional
kmsg: 
heartbeat: 
meminfo: 

#! include/hwsim
need_kconfig:
- CONFIG_WLAN=y
- CONFIG_CFG80211=m
- CONFIG_CFG80211_WEXT=y
- CONFIG_MAC80211=m
- CONFIG_MAC80211_HWSIM=m
- CONFIG_MAC80211_LEDS=y
- CONFIG_MAC80211_MESH=y
- CONFIG_MAC80211_DEBUGFS=y
- CONFIG_VETH=m
- CONFIG_BRIDGE=m

#! include/queue/cyclic
commit: 1180cd89a7ca9add3e086f7f06b76d6114ae8593

#! include/testbox/lkp-skl-d04
need_kconfig_hw:
- CONFIG_E1000E=y
- CONFIG_SATA_AHCI
ucode: '0xe2'
enqueue_time: 2021-01-17 10:41:24.643020479 +08:00
_id: 6003a3d40d0fe874ca7bf09c
_rt: "/result/hwsim/group-26-ucode=0xe2/lkp-skl-d04/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/1180cd89a7ca9add3e086f7f06b76d6114ae8593"

#! schedule options
user: lkp
compiler: gcc-9
LKP_SERVER: internal-lkp-server
head_commit: d7177688a51bfce76f3a949d3e4091319d482c55
base_commit: 7c53f6b671f4aba70ff15e1b05148b10d58c2837
branch: linux-devel/devel-hourly-2021011511
rootfs: debian-10.4-x86_64-20200603.cgz
result_root: "/result/hwsim/group-26-ucode=0xe2/lkp-skl-d04/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/1180cd89a7ca9add3e086f7f06b76d6114ae8593/0"
scheduler_version: "/lkp/lkp/.src-20210115-132419"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-skl-d04/hwsim-group-26-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-1180cd89a7ca9add3e086f7f06b76d6114ae8593-20210117-29898-1mppymi-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- branch=linux-devel/devel-hourly-2021011511
- commit=1180cd89a7ca9add3e086f7f06b76d6114ae8593
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/1180cd89a7ca9add3e086f7f06b76d6114ae8593/vmlinuz-5.10.0-rc7-g1180cd89a7ca
- max_uptime=2100
- RESULT_ROOT=/result/hwsim/group-26-ucode=0xe2/lkp-skl-d04/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/1180cd89a7ca9add3e086f7f06b76d6114ae8593/0
- LKP_SERVER=internal-lkp-server
- nokaslr
- selinux=0
- debug
- apic=debug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=100
- net.ifnames=0
- printk.devkmsg=on
- panic=-1
- softlockup_panic=1
- nmi_watchdog=panic
- oops=panic
- load_ramdisk=2
- prompt_ramdisk=0
- drbd.minor_count=8
- systemd.log_level=err
- ignore_loglevel
- console=tty0
- earlyprintk=ttyS0,115200
- console=ttyS0,115200
- vga=normal
- rw
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/1180cd89a7ca9add3e086f7f06b76d6114ae8593/modules.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hwsim_20210101.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/hwsim-x86_64-537ab94-1_20210101.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20201117.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20210115-132419/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
last_kernel: 5.10.0-rc7

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/1180cd89a7ca9add3e086f7f06b76d6114ae8593/vmlinuz-5.10.0-rc7-g1180cd89a7ca"
dequeue_time: 2021-01-17 10:45:33.875190487 +08:00
job_state: finished
loadavg: 1.58 1.07 0.48 1/136 6306
start_time: '1610847245'
end_time: '1610847471'
version: "/lkp/lkp/.src-20210115-132452:bb064f4d:9246e2f20"

--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

export USER=root
./build.sh
./start.sh
./run-tests.py ap_acs_vht160_scan_disable
./run-tests.py ap_beacon_rate_ht2
./run-tests.py ap_beacon_rate_legacy
./run-tests.py ap_cipher_bip
./run-tests.py ap_config_reload_file
./run-tests.py ap_csa_1_switch
./run-tests.py ap_ft_gcmp_256
./run-tests.py ap_ft_internal_rrb_check
./run-tests.py ap_ft_over_ds_ocv
./run-tests.py ap_ft_ptk_rekey_ap
./run-tests.py ap_hs20_auto_interworking
./run-tests.py ap_hs20_eap_unknown
./run-tests.py ap_hs20_req_conn_capab
./run-tests.py ap_ht_op_class_116
./run-tests.py ap_open_sta_enable_disable
./run-tests.py ap_open_sta_ps
./run-tests.py ap_pmf_beacon_protection_mismatch
./run-tests.py ap_pmf_sta_sa_query_no_response
./run-tests.py ap_vendor_elements
./run-tests.py ap_vlan_file_parsing
./run-tests.py ap_wpa2_eap_ext_enable_network_while_connected
./run-tests.py ap_wpa2_eap_fast_eap_sim_ext
./run-tests.py ap_wpa2_eap_fast_eap_vendor
./run-tests.py ap_wpa2_eap_peap_eap_sim
./run-tests.py ap_wpa2_eap_peap_eap_sim_ext
./run-tests.py ap_wpa2_eap_tls_intermediate_ca_ocsp_revoked
./run-tests.py ap_wpa2_eap_ttls_eap_mschapv2_server_oom
./run-tests.py ap_wpa2_eap_ttls_server_cert_eku_client_server
./run-tests.py ap_wpa2_eap_ttls_server_cert_hash
./run-tests.py ap_wpa2_gtk_initial_rsc_tkip
./run-tests.py ap_wpa2_in_different_bridge
./run-tests.py ap_wps_er_http_client
./run-tests.py ap_wps_invalid_assoc_req_elem
./run-tests.py dbus_tdls_oom
./run-tests.py dfs_radar_chanlist_vht80
./run-tests.py dpp_config_dpp_gen_prime256v1
./run-tests.py dpp_config_dpp_gen_secp384r1_secp384r1
./run-tests.py dpp_config_no_csign
./run-tests.py dpp_config_signed_connector_error_no_dot_2
./run-tests.py dpp_pkex_curve_mismatch
./run-tests.py dpp_proto_auth_resp_r_auth_mismatch
./run-tests.py dpp_qr_code_keygen_fail
./run-tests.py dpp_two_initiators
./run-tests.py ext_password_eap
./run-tests.py fils_sk_pfs_26
./run-tests.py fst_sta_start_session_bad_session_id
./run-tests.py grpform_go_neg_stopped
./run-tests.py hapd_ctrl_eapol_reauth_errors
./run-tests.py he80plus80
./run-tests.py he_wifi_generation
./run-tests.py ibss_rsn_tkip
./run-tests.py mesh_secure_gcmp_gmac
./run-tests.py nfc_invalid_ndef_record
./run-tests.py nfc_wps_handover
./run-tests.py obss_coex_report_handling2
./run-tests.py p2ps_adv_go_persistent_no_peer_entry
./run-tests.py radius_acct_failure_sta_data
./run-tests.py radius_auth_unreachable2
./run-tests.py radius_protocol
./run-tests.py radius_psk
./run-tests.py rrm_beacon_req_table_request_oom
./run-tests.py rrm_link_measurement_oom
./run-tests.py rrm_neighbor_rep_req
./run-tests.py rsn_preauth_processing
./run-tests.py sae_pk_missing_ie
./run-tests.py sae_pk_only
./run-tests.py scan_bss_expiration_count
./run-tests.py scan_random_mac_connected
./run-tests.py sigma_dut_ap_dpp_tcp_enrollee_init
./run-tests.py sigma_dut_ap_ent_ft_eap
./run-tests.py sigma_dut_ap_vht40
./run-tests.py sigma_dut_client_privacy
./run-tests.py sigma_dut_dpp_incompatible_roles_resp
./run-tests.py suite_b_192_rsa_ecdhe_radius_rsa2048_client
./run-tests.py tnc_fast
./run-tests.py wep_shared_key_auth
./run-tests.py wpa2_ocv_vht80plus80
./run-tests.py wpas_ctrl_dup_network_global
./run-tests.py wpas_ctrl_get_capability
./run-tests.py wpas_ctrl_set_lci_errors
./run-tests.py wps_ext_cred_proto_encr_type_missing
./run-tests.py wps_ext_cred_proto_network_key_missing_open
./run-tests.py wps_ext_proto_ack_m3
./run-tests.py wps_ext_proto_ack_m3_no_r_nonce
./stop.sh

--gatW/ieO32f1wygP--
