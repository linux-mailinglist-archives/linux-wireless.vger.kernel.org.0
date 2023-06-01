Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F65C719FA8
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jun 2023 16:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbjFAOUy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Jun 2023 10:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbjFAOUr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Jun 2023 10:20:47 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F561188
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jun 2023 07:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685629243; x=1717165243;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yAa6/wT/RMfIqorf29UGFUWFpjhlM00E639Ack/zkM0=;
  b=V6hhb052jvL71o9SDvyN2JenGBDG1jSdTn0HkWIS3pGL0QumUHKjXcew
   Jxsk+I01whU2+8rrOiC9txboDAH9GXj+KRL5PkGkPx8ddJgrU0UH4xlGX
   qS/ik0UaB1Z8ui8HvQHo6xUIrM06jHc7XhkdEZAugoEoUDpj24Aa5QnL6
   3sxWvv0LroHfIGghMhYtjTGSHR/w5HHP7qvoRWnsflxbW3f7WVG4I5y1t
   XzKixajhEz120KtOwum0MIaIy9o2Ncu7C5AhBTlASXwHIEI7Xabm3n/gM
   4u4JcyWZiLvk3+MAIpFimD0HFdkPrfQUlrVEmcNGVD7Gli98fYyF4gUI0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="441931859"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="441931859"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 07:20:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="819812837"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="819812837"
Received: from dvinnyc-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.249.93.27])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 07:20:31 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 4/6] wifi: iwlwifi: api: fix kernel-doc links
Date:   Thu,  1 Jun 2023 17:20:06 +0300
Message-Id: <20230601171633.85e2cf489893.Ie3889ea6f755b80c988543ccca56c67420c51b1f@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230601142008.375040-1-gregory.greenman@intel.com>
References: <20230601142008.375040-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Some of the kernel-doc links are outdated due to other
changes, fix that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/commands.h | 12 ++++++++----
 .../net/wireless/intel/iwlwifi/fw/api/datapath.h |  6 ++++--
 .../net/wireless/intel/iwlwifi/fw/api/location.h | 16 +++++++++++-----
 .../net/wireless/intel/iwlwifi/fw/api/nvm-reg.h  | 11 ++++++++---
 .../net/wireless/intel/iwlwifi/fw/api/offload.h  |  3 ++-
 drivers/net/wireless/intel/iwlwifi/fw/api/phy.h  | 10 +++++++---
 6 files changed, 40 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
index 78d3ccab279d..13cb0d53a1a3 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
@@ -555,18 +555,22 @@ enum iwl_legacy_cmds {
 	WOWLAN_TKIP_PARAM = 0xe3,
 
 	/**
-	 * @WOWLAN_KEK_KCK_MATERIAL: &struct iwl_wowlan_kek_kck_material_cmd
+	 * @WOWLAN_KEK_KCK_MATERIAL: &struct iwl_wowlan_kek_kck_material_cmd_v2,
+	 * &struct iwl_wowlan_kek_kck_material_cmd_v3 or
+	 * &struct iwl_wowlan_kek_kck_material_cmd_v4
 	 */
 	WOWLAN_KEK_KCK_MATERIAL = 0xe4,
 
 	/**
-	 * @WOWLAN_GET_STATUSES: response in &struct iwl_wowlan_status
+	 * @WOWLAN_GET_STATUSES: response in &struct iwl_wowlan_status_v6,
+	 *	&struct iwl_wowlan_status_v7, &struct iwl_wowlan_status_v9 or
+	 *	&struct iwl_wowlan_status_v12
 	 */
 	WOWLAN_GET_STATUSES = 0xe5,
 
 	/**
-	 * @SCAN_OFFLOAD_PROFILES_QUERY_CMD:
-	 * No command data, response is &struct iwl_scan_offload_profiles_query
+	 * @SCAN_OFFLOAD_PROFILES_QUERY_CMD: No command data, response is
+	 *	&struct iwl_scan_offload_profiles_query_v1
 	 */
 	SCAN_OFFLOAD_PROFILES_QUERY_CMD = 0x56,
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
index 6f59381b9f9a..751b596ea1a5 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
@@ -38,7 +38,9 @@ enum iwl_data_path_subcmd_ids {
 	WNM_80211V_TIMING_MEASUREMENT_CONFIG_CMD = 0x4,
 
 	/**
-	 * @STA_HE_CTXT_CMD: &struct iwl_he_sta_context_cmd
+	 * @STA_HE_CTXT_CMD: &struct iwl_he_sta_context_cmd_v1,
+	 *	&struct iwl_he_sta_context_cmd_v2 or
+	 *	&struct iwl_he_sta_context_cmd_v3
 	 */
 	STA_HE_CTXT_CMD = 0x7,
 
@@ -447,7 +449,7 @@ struct iwl_sad_properties {
  * @phy_id: PHY index
  * @rlc: RLC properties, &struct iwl_rlc_properties
  * @sad: SAD (single antenna diversity) options, &struct iwl_sad_properties
- * @flags: flags, &enum iwl_rlc_flags
+ * @flags: flags (unused)
  * @reserved: reserved
  */
 struct iwl_rlc_config_cmd {
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
index 12af94e166ed..b044990c7b87 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2021 Intel Corporation
+ * Copyright (C) 2018-2022 Intel Corporation
  */
 #ifndef __iwl_fw_api_location_h__
 #define __iwl_fw_api_location_h__
@@ -35,8 +35,11 @@ enum iwl_location_subcmd_ids {
 	 */
 	TOF_RANGE_REQ_EXT_CMD = 0x3,
 	/**
-	 * @TOF_RESPONDER_CONFIG_CMD: FTM responder configuration,
-	 *	uses &struct iwl_tof_responder_config_cmd
+	 * @TOF_RESPONDER_CONFIG_CMD: FTM responder configuration, one of
+	 *	&struct iwl_tof_responder_config_cmd_v6,
+	 *	&struct iwl_tof_responder_config_cmd_v7,
+	 *	&struct iwl_tof_responder_config_cmd_v8 or
+	 *	&struct iwl_tof_responder_config_cmd_v9
 	 */
 	TOF_RESPONDER_CONFIG_CMD = 0x4,
 	/**
@@ -69,8 +72,11 @@ enum iwl_location_subcmd_ids {
 	 */
 	TOF_MCSI_DEBUG_NOTIF = 0xFE,
 	/**
-	 * @TOF_RANGE_RESPONSE_NOTIF: ranging response, using
-	 *	&struct iwl_tof_range_rsp_ntfy
+	 * @TOF_RANGE_RESPONSE_NOTIF: ranging response, using one of
+	 *	&struct iwl_tof_range_rsp_ntfy_v5,
+	 *	&struct iwl_tof_range_rsp_ntfy_v6,
+	 *	&struct iwl_tof_range_rsp_ntfy_v7 or
+	 *	&struct iwl_tof_range_rsp_ntfy_v8
 	 */
 	TOF_RANGE_RESPONSE_NOTIF = 0xFF,
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
index 635e4ddfbca6..28bfabb399b2 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
@@ -17,7 +17,12 @@ enum iwl_regulatory_and_nvm_subcmd_ids {
 	NVM_ACCESS_COMPLETE = 0x0,
 
 	/**
-	 * @LARI_CONFIG_CHANGE: &struct iwl_lari_config_change_cmd
+	 * @LARI_CONFIG_CHANGE: &struct iwl_lari_config_change_cmd_v1,
+	 *	&struct iwl_lari_config_change_cmd_v2,
+	 *	&struct iwl_lari_config_change_cmd_v3,
+	 *	&struct iwl_lari_config_change_cmd_v4,
+	 *	&struct iwl_lari_config_change_cmd_v5 or
+	 *	&struct iwl_lari_config_change_cmd_v6
 	 */
 	LARI_CONFIG_CHANGE = 0x1,
 
@@ -29,12 +34,12 @@ enum iwl_regulatory_and_nvm_subcmd_ids {
 	NVM_GET_INFO = 0x2,
 
 	/**
-	 * @TAS_CONFIG: &struct iwl_tas_config_cmd
+	 * @TAS_CONFIG: &union iwl_tas_config_cmd
 	 */
 	TAS_CONFIG = 0x3,
 
 	/**
-	 * @SAR_OFFSET_MAPPING_TABLE_CMD: &iwl_sar_offset_mapping_cmd
+	 * @SAR_OFFSET_MAPPING_TABLE_CMD: &struct iwl_sar_offset_mapping_cmd
 	 */
 	SAR_OFFSET_MAPPING_TABLE_CMD = 0x4,
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/offload.h b/drivers/net/wireless/intel/iwlwifi/fw/api/offload.h
index a0123f81f5d8..898bf351f6e4 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/offload.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/offload.h
@@ -28,7 +28,8 @@ enum iwl_prot_offload_subcmd_ids {
 	D3_END_NOTIFICATION = 0xFE,
 
 	/**
-	 * @STORED_BEACON_NTF: &struct iwl_stored_beacon_notif
+	 * @STORED_BEACON_NTF: &struct iwl_stored_beacon_notif_v2 or
+	 *	&struct iwl_stored_beacon_notif_v3
 	 */
 	STORED_BEACON_NTF = 0xFF,
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/phy.h b/drivers/net/wireless/intel/iwlwifi/fw/api/phy.h
index b1b9c29859c1..5a3f30e5e06d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/phy.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/phy.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2019-2021 Intel Corporation
+ * Copyright (C) 2012-2014, 2019-2022 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -29,12 +29,16 @@ enum iwl_phy_ops_subcmd_ids {
 	TEMP_REPORTING_THRESHOLDS_CMD = 0x04,
 
 	/**
-	 * @PER_CHAIN_LIMIT_OFFSET_CMD: &struct iwl_geo_tx_power_profiles_cmd
+	 * @PER_CHAIN_LIMIT_OFFSET_CMD: &struct iwl_geo_tx_power_profiles_cmd_v1,
+	 * &struct iwl_geo_tx_power_profiles_cmd_v2,
+	 * &struct iwl_geo_tx_power_profiles_cmd_v3,
+	 * &struct iwl_geo_tx_power_profiles_cmd_v4 or
+	 * &struct iwl_geo_tx_power_profiles_cmd_v5
 	 */
 	PER_CHAIN_LIMIT_OFFSET_CMD = 0x05,
 
 	/**
-	 * @PER_PLATFORM_ANT_GAIN_CMD: &struct iwl_ppag_table_cmd
+	 * @PER_PLATFORM_ANT_GAIN_CMD: &union iwl_ppag_table_cmd
 	 */
 	PER_PLATFORM_ANT_GAIN_CMD = 0x07,
 
-- 
2.38.1

