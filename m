Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49CB247A064
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Dec 2021 12:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235660AbhLSL2x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Dec 2021 06:28:53 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:51466 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235656AbhLSL2w (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Dec 2021 06:28:52 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1myuN0-001O73-2k; Sun, 19 Dec 2021 13:28:50 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 19 Dec 2021 13:28:35 +0200
Message-Id: <iwlwifi.20211219132536.3331df94b106.If6c96b0d386e1c5988c8da6b69257e8f2e737f07@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211219112836.132859-1-luca@coelho.fi>
References: <20211219112836.132859-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 11/12] iwlwifi: fw: fix some scan kernel-doc
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Some devices also use iwl_scan_config_v2 struct, so link it in
the documentation for SCAN_CFG_CMD. Fix a bunch of kernel-doc
as well.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/commands.h  |  3 +-
 .../net/wireless/intel/iwlwifi/fw/api/scan.h  | 30 +++++++++++++++----
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
index 641069753397..0703e41403a6 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
@@ -91,7 +91,8 @@ enum iwl_legacy_cmds {
 
 	/**
 	 * @SCAN_CFG_CMD:
-	 * uses &struct iwl_scan_config_v1 or &struct iwl_scan_config
+	 * uses &struct iwl_scan_config_v1, &struct iwl_scan_config_v2
+	 * or &struct iwl_scan_config
 	 */
 	SCAN_CFG_CMD = 0xc,
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
index 68064389cbc8..5413087ae909 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
@@ -211,7 +211,7 @@ struct iwl_scan_channel_cfg_lmac {
 	__le32 iter_interval;
 } __packed;
 
-/*
+/**
  * struct iwl_scan_probe_segment - PROBE_SEGMENT_API_S_VER_1
  * @offset: offset in the data block
  * @len: length of the segment
@@ -221,7 +221,8 @@ struct iwl_scan_probe_segment {
 	__le16 len;
 } __packed;
 
-/* iwl_scan_probe_req - PROBE_REQUEST_FRAME_API_S_VER_2
+/**
+ * struct iwl_scan_probe_req_v1 - PROBE_REQUEST_FRAME_API_S_VER_2
  * @mac_header: first (and common) part of the probe
  * @band_data: band specific data
  * @common_data: last (and common) part of the probe
@@ -234,7 +235,8 @@ struct iwl_scan_probe_req_v1 {
 	u8 buf[SCAN_OFFLOAD_PROBE_REQ_SIZE];
 } __packed;
 
-/* iwl_scan_probe_req - PROBE_REQUEST_FRAME_API_S_VER_v2
+/**
+ * struct iwl_scan_probe_req - PROBE_REQUEST_FRAME_API_S_VER_v2
  * @mac_header: first (and common) part of the probe
  * @band_data: band specific data
  * @common_data: last (and common) part of the probe
@@ -257,7 +259,8 @@ enum iwl_scan_channel_flags {
 	IWL_SCAN_CHANNEL_FLAG_6G_PSC_NO_FILTER  = BIT(6),
 };
 
-/* struct iwl_scan_channel_opt - CHANNEL_OPTIMIZATION_API_S
+/**
+ * struct iwl_scan_channel_opt - CHANNEL_OPTIMIZATION_API_S
  * @flags: enum iwl_scan_channel_flags
  * @non_ebs_ratio: defines the ratio of number of scan iterations where EBS is
  *	involved.
@@ -502,7 +505,7 @@ struct iwl_scan_dwell {
 } __packed;
 
 /**
- * struct iwl_scan_config_v1
+ * struct iwl_scan_config_v1 - scan configuration command
  * @flags:			enum scan_config_flags
  * @tx_chains:			valid_tx antenna - ANT_* definitions
  * @rx_chains:			valid_rx antenna - ANT_* definitions
@@ -534,6 +537,21 @@ struct iwl_scan_config_v1 {
 #define SCAN_LB_LMAC_IDX 0
 #define SCAN_HB_LMAC_IDX 1
 
+/**
+ * struct iwl_scan_config_v2 - scan configuration command
+ * @flags:			enum scan_config_flags
+ * @tx_chains:			valid_tx antenna - ANT_* definitions
+ * @rx_chains:			valid_rx antenna - ANT_* definitions
+ * @legacy_rates:		default legacy rates - enum scan_config_rates
+ * @out_of_channel_time:	default max out of serving channel time
+ * @suspend_time:		default max suspend time
+ * @dwell:			dwells for the scan
+ * @mac_addr:			default mac address to be used in probes
+ * @bcast_sta_id:		the index of the station in the fw
+ * @channel_flags:		default channel flags - enum iwl_channel_flags
+ *				scan_config_channel_flag
+ * @channel_array:		default supported channels
+ */
 struct iwl_scan_config_v2 {
 	__le32 flags;
 	__le32 tx_chains;
@@ -549,7 +567,7 @@ struct iwl_scan_config_v2 {
 } __packed; /* SCAN_CONFIG_DB_CMD_API_S_2 */
 
 /**
- * struct iwl_scan_config
+ * struct iwl_scan_config - scan configuration command
  * @enable_cam_mode: whether to enable CAM mode.
  * @enable_promiscouos_mode: whether to enable promiscouos mode
  * @bcast_sta_id: the index of the station in the fw. Deprecated starting with
-- 
2.34.1

