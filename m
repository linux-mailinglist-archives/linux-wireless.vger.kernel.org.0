Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8DBA28337C
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Oct 2020 11:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbgJEJio (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Oct 2020 05:38:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:41362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725931AbgJEJin (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Oct 2020 05:38:43 -0400
Received: from mail.kernel.org (ip5f5ad5d6.dynamic.kabel-deutschland.de [95.90.213.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A65E20774;
        Mon,  5 Oct 2020 09:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601890722;
        bh=0K+5x0GSJgzNJNXHAEZhbUSUqc0zPBCk8o4FgS5ygPE=;
        h=From:To:Cc:Subject:Date:From;
        b=dzSl0dD2aPg/exFlPWR7zBahC1B8Maqm1P9RsnekELV09yaIAebsCIwAo/gnILlLQ
         B5wNKPJ/lrFlbbpc2AoV5V12sLLGMDKdkR3/XkOtfv6yZLKLeXHwNlxL5Cj0MjwaLN
         iM3mdfV6I84MXtXkmlQTs3pCqL2y+KixtKDzbcBw=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kPMx5-000TfM-OD; Mon, 05 Oct 2020 11:38:39 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     "Jonathan Corbet" <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: [PATCH] docs: net: 80211: reduce docs build time
Date:   Mon,  5 Oct 2020 11:38:37 +0200
Message-Id: <f0085721d85ebc3a77164b457ed948eee48b55df.1601890703.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

the files under /80211 calls kernel-doc script 207 times, one for each
single function and doc chapter. Due to that, it takes a lot of time
handling it:

	$ touch Documentation/driver-api/80211/*rst && time make SPHINXDIRS=driver-api/80211 htmldocs
...
	real	0m22,928s
	user	0m21,644s
	sys	0m1,334s

Reduce the build time by doing only one kernel-doc call
per functions that belong to the same group. With that, there's now
50 calls to kernel-doc, which makes the build time for those docs
62% faster:

	$ touch Documentation/driver-api/80211/*rst && time make SPHINXDIRS=driver-api/80211 htmldocs
...
	real	0m8,666s
	user	0m8,084s
	sys	0m0,642s

As a side effect, it should now be easier to add newer
functions, as there's no need to repeat the kernel-doc
pattern.

Measurements made on a NUC8i7HNK machine with lots of ram
and a fast SSD disk with Sphinx 3.2.1.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/driver-api/80211/cfg80211.rst   | 392 +++++-------------
 .../driver-api/80211/mac80211-advanced.rst    | 151 +++----
 Documentation/driver-api/80211/mac80211.rst   | 148 ++-----
 3 files changed, 199 insertions(+), 492 deletions(-)

diff --git a/Documentation/driver-api/80211/cfg80211.rst b/Documentation/driver-api/80211/cfg80211.rst
index eeab91b59457..836f609c3f75 100644
--- a/Documentation/driver-api/80211/cfg80211.rst
+++ b/Documentation/driver-api/80211/cfg80211.rst
@@ -12,79 +12,32 @@ Device registration
    :doc: Device registration
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: ieee80211_channel_flags
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: ieee80211_channel
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: ieee80211_rate_flags
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: ieee80211_rate
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: ieee80211_sta_ht_cap
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: ieee80211_supported_band
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_signal_type
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: wiphy_params_flags
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: wiphy_flags
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: wiphy
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: wireless_dev
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: wiphy_new
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: wiphy_read_of_freq_limits
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: wiphy_register
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: wiphy_unregister
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: wiphy_free
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: wiphy_name
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: wiphy_dev
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: wiphy_priv
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: priv_to_wiphy
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: set_wiphy_dev
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: wdev_priv
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: ieee80211_iface_limit
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: ieee80211_iface_combination
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_check_combinations
+   :functions:
+	ieee80211_channel_flags
+	ieee80211_channel
+	ieee80211_rate_flags
+	ieee80211_rate
+	ieee80211_sta_ht_cap
+	ieee80211_supported_band
+	cfg80211_signal_type
+	wiphy_params_flags
+	wiphy_flags
+	wiphy
+	wireless_dev
+	wiphy_new
+	wiphy_read_of_freq_limits
+	wiphy_register
+	wiphy_unregister
+	wiphy_free
+	wiphy_name
+	wiphy_dev
+	wiphy_priv
+	priv_to_wiphy
+	set_wiphy_dev
+	wdev_priv
+	ieee80211_iface_limit
+	ieee80211_iface_combination
+	cfg80211_check_combinations
 
 Actions and configuration
 =========================
@@ -93,139 +46,52 @@ Actions and configuration
    :doc: Actions and configuration
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_ops
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: vif_params
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: key_params
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: survey_info_flags
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: survey_info
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_beacon_data
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_ap_settings
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: station_parameters
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: rate_info_flags
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: rate_info
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: station_info
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: monitor_flags
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: mpath_info_flags
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: mpath_info
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: bss_parameters
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: ieee80211_txq_params
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_crypto_settings
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_auth_request
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_assoc_request
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_deauth_request
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_disassoc_request
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_ibss_params
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_connect_params
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_pmksa
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_rx_mlme_mgmt
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_auth_timeout
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_rx_assoc_resp
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_assoc_timeout
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_tx_mlme_mgmt
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_ibss_joined
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_connect_resp_params
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_connect_done
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_connect_result
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_connect_bss
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_connect_timeout
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_roamed
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_disconnected
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_ready_on_channel
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_remain_on_channel_expired
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_new_sta
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_rx_mgmt
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_mgmt_tx_status
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_cqm_rssi_notify
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_cqm_pktloss_notify
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_michael_mic_failure
+   :functions:
+	cfg80211_ops
+	vif_params
+	key_params
+	survey_info_flags
+	survey_info
+	cfg80211_beacon_data
+	cfg80211_ap_settings
+	station_parameters
+	rate_info_flags
+	rate_info
+	station_info
+	monitor_flags
+	mpath_info_flags
+	mpath_info
+	bss_parameters
+	ieee80211_txq_params
+	cfg80211_crypto_settings
+	cfg80211_auth_request
+	cfg80211_assoc_request
+	cfg80211_deauth_request
+	cfg80211_disassoc_request
+	cfg80211_ibss_params
+	cfg80211_connect_params
+	cfg80211_pmksa
+	cfg80211_rx_mlme_mgmt
+	cfg80211_auth_timeout
+	cfg80211_rx_assoc_resp
+	cfg80211_assoc_timeout
+	cfg80211_tx_mlme_mgmt
+	cfg80211_ibss_joined
+	cfg80211_connect_resp_params
+	cfg80211_connect_done
+	cfg80211_connect_result
+	cfg80211_connect_bss
+	cfg80211_connect_timeout
+	cfg80211_roamed
+	cfg80211_disconnected
+	cfg80211_ready_on_channel
+	cfg80211_remain_on_channel_expired
+	cfg80211_new_sta
+	cfg80211_rx_mgmt
+	cfg80211_mgmt_tx_status
+	cfg80211_cqm_rssi_notify
+	cfg80211_cqm_pktloss_notify
+	cfg80211_michael_mic_failure
 
 Scanning and BSS list handling
 ==============================
@@ -234,34 +100,17 @@ Scanning and BSS list handling
    :doc: Scanning and BSS list handling
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_ssid
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_scan_request
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_scan_done
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_bss
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_inform_bss
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_inform_bss_frame_data
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_inform_bss_data
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_unlink_bss
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_find_ie
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: ieee80211_bss_get_ie
+   :functions:
+	cfg80211_ssid
+	cfg80211_scan_request
+	cfg80211_scan_done
+	cfg80211_bss
+	cfg80211_inform_bss
+	cfg80211_inform_bss_frame_data
+	cfg80211_inform_bss_data
+	cfg80211_unlink_bss
+	cfg80211_find_ie
+	ieee80211_bss_get_ie
 
 Utility functions
 =================
@@ -270,25 +119,14 @@ Utility functions
    :doc: Utility functions
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: ieee80211_channel_to_frequency
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: ieee80211_frequency_to_channel
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: ieee80211_get_channel
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: ieee80211_get_response_rate
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: ieee80211_hdrlen
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: ieee80211_get_hdrlen_from_skb
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: ieee80211_radiotap_iterator
+   :functions:
+	ieee80211_channel_to_frequency
+	ieee80211_frequency_to_channel
+	ieee80211_get_channel
+	ieee80211_get_response_rate
+	ieee80211_hdrlen
+	ieee80211_get_hdrlen_from_skb
+	ieee80211_radiotap_iterator
 
 Data path helpers
 =================
@@ -297,13 +135,10 @@ Data path helpers
    :doc: Data path helpers
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: ieee80211_data_to_8023
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: ieee80211_amsdu_to_8023s
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_classify8021d
+   :functions:
+	ieee80211_data_to_8023
+	ieee80211_amsdu_to_8023s
+	cfg80211_classify8021d
 
 Regulatory enforcement infrastructure
 =====================================
@@ -312,13 +147,10 @@ Regulatory enforcement infrastructure
    :doc: Regulatory enforcement infrastructure
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: regulatory_hint
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: wiphy_apply_custom_regulatory
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: freq_reg_info
+   :functions:
+	regulatory_hint
+	wiphy_apply_custom_regulatory
+	freq_reg_info
 
 RFkill integration
 ==================
@@ -327,13 +159,10 @@ RFkill integration
    :doc: RFkill integration
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: wiphy_rfkill_set_hw_state
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: wiphy_rfkill_start_polling
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: wiphy_rfkill_stop_polling
+   :functions:
+	wiphy_rfkill_set_hw_state
+	wiphy_rfkill_start_polling
+	wiphy_rfkill_stop_polling
 
 Test mode
 =========
@@ -342,13 +171,8 @@ Test mode
    :doc: Test mode
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_testmode_alloc_reply_skb
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_testmode_reply
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_testmode_alloc_event_skb
-
-.. kernel-doc:: include/net/cfg80211.h
-   :functions: cfg80211_testmode_event
+   :functions:
+	cfg80211_testmode_alloc_reply_skb
+	cfg80211_testmode_reply
+	cfg80211_testmode_alloc_event_skb
+	cfg80211_testmode_event
diff --git a/Documentation/driver-api/80211/mac80211-advanced.rst b/Documentation/driver-api/80211/mac80211-advanced.rst
index 24cb64b3b715..f8df7b3af8f5 100644
--- a/Documentation/driver-api/80211/mac80211-advanced.rst
+++ b/Documentation/driver-api/80211/mac80211-advanced.rst
@@ -15,25 +15,14 @@ appropriate trigger, which will then be triggered appropriately by
 mac80211.
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_get_tx_led_name
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_get_rx_led_name
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_get_assoc_led_name
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_get_radio_led_name
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_tpt_blink
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_tpt_led_trigger_flags
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_create_tpt_led_trigger
+   :functions:
+	ieee80211_get_tx_led_name
+	ieee80211_get_rx_led_name
+	ieee80211_get_assoc_led_name
+	ieee80211_get_radio_led_name
+	ieee80211_tpt_blink
+	ieee80211_tpt_led_trigger_flags
+	ieee80211_create_tpt_led_trigger
 
 Hardware crypto acceleration
 ============================
@@ -42,22 +31,13 @@ Hardware crypto acceleration
    :doc: Hardware crypto acceleration
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: set_key_cmd
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_key_conf
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_key_flags
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_get_tkip_p1k
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_get_tkip_p1k_iv
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_get_tkip_p2k
+   :functions:
+	set_key_cmd
+	ieee80211_key_conf
+	ieee80211_key_flags
+	ieee80211_get_tkip_p1k
+	ieee80211_get_tkip_p1k_iv
+	ieee80211_get_tkip_p2k
 
 Powersave support
 =================
@@ -99,28 +79,15 @@ support for powersaving clients
    :doc: AP support for powersaving clients
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_get_buffered_bc
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_beacon_get
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_sta_eosp
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_frame_release_type
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_sta_ps_transition
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_sta_ps_transition_ni
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_sta_set_buffered
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_sta_block_awake
+   :functions:
+	ieee80211_get_buffered_bc
+	ieee80211_beacon_get
+	ieee80211_sta_eosp
+	ieee80211_frame_release_type
+	ieee80211_sta_ps_transition
+	ieee80211_sta_ps_transition_ni
+	ieee80211_sta_set_buffered
+	ieee80211_sta_block_awake
 
 Supporting multiple virtual interfaces
 ======================================
@@ -134,10 +101,9 @@ addresses here, note which configurations are supported by mac80211, add
 notes about supporting hw crypto with it.
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_iterate_active_interfaces
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_iterate_active_interfaces_atomic
+   :functions:
+	ieee80211_iterate_active_interfaces
+	ieee80211_iterate_active_interfaces_atomic
 
 Station handling
 ================
@@ -145,16 +111,11 @@ Station handling
 TODO
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_sta
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: sta_notify_cmd
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_find_sta
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_find_sta_by_ifaddr
+   :functions:
+	ieee80211_sta
+	sta_notify_cmd
+	ieee80211_find_sta
+	ieee80211_find_sta_by_ifaddr
 
 Hardware scan offload
 =====================
@@ -193,10 +154,9 @@ Spatial Multiplexing Powersave (SMPS)
    :doc: Spatial multiplexing power save
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_request_smps
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_smps_mode
+   :functions:
+	ieee80211_request_smps
+	ieee80211_smps_mode
 
 TBD
 
@@ -209,22 +169,13 @@ Rate Control API
 TBD
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_start_tx_ba_session
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_start_tx_ba_cb_irqsafe
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_stop_tx_ba_session
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_stop_tx_ba_cb_irqsafe
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_rate_control_changed
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_tx_rate_control
+   :functions:
+	ieee80211_start_tx_ba_session
+	ieee80211_start_tx_ba_cb_irqsafe
+	ieee80211_stop_tx_ba_session
+	ieee80211_stop_tx_ba_cb_irqsafe
+	ieee80211_rate_control_changed
+	ieee80211_tx_rate_control
 
 TBD
 
@@ -261,10 +212,9 @@ Programming information
 -----------------------
 
 .. kernel-doc:: net/mac80211/sta_info.h
-   :functions: sta_info
-
-.. kernel-doc:: net/mac80211/sta_info.h
-   :functions: ieee80211_sta_info_flags
+   :functions:
+	sta_info
+	ieee80211_sta_info_flags
 
 STA information lifetime rules
 ------------------------------
@@ -276,13 +226,10 @@ Aggregation Functions
 =====================
 
 .. kernel-doc:: net/mac80211/sta_info.h
-   :functions: sta_ampdu_mlme
-
-.. kernel-doc:: net/mac80211/sta_info.h
-   :functions: tid_ampdu_tx
-
-.. kernel-doc:: net/mac80211/sta_info.h
-   :functions: tid_ampdu_rx
+   :functions:
+	sta_ampdu_mlme
+	tid_ampdu_tx
+	tid_ampdu_rx
 
 Synchronisation Functions
 =========================
diff --git a/Documentation/driver-api/80211/mac80211.rst b/Documentation/driver-api/80211/mac80211.rst
index eab40bcf3987..67d2e58b45e4 100644
--- a/Documentation/driver-api/80211/mac80211.rst
+++ b/Documentation/driver-api/80211/mac80211.rst
@@ -30,31 +30,16 @@ Finally, a discussion of hardware capabilities should be done with
 references to other parts of the book.
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_hw
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_hw_flags
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: SET_IEEE80211_DEV
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: SET_IEEE80211_PERM_ADDR
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_ops
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_alloc_hw
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_register_hw
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_unregister_hw
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_free_hw
+   :functions:
+	ieee80211_hw
+	ieee80211_hw_flags
+	SET_IEEE80211_DEV
+	SET_IEEE80211_PERM_ADDR
+	ieee80211_ops
+	ieee80211_alloc_hw
+	ieee80211_register_hw
+	ieee80211_unregister_hw
+	ieee80211_free_hw
 
 PHY configuration
 =================
@@ -65,10 +50,9 @@ This chapter should describe PHY handling including start/stop callbacks
 and the various structures used.
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_conf
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_conf_flags
+   :functions:
+	ieee80211_conf
+	ieee80211_conf_flags
 
 Virtual interfaces
 ==================
@@ -123,79 +107,32 @@ functions/definitions
 ---------------------
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_rx_status
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: mac80211_rx_encoding_flags
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: mac80211_rx_flags
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: mac80211_tx_info_flags
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: mac80211_tx_control_flags
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: mac80211_rate_control_flags
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_tx_rate
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_tx_info
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_tx_info_clear_status
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_rx
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_rx_ni
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_rx_irqsafe
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_tx_status
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_tx_status_ni
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_tx_status_irqsafe
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_rts_get
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_rts_duration
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_ctstoself_get
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_ctstoself_duration
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_generic_frame_duration
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_wake_queue
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_stop_queue
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_wake_queues
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_stop_queues
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_queue_stopped
+   :functions:
+	ieee80211_rx_status
+	mac80211_rx_encoding_flags
+	mac80211_rx_flags
+	mac80211_tx_info_flags
+	mac80211_tx_control_flags
+	mac80211_rate_control_flags
+	ieee80211_tx_rate
+	ieee80211_tx_info
+	ieee80211_tx_info_clear_status
+	ieee80211_rx
+	ieee80211_rx_ni
+	ieee80211_rx_irqsafe
+	ieee80211_tx_status
+	ieee80211_tx_status_ni
+	ieee80211_tx_status_irqsafe
+	ieee80211_rts_get
+	ieee80211_rts_duration
+	ieee80211_ctstoself_get
+	ieee80211_ctstoself_duration
+	ieee80211_generic_frame_duration
+	ieee80211_wake_queue
+	ieee80211_stop_queue
+	ieee80211_wake_queues
+	ieee80211_stop_queues
+	ieee80211_queue_stopped
 
 Frame filtering
 ===============
@@ -213,7 +150,6 @@ The mac80211 workqueue
    :doc: mac80211 workqueue
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_queue_work
-
-.. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_queue_delayed_work
+   :functions:
+	ieee80211_queue_work
+	ieee80211_queue_delayed_work
-- 
2.26.2

