Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 348C130ED2B
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Feb 2021 08:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbhBDHT7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Feb 2021 02:19:59 -0500
Received: from mga17.intel.com ([192.55.52.151]:35384 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232926AbhBDHTw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Feb 2021 02:19:52 -0500
IronPort-SDR: PUZ3XPpz5hAAdP1n3XGblhxUMdqFucoS9xK1boaJYWS1LzwyFbo0L56mm0rIZc/XXdwdhzKisl
 cazUK0HIYvVw==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="160945053"
X-IronPort-AV: E=Sophos;i="5.79,400,1602572400"; 
   d="xz'?yaml'?scan'208";a="160945053"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 23:19:05 -0800
IronPort-SDR: NybKJMSpHQ1DkMma16qfxo6RVOBVCgCNBXwIlbxnn+mPbmHit21iUVd3GTVzwBANBzwcFZlIpL
 6aVD345owwGg==
X-IronPort-AV: E=Sophos;i="5.79,400,1602572400"; 
   d="xz'?yaml'?scan'208";a="372192479"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 23:19:00 -0800
Date:   Thu, 4 Feb 2021 15:34:52 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     0day robot <lkp@intel.com>,
        Chaitanya Tata <chaitanya.tata@bluwireless.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: [cfg80211]  12f9a570c0: hwsim.ap_csa_2_switches_count_1.fail
Message-ID: <20210204073451.GD17757@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="7LkOrbQMr4cezO2T"
Content-Disposition: inline
In-Reply-To: <20210127215941.2d6a97b09784.I4f1fac32f67045171be50931f44d77e150911bee@changeid>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--7LkOrbQMr4cezO2T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Greeting,

FYI, we noticed the following commit (built with gcc-9):

commit: 12f9a570c0a654c6abc9e189e2227a1eb2d5d99e ("cfg80211: Skip key deletion for open associations")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git Johannes-Berg/cfg80211-fix-netdev-registration-deadlock/20210202-092757


in testcase: hwsim
version: hwsim-x86_64-537ab94-1_20210101
with following parameters:

	test: group-33
	ucode: 0x21



on test machine: 4 threads Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz with 8G memory

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):




If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>

2021-02-03 00:04:54 export USER=root
2021-02-03 00:04:54 ./build.sh
Building TNC testing tools
Building wlantest
Building hs20-osu-client
Building hostapd
Building wpa_supplicant
2021-02-03 00:06:06 ./start.sh
2021-02-03 00:06:06 ./run-tests.py ap_acs_hw_mode_any_5ghz
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_acs_hw_mode_any_5ghz 1/1
Test: Automatic channel selection with hw_mode=any and 5 GHz
Starting AP wlan3
Removing BSS wlan3
Starting AP wlan3
Connect STA wlan0 to AP
Country code at the end: 00
PASS ap_acs_hw_mode_any_5ghz 12.909362 2021-02-03 00:06:20.765348
passed all 1 test case(s)
2021-02-03 00:06:20 ./run-tests.py ap_csa_2_switches_count_1
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_csa_2_switches_count_1 1/1
Test: AP Channel Switch, two switches with count 1
Starting AP wlan3
Connect STA wlan0 to AP
dev2->dev1 unicast data delivery failed
Traceback (most recent call last):
  File "./run-tests.py", line 533, in main
    t(dev, apdev)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_ap_csa.py", line 139, in test_ap_csa_2_switches_count_1
    hwsim_utils.test_connectivity(dev[0], ap)
  File "/lkp/benchmarks/hwsim/tests/hwsim/hwsim_utils.py", line 195, in test_connectivity
    raise Exception(last_err)
Exception: dev2->dev1 unicast data delivery failed
FAIL ap_csa_2_switches_count_1 5.255997 2021-02-03 00:06:26.179210
passed 0 test case(s)
skipped 0 test case(s)
failed tests: ap_csa_2_switches_count_1
2021-02-03 00:06:26 ./run-tests.py ap_ft_pmf_over_ds
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_ft_pmf_over_ds 1/1
Test: WPA2-PSK-FT AP over DS with PMF
Starting AP wlan3
Starting AP wlan4
Connect to first AP
Connect STA wlan0 to AP
Roam to the second AP
Roam back to the first AP
PASS ap_ft_pmf_over_ds 0.668993 2021-02-03 00:06:27.012678
passed all 1 test case(s)
2021-02-03 00:06:27 ./run-tests.py ap_ft_sae_ptk_rekey1
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_ft_sae_ptk_rekey1 1/1
Test: WPA2-PSK-FT-SAE AP and PTK rekey triggered by station
Starting AP wlan3
Starting AP wlan4
Connect to first AP
Connect STA wlan0 to AP
Roam to the second AP
PASS ap_ft_sae_ptk_rekey1 1.487963 2021-02-03 00:06:28.658113
passed all 1 test case(s)
2021-02-03 00:06:28 ./run-tests.py ap_ft_sae_rsnxe_used_mismatch2
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_ft_sae_rsnxe_used_mismatch2 1/1
Test: FT-SAE AP and unexpected RSNXE Used in ReassocResp
Starting AP wlan3
Starting AP wlan4
Connect to first AP
Connect STA wlan0 to AP
PASS ap_ft_sae_rsnxe_used_mismatch2 0.754793 2021-02-03 00:06:29.569400
passed all 1 test case(s)
2021-02-03 00:06:29 ./run-tests.py ap_ft_skip_prune_assoc2
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_ft_skip_prune_assoc2 1/1
Test: WPA2-PSK-FT AP with skip_prune_assoc (disable full_ap_client_state)
Starting AP wlan3
Starting AP wlan4
Connect to first AP
Connect STA wlan0 to AP
Roam to the second AP
Roam back to the first AP
PASS ap_ft_skip_prune_assoc2 0.496598 2021-02-03 00:06:30.222631
passed all 1 test case(s)
2021-02-03 00:06:30 ./run-tests.py ap_hs20_external_selection
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_hs20_external_selection 1/1
Test: Hotspot 2.0 connection using external network selection and creation
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_hs20_external_selection 0.268145 2021-02-03 00:06:30.643985
passed all 1 test case(s)
2021-02-03 00:06:30 ./run-tests.py ap_hs20_fetch_osu_proto
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_hs20_fetch_osu_proto 1/1
Test: Hotspot 2.0 OSU provider and protocol testing
Starting AP wlan3
PASS ap_hs20_fetch_osu_proto 1.204107 2021-02-03 00:06:32.004099
passed all 1 test case(s)
2021-02-03 00:06:32 ./run-tests.py ap_hs20_min_bandwidth_and_roaming_partner_preference
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_hs20_min_bandwidth_and_roaming_partner_preference 1/1
Test: Hotspot 2.0 and minimum bandwidth with roaming partner preference
Starting AP wlan3
Starting AP wlan4
PASS ap_hs20_min_bandwidth_and_roaming_partner_preference 0.64994 2021-02-03 00:06:32.814619
passed all 1 test case(s)
2021-02-03 00:06:32 ./run-tests.py ap_hs20_min_bandwidth_no_wan_metrics
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_hs20_min_bandwidth_no_wan_metrics 1/1
Test: Hotspot 2.0 network selection with min bandwidth but no WAN Metrics
Starting AP wlan3
PASS ap_hs20_min_bandwidth_no_wan_metrics 0.180371 2021-02-03 00:06:33.156209
passed all 1 test case(s)
2021-02-03 00:06:33 ./run-tests.py ap_hs20_network_preference2
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_hs20_network_preference2 1/1
Test: Hotspot 2.0 network selection with preferred credential
Starting AP wlan4
Starting AP wlan3
PASS ap_hs20_network_preference2 0.510504 2021-02-03 00:06:33.826628
passed all 1 test case(s)
2021-02-03 00:06:33 ./run-tests.py ap_hs20_osen
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_hs20_osen 1/1
Test: Hotspot 2.0 OSEN connection
Starting AP wlan3
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan5 to AP
PASS ap_hs20_osen 0.476851 2021-02-03 00:06:34.462415
passed all 1 test case(s)
2021-02-03 00:06:34 ./run-tests.py ap_hs20_proxyarp_disable_dgaf
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_hs20_proxyarp_disable_dgaf 1/1
Test: Hotspot 2.0 and ProxyARP with DGAF disabled
Starting AP wlan3
Connect STA wlan1 to AP
After connect: ['192.168.1.123 dev ap-br0 lladdr 02:00:00:00:00:00 PERMANENT', 'aaaa:bbbb:cccc::2 dev ap-br0 lladdr 02:00:00:00:00:00 PERMANENT']
After disconnect: []
PASS ap_hs20_proxyarp_disable_dgaf 1.208 2021-02-03 00:06:35.823218
passed all 1 test case(s)
2021-02-03 00:06:35 ./run-tests.py ap_ht40_csa3
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_ht40_csa3 1/1
Test: HT with 40 MHz channel width and CSA
Starting AP wlan3
Connect STA wlan0 to AP
dev2->dev1 unicast data delivery failed
Traceback (most recent call last):
  File "./run-tests.py", line 533, in main
    t(dev, apdev)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_ap_ht.py", line 1142, in test_ap_ht40_csa3
    hwsim_utils.test_connectivity(dev[0], hapd)
  File "/lkp/benchmarks/hwsim/tests/hwsim/hwsim_utils.py", line 195, in test_connectivity
    raise Exception(last_err)
Exception: dev2->dev1 unicast data delivery failed
FAIL ap_ht40_csa3 5.677041 2021-02-03 00:06:41.659603
passed 0 test case(s)
skipped 0 test case(s)
failed tests: ap_ht40_csa3
2021-02-03 00:06:41 ./run-tests.py ap_ht40_scan_conflict
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_ht40_scan_conflict 1/1
Test: HT40 co-ex scan conflict
Starting AP wlan4
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_ht40_scan_conflict 2.874248 2021-02-03 00:06:44.693659
passed all 1 test case(s)
2021-02-03 00:06:44 ./run-tests.py ap_open_unexpected_assoc_event
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_unexpected_assoc_event 1/1
Test: AP with open mode and unexpected association event
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_open_unexpected_assoc_event 0.563543 2021-02-03 00:06:45.417773
passed all 1 test case(s)
2021-02-03 00:06:45 ./run-tests.py ap_pmf_sta_sa_query_oom
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_pmf_sta_sa_query_oom 1/1
Test: WPA2-PSK AP with station using SA Query (OOM)
Connect STA wlan0 to AP
PASS ap_pmf_sta_sa_query_oom 0.375688 2021-02-03 00:06:45.951757
passed all 1 test case(s)
2021-02-03 00:06:45 ./run-tests.py ap_roam_wpa2_psk
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_roam_wpa2_psk 1/1
Test: Roam between two WPA2-PSK APs
Starting AP wlan3
Connect STA wlan0 to AP
Starting AP wlan4
PASS ap_roam_wpa2_psk 14.776256 2021-02-03 00:07:00.883474
passed all 1 test case(s)
2021-02-03 00:07:00 ./run-tests.py ap_vht80_csa
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht80_csa 1/1
Test: VHT with 80 MHz channel width and CSA
Starting AP wlan3
Connect STA wlan0 to AP
Country code at the end: 00
dev2->dev1 unicast data delivery failed
Traceback (most recent call last):
  File "./run-tests.py", line 533, in main
    t(dev, apdev)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_ap_vht.py", line 739, in test_ap_vht80_csa
    hwsim_utils.test_connectivity(dev[0], hapd)
  File "/lkp/benchmarks/hwsim/tests/hwsim/hwsim_utils.py", line 195, in test_connectivity
    raise Exception(last_err)
Exception: dev2->dev1 unicast data delivery failed
FAIL ap_vht80_csa 5.77785 2021-02-03 00:07:06.818475
passed 0 test case(s)
skipped 0 test case(s)
failed tests: ap_vht80_csa
2021-02-03 00:07:06 ./run-tests.py ap_wowlan_triggers
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wowlan_triggers 1/1
Test: AP with wowlan_triggers
Starting AP wlan3
Connect STA wlan0 to AP
dev2->dev1 unicast data delivery failed
Traceback (most recent call last):
  File "./run-tests.py", line 533, in main
    t(dev, apdev)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_ap_params.py", line 845, in test_ap_wowlan_triggers
    hwsim_utils.test_connectivity(dev[0], hapd)
  File "/lkp/benchmarks/hwsim/tests/hwsim/hwsim_utils.py", line 195, in test_connectivity
    raise Exception(last_err)
Exception: dev2->dev1 unicast data delivery failed
FAIL ap_wowlan_triggers 5.259493 2021-02-03 00:07:12.239506
passed 0 test case(s)
skipped 0 test case(s)
failed tests: ap_wowlan_triggers
2021-02-03 00:07:12 ./run-tests.py ap_wpa2_eap_pwd_salt_sha1
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_pwd_salt_sha1 1/1
Test: WPA2-Enterprise connection using EAP-pwd and salted password SHA-1
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_pwd_salt_sha1 0.235241 2021-02-03 00:07:12.640604
passed all 1 test case(s)
2021-02-03 00:07:12 ./run-tests.py ap_wpa2_eap_ttls_dh_params_invalid
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_ttls_dh_params_invalid 1/1
Test: EAP-TLS server and invalid dhparams file
Starting AP wlan3
PASS ap_wpa2_eap_ttls_dh_params_invalid 0.055963 2021-02-03 00:07:12.855433
passed all 1 test case(s)
2021-02-03 00:07:12 ./run-tests.py ap_wpa2_eap_ttls_eap_md5_server_oom
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_ttls_eap_md5_server_oom 1/1
Test: WPA2-Enterprise connection using EAP-TTLS/EAP-MD5 - server OOM
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan0 to AP
PASS ap_wpa2_eap_ttls_eap_md5_server_oom 0.339437 2021-02-03 00:07:13.351569
passed all 1 test case(s)
2021-02-03 00:07:13 ./run-tests.py ap_wpa2_eap_unexpected_wep_eapol_key
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_unexpected_wep_eapol_key 1/1
Test: WPA2-Enterprise connection and unexpected WEP EAPOL-Key
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_unexpected_wep_eapol_key 0.23947 2021-02-03 00:07:13.746338
passed all 1 test case(s)
2021-02-03 00:07:13 ./run-tests.py ap_wpa2_psk_incorrect_passphrase
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_psk_incorrect_passphrase 1/1
Test: WPA2-PSK AP and station using incorrect passphrase
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_psk_incorrect_passphrase 10.444571 2021-02-03 00:07:24.348540
passed all 1 test case(s)
2021-02-03 00:07:24 ./run-tests.py ap_wpa2_psk_supp_proto_gtk_tx_bit_workaround
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_psk_supp_proto_gtk_tx_bit_workaround 1/1
Test: WPA2-PSK supplicant protocol testing: GTK TX bit workaround
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_psk_supp_proto_gtk_tx_bit_workaround 0.233467 2021-02-03 00:07:24.741161
passed all 1 test case(s)
2021-02-03 00:07:24 ./run-tests.py ap_wpa2_tdls_diff_rsnie
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_tdls_diff_rsnie 1/1
Test: TDLS with different RSN IEs
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Setup TDLS
Teardown TDLS
PASS ap_wpa2_tdls_diff_rsnie 3.017181 2021-02-03 00:07:27.916099
passed all 1 test case(s)
2021-02-03 00:07:27 ./run-tests.py ap_wps_and_bss_limit
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wps_and_bss_limit 1/1
Test: WPS and wpa_supplicant BSS entry limit
Starting AP wlan3
Starting AP wlan4
PASS ap_wps_and_bss_limit 4.243865 2021-02-03 00:07:32.321394
passed all 1 test case(s)
2021-02-03 00:07:32 ./run-tests.py ap_wps_authenticator_mismatch_m2
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wps_authenticator_mismatch_m2 1/1
Test: WPS and Authenticator attribute mismatch in M2
Starting AP wlan3
PASS ap_wps_authenticator_mismatch_m2 0.262258 2021-02-03 00:07:32.744824
passed all 1 test case(s)
2021-02-03 00:07:32 ./run-tests.py ap_wps_er_http_proto_upnp_info_no_device_type
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wps_er_http_proto_upnp_info_no_device_type 1/1
Test: WPS ER HTTP protocol testing - No deviceType in UPnP info
HTTP server received: GET /foo.xml HTTP/1.1
HTTP header: Cache-Control: no-cache
HTTP header: Pragma: no-cache
HTTP header: Accept: text/xml, application/xml
HTTP header: User-Agent: wpa_supplicant
HTTP header: Host: 127.0.0.1:12345
PASS ap_wps_er_http_proto_upnp_info_no_device_type 2.038222 2021-02-03 00:07:34.943100
passed all 1 test case(s)
2021-02-03 00:07:34 ./run-tests.py ap_wps_er_init_oom
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wps_er_init_oom 1/1
Test: WPS ER and OOM during init
PASS ap_wps_er_init_oom 0.044205 2021-02-03 00:07:35.146994
passed all 1 test case(s)
2021-02-03 00:07:35 ./run-tests.py ap_wps_er_ssdp_proto
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wps_er_ssdp_proto 1/1
Test: WPS ER SSDP protocol testing
PASS ap_wps_er_ssdp_proto 2.33919 2021-02-03 00:07:37.642445
passed all 1 test case(s)
2021-02-03 00:07:37 ./run-tests.py ap_wps_m5_oom
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wps_m5_oom 1/1
Test: WPS and OOM for M5 on STA
Starting AP wlan3
PASS ap_wps_m5_oom 0.463147 2021-02-03 00:07:38.266681
passed all 1 test case(s)
2021-02-03 00:07:38 ./run-tests.py ap_wps_new_version_ap
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wps_new_version_ap 1/1
Test: WPS compatibility with new version number on the AP
Starting AP wlan3
WPS provisioning step
PASS ap_wps_new_version_ap 0.34721 2021-02-03 00:07:38.773379
passed all 1 test case(s)
2021-02-03 00:07:38 ./run-tests.py autogo_noa
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START autogo_noa 1/1
Test: P2P autonomous GO and NoA
Start autonomous GO wlan0
Connect STA wlan1 to AP
PASS autogo_noa 0.273418 2021-02-03 00:07:39.204520
passed all 1 test case(s)
2021-02-03 00:07:39 ./run-tests.py bgscan_learn_beacon_loss
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START bgscan_learn_beacon_loss 1/1
Test: bgscan_simple and beacon loss
Starting AP wlan3
Connect STA wlan0 to AP
PASS bgscan_learn_beacon_loss 1.483879 2021-02-03 00:07:40.845941
passed all 1 test case(s)
2021-02-03 00:07:40 ./run-tests.py dbus_wps_cancel
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dbus_wps_cancel 1/1
Test: D-Bus WPS Cancel operation
No dbus module available
Skip test case: No dbus module available
SKIP dbus_wps_cancel 0.035014 2021-02-03 00:07:41.041998
passed all 0 test case(s)
skipped 1 test case(s)
2021-02-03 00:07:41 ./run-tests.py dfs_radar_chanlist_vht20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dfs_radar_chanlist_vht20 1/1
Test: DFS chanlist when radar is detected and VHT40 configured
Starting AP wlan3 on DFS channel
Starting AP wlan3
Trigger a simulated radar event
Connect STA wlan0 to AP
Country code at the end: 00
PASS dfs_radar_chanlist_vht20 4.180751 2021-02-03 00:07:45.385070
passed all 1 test case(s)
2021-02-03 00:07:45 ./run-tests.py dpp_auto_connect_2_ver1
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_auto_connect_2_ver1 1/1
Test: DPP and auto connect (2; AP and STA using ver 1)
Starting AP wlan3
PASS dpp_auto_connect_2_ver1 5.955091 2021-02-03 00:07:51.497018
passed all 1 test case(s)
2021-02-03 00:07:51 ./run-tests.py dpp_config_connector_error_invalid_timestamp_date
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_config_connector_error_invalid_timestamp_date 1/1
Test: DPP Config Object connector error - invalid timestamp date
Skip test case: OpenSSL python method not available
SKIP dpp_config_connector_error_invalid_timestamp_date 0.033603 2021-02-03 00:07:51.689628
passed all 0 test case(s)
skipped 1 test case(s)
2021-02-03 00:07:51 ./run-tests.py dpp_config_dpp_override_prime256v1
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_config_dpp_override_prime256v1 1/1
Test: DPP Config Object override (P-256)
dev0 displays QR Code
dev1 scans QR Code and initiates DPP Authentication
PASS dpp_config_dpp_override_prime256v1 2.065779 2021-02-03 00:07:53.917437
passed all 1 test case(s)
2021-02-03 00:07:53 ./run-tests.py dpp_config_jwk_error_no_y
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_config_jwk_error_no_y 1/1
Test: DPP Config Object JWK error - no y
dev0 displays QR Code
dev1 scans QR Code and initiates DPP Authentication
PASS dpp_config_jwk_error_no_y 0.055721 2021-02-03 00:07:54.128549
passed all 1 test case(s)
2021-02-03 00:07:54 ./run-tests.py dpp_config_legacy_gen
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_config_legacy_gen 1/1
Test: Generate DPP Config Object for legacy network
dev0 displays QR Code
dev1 scans QR Code and initiates DPP Authentication
PASS dpp_config_legacy_gen 0.053415 2021-02-03 00:07:54.337242
passed all 1 test case(s)
2021-02-03 00:07:54 ./run-tests.py dpp_proto_auth_conf_invalid_i_bootstrap_key
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_proto_auth_conf_invalid_i_bootstrap_key 1/1
Test: DPP protocol testing - invalid I-bootstrap key in Auth Conf
PASS dpp_proto_auth_conf_invalid_i_bootstrap_key 0.048936 2021-02-03 00:07:54.544633
passed all 1 test case(s)
2021-02-03 00:07:54 ./run-tests.py dpp_proto_auth_conf_no_wrapped_data
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_proto_auth_conf_no_wrapped_data 1/1
Test: DPP protocol testing - no Wrapped Data in Auth Conf
PASS dpp_proto_auth_conf_no_wrapped_data 0.047731 2021-02-03 00:07:54.752618
passed all 1 test case(s)
2021-02-03 00:07:54 ./run-tests.py dpp_proto_auth_resp_i_nonce_mismatch
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_proto_auth_resp_i_nonce_mismatch 1/1
Test: DPP protocol testing - I-nonce mismatch in Auth Resp
PASS dpp_proto_auth_resp_i_nonce_mismatch 0.148387 2021-02-03 00:07:55.060516
passed all 1 test case(s)
2021-02-03 00:07:55 ./run-tests.py dpp_qr_code_auth_mutual2
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_qr_code_auth_mutual2 1/1
Test: DPP QR Code and authentication exchange (mutual2)
dev0 displays QR Code
dev1 displays QR Code
dev1 scans QR Code and initiates DPP Authentication
dev0 scans QR Code
PASS dpp_qr_code_auth_mutual2 3.062129 2021-02-03 00:07:58.280291
passed all 1 test case(s)
2021-02-03 00:07:58 ./run-tests.py dpp_qr_code_auth_mutual_p_521
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_qr_code_auth_mutual_p_521 1/1
Test: DPP QR Code and authentication exchange (mutual, autogen P-521)
dev0 displays QR Code
dev1 scans QR Code and initiates DPP Authentication
dev0 scans QR Code
PASS dpp_qr_code_auth_mutual_p_521 1.060108 2021-02-03 00:07:59.499497
passed all 1 test case(s)
2021-02-03 00:07:59 ./run-tests.py dpp_qr_code_auth_rand_mac_addr
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_qr_code_auth_rand_mac_addr 1/1
Test: DPP QR Code and authentication exchange (rand_mac_addr=1)
Skip test case: Driver does not support random GAS TA
SKIP dpp_qr_code_auth_rand_mac_addr 0.035043 2021-02-03 00:07:59.693564
passed all 0 test case(s)
skipped 1 test case(s)
2021-02-03 00:07:59 ./run-tests.py eap_teap_basic_password_auth_user_and_machine_no_machine
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START eap_teap_basic_password_auth_user_and_machine_no_machine 1/1
Test: EAP-TEAP with Basic-Password-Auth using user and machine credentials (no machine)
Starting AP wlan3
Connect STA wlan0 to AP
PASS eap_teap_basic_password_auth_user_and_machine_no_machine 0.212537 2021-02-03 00:08:00.068075
passed all 1 test case(s)
2021-02-03 00:08:00 ./run-tests.py eap_teap_tls_cs_sha1
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START eap_teap_tls_cs_sha1 1/1
Test: EAP-TEAP with TLS cipher suite that uses SHA-1
Starting AP wlan3
Connect STA wlan0 to AP
PASS eap_teap_tls_cs_sha1 0.215339 2021-02-03 00:08:00.441304
passed all 1 test case(s)
2021-02-03 00:08:00 ./run-tests.py erp_local_errors
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START erp_local_errors 1/1
Test: ERP and local error cases
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
PASS erp_local_errors 1.654486 2021-02-03 00:08:02.252257
passed all 1 test case(s)
2021-02-03 00:08:02 ./run-tests.py erp_radius_eap_tls_v13
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START erp_radius_eap_tls_v13 1/1
Test: ERP enabled on RADIUS server and peer using EAP-TLS v1.3
Starting AP as-erp
Starting AP wlan3
Connect STA wlan0 to AP
PASS erp_radius_eap_tls_v13 0.283183 2021-02-03 00:08:02.692945
passed all 1 test case(s)
2021-02-03 00:08:02 ./run-tests.py fst_ap_ack_request_with_bad_fsts_id
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START fst_ap_ack_request_with_bad_fsts_id 1/1
Test: FST AP ack request with bad fsts id
Starting AP wlan3 (old add_ap argument type)
Starting AP wlan4 (old add_ap argument type)
Connect STA wlan5 to AP
Connect STA wlan6 to AP
Success. Bad scenario was handled correctly (Ack request received with bad fsts_id)
PASS fst_ap_ack_request_with_bad_fsts_id 5.522014 2021-02-03 00:08:08.372576
passed all 1 test case(s)
2021-02-03 00:08:08 ./run-tests.py fst_ap_initiate_session_response_with_zero_llt
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START fst_ap_initiate_session_response_with_zero_llt 1/1
Test: FST AP initiate session - zero llt
Starting AP wlan3 (old add_ap argument type)
Starting AP wlan4 (old add_ap argument type)
Connect STA wlan5 to AP
Connect STA wlan6 to AP
Success. Bad parameter was detected (Response with zero llt)
PASS fst_ap_initiate_session_response_with_zero_llt 0.486703 2021-02-03 00:08:09.019710
passed all 1 test case(s)
2021-02-03 00:08:09 ./run-tests.py fst_ap_tear_down_session_bad_fsts_id
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START fst_ap_tear_down_session_bad_fsts_id 1/1
Test: FST AP tear down session - bad fsts id
Starting AP wlan3 (old add_ap argument type)
Starting AP wlan4 (old add_ap argument type)
Connect STA wlan5 to AP
Connect STA wlan6 to AP
Success. Bad parameter was detected (Bad fsts_id)
PASS fst_ap_tear_down_session_bad_fsts_id 5.495795 2021-02-03 00:08:14.675082
passed all 1 test case(s)
2021-02-03 00:08:14 ./run-tests.py gas_anqp_address3_ap_non_compliant
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START gas_anqp_address3_ap_non_compliant 1/1
Test: GAS/ANQP query using IEEE 802.11 non-compliant Address 3 (AP)
Starting AP wlan3
PASS gas_anqp_address3_ap_non_compliant 0.443631 2021-02-03 00:08:15.274815
passed all 1 test case(s)
2021-02-03 00:08:15 ./run-tests.py gas_anqp_address3_assoc
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START gas_anqp_address3_assoc 1/1
Test: GAS/ANQP query using IEEE 802.11 compliant Address 3 value when associated
Starting AP wlan3
Connect STA wlan0 to AP
PASS gas_anqp_address3_assoc 0.536333 2021-02-03 00:08:15.968907
passed all 1 test case(s)
2021-02-03 00:08:15 ./run-tests.py gas_stop_fetch_anqp
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START gas_stop_fetch_anqp 1/1
Test: Stop FETCH_ANQP operation
Starting AP wlan3
PASS gas_stop_fetch_anqp 0.148113 2021-02-03 00:08:16.272233
passed all 1 test case(s)
2021-02-03 00:08:16 ./run-tests.py grpform_force_chan_conflict
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START grpform_force_chan_conflict 1/1
Test: P2P group formation fails due to forced channel mismatch
Start GO negotiation wlan0 -> wlan1
wlan1: Trying to discover peer 02:00:00:00:00:00
wlan0: Trying to discover peer 02:00:00:00:01:00
PASS grpform_force_chan_conflict 1.543236 2021-02-03 00:08:17.974097
passed all 1 test case(s)
2021-02-03 00:08:18 ./run-tests.py grpform_no_wsc_done
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START grpform_no_wsc_done 1/1
Test: P2P group formation with WSC-Done not sent
wlan1: Trying to discover peer 02:00:00:00:00:00
wlan0: Trying to discover peer 02:00:00:00:01:00
Drop WSC_Done
wlan1: Trying to discover peer 02:00:00:00:00:00
wlan0: Trying to discover peer 02:00:00:00:01:00
Drop WSC_Done
PASS grpform_no_wsc_done 1.468339 2021-02-03 00:08:19.599329
passed all 1 test case(s)
2021-02-03 00:08:19 ./run-tests.py he160_no_dfs_120_minus
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START he160_no_dfs_120_minus 1/1
Test: HE with 160 MHz channel width and no DFS (120 minus)
Starting AP wlan3
Connect STA wlan0 to AP
Country code at the end: 00
PASS he160_no_dfs_120_minus 0.789011 2021-02-03 00:08:20.543017
passed all 1 test case(s)
2021-02-03 00:08:20 ./run-tests.py he80_invalid2
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START he80_invalid2 1/1
Test: HE with invalid 80 MHz channel configuration (seg0)
Starting AP wlan3
Country code at the end: 00
PASS he80_invalid2 1.072566 2021-02-03 00:08:21.769668
passed all 1 test case(s)
2021-02-03 00:08:21 ./run-tests.py he_params
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START he_params 1/1
Test: HE AP parameters
Starting AP wlan3
Connect STA wlan0 to AP
PASS he_params 0.227878 2021-02-03 00:08:22.153712
passed all 1 test case(s)
2021-02-03 00:08:22 ./run-tests.py ieee8021x_held
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ieee8021x_held 1/1
Test: IEEE 802.1X and HELD state
Starting AP wlan3
Connect STA wlan0 to AP
PASS ieee8021x_held 3.384748 2021-02-03 00:08:25.697686
passed all 1 test case(s)
2021-02-03 00:08:25 ./run-tests.py macsec_psk_shorter_ckn2
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START macsec_psk_shorter_ckn2 1/1
Test: MACsec PSK (shorter CKN, unaligned)
Skip test case: macsec supported (wpa_supplicant CONFIG_MACSEC, CONFIG_DRIVER_MACSEC_LINUX; kernel CONFIG_MACSEC)
SKIP macsec_psk_shorter_ckn2 0.075782 2021-02-03 00:08:25.931948
passed all 0 test case(s)
skipped 1 test case(s)
2021-02-03 00:08:25 ./run-tests.py mbo_non_pref_chan
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START mbo_non_pref_chan 1/1
Test: MBO non-preferred channel list
Starting AP wlan3
Connect STA wlan0 to AP
PASS mbo_non_pref_chan 0.587402 2021-02-03 00:08:26.695997
passed all 1 test case(s)
2021-02-03 00:08:26 ./run-tests.py mbo_sta_supp_op_classes
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START mbo_sta_supp_op_classes 1/1
Test: MBO STA supported operating classes
Starting AP wlan3
Connect STA wlan0 to AP
PASS mbo_sta_supp_op_classes 0.178048 2021-02-03 00:08:27.033942
passed all 1 test case(s)
2021-02-03 00:08:27 ./run-tests.py mbo_supp_oper_classes_us_disable_vht
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START mbo_supp_oper_classes_us_disable_vht 1/1
Test: MBO and supported operating classes (US) - disable_vht
Starting AP wlan4
Country: US
Connect STA wlan0 to AP
Country code at the end (1): US
Country code at the end (2): 00
Country code at the end (3): 00
PASS mbo_supp_oper_classes_us_disable_vht 0.680999 2021-02-03 00:08:27.873065
passed all 1 test case(s)
2021-02-03 00:08:27 ./run-tests.py mesh_forwarding
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START mesh_forwarding 1/1
Test: Mesh with two stations that can't reach each other directly
PASS mesh_forwarding 1.222768 2021-02-03 00:08:29.250539
passed all 1 test case(s)
2021-02-03 00:08:29 ./run-tests.py nfc_p2p_static_handover_join_tagdev_go
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START nfc_p2p_static_handover_join_tagdev_go 1/1
Test: NFC static handover to join a P2P group (NFC Tag device is the GO)
Start autonomous GO
Write NFC Tag on the GO
Read NFC Tag on a P2P Device to join a group
Read NFC Tag on another P2P Device to join a group
PASS nfc_p2p_static_handover_join_tagdev_go 1.93676 2021-02-03 00:08:31.340844
passed all 1 test case(s)
2021-02-03 00:08:31 ./run-tests.py p2p_channel_5ghz_only
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START p2p_channel_5ghz_only 1/1
Test: P2P GO start with only 5 GHz band allowed
Start autonomous GO wlan0
Country code at the end: 00
PASS p2p_channel_5ghz_only 0.389332 2021-02-03 00:08:31.885213
passed all 1 test case(s)
2021-02-03 00:08:31 ./run-tests.py p2p_go_invite
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START p2p_go_invite 1/1
Test: P2P GO inviting a client to join
Generate BSS table entry for old group
Discover peer
wlan0: Trying to discover peer 02:00:00:00:01:00
Start GO on non-social channel
Invite peer to join the group
Join the group
wlan1: Trying to discover peer 02:00:00:00:00:00
Client connected
Terminate group
PASS p2p_go_invite 8.152832 2021-02-03 00:08:40.194870
passed all 1 test case(s)
2021-02-03 00:08:40 ./run-tests.py p2p_msg_go_neg_req_reject
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START p2p_msg_go_neg_req_reject 1/1
Test: P2P protocol tests for user reject incorrectly in GO Neg Req
wlan1: Trying to discover peer 02:00:00:00:00:00
PASS p2p_msg_go_neg_req_reject 1.433934 2021-02-03 00:08:41.788539
passed all 1 test case(s)
2021-02-03 00:08:41 ./run-tests.py p2ps_exact_search_srvinfo
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START p2ps_exact_search_srvinfo 1/1
Test: P2PS exact service request with service info
PASS p2ps_exact_search_srvinfo 0.239895 2021-02-03 00:08:42.184485
passed all 1 test case(s)
2021-02-03 00:08:42 ./run-tests.py pmksa_cache_and_ptk_rekey_ap
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START pmksa_cache_and_ptk_rekey_ap 1/1
Test: PMKSA caching and PTK rekey triggered by AP
Starting AP wlan3
Connect STA wlan0 to AP
Starting AP wlan4
Roam to AP2
Roam back to AP1
PASS pmksa_cache_and_ptk_rekey_ap 2.564103 2021-02-03 00:08:44.903896
passed all 1 test case(s)
2021-02-03 00:08:44 ./run-tests.py pmksa_cache_preauth
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START pmksa_cache_preauth 1/1
Test: RSN pre-authentication to generate PMKSA cache entry
Starting AP wlan3
Connect STA wlan0 to AP
Starting AP wlan4
PASS pmksa_cache_preauth 0.748757 2021-02-03 00:08:45.809016
passed all 1 test case(s)
2021-02-03 00:08:45 ./run-tests.py radius_acct_pmksa_caching
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START radius_acct_pmksa_caching 1/1
Test: RADIUS Accounting with PMKSA caching
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
PASS radius_acct_pmksa_caching 0.516278 2021-02-03 00:08:46.481772
passed all 1 test case(s)
2021-02-03 00:08:46 ./run-tests.py sae_and_psk_transition_disable
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_and_psk_transition_disable 1/1
Test: SAE and PSK transition disable indication
Starting AP wlan3
Connect STA wlan0 to AP
PASS sae_and_psk_transition_disable 0.291366 2021-02-03 00:08:46.933173
passed all 1 test case(s)
2021-02-03 00:08:46 ./run-tests.py sae_h2e_rsnxe_mismatch
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_h2e_rsnxe_mismatch 1/1
Test: SAE H2E and RSNXE mismatch in EAPOL-Key msg 2/4
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
PASS sae_h2e_rsnxe_mismatch 0.374933 2021-02-03 00:08:47.464601
passed all 1 test case(s)
2021-02-03 00:08:47 ./run-tests.py scan_abort
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_abort 1/1
Test: Aborting a full scan
PASS scan_abort 0.0409 2021-02-03 00:08:47.664114
passed all 1 test case(s)
2021-02-03 00:08:47 ./run-tests.py scan_for_auth_fail
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_for_auth_fail 1/1
Test: cfg80211 workaround with scan-for-auth failing
Starting AP wlan3
Connect STA wlan0 to AP
PASS scan_for_auth_fail 0.362718 2021-02-03 00:08:48.181330
passed all 1 test case(s)
2021-02-03 00:08:48 ./run-tests.py sigma_dut_ap_sae_pk_misbehavior
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_ap_sae_pk_misbehavior 1/1
Test: sigma_dut controlled AP using SAE-PK misbehavior
Skip test case: sigma_dut not available
SKIP sigma_dut_ap_sae_pk_misbehavior 0.062682 2021-02-03 00:08:48.401901
passed all 0 test case(s)
skipped 1 test case(s)
2021-02-03 00:08:48 ./run-tests.py sigma_dut_dpp_nfc_handover_requestor_enrollee
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_dpp_nfc_handover_requestor_enrollee 1/1
Test: sigma_dut DPP/NFC handover requestor as Enrollee
Starting AP wlan3
Skip test case: sigma_dut not available
SKIP sigma_dut_dpp_nfc_handover_requestor_enrollee 0.096988 2021-02-03 00:08:48.660086
passed all 0 test case(s)
skipped 1 test case(s)
2021-02-03 00:08:48 ./run-tests.py sigma_dut_sae_pw_id_ft
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_sae_pw_id_ft 1/1
Test: sigma_dut controlled SAE association with Password Identifier and FT
Skip test case: sigma_dut not available
SKIP sigma_dut_sae_pw_id_ft 0.033816 2021-02-03 00:08:48.854774
passed all 0 test case(s)
skipped 1 test case(s)
2021-02-03 00:08:48 ./run-tests.py tspec_ap_parsing
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START tspec_ap_parsing 1/1
Test: TSPEC AP parsing tests
Starting AP wlan3
Connect STA wlan0 to AP
PASS tspec_ap_parsing 0.218362 2021-02-03 00:08:49.232161
passed all 1 test case(s)
2021-02-03 00:08:49 ./run-tests.py wifi_display_go_invite
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START wifi_display_go_invite 1/1
Test: P2P GO with Wi-Fi Display inviting a client to join
wlan0: Trying to discover peer 02:00:00:00:01:00
wlan1: Trying to discover peer 02:00:00:00:00:00
Authorize invitation
Try to connect the client to the GO
wlan2: Trying to discover peer 02:00:00:00:00:00
Client connected
Invite peer to join the group
PASS wifi_display_go_invite 1.482665 2021-02-03 00:08:50.870367
passed all 1 test case(s)
2021-02-03 00:08:50 ./run-tests.py wnm_sleep_mode_open_fail
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START wnm_sleep_mode_open_fail 1/1
Test: WNM Sleep Mode - open (fail)
Starting AP wlan3
Connect STA wlan0 to AP
PASS wnm_sleep_mode_open_fail 0.195912 2021-02-03 00:08:51.225212
passed all 1 test case(s)
2021-02-03 00:08:51 ./run-tests.py wpa2_ocv_ap_mismatch
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START wpa2_ocv_ap_mismatch 1/1
Test: OCV AP mismatch
Starting AP wlan3
Connect STA wlan0 to AP
Send EAPOL-Key msg 2/4
Send EAPOL-Key msg 2/4
Send EAPOL-Key msg 2/4
Send EAPOL-Key msg 2/4
Send EAPOL-Key msg 2/4
Send EAPOL-Key msg 2/4
Send EAPOL-Key msg 4/4
PASS wpa2_ocv_ap_mismatch 4.309702 2021-02-03 00:08:55.693607
passed all 1 test case(s)
2021-02-03 00:08:55 ./run-tests.py wpas_ctrl_cred
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START wpas_ctrl_cred 1/1
Test: wpa_supplicant ctrl_iface cred set
PASS wpas_ctrl_cred 0.126635 2021-02-03 00:08:55.979963
passed all 1 test case(s)
2021-02-03 00:08:56 ./run-tests.py wpas_ctrl_wps_errors
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START wpas_ctrl_wps_errors 1/1
Test: wpa_supplicant ctrl_iface WPS error cases
PASS wpas_ctrl_wps_errors 0.03499 2021-02-03 00:08:56.171238
passed all 1 test case(s)
2021-02-03 00:08:56 ./run-tests.py wpas_mesh_password_mismatch_retry
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START wpas_mesh_password_mismatch_retry 1/1
Test: Mesh password mismatch and retry
Skip test case: Skip test case with long duration due to --long not specified
SKIP wpas_mesh_password_mismatch_retry 0.034659 2021-02-03 00:08:56.366421
passed all 0 test case(s)
skipped 1 test case(s)
2021-02-03 00:08:56 ./run-tests.py wps_ext_ap_settings_mac_addr_missing
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START wps_ext_ap_settings_mac_addr_missing 1/1
Test: WPS and AP Settings: missing MAC Address
Starting AP wlan3
PASS wps_ext_ap_settings_mac_addr_missing 0.329988 2021-02-03 00:08:56.861621
passed all 1 test case(s)
2021-02-03 00:08:56 ./stop.sh



To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install                job.yaml  # job file is attached in this email
        bin/lkp split-job --compatible job.yaml
        bin/lkp run                    compatible-job.yaml



Thanks,
Oliver Sang


--7LkOrbQMr4cezO2T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.11.0-rc4-00539-g12f9a570c0a6"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.11.0-rc4 Kernel Configuration
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
CONFIG_EXPERT=y
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
# CONFIG_DEBUG_RSEQ is not set
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_MEMCG_SYSFS_ON is not set
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
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
CONFIG_XEN_PVHVM_GUEST=y
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
# CONFIG_PROCESSOR_SELECT is not set
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
# CONFIG_X86_SGX is not set
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
# CONFIG_SUSPEND_SKIP_SYNC is not set
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
# CONFIG_DPM_WATCHDOG is not set
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
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
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
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
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
# CONFIG_KVM_WERROR is not set
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
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
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
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y

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
# CONFIG_GUP_TEST is not set
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
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
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
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
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
# CONFIG_PATA_PLATFORM is not set
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
# CONFIG_DM_MULTIPATH_IOA is not set
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
# CONFIG_SERIAL_BCM63XX is not set
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
# CONFIG_TTY_PRINTK is not set
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
CONFIG_I2C_SMBUS=m
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
CONFIG_I2C_I801=m
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
# CONFIG_PINCTRL_ALDERLAKE is not set
CONFIG_PINCTRL_BROXTON=m
CONFIG_PINCTRL_CANNONLAKE=m
CONFIG_PINCTRL_CEDARFORK=m
CONFIG_PINCTRL_DENVERTON=m
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
CONFIG_PINCTRL_GEMINILAKE=m
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
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

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
# CONFIG_GPIO_MOCKUP is not set
# end of Virtual GPIO drivers

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
# CONFIG_SENSORS_CORSAIR_PSU is not set
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
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX127 is not set
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
# CONFIG_SENSORS_PM6764TR is not set
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_Q54SJ108A2 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=m
# CONFIG_SENSORS_SBTSI is not set
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
CONFIG_PROC_THERMAL_MMIO_RAPL=m
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
CONFIG_LPC_ICH=m
CONFIG_LPC_SCH=m
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_INTEL_PMT is not set
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
# CONFIG_VIDEO_OV02A10 is not set
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
# CONFIG_VIDEO_OV9734 is not set
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
# CONFIG_VIDEO_CCS is not set
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
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
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

#
# drm/i915 Debugging
#
CONFIG_DRM_I915_WERROR=y
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_DEBUG_MMIO is not set
# CONFIG_DRM_I915_DEBUG_GEM is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
# end of drm/i915 Debugging

#
# drm/i915 Profile Guided Optimisation
#
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# end of drm/i915 Profile Guided Optimisation

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

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support
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
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
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
# CONFIG_EDAC_IGEN6 is not set
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
# CONFIG_RTC_DRV_RX6110 is not set

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
# CONFIG_UV_SYSFS is not set
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m
CONFIG_MXM_WMI=m
# CONFIG_PEAQ_WMI is not set
# CONFIG_XIAOMI_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
# CONFIG_AMD_PMC is not set
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
# CONFIG_DELL_WMI_SYSMAN is not set
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
# CONFIG_INTEL_PMT_CLASS is not set
# CONFIG_INTEL_PMT_TELEMETRY is not set
# CONFIG_INTEL_PMT_CRASHLOG is not set
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
# CONFIG_MLXREG_IO is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
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
# Enable LiteX SoC Builder specific drivers
#
# end of Enable LiteX SoC Builder specific drivers

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
# CONFIG_PWM_DWC is not set
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
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
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
# CONFIG_CIFS_SWN_UPCALL is not set
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
# CONFIG_HARDENED_USERCOPY_PAGESPAN is not set
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
# CONFIG_CRYPTO_DEV_QAT_4XXX is not set
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
# CONFIG_DMA_MAP_BENCHMARK is not set
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
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_32B is not set
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
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
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
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
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
# CONFIG_UNWINDER_GUESS is not set
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
# CONFIG_RESOURCE_KUNIT_TEST is not set
CONFIG_SYSCTL_KUNIT_TEST=m
CONFIG_LIST_KUNIT_TEST=m
# CONFIG_LINEAR_RANGES_TEST is not set
# CONFIG_CMDLINE_KUNIT_TEST is not set
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

--7LkOrbQMr4cezO2T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='hwsim'
	export testcase='hwsim'
	export category='functional'
	export need_memory='1G'
	export job_origin='/lkp-src/allot/cyclic:p1:linux-devel:devel-hourly/lkp-ivb-d02/hwsim-part4.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-ivb-d02'
	export tbox_group='lkp-ivb-d02'
	export kconfig='x86_64-rhel-8.3'
	export submit_id='6019e70be465af0e90ac9929'
	export job_file='/lkp/jobs/scheduled/lkp-ivb-d02/hwsim-group-33-ucode=0x21-debian-10.4-x86_64-20200603.cgz-12f9a570c0a654c6abc9e189e2227a1eb2d5d99e-20210203-69264-q6dlil-3.yaml'
	export id='85fd80e4d6639013cd576534946905ca06f51178'
	export queuer_version='/lkp-src'
	export model='Ivy Bridge'
	export nr_node=1
	export nr_cpu=4
	export memory='8G'
	export nr_hdd_partitions=4
	export nr_ssd_partitions=1
	export ssd_partitions='/dev/disk/by-id/ata-INTEL_SSDSC2BA400G4_BTHV634505W5400NGN-part1'
	export hdd_partitions='/dev/disk/by-id/ata-ST4000NM0035-1V4107_ZC127QJQ-part1 /dev/disk/by-id/ata-ST4000NM0035-1V4107_ZC127QJQ-part2 /dev/disk/by-id/ata-ST4000NM0035-1V4107_ZC127QJQ-part3 /dev/disk/by-id/ata-ST4000NM0035-1V4107_ZC127QJQ-part4'
	export swap_partitions='/dev/disk/by-id/ata-ST4000NM0035-1V4107_ZC127QJQ-part6'
	export rootfs_partition='/dev/disk/by-id/ata-ST4000NM0035-1V4107_ZC127QJQ-part5'
	export brand='Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz'
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
	export commit='12f9a570c0a654c6abc9e189e2227a1eb2d5d99e'
	export netconsole_port=6673
	export ucode='0x21'
	export need_kconfig_hw='CONFIG_NET_VENDOR_REALTEK=y
CONFIG_R8169=y
CONFIG_SATA_AHCI'
	export enqueue_time='2021-02-03 07:58:03 +0800'
	export _id='6019e70be465af0e90ac9929'
	export _rt='/result/hwsim/group-33-ucode=0x21/lkp-ivb-d02/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/12f9a570c0a654c6abc9e189e2227a1eb2d5d99e'
	export user='lkp'
	export compiler='gcc-9'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='fc28d02d4d09af8f29410ec21e562c6df90ca9c5'
	export base_commit='1048ba83fb1c00cd24172e23e8263972f6b5d9ac'
	export branch='linux-review/Johannes-Berg/cfg80211-fix-netdev-registration-deadlock/20210202-092757'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export result_root='/result/hwsim/group-33-ucode=0x21/lkp-ivb-d02/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/12f9a570c0a654c6abc9e189e2227a1eb2d5d99e/3'
	export scheduler_version='/lkp/lkp/.src-20210203-070843'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-ivb-d02/hwsim-group-33-ucode=0x21-debian-10.4-x86_64-20200603.cgz-12f9a570c0a654c6abc9e189e2227a1eb2d5d99e-20210203-69264-q6dlil-3.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3
branch=linux-review/Johannes-Berg/cfg80211-fix-netdev-registration-deadlock/20210202-092757
commit=12f9a570c0a654c6abc9e189e2227a1eb2d5d99e
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/12f9a570c0a654c6abc9e189e2227a1eb2d5d99e/vmlinuz-5.11.0-rc4-00539-g12f9a570c0a6
max_uptime=2100
RESULT_ROOT=/result/hwsim/group-33-ucode=0x21/lkp-ivb-d02/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/12f9a570c0a654c6abc9e189e2227a1eb2d5d99e/3
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/12f9a570c0a654c6abc9e189e2227a1eb2d5d99e/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hwsim_20210101.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/hwsim-x86_64-537ab94-1_20210101.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20201117.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='4.20.0'
	export repeat_to=4
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-9/12f9a570c0a654c6abc9e189e2227a1eb2d5d99e/vmlinuz-5.11.0-rc4-00539-g12f9a570c0a6'
	export dequeue_time='2021-02-03 08:04:03 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-ivb-d02/hwsim-group-33-ucode=0x21-debian-10.4-x86_64-20200603.cgz-12f9a570c0a654c6abc9e189e2227a1eb2d5d99e-20210203-69264-q6dlil-3.cgz'

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

	run_test test='group-33' $LKP_SRC/tests/wrapper hwsim
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env test='group-33' $LKP_SRC/stats/wrapper hwsim
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

--7LkOrbQMr4cezO2T
Content-Type: application/x-xz
Content-Disposition: attachment; filename="kmsg.xz"
Content-Transfer-Encoding: base64

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
AAAABFla

--7LkOrbQMr4cezO2T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=hwsim

2021-02-03 00:04:54 export USER=root
2021-02-03 00:04:54 ./build.sh
Building TNC testing tools
Building wlantest
Building hs20-osu-client
Building hostapd
Building wpa_supplicant
2021-02-03 00:06:06 ./start.sh
2021-02-03 00:06:06 ./run-tests.py ap_acs_hw_mode_any_5ghz
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_acs_hw_mode_any_5ghz 1/1
Test: Automatic channel selection with hw_mode=any and 5 GHz
Starting AP wlan3
Removing BSS wlan3
Starting AP wlan3
Connect STA wlan0 to AP
Country code at the end: 00
PASS ap_acs_hw_mode_any_5ghz 12.909362 2021-02-03 00:06:20.765348
passed all 1 test case(s)
2021-02-03 00:06:20 ./run-tests.py ap_csa_2_switches_count_1
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_csa_2_switches_count_1 1/1
Test: AP Channel Switch, two switches with count 1
Starting AP wlan3
Connect STA wlan0 to AP
dev2->dev1 unicast data delivery failed
Traceback (most recent call last):
  File "./run-tests.py", line 533, in main
    t(dev, apdev)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_ap_csa.py", line 139, in test_ap_csa_2_switches_count_1
    hwsim_utils.test_connectivity(dev[0], ap)
  File "/lkp/benchmarks/hwsim/tests/hwsim/hwsim_utils.py", line 195, in test_connectivity
    raise Exception(last_err)
Exception: dev2->dev1 unicast data delivery failed
FAIL ap_csa_2_switches_count_1 5.255997 2021-02-03 00:06:26.179210
passed 0 test case(s)
skipped 0 test case(s)
failed tests: ap_csa_2_switches_count_1
2021-02-03 00:06:26 ./run-tests.py ap_ft_pmf_over_ds
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_ft_pmf_over_ds 1/1
Test: WPA2-PSK-FT AP over DS with PMF
Starting AP wlan3
Starting AP wlan4
Connect to first AP
Connect STA wlan0 to AP
Roam to the second AP
Roam back to the first AP
PASS ap_ft_pmf_over_ds 0.668993 2021-02-03 00:06:27.012678
passed all 1 test case(s)
2021-02-03 00:06:27 ./run-tests.py ap_ft_sae_ptk_rekey1
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_ft_sae_ptk_rekey1 1/1
Test: WPA2-PSK-FT-SAE AP and PTK rekey triggered by station
Starting AP wlan3
Starting AP wlan4
Connect to first AP
Connect STA wlan0 to AP
Roam to the second AP
PASS ap_ft_sae_ptk_rekey1 1.487963 2021-02-03 00:06:28.658113
passed all 1 test case(s)
2021-02-03 00:06:28 ./run-tests.py ap_ft_sae_rsnxe_used_mismatch2
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_ft_sae_rsnxe_used_mismatch2 1/1
Test: FT-SAE AP and unexpected RSNXE Used in ReassocResp
Starting AP wlan3
Starting AP wlan4
Connect to first AP
Connect STA wlan0 to AP
PASS ap_ft_sae_rsnxe_used_mismatch2 0.754793 2021-02-03 00:06:29.569400
passed all 1 test case(s)
2021-02-03 00:06:29 ./run-tests.py ap_ft_skip_prune_assoc2
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_ft_skip_prune_assoc2 1/1
Test: WPA2-PSK-FT AP with skip_prune_assoc (disable full_ap_client_state)
Starting AP wlan3
Starting AP wlan4
Connect to first AP
Connect STA wlan0 to AP
Roam to the second AP
Roam back to the first AP
PASS ap_ft_skip_prune_assoc2 0.496598 2021-02-03 00:06:30.222631
passed all 1 test case(s)
2021-02-03 00:06:30 ./run-tests.py ap_hs20_external_selection
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_hs20_external_selection 1/1
Test: Hotspot 2.0 connection using external network selection and creation
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_hs20_external_selection 0.268145 2021-02-03 00:06:30.643985
passed all 1 test case(s)
2021-02-03 00:06:30 ./run-tests.py ap_hs20_fetch_osu_proto
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_hs20_fetch_osu_proto 1/1
Test: Hotspot 2.0 OSU provider and protocol testing
Starting AP wlan3
PASS ap_hs20_fetch_osu_proto 1.204107 2021-02-03 00:06:32.004099
passed all 1 test case(s)
2021-02-03 00:06:32 ./run-tests.py ap_hs20_min_bandwidth_and_roaming_partner_preference
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_hs20_min_bandwidth_and_roaming_partner_preference 1/1
Test: Hotspot 2.0 and minimum bandwidth with roaming partner preference
Starting AP wlan3
Starting AP wlan4
PASS ap_hs20_min_bandwidth_and_roaming_partner_preference 0.64994 2021-02-03 00:06:32.814619
passed all 1 test case(s)
2021-02-03 00:06:32 ./run-tests.py ap_hs20_min_bandwidth_no_wan_metrics
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_hs20_min_bandwidth_no_wan_metrics 1/1
Test: Hotspot 2.0 network selection with min bandwidth but no WAN Metrics
Starting AP wlan3
PASS ap_hs20_min_bandwidth_no_wan_metrics 0.180371 2021-02-03 00:06:33.156209
passed all 1 test case(s)
2021-02-03 00:06:33 ./run-tests.py ap_hs20_network_preference2
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_hs20_network_preference2 1/1
Test: Hotspot 2.0 network selection with preferred credential
Starting AP wlan4
Starting AP wlan3
PASS ap_hs20_network_preference2 0.510504 2021-02-03 00:06:33.826628
passed all 1 test case(s)
2021-02-03 00:06:33 ./run-tests.py ap_hs20_osen
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_hs20_osen 1/1
Test: Hotspot 2.0 OSEN connection
Starting AP wlan3
Connect STA wlan1 to AP
Connect STA wlan2 to AP
Connect STA wlan0 to AP
Connect STA wlan5 to AP
PASS ap_hs20_osen 0.476851 2021-02-03 00:06:34.462415
passed all 1 test case(s)
2021-02-03 00:06:34 ./run-tests.py ap_hs20_proxyarp_disable_dgaf
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_hs20_proxyarp_disable_dgaf 1/1
Test: Hotspot 2.0 and ProxyARP with DGAF disabled
Starting AP wlan3
Connect STA wlan1 to AP
After connect: ['192.168.1.123 dev ap-br0 lladdr 02:00:00:00:00:00 PERMANENT', 'aaaa:bbbb:cccc::2 dev ap-br0 lladdr 02:00:00:00:00:00 PERMANENT']
After disconnect: []
PASS ap_hs20_proxyarp_disable_dgaf 1.208 2021-02-03 00:06:35.823218
passed all 1 test case(s)
2021-02-03 00:06:35 ./run-tests.py ap_ht40_csa3
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_ht40_csa3 1/1
Test: HT with 40 MHz channel width and CSA
Starting AP wlan3
Connect STA wlan0 to AP
dev2->dev1 unicast data delivery failed
Traceback (most recent call last):
  File "./run-tests.py", line 533, in main
    t(dev, apdev)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_ap_ht.py", line 1142, in test_ap_ht40_csa3
    hwsim_utils.test_connectivity(dev[0], hapd)
  File "/lkp/benchmarks/hwsim/tests/hwsim/hwsim_utils.py", line 195, in test_connectivity
    raise Exception(last_err)
Exception: dev2->dev1 unicast data delivery failed
FAIL ap_ht40_csa3 5.677041 2021-02-03 00:06:41.659603
passed 0 test case(s)
skipped 0 test case(s)
failed tests: ap_ht40_csa3
2021-02-03 00:06:41 ./run-tests.py ap_ht40_scan_conflict
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_ht40_scan_conflict 1/1
Test: HT40 co-ex scan conflict
Starting AP wlan4
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_ht40_scan_conflict 2.874248 2021-02-03 00:06:44.693659
passed all 1 test case(s)
2021-02-03 00:06:44 ./run-tests.py ap_open_unexpected_assoc_event
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_open_unexpected_assoc_event 1/1
Test: AP with open mode and unexpected association event
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_open_unexpected_assoc_event 0.563543 2021-02-03 00:06:45.417773
passed all 1 test case(s)
2021-02-03 00:06:45 ./run-tests.py ap_pmf_sta_sa_query_oom
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_pmf_sta_sa_query_oom 1/1
Test: WPA2-PSK AP with station using SA Query (OOM)
Connect STA wlan0 to AP
PASS ap_pmf_sta_sa_query_oom 0.375688 2021-02-03 00:06:45.951757
passed all 1 test case(s)
2021-02-03 00:06:45 ./run-tests.py ap_roam_wpa2_psk
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_roam_wpa2_psk 1/1
Test: Roam between two WPA2-PSK APs
Starting AP wlan3
Connect STA wlan0 to AP
Starting AP wlan4
PASS ap_roam_wpa2_psk 14.776256 2021-02-03 00:07:00.883474
passed all 1 test case(s)
2021-02-03 00:07:00 ./run-tests.py ap_vht80_csa
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_vht80_csa 1/1
Test: VHT with 80 MHz channel width and CSA
Starting AP wlan3
Connect STA wlan0 to AP
Country code at the end: 00
dev2->dev1 unicast data delivery failed
Traceback (most recent call last):
  File "./run-tests.py", line 533, in main
    t(dev, apdev)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_ap_vht.py", line 739, in test_ap_vht80_csa
    hwsim_utils.test_connectivity(dev[0], hapd)
  File "/lkp/benchmarks/hwsim/tests/hwsim/hwsim_utils.py", line 195, in test_connectivity
    raise Exception(last_err)
Exception: dev2->dev1 unicast data delivery failed
FAIL ap_vht80_csa 5.77785 2021-02-03 00:07:06.818475
passed 0 test case(s)
skipped 0 test case(s)
failed tests: ap_vht80_csa
2021-02-03 00:07:06 ./run-tests.py ap_wowlan_triggers
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wowlan_triggers 1/1
Test: AP with wowlan_triggers
Starting AP wlan3
Connect STA wlan0 to AP
dev2->dev1 unicast data delivery failed
Traceback (most recent call last):
  File "./run-tests.py", line 533, in main
    t(dev, apdev)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_ap_params.py", line 845, in test_ap_wowlan_triggers
    hwsim_utils.test_connectivity(dev[0], hapd)
  File "/lkp/benchmarks/hwsim/tests/hwsim/hwsim_utils.py", line 195, in test_connectivity
    raise Exception(last_err)
Exception: dev2->dev1 unicast data delivery failed
FAIL ap_wowlan_triggers 5.259493 2021-02-03 00:07:12.239506
passed 0 test case(s)
skipped 0 test case(s)
failed tests: ap_wowlan_triggers
2021-02-03 00:07:12 ./run-tests.py ap_wpa2_eap_pwd_salt_sha1
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_pwd_salt_sha1 1/1
Test: WPA2-Enterprise connection using EAP-pwd and salted password SHA-1
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_pwd_salt_sha1 0.235241 2021-02-03 00:07:12.640604
passed all 1 test case(s)
2021-02-03 00:07:12 ./run-tests.py ap_wpa2_eap_ttls_dh_params_invalid
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_ttls_dh_params_invalid 1/1
Test: EAP-TLS server and invalid dhparams file
Starting AP wlan3
PASS ap_wpa2_eap_ttls_dh_params_invalid 0.055963 2021-02-03 00:07:12.855433
passed all 1 test case(s)
2021-02-03 00:07:12 ./run-tests.py ap_wpa2_eap_ttls_eap_md5_server_oom
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_ttls_eap_md5_server_oom 1/1
Test: WPA2-Enterprise connection using EAP-TTLS/EAP-MD5 - server OOM
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan0 to AP
PASS ap_wpa2_eap_ttls_eap_md5_server_oom 0.339437 2021-02-03 00:07:13.351569
passed all 1 test case(s)
2021-02-03 00:07:13 ./run-tests.py ap_wpa2_eap_unexpected_wep_eapol_key
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_eap_unexpected_wep_eapol_key 1/1
Test: WPA2-Enterprise connection and unexpected WEP EAPOL-Key
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_eap_unexpected_wep_eapol_key 0.23947 2021-02-03 00:07:13.746338
passed all 1 test case(s)
2021-02-03 00:07:13 ./run-tests.py ap_wpa2_psk_incorrect_passphrase
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_psk_incorrect_passphrase 1/1
Test: WPA2-PSK AP and station using incorrect passphrase
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_psk_incorrect_passphrase 10.444571 2021-02-03 00:07:24.348540
passed all 1 test case(s)
2021-02-03 00:07:24 ./run-tests.py ap_wpa2_psk_supp_proto_gtk_tx_bit_workaround
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_psk_supp_proto_gtk_tx_bit_workaround 1/1
Test: WPA2-PSK supplicant protocol testing: GTK TX bit workaround
Starting AP wlan3
Connect STA wlan0 to AP
PASS ap_wpa2_psk_supp_proto_gtk_tx_bit_workaround 0.233467 2021-02-03 00:07:24.741161
passed all 1 test case(s)
2021-02-03 00:07:24 ./run-tests.py ap_wpa2_tdls_diff_rsnie
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wpa2_tdls_diff_rsnie 1/1
Test: TDLS with different RSN IEs
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
Setup TDLS
Teardown TDLS
PASS ap_wpa2_tdls_diff_rsnie 3.017181 2021-02-03 00:07:27.916099
passed all 1 test case(s)
2021-02-03 00:07:27 ./run-tests.py ap_wps_and_bss_limit
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wps_and_bss_limit 1/1
Test: WPS and wpa_supplicant BSS entry limit
Starting AP wlan3
Starting AP wlan4
PASS ap_wps_and_bss_limit 4.243865 2021-02-03 00:07:32.321394
passed all 1 test case(s)
2021-02-03 00:07:32 ./run-tests.py ap_wps_authenticator_mismatch_m2
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wps_authenticator_mismatch_m2 1/1
Test: WPS and Authenticator attribute mismatch in M2
Starting AP wlan3
PASS ap_wps_authenticator_mismatch_m2 0.262258 2021-02-03 00:07:32.744824
passed all 1 test case(s)
2021-02-03 00:07:32 ./run-tests.py ap_wps_er_http_proto_upnp_info_no_device_type
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wps_er_http_proto_upnp_info_no_device_type 1/1
Test: WPS ER HTTP protocol testing - No deviceType in UPnP info
HTTP server received: GET /foo.xml HTTP/1.1
HTTP header: Cache-Control: no-cache
HTTP header: Pragma: no-cache
HTTP header: Accept: text/xml, application/xml
HTTP header: User-Agent: wpa_supplicant
HTTP header: Host: 127.0.0.1:12345
PASS ap_wps_er_http_proto_upnp_info_no_device_type 2.038222 2021-02-03 00:07:34.943100
passed all 1 test case(s)
2021-02-03 00:07:34 ./run-tests.py ap_wps_er_init_oom
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wps_er_init_oom 1/1
Test: WPS ER and OOM during init
PASS ap_wps_er_init_oom 0.044205 2021-02-03 00:07:35.146994
passed all 1 test case(s)
2021-02-03 00:07:35 ./run-tests.py ap_wps_er_ssdp_proto
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wps_er_ssdp_proto 1/1
Test: WPS ER SSDP protocol testing
PASS ap_wps_er_ssdp_proto 2.33919 2021-02-03 00:07:37.642445
passed all 1 test case(s)
2021-02-03 00:07:37 ./run-tests.py ap_wps_m5_oom
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wps_m5_oom 1/1
Test: WPS and OOM for M5 on STA
Starting AP wlan3
PASS ap_wps_m5_oom 0.463147 2021-02-03 00:07:38.266681
passed all 1 test case(s)
2021-02-03 00:07:38 ./run-tests.py ap_wps_new_version_ap
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ap_wps_new_version_ap 1/1
Test: WPS compatibility with new version number on the AP
Starting AP wlan3
WPS provisioning step
PASS ap_wps_new_version_ap 0.34721 2021-02-03 00:07:38.773379
passed all 1 test case(s)
2021-02-03 00:07:38 ./run-tests.py autogo_noa
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START autogo_noa 1/1
Test: P2P autonomous GO and NoA
Start autonomous GO wlan0
Connect STA wlan1 to AP
PASS autogo_noa 0.273418 2021-02-03 00:07:39.204520
passed all 1 test case(s)
2021-02-03 00:07:39 ./run-tests.py bgscan_learn_beacon_loss
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START bgscan_learn_beacon_loss 1/1
Test: bgscan_simple and beacon loss
Starting AP wlan3
Connect STA wlan0 to AP
PASS bgscan_learn_beacon_loss 1.483879 2021-02-03 00:07:40.845941
passed all 1 test case(s)
2021-02-03 00:07:40 ./run-tests.py dbus_wps_cancel
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dbus_wps_cancel 1/1
Test: D-Bus WPS Cancel operation
No dbus module available
Skip test case: No dbus module available
SKIP dbus_wps_cancel 0.035014 2021-02-03 00:07:41.041998
passed all 0 test case(s)
skipped 1 test case(s)
2021-02-03 00:07:41 ./run-tests.py dfs_radar_chanlist_vht20
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dfs_radar_chanlist_vht20 1/1
Test: DFS chanlist when radar is detected and VHT40 configured
Starting AP wlan3 on DFS channel
Starting AP wlan3
Trigger a simulated radar event
Connect STA wlan0 to AP
Country code at the end: 00
PASS dfs_radar_chanlist_vht20 4.180751 2021-02-03 00:07:45.385070
passed all 1 test case(s)
2021-02-03 00:07:45 ./run-tests.py dpp_auto_connect_2_ver1
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_auto_connect_2_ver1 1/1
Test: DPP and auto connect (2; AP and STA using ver 1)
Starting AP wlan3
PASS dpp_auto_connect_2_ver1 5.955091 2021-02-03 00:07:51.497018
passed all 1 test case(s)
2021-02-03 00:07:51 ./run-tests.py dpp_config_connector_error_invalid_timestamp_date
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_config_connector_error_invalid_timestamp_date 1/1
Test: DPP Config Object connector error - invalid timestamp date
Skip test case: OpenSSL python method not available
SKIP dpp_config_connector_error_invalid_timestamp_date 0.033603 2021-02-03 00:07:51.689628
passed all 0 test case(s)
skipped 1 test case(s)
2021-02-03 00:07:51 ./run-tests.py dpp_config_dpp_override_prime256v1
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_config_dpp_override_prime256v1 1/1
Test: DPP Config Object override (P-256)
dev0 displays QR Code
dev1 scans QR Code and initiates DPP Authentication
PASS dpp_config_dpp_override_prime256v1 2.065779 2021-02-03 00:07:53.917437
passed all 1 test case(s)
2021-02-03 00:07:53 ./run-tests.py dpp_config_jwk_error_no_y
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_config_jwk_error_no_y 1/1
Test: DPP Config Object JWK error - no y
dev0 displays QR Code
dev1 scans QR Code and initiates DPP Authentication
PASS dpp_config_jwk_error_no_y 0.055721 2021-02-03 00:07:54.128549
passed all 1 test case(s)
2021-02-03 00:07:54 ./run-tests.py dpp_config_legacy_gen
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_config_legacy_gen 1/1
Test: Generate DPP Config Object for legacy network
dev0 displays QR Code
dev1 scans QR Code and initiates DPP Authentication
PASS dpp_config_legacy_gen 0.053415 2021-02-03 00:07:54.337242
passed all 1 test case(s)
2021-02-03 00:07:54 ./run-tests.py dpp_proto_auth_conf_invalid_i_bootstrap_key
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_proto_auth_conf_invalid_i_bootstrap_key 1/1
Test: DPP protocol testing - invalid I-bootstrap key in Auth Conf
PASS dpp_proto_auth_conf_invalid_i_bootstrap_key 0.048936 2021-02-03 00:07:54.544633
passed all 1 test case(s)
2021-02-03 00:07:54 ./run-tests.py dpp_proto_auth_conf_no_wrapped_data
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_proto_auth_conf_no_wrapped_data 1/1
Test: DPP protocol testing - no Wrapped Data in Auth Conf
PASS dpp_proto_auth_conf_no_wrapped_data 0.047731 2021-02-03 00:07:54.752618
passed all 1 test case(s)
2021-02-03 00:07:54 ./run-tests.py dpp_proto_auth_resp_i_nonce_mismatch
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_proto_auth_resp_i_nonce_mismatch 1/1
Test: DPP protocol testing - I-nonce mismatch in Auth Resp
PASS dpp_proto_auth_resp_i_nonce_mismatch 0.148387 2021-02-03 00:07:55.060516
passed all 1 test case(s)
2021-02-03 00:07:55 ./run-tests.py dpp_qr_code_auth_mutual2
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_qr_code_auth_mutual2 1/1
Test: DPP QR Code and authentication exchange (mutual2)
dev0 displays QR Code
dev1 displays QR Code
dev1 scans QR Code and initiates DPP Authentication
dev0 scans QR Code
PASS dpp_qr_code_auth_mutual2 3.062129 2021-02-03 00:07:58.280291
passed all 1 test case(s)
2021-02-03 00:07:58 ./run-tests.py dpp_qr_code_auth_mutual_p_521
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_qr_code_auth_mutual_p_521 1/1
Test: DPP QR Code and authentication exchange (mutual, autogen P-521)
dev0 displays QR Code
dev1 scans QR Code and initiates DPP Authentication
dev0 scans QR Code
PASS dpp_qr_code_auth_mutual_p_521 1.060108 2021-02-03 00:07:59.499497
passed all 1 test case(s)
2021-02-03 00:07:59 ./run-tests.py dpp_qr_code_auth_rand_mac_addr
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_qr_code_auth_rand_mac_addr 1/1
Test: DPP QR Code and authentication exchange (rand_mac_addr=1)
Skip test case: Driver does not support random GAS TA
SKIP dpp_qr_code_auth_rand_mac_addr 0.035043 2021-02-03 00:07:59.693564
passed all 0 test case(s)
skipped 1 test case(s)
2021-02-03 00:07:59 ./run-tests.py eap_teap_basic_password_auth_user_and_machine_no_machine
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START eap_teap_basic_password_auth_user_and_machine_no_machine 1/1
Test: EAP-TEAP with Basic-Password-Auth using user and machine credentials (no machine)
Starting AP wlan3
Connect STA wlan0 to AP
PASS eap_teap_basic_password_auth_user_and_machine_no_machine 0.212537 2021-02-03 00:08:00.068075
passed all 1 test case(s)
2021-02-03 00:08:00 ./run-tests.py eap_teap_tls_cs_sha1
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START eap_teap_tls_cs_sha1 1/1
Test: EAP-TEAP with TLS cipher suite that uses SHA-1
Starting AP wlan3
Connect STA wlan0 to AP
PASS eap_teap_tls_cs_sha1 0.215339 2021-02-03 00:08:00.441304
passed all 1 test case(s)
2021-02-03 00:08:00 ./run-tests.py erp_local_errors
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START erp_local_errors 1/1
Test: ERP and local error cases
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
PASS erp_local_errors 1.654486 2021-02-03 00:08:02.252257
passed all 1 test case(s)
2021-02-03 00:08:02 ./run-tests.py erp_radius_eap_tls_v13
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START erp_radius_eap_tls_v13 1/1
Test: ERP enabled on RADIUS server and peer using EAP-TLS v1.3
Starting AP as-erp
Starting AP wlan3
Connect STA wlan0 to AP
PASS erp_radius_eap_tls_v13 0.283183 2021-02-03 00:08:02.692945
passed all 1 test case(s)
2021-02-03 00:08:02 ./run-tests.py fst_ap_ack_request_with_bad_fsts_id
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START fst_ap_ack_request_with_bad_fsts_id 1/1
Test: FST AP ack request with bad fsts id
Starting AP wlan3 (old add_ap argument type)
Starting AP wlan4 (old add_ap argument type)
Connect STA wlan5 to AP
Connect STA wlan6 to AP
Success. Bad scenario was handled correctly (Ack request received with bad fsts_id)
PASS fst_ap_ack_request_with_bad_fsts_id 5.522014 2021-02-03 00:08:08.372576
passed all 1 test case(s)
2021-02-03 00:08:08 ./run-tests.py fst_ap_initiate_session_response_with_zero_llt
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START fst_ap_initiate_session_response_with_zero_llt 1/1
Test: FST AP initiate session - zero llt
Starting AP wlan3 (old add_ap argument type)
Starting AP wlan4 (old add_ap argument type)
Connect STA wlan5 to AP
Connect STA wlan6 to AP
Success. Bad parameter was detected (Response with zero llt)
PASS fst_ap_initiate_session_response_with_zero_llt 0.486703 2021-02-03 00:08:09.019710
passed all 1 test case(s)
2021-02-03 00:08:09 ./run-tests.py fst_ap_tear_down_session_bad_fsts_id
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START fst_ap_tear_down_session_bad_fsts_id 1/1
Test: FST AP tear down session - bad fsts id
Starting AP wlan3 (old add_ap argument type)
Starting AP wlan4 (old add_ap argument type)
Connect STA wlan5 to AP
Connect STA wlan6 to AP
Success. Bad parameter was detected (Bad fsts_id)
PASS fst_ap_tear_down_session_bad_fsts_id 5.495795 2021-02-03 00:08:14.675082
passed all 1 test case(s)
2021-02-03 00:08:14 ./run-tests.py gas_anqp_address3_ap_non_compliant
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START gas_anqp_address3_ap_non_compliant 1/1
Test: GAS/ANQP query using IEEE 802.11 non-compliant Address 3 (AP)
Starting AP wlan3
PASS gas_anqp_address3_ap_non_compliant 0.443631 2021-02-03 00:08:15.274815
passed all 1 test case(s)
2021-02-03 00:08:15 ./run-tests.py gas_anqp_address3_assoc
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START gas_anqp_address3_assoc 1/1
Test: GAS/ANQP query using IEEE 802.11 compliant Address 3 value when associated
Starting AP wlan3
Connect STA wlan0 to AP
PASS gas_anqp_address3_assoc 0.536333 2021-02-03 00:08:15.968907
passed all 1 test case(s)
2021-02-03 00:08:15 ./run-tests.py gas_stop_fetch_anqp
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START gas_stop_fetch_anqp 1/1
Test: Stop FETCH_ANQP operation
Starting AP wlan3
PASS gas_stop_fetch_anqp 0.148113 2021-02-03 00:08:16.272233
passed all 1 test case(s)
2021-02-03 00:08:16 ./run-tests.py grpform_force_chan_conflict
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START grpform_force_chan_conflict 1/1
Test: P2P group formation fails due to forced channel mismatch
Start GO negotiation wlan0 -> wlan1
wlan1: Trying to discover peer 02:00:00:00:00:00
wlan0: Trying to discover peer 02:00:00:00:01:00
PASS grpform_force_chan_conflict 1.543236 2021-02-03 00:08:17.974097
passed all 1 test case(s)
2021-02-03 00:08:18 ./run-tests.py grpform_no_wsc_done
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START grpform_no_wsc_done 1/1
Test: P2P group formation with WSC-Done not sent
wlan1: Trying to discover peer 02:00:00:00:00:00
wlan0: Trying to discover peer 02:00:00:00:01:00
Drop WSC_Done
wlan1: Trying to discover peer 02:00:00:00:00:00
wlan0: Trying to discover peer 02:00:00:00:01:00
Drop WSC_Done
PASS grpform_no_wsc_done 1.468339 2021-02-03 00:08:19.599329
passed all 1 test case(s)
2021-02-03 00:08:19 ./run-tests.py he160_no_dfs_120_minus
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START he160_no_dfs_120_minus 1/1
Test: HE with 160 MHz channel width and no DFS (120 minus)
Starting AP wlan3
Connect STA wlan0 to AP
Country code at the end: 00
PASS he160_no_dfs_120_minus 0.789011 2021-02-03 00:08:20.543017
passed all 1 test case(s)
2021-02-03 00:08:20 ./run-tests.py he80_invalid2
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START he80_invalid2 1/1
Test: HE with invalid 80 MHz channel configuration (seg0)
Starting AP wlan3
Country code at the end: 00
PASS he80_invalid2 1.072566 2021-02-03 00:08:21.769668
passed all 1 test case(s)
2021-02-03 00:08:21 ./run-tests.py he_params
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START he_params 1/1
Test: HE AP parameters
Starting AP wlan3
Connect STA wlan0 to AP
PASS he_params 0.227878 2021-02-03 00:08:22.153712
passed all 1 test case(s)
2021-02-03 00:08:22 ./run-tests.py ieee8021x_held
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START ieee8021x_held 1/1
Test: IEEE 802.1X and HELD state
Starting AP wlan3
Connect STA wlan0 to AP
PASS ieee8021x_held 3.384748 2021-02-03 00:08:25.697686
passed all 1 test case(s)
2021-02-03 00:08:25 ./run-tests.py macsec_psk_shorter_ckn2
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START macsec_psk_shorter_ckn2 1/1
Test: MACsec PSK (shorter CKN, unaligned)
Skip test case: macsec supported (wpa_supplicant CONFIG_MACSEC, CONFIG_DRIVER_MACSEC_LINUX; kernel CONFIG_MACSEC)
SKIP macsec_psk_shorter_ckn2 0.075782 2021-02-03 00:08:25.931948
passed all 0 test case(s)
skipped 1 test case(s)
2021-02-03 00:08:25 ./run-tests.py mbo_non_pref_chan
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START mbo_non_pref_chan 1/1
Test: MBO non-preferred channel list
Starting AP wlan3
Connect STA wlan0 to AP
PASS mbo_non_pref_chan 0.587402 2021-02-03 00:08:26.695997
passed all 1 test case(s)
2021-02-03 00:08:26 ./run-tests.py mbo_sta_supp_op_classes
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START mbo_sta_supp_op_classes 1/1
Test: MBO STA supported operating classes
Starting AP wlan3
Connect STA wlan0 to AP
PASS mbo_sta_supp_op_classes 0.178048 2021-02-03 00:08:27.033942
passed all 1 test case(s)
2021-02-03 00:08:27 ./run-tests.py mbo_supp_oper_classes_us_disable_vht
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START mbo_supp_oper_classes_us_disable_vht 1/1
Test: MBO and supported operating classes (US) - disable_vht
Starting AP wlan4
Country: US
Connect STA wlan0 to AP
Country code at the end (1): US
Country code at the end (2): 00
Country code at the end (3): 00
PASS mbo_supp_oper_classes_us_disable_vht 0.680999 2021-02-03 00:08:27.873065
passed all 1 test case(s)
2021-02-03 00:08:27 ./run-tests.py mesh_forwarding
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START mesh_forwarding 1/1
Test: Mesh with two stations that can't reach each other directly
PASS mesh_forwarding 1.222768 2021-02-03 00:08:29.250539
passed all 1 test case(s)
2021-02-03 00:08:29 ./run-tests.py nfc_p2p_static_handover_join_tagdev_go
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START nfc_p2p_static_handover_join_tagdev_go 1/1
Test: NFC static handover to join a P2P group (NFC Tag device is the GO)
Start autonomous GO
Write NFC Tag on the GO
Read NFC Tag on a P2P Device to join a group
Read NFC Tag on another P2P Device to join a group
PASS nfc_p2p_static_handover_join_tagdev_go 1.93676 2021-02-03 00:08:31.340844
passed all 1 test case(s)
2021-02-03 00:08:31 ./run-tests.py p2p_channel_5ghz_only
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START p2p_channel_5ghz_only 1/1
Test: P2P GO start with only 5 GHz band allowed
Start autonomous GO wlan0
Country code at the end: 00
PASS p2p_channel_5ghz_only 0.389332 2021-02-03 00:08:31.885213
passed all 1 test case(s)
2021-02-03 00:08:31 ./run-tests.py p2p_go_invite
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START p2p_go_invite 1/1
Test: P2P GO inviting a client to join
Generate BSS table entry for old group
Discover peer
wlan0: Trying to discover peer 02:00:00:00:01:00
Start GO on non-social channel
Invite peer to join the group
Join the group
wlan1: Trying to discover peer 02:00:00:00:00:00
Client connected
Terminate group
PASS p2p_go_invite 8.152832 2021-02-03 00:08:40.194870
passed all 1 test case(s)
2021-02-03 00:08:40 ./run-tests.py p2p_msg_go_neg_req_reject
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START p2p_msg_go_neg_req_reject 1/1
Test: P2P protocol tests for user reject incorrectly in GO Neg Req
wlan1: Trying to discover peer 02:00:00:00:00:00
PASS p2p_msg_go_neg_req_reject 1.433934 2021-02-03 00:08:41.788539
passed all 1 test case(s)
2021-02-03 00:08:41 ./run-tests.py p2ps_exact_search_srvinfo
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START p2ps_exact_search_srvinfo 1/1
Test: P2PS exact service request with service info
PASS p2ps_exact_search_srvinfo 0.239895 2021-02-03 00:08:42.184485
passed all 1 test case(s)
2021-02-03 00:08:42 ./run-tests.py pmksa_cache_and_ptk_rekey_ap
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START pmksa_cache_and_ptk_rekey_ap 1/1
Test: PMKSA caching and PTK rekey triggered by AP
Starting AP wlan3
Connect STA wlan0 to AP
Starting AP wlan4
Roam to AP2
Roam back to AP1
PASS pmksa_cache_and_ptk_rekey_ap 2.564103 2021-02-03 00:08:44.903896
passed all 1 test case(s)
2021-02-03 00:08:44 ./run-tests.py pmksa_cache_preauth
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START pmksa_cache_preauth 1/1
Test: RSN pre-authentication to generate PMKSA cache entry
Starting AP wlan3
Connect STA wlan0 to AP
Starting AP wlan4
PASS pmksa_cache_preauth 0.748757 2021-02-03 00:08:45.809016
passed all 1 test case(s)
2021-02-03 00:08:45 ./run-tests.py radius_acct_pmksa_caching
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START radius_acct_pmksa_caching 1/1
Test: RADIUS Accounting with PMKSA caching
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan1 to AP
PASS radius_acct_pmksa_caching 0.516278 2021-02-03 00:08:46.481772
passed all 1 test case(s)
2021-02-03 00:08:46 ./run-tests.py sae_and_psk_transition_disable
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_and_psk_transition_disable 1/1
Test: SAE and PSK transition disable indication
Starting AP wlan3
Connect STA wlan0 to AP
PASS sae_and_psk_transition_disable 0.291366 2021-02-03 00:08:46.933173
passed all 1 test case(s)
2021-02-03 00:08:46 ./run-tests.py sae_h2e_rsnxe_mismatch
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sae_h2e_rsnxe_mismatch 1/1
Test: SAE H2E and RSNXE mismatch in EAPOL-Key msg 2/4
Starting AP wlan3
Connect STA wlan0 to AP
Connect STA wlan0 to AP
Connect STA wlan0 to AP
PASS sae_h2e_rsnxe_mismatch 0.374933 2021-02-03 00:08:47.464601
passed all 1 test case(s)
2021-02-03 00:08:47 ./run-tests.py scan_abort
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_abort 1/1
Test: Aborting a full scan
PASS scan_abort 0.0409 2021-02-03 00:08:47.664114
passed all 1 test case(s)
2021-02-03 00:08:47 ./run-tests.py scan_for_auth_fail
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START scan_for_auth_fail 1/1
Test: cfg80211 workaround with scan-for-auth failing
Starting AP wlan3
Connect STA wlan0 to AP
PASS scan_for_auth_fail 0.362718 2021-02-03 00:08:48.181330
passed all 1 test case(s)
2021-02-03 00:08:48 ./run-tests.py sigma_dut_ap_sae_pk_misbehavior
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_ap_sae_pk_misbehavior 1/1
Test: sigma_dut controlled AP using SAE-PK misbehavior
Skip test case: sigma_dut not available
SKIP sigma_dut_ap_sae_pk_misbehavior 0.062682 2021-02-03 00:08:48.401901
passed all 0 test case(s)
skipped 1 test case(s)
2021-02-03 00:08:48 ./run-tests.py sigma_dut_dpp_nfc_handover_requestor_enrollee
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_dpp_nfc_handover_requestor_enrollee 1/1
Test: sigma_dut DPP/NFC handover requestor as Enrollee
Starting AP wlan3
Skip test case: sigma_dut not available
SKIP sigma_dut_dpp_nfc_handover_requestor_enrollee 0.096988 2021-02-03 00:08:48.660086
passed all 0 test case(s)
skipped 1 test case(s)
2021-02-03 00:08:48 ./run-tests.py sigma_dut_sae_pw_id_ft
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START sigma_dut_sae_pw_id_ft 1/1
Test: sigma_dut controlled SAE association with Password Identifier and FT
Skip test case: sigma_dut not available
SKIP sigma_dut_sae_pw_id_ft 0.033816 2021-02-03 00:08:48.854774
passed all 0 test case(s)
skipped 1 test case(s)
2021-02-03 00:08:48 ./run-tests.py tspec_ap_parsing
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START tspec_ap_parsing 1/1
Test: TSPEC AP parsing tests
Starting AP wlan3
Connect STA wlan0 to AP
PASS tspec_ap_parsing 0.218362 2021-02-03 00:08:49.232161
passed all 1 test case(s)
2021-02-03 00:08:49 ./run-tests.py wifi_display_go_invite
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START wifi_display_go_invite 1/1
Test: P2P GO with Wi-Fi Display inviting a client to join
wlan0: Trying to discover peer 02:00:00:00:01:00
wlan1: Trying to discover peer 02:00:00:00:00:00
Authorize invitation
Try to connect the client to the GO
wlan2: Trying to discover peer 02:00:00:00:00:00
Client connected
Invite peer to join the group
PASS wifi_display_go_invite 1.482665 2021-02-03 00:08:50.870367
passed all 1 test case(s)
2021-02-03 00:08:50 ./run-tests.py wnm_sleep_mode_open_fail
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START wnm_sleep_mode_open_fail 1/1
Test: WNM Sleep Mode - open (fail)
Starting AP wlan3
Connect STA wlan0 to AP
PASS wnm_sleep_mode_open_fail 0.195912 2021-02-03 00:08:51.225212
passed all 1 test case(s)
2021-02-03 00:08:51 ./run-tests.py wpa2_ocv_ap_mismatch
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START wpa2_ocv_ap_mismatch 1/1
Test: OCV AP mismatch
Starting AP wlan3
Connect STA wlan0 to AP
Send EAPOL-Key msg 2/4
Send EAPOL-Key msg 2/4
Send EAPOL-Key msg 2/4
Send EAPOL-Key msg 2/4
Send EAPOL-Key msg 2/4
Send EAPOL-Key msg 2/4
Send EAPOL-Key msg 4/4
PASS wpa2_ocv_ap_mismatch 4.309702 2021-02-03 00:08:55.693607
passed all 1 test case(s)
2021-02-03 00:08:55 ./run-tests.py wpas_ctrl_cred
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START wpas_ctrl_cred 1/1
Test: wpa_supplicant ctrl_iface cred set
PASS wpas_ctrl_cred 0.126635 2021-02-03 00:08:55.979963
passed all 1 test case(s)
2021-02-03 00:08:56 ./run-tests.py wpas_ctrl_wps_errors
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START wpas_ctrl_wps_errors 1/1
Test: wpa_supplicant ctrl_iface WPS error cases
PASS wpas_ctrl_wps_errors 0.03499 2021-02-03 00:08:56.171238
passed all 1 test case(s)
2021-02-03 00:08:56 ./run-tests.py wpas_mesh_password_mismatch_retry
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START wpas_mesh_password_mismatch_retry 1/1
Test: Mesh password mismatch and retry
Skip test case: Skip test case with long duration due to --long not specified
SKIP wpas_mesh_password_mismatch_retry 0.034659 2021-02-03 00:08:56.366421
passed all 0 test case(s)
skipped 1 test case(s)
2021-02-03 00:08:56 ./run-tests.py wps_ext_ap_settings_mac_addr_missing
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START wps_ext_ap_settings_mac_addr_missing 1/1
Test: WPS and AP Settings: missing MAC Address
Starting AP wlan3
PASS wps_ext_ap_settings_mac_addr_missing 0.329988 2021-02-03 00:08:56.861621
passed all 1 test case(s)
2021-02-03 00:08:56 ./stop.sh

--7LkOrbQMr4cezO2T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/hwsim-part4.yaml
suite: hwsim
testcase: hwsim
category: functional
need_memory: 1G
hwsim:
  test: group-33
job_origin: "/lkp-src/allot/cyclic:p1:linux-devel:devel-hourly/lkp-ivb-d02/hwsim-part4.yaml"

#! queue options
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-ivb-d02
tbox_group: lkp-ivb-d02
kconfig: x86_64-rhel-8.3
submit_id: 6019e25883c2f073f83b2db1
job_file: "/lkp/jobs/scheduled/lkp-ivb-d02/hwsim-group-33-ucode=0x21-debian-10.4-x86_64-20200603.cgz-12f9a570c0a654c6abc9e189e2227a1eb2d5d99e-20210203-29688-7g2j96-0.yaml"
id: e8e689aa2d96c36cf6593190c19b35f2777cda75
queuer_version: "/lkp-src"

#! hosts/lkp-ivb-d02
model: Ivy Bridge
nr_node: 1
nr_cpu: 4
memory: 8G
nr_hdd_partitions: 4
nr_ssd_partitions: 1
ssd_partitions: "/dev/disk/by-id/ata-INTEL_SSDSC2BA400G4_BTHV634505W5400NGN-part1"
hdd_partitions: "/dev/disk/by-id/ata-ST4000NM0035-1V4107_ZC127QJQ-part1 /dev/disk/by-id/ata-ST4000NM0035-1V4107_ZC127QJQ-part2
  /dev/disk/by-id/ata-ST4000NM0035-1V4107_ZC127QJQ-part3 /dev/disk/by-id/ata-ST4000NM0035-1V4107_ZC127QJQ-part4"
swap_partitions: "/dev/disk/by-id/ata-ST4000NM0035-1V4107_ZC127QJQ-part6"
rootfs_partition: "/dev/disk/by-id/ata-ST4000NM0035-1V4107_ZC127QJQ-part5"
brand: Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz

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
commit: 12f9a570c0a654c6abc9e189e2227a1eb2d5d99e

#! include/testbox/lkp-ivb-d02
netconsole_port: 6673
ucode: '0x21'
need_kconfig_hw:
- CONFIG_NET_VENDOR_REALTEK=y
- CONFIG_R8169=y
- CONFIG_SATA_AHCI
enqueue_time: 2021-02-03 07:38:01.161484738 +08:00
_id: 6019e25883c2f073f83b2db1
_rt: "/result/hwsim/group-33-ucode=0x21/lkp-ivb-d02/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/12f9a570c0a654c6abc9e189e2227a1eb2d5d99e"

#! schedule options
user: lkp
compiler: gcc-9
LKP_SERVER: internal-lkp-server
head_commit: fc28d02d4d09af8f29410ec21e562c6df90ca9c5
base_commit: 1048ba83fb1c00cd24172e23e8263972f6b5d9ac
branch: linux-devel/devel-hourly-20210202-104118
rootfs: debian-10.4-x86_64-20200603.cgz
result_root: "/result/hwsim/group-33-ucode=0x21/lkp-ivb-d02/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/12f9a570c0a654c6abc9e189e2227a1eb2d5d99e/0"
scheduler_version: "/lkp/lkp/.src-20210203-070843"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-ivb-d02/hwsim-group-33-ucode=0x21-debian-10.4-x86_64-20200603.cgz-12f9a570c0a654c6abc9e189e2227a1eb2d5d99e-20210203-29688-7g2j96-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- branch=linux-devel/devel-hourly-20210202-104118
- commit=12f9a570c0a654c6abc9e189e2227a1eb2d5d99e
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/12f9a570c0a654c6abc9e189e2227a1eb2d5d99e/vmlinuz-5.11.0-rc4-00539-g12f9a570c0a6
- max_uptime=2100
- RESULT_ROOT=/result/hwsim/group-33-ucode=0x21/lkp-ivb-d02/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/12f9a570c0a654c6abc9e189e2227a1eb2d5d99e/0
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/12f9a570c0a654c6abc9e189e2227a1eb2d5d99e/modules.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hwsim_20210101.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/hwsim-x86_64-537ab94-1_20210101.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20201117.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20210202-160757/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
last_kernel: 4.20.0

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/12f9a570c0a654c6abc9e189e2227a1eb2d5d99e/vmlinuz-5.11.0-rc4-00539-g12f9a570c0a6"
dequeue_time: 2021-02-03 07:46:06.150439826 +08:00

#! /lkp/lkp/.src-20210203-070843/include/site/inn
job_state: finished
loadavg: 0.74 1.15 0.57 1/147 6572
start_time: '1612309622'
end_time: '1612309862'
version: "/lkp/lkp/.src-20210203-070914:af55aba6-dirty:7cfd2a027"

--7LkOrbQMr4cezO2T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

export USER=root
./build.sh
./start.sh
./run-tests.py ap_acs_hw_mode_any_5ghz
./run-tests.py ap_csa_2_switches_count_1
./run-tests.py ap_ft_pmf_over_ds
./run-tests.py ap_ft_sae_ptk_rekey1
./run-tests.py ap_ft_sae_rsnxe_used_mismatch2
./run-tests.py ap_ft_skip_prune_assoc2
./run-tests.py ap_hs20_external_selection
./run-tests.py ap_hs20_fetch_osu_proto
./run-tests.py ap_hs20_min_bandwidth_and_roaming_partner_preference
./run-tests.py ap_hs20_min_bandwidth_no_wan_metrics
./run-tests.py ap_hs20_network_preference2
./run-tests.py ap_hs20_osen
./run-tests.py ap_hs20_proxyarp_disable_dgaf
./run-tests.py ap_ht40_csa3
./run-tests.py ap_ht40_scan_conflict
./run-tests.py ap_open_unexpected_assoc_event
./run-tests.py ap_pmf_sta_sa_query_oom
./run-tests.py ap_roam_wpa2_psk
./run-tests.py ap_vht80_csa
./run-tests.py ap_wowlan_triggers
./run-tests.py ap_wpa2_eap_pwd_salt_sha1
./run-tests.py ap_wpa2_eap_ttls_dh_params_invalid
./run-tests.py ap_wpa2_eap_ttls_eap_md5_server_oom
./run-tests.py ap_wpa2_eap_unexpected_wep_eapol_key
./run-tests.py ap_wpa2_psk_incorrect_passphrase
./run-tests.py ap_wpa2_psk_supp_proto_gtk_tx_bit_workaround
./run-tests.py ap_wpa2_tdls_diff_rsnie
./run-tests.py ap_wps_and_bss_limit
./run-tests.py ap_wps_authenticator_mismatch_m2
./run-tests.py ap_wps_er_http_proto_upnp_info_no_device_type
./run-tests.py ap_wps_er_init_oom
./run-tests.py ap_wps_er_ssdp_proto
./run-tests.py ap_wps_m5_oom
./run-tests.py ap_wps_new_version_ap
./run-tests.py autogo_noa
./run-tests.py bgscan_learn_beacon_loss
./run-tests.py dbus_wps_cancel
./run-tests.py dfs_radar_chanlist_vht20
./run-tests.py dpp_auto_connect_2_ver1
./run-tests.py dpp_config_connector_error_invalid_timestamp_date
./run-tests.py dpp_config_dpp_override_prime256v1
./run-tests.py dpp_config_jwk_error_no_y
./run-tests.py dpp_config_legacy_gen
./run-tests.py dpp_proto_auth_conf_invalid_i_bootstrap_key
./run-tests.py dpp_proto_auth_conf_no_wrapped_data
./run-tests.py dpp_proto_auth_resp_i_nonce_mismatch
./run-tests.py dpp_qr_code_auth_mutual2
./run-tests.py dpp_qr_code_auth_mutual_p_521
./run-tests.py dpp_qr_code_auth_rand_mac_addr
./run-tests.py eap_teap_basic_password_auth_user_and_machine_no_machine
./run-tests.py eap_teap_tls_cs_sha1
./run-tests.py erp_local_errors
./run-tests.py erp_radius_eap_tls_v13
./run-tests.py fst_ap_ack_request_with_bad_fsts_id
./run-tests.py fst_ap_initiate_session_response_with_zero_llt
./run-tests.py fst_ap_tear_down_session_bad_fsts_id
./run-tests.py gas_anqp_address3_ap_non_compliant
./run-tests.py gas_anqp_address3_assoc
./run-tests.py gas_stop_fetch_anqp
./run-tests.py grpform_force_chan_conflict
./run-tests.py grpform_no_wsc_done
./run-tests.py he160_no_dfs_120_minus
./run-tests.py he80_invalid2
./run-tests.py he_params
./run-tests.py ieee8021x_held
./run-tests.py macsec_psk_shorter_ckn2
./run-tests.py mbo_non_pref_chan
./run-tests.py mbo_sta_supp_op_classes
./run-tests.py mbo_supp_oper_classes_us_disable_vht
./run-tests.py mesh_forwarding
./run-tests.py nfc_p2p_static_handover_join_tagdev_go
./run-tests.py p2p_channel_5ghz_only
./run-tests.py p2p_go_invite
./run-tests.py p2p_msg_go_neg_req_reject
./run-tests.py p2ps_exact_search_srvinfo
./run-tests.py pmksa_cache_and_ptk_rekey_ap
./run-tests.py pmksa_cache_preauth
./run-tests.py radius_acct_pmksa_caching
./run-tests.py sae_and_psk_transition_disable
./run-tests.py sae_h2e_rsnxe_mismatch
./run-tests.py scan_abort
./run-tests.py scan_for_auth_fail
./run-tests.py sigma_dut_ap_sae_pk_misbehavior
./run-tests.py sigma_dut_dpp_nfc_handover_requestor_enrollee
./run-tests.py sigma_dut_sae_pw_id_ft
./run-tests.py tspec_ap_parsing
./run-tests.py wifi_display_go_invite
./run-tests.py wnm_sleep_mode_open_fail
./run-tests.py wpa2_ocv_ap_mismatch
./run-tests.py wpas_ctrl_cred
./run-tests.py wpas_ctrl_wps_errors
./run-tests.py wpas_mesh_password_mismatch_retry
./run-tests.py wps_ext_ap_settings_mac_addr_missing
./stop.sh

--7LkOrbQMr4cezO2T--
