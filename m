Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB74270FD1C
	for <lists+linux-wireless@lfdr.de>; Wed, 24 May 2023 19:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236244AbjEXRrU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 May 2023 13:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236143AbjEXRrQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 May 2023 13:47:16 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACEA1A8
        for <linux-wireless@vger.kernel.org>; Wed, 24 May 2023 10:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684950406; x=1716486406;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oxvAaly4LSmIcWbSXT/JIWtxAFkCx28Ua6xypavDCIU=;
  b=RaXmxkyJ/KF47ZQk1Oc/0cX9Rpk8tfHrEqBzFuHhBJmImpdyONXTY8UO
   CH4XobSofxw9YC4GadzGMMr8MmVjGkfPWtPfTrMJDKbF6Qe5AhF7SG2kU
   tpzD/S3AGbSj337PabdiBUJavLhWdpzuSPBew9Xt/ODqFYi4KouTNchEc
   7yryAztLKAXeWsPpc4NxlrTJbUD4fqvkKw59OhlVbP93KLuDjlqY8bV9t
   3yIHnJGXIEgjEln03wsZliK/F1yM9Pl9HMpbXZRejRhAk2SqEpIRVR18J
   z2Qb8YTHNHVblL8H6Hq0LFbt9/gLygBgCN0KWK5j7V0tFocbFQOJ8o7Si
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="440000755"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="440000755"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 10:43:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="769548574"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="769548574"
Received: from hmozes-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.89.195])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 10:43:41 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Abhishek Naik <abhishek.naik@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 14/14] wifi: iwlwifi: update response for mcc_update command
Date:   Wed, 24 May 2023 20:42:11 +0300
Message-Id: <20230524203151.fd9016f8f994.Ibddcb9fbfa74895f742c0ac20968720691c94853@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230524174211.1482360-1-gregory.greenman@intel.com>
References: <20230524174211.1482360-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Abhishek Naik <abhishek.naik@intel.com>

Add support for the MCC update response version 8.
Versions 5-6 are already covered by the existing
flags conversion, and 7 isn't used.

The capabilities field in iwl_mcc_update_resp is 32 bits
wide now, and the flags moved, so some more changes are
needed.

While at it, convert the flags to bool (to avoid having
to deal with BIT(16) specially etc.) and use the
struct_size() macro for the memory allocation.

Signed-off-by: Abhishek Naik <abhishek.naik@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   |  35 +++++-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 117 ++++++++++++------
 .../wireless/intel/iwlwifi/iwl-nvm-parse.h    |   4 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c  |  58 ++++++---
 6 files changed, 161 insertions(+), 59 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
index 91bfde6d5367..635e4ddfbca6 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
@@ -317,7 +317,7 @@ struct iwl_mcc_update_resp_v3 {
 } __packed; /* LAR_UPDATE_MCC_CMD_RESP_S_VER_3 */
 
 /**
- * struct iwl_mcc_update_resp - response to MCC_UPDATE_CMD.
+ * struct iwl_mcc_update_resp_v4 - response to MCC_UPDATE_CMD.
  * Contains the new channel control profile map, if changed, and the new MCC
  * (mobile country code).
  * The new MCC may be different than what was requested in MCC_UPDATE_CMD.
@@ -333,7 +333,7 @@ struct iwl_mcc_update_resp_v3 {
  * @channels: channel control data map, DWORD for each channel. Only the first
  *	16bits are used.
  */
-struct iwl_mcc_update_resp {
+struct iwl_mcc_update_resp_v4 {
 	__le32 status;
 	__le16 mcc;
 	__le16 cap;
@@ -345,6 +345,37 @@ struct iwl_mcc_update_resp {
 	__le32 channels[];
 } __packed; /* LAR_UPDATE_MCC_CMD_RESP_S_VER_4 */
 
+/**
+ * struct iwl_mcc_update_resp_v8 - response to MCC_UPDATE_CMD.
+ * Contains the new channel control profile map, if changed, and the new MCC
+ * (mobile country code).
+ * The new MCC may be different than what was requested in MCC_UPDATE_CMD.
+ * @status: see &enum iwl_mcc_update_status
+ * @mcc: the new applied MCC
+ * @padding: padding for 2 bytes.
+ * @cap: capabilities for all channels which matches the MCC
+ * @time: time elapsed from the MCC test start (in units of 30 seconds)
+ * @geo_info: geographic specific profile information
+ *     see &enum iwl_geo_information.
+ * @source_id: the MCC source, see iwl_mcc_source
+ * @reserved: for four bytes alignment.
+ * @n_channels: number of channels in @channels_data.
+ * @channels: channel control data map, DWORD for each channel. Only the first
+ *     16bits are used.
+ */
+struct iwl_mcc_update_resp_v8 {
+	__le32 status;
+	__le16 mcc;
+	u8 padding[2];
+	__le32 cap;
+	__le16 time;
+	__le16 geo_info;
+	u8 source_id;
+	u8 reserved[3];
+	__le32 n_channels;
+	__le32 channels[];
+} __packed; /* LAR_UPDATE_MCC_CMD_RESP_S_VER_8 */
+
 /**
  * struct iwl_mcc_chub_notif - chub notifies of mcc change
  * (MCC_CHUB_UPDATE_CMD = 0xc9)
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index cf19e8a561e9..7edb98ef8093 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -173,34 +173,34 @@ enum iwl_nvm_channel_flags {
 };
 
 /**
- * enum iwl_reg_capa_flags - global flags applied for the whole regulatory
+ * enum iwl_reg_capa_flags_v1 - global flags applied for the whole regulatory
  * domain.
- * @REG_CAPA_BF_CCD_LOW_BAND: Beam-forming or Cyclic Delay Diversity in the
+ * @REG_CAPA_V1_BF_CCD_LOW_BAND: Beam-forming or Cyclic Delay Diversity in the
  *	2.4Ghz band is allowed.
- * @REG_CAPA_BF_CCD_HIGH_BAND: Beam-forming or Cyclic Delay Diversity in the
+ * @REG_CAPA_V1_BF_CCD_HIGH_BAND: Beam-forming or Cyclic Delay Diversity in the
  *	5Ghz band is allowed.
- * @REG_CAPA_160MHZ_ALLOWED: 11ac channel with a width of 160Mhz is allowed
+ * @REG_CAPA_V1_160MHZ_ALLOWED: 11ac channel with a width of 160Mhz is allowed
  *	for this regulatory domain (valid only in 5Ghz).
- * @REG_CAPA_80MHZ_ALLOWED: 11ac channel with a width of 80Mhz is allowed
+ * @REG_CAPA_V1_80MHZ_ALLOWED: 11ac channel with a width of 80Mhz is allowed
  *	for this regulatory domain (valid only in 5Ghz).
- * @REG_CAPA_MCS_8_ALLOWED: 11ac with MCS 8 is allowed.
- * @REG_CAPA_MCS_9_ALLOWED: 11ac with MCS 9 is allowed.
- * @REG_CAPA_40MHZ_FORBIDDEN: 11n channel with a width of 40Mhz is forbidden
+ * @REG_CAPA_V1_MCS_8_ALLOWED: 11ac with MCS 8 is allowed.
+ * @REG_CAPA_V1_MCS_9_ALLOWED: 11ac with MCS 9 is allowed.
+ * @REG_CAPA_V1_40MHZ_FORBIDDEN: 11n channel with a width of 40Mhz is forbidden
  *	for this regulatory domain (valid only in 5Ghz).
- * @REG_CAPA_DC_HIGH_ENABLED: DC HIGH allowed.
- * @REG_CAPA_11AX_DISABLED: 11ax is forbidden for this regulatory domain.
+ * @REG_CAPA_V1_DC_HIGH_ENABLED: DC HIGH allowed.
+ * @REG_CAPA_V1_11AX_DISABLED: 11ax is forbidden for this regulatory domain.
  */
-enum iwl_reg_capa_flags {
-	REG_CAPA_BF_CCD_LOW_BAND	= BIT(0),
-	REG_CAPA_BF_CCD_HIGH_BAND	= BIT(1),
-	REG_CAPA_160MHZ_ALLOWED		= BIT(2),
-	REG_CAPA_80MHZ_ALLOWED		= BIT(3),
-	REG_CAPA_MCS_8_ALLOWED		= BIT(4),
-	REG_CAPA_MCS_9_ALLOWED		= BIT(5),
-	REG_CAPA_40MHZ_FORBIDDEN	= BIT(7),
-	REG_CAPA_DC_HIGH_ENABLED	= BIT(9),
-	REG_CAPA_11AX_DISABLED		= BIT(10),
-};
+enum iwl_reg_capa_flags_v1 {
+	REG_CAPA_V1_BF_CCD_LOW_BAND	= BIT(0),
+	REG_CAPA_V1_BF_CCD_HIGH_BAND	= BIT(1),
+	REG_CAPA_V1_160MHZ_ALLOWED	= BIT(2),
+	REG_CAPA_V1_80MHZ_ALLOWED	= BIT(3),
+	REG_CAPA_V1_MCS_8_ALLOWED	= BIT(4),
+	REG_CAPA_V1_MCS_9_ALLOWED	= BIT(5),
+	REG_CAPA_V1_40MHZ_FORBIDDEN	= BIT(7),
+	REG_CAPA_V1_DC_HIGH_ENABLED	= BIT(9),
+	REG_CAPA_V1_11AX_DISABLED	= BIT(10),
+}; /* GEO_CHANNEL_CAPABILITIES_API_S_VER_1 */
 
 /**
  * enum iwl_reg_capa_flags_v2 - global flags applied for the whole regulatory
@@ -234,7 +234,31 @@ enum iwl_reg_capa_flags_v2 {
 	REG_CAPA_V2_WEATHER_DISABLED	= BIT(7),
 	REG_CAPA_V2_40MHZ_ALLOWED	= BIT(8),
 	REG_CAPA_V2_11AX_DISABLED	= BIT(10),
-};
+}; /* GEO_CHANNEL_CAPABILITIES_API_S_VER_2 */
+
+/**
+ * enum iwl_reg_capa_flags_v4 - global flags applied for the whole regulatory
+ * domain.
+ * @REG_CAPA_V4_160MHZ_ALLOWED: 11ac channel with a width of 160Mhz is allowed
+ *	for this regulatory domain (valid only in 5Ghz).
+ * @REG_CAPA_V4_80MHZ_ALLOWED: 11ac channel with a width of 80Mhz is allowed
+ *	for this regulatory domain (valid only in 5Ghz).
+ * @REG_CAPA_V4_MCS_12_ALLOWED: 11ac with MCS 12 is allowed.
+ * @REG_CAPA_V4_MCS_13_ALLOWED: 11ac with MCS 13 is allowed.
+ * @REG_CAPA_V4_11BE_DISABLED: 11be is forbidden for this regulatory domain.
+ * @REG_CAPA_V4_11AX_DISABLED: 11ax is forbidden for this regulatory domain.
+ * @REG_CAPA_V4_320MHZ_ALLOWED: 11be channel with a width of 320Mhz is allowed
+ *	for this regulatory domain (valid only in 5GHz).
+ */
+enum iwl_reg_capa_flags_v4 {
+	REG_CAPA_V4_160MHZ_ALLOWED		= BIT(3),
+	REG_CAPA_V4_80MHZ_ALLOWED		= BIT(4),
+	REG_CAPA_V4_MCS_12_ALLOWED		= BIT(5),
+	REG_CAPA_V4_MCS_13_ALLOWED		= BIT(6),
+	REG_CAPA_V4_11BE_DISABLED		= BIT(8),
+	REG_CAPA_V4_11AX_DISABLED		= BIT(13),
+	REG_CAPA_V4_320MHZ_ALLOWED		= BIT(16),
+}; /* GEO_CHANNEL_CAPABILITIES_API_S_VER_4 */
 
 /*
 * API v2 for reg_capa_flags is relevant from version 6 and onwards of the
@@ -242,23 +266,33 @@ enum iwl_reg_capa_flags_v2 {
 */
 #define REG_CAPA_V2_RESP_VER	6
 
+/* API v4 for reg_capa_flags is relevant from version 8 and onwards of the
+ * MCC update command response.
+ */
+#define REG_CAPA_V4_RESP_VER	8
+
 /**
  * struct iwl_reg_capa - struct for global regulatory capabilities, Used for
  * handling the different APIs of reg_capa_flags.
  *
  * @allow_40mhz: 11n channel with a width of 40Mhz is allowed
- *	for this regulatory domain (valid only in 5Ghz).
+ *	for this regulatory domain.
  * @allow_80mhz: 11ac channel with a width of 80Mhz is allowed
- *	for this regulatory domain (valid only in 5Ghz).
+ *	for this regulatory domain (valid only in 5 and 6 Ghz).
  * @allow_160mhz: 11ac channel with a width of 160Mhz is allowed
- *	for this regulatory domain (valid only in 5Ghz).
+ *	for this regulatory domain (valid only in 5 and 6 Ghz).
+ * @allow_320mhz: 11be channel with a width of 320Mhz is allowed
+ *	for this regulatory domain (valid only in 6 Ghz).
  * @disable_11ax: 11ax is forbidden for this regulatory domain.
+ * @disable_11be: 11be is forbidden for this regulatory domain.
  */
 struct iwl_reg_capa {
-	u16 allow_40mhz;
-	u16 allow_80mhz;
-	u16 allow_160mhz;
-	u16 disable_11ax;
+	bool allow_40mhz;
+	bool allow_80mhz;
+	bool allow_160mhz;
+	bool allow_320mhz;
+	bool disable_11ax;
+	bool disable_11be;
 };
 
 static inline void iwl_nvm_print_channel_flags(struct device *dev, u32 level,
@@ -1538,20 +1572,27 @@ static u32 iwl_nvm_get_regdom_bw_flags(const u16 *nvm_chan,
 	return flags;
 }
 
-static struct iwl_reg_capa iwl_get_reg_capa(u16 flags, u8 resp_ver)
+static struct iwl_reg_capa iwl_get_reg_capa(u32 flags, u8 resp_ver)
 {
-	struct iwl_reg_capa reg_capa;
-
-	if (resp_ver >= REG_CAPA_V2_RESP_VER) {
+	struct iwl_reg_capa reg_capa = {};
+
+	if (resp_ver >= REG_CAPA_V4_RESP_VER) {
+		reg_capa.allow_40mhz = true;
+		reg_capa.allow_80mhz = flags & REG_CAPA_V4_80MHZ_ALLOWED;
+		reg_capa.allow_160mhz = flags & REG_CAPA_V4_160MHZ_ALLOWED;
+		reg_capa.allow_320mhz = flags & REG_CAPA_V4_320MHZ_ALLOWED;
+		reg_capa.disable_11ax = flags & REG_CAPA_V4_11AX_DISABLED;
+		reg_capa.disable_11be = flags & REG_CAPA_V4_11BE_DISABLED;
+	} else if (resp_ver >= REG_CAPA_V2_RESP_VER) {
 		reg_capa.allow_40mhz = flags & REG_CAPA_V2_40MHZ_ALLOWED;
 		reg_capa.allow_80mhz = flags & REG_CAPA_V2_80MHZ_ALLOWED;
 		reg_capa.allow_160mhz = flags & REG_CAPA_V2_160MHZ_ALLOWED;
 		reg_capa.disable_11ax = flags & REG_CAPA_V2_11AX_DISABLED;
 	} else {
-		reg_capa.allow_40mhz = !(flags & REG_CAPA_40MHZ_FORBIDDEN);
-		reg_capa.allow_80mhz = flags & REG_CAPA_80MHZ_ALLOWED;
-		reg_capa.allow_160mhz = flags & REG_CAPA_160MHZ_ALLOWED;
-		reg_capa.disable_11ax = flags & REG_CAPA_11AX_DISABLED;
+		reg_capa.allow_40mhz = !(flags & REG_CAPA_V1_40MHZ_FORBIDDEN);
+		reg_capa.allow_80mhz = flags & REG_CAPA_V1_80MHZ_ALLOWED;
+		reg_capa.allow_160mhz = flags & REG_CAPA_V1_160MHZ_ALLOWED;
+		reg_capa.disable_11ax = flags & REG_CAPA_V1_11AX_DISABLED;
 	}
 	return reg_capa;
 }
@@ -1559,7 +1600,7 @@ static struct iwl_reg_capa iwl_get_reg_capa(u16 flags, u8 resp_ver)
 struct ieee80211_regdomain *
 iwl_parse_nvm_mcc_info(struct device *dev, const struct iwl_cfg *cfg,
 		       int num_of_ch, __le32 *channels, u16 fw_mcc,
-		       u16 geo_info, u16 cap, u8 resp_ver)
+		       u16 geo_info, u32 cap, u8 resp_ver)
 {
 	int ch_idx;
 	u16 ch_flags;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
index e01f7751cf11..c79f72d54482 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2015, 2018-2021 Intel Corporation
+ * Copyright (C) 2005-2015, 2018-2022 Intel Corporation
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
 #ifndef __iwl_nvm_parse_h__
@@ -50,7 +50,7 @@ iwl_parse_nvm_data(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 struct ieee80211_regdomain *
 iwl_parse_nvm_mcc_info(struct device *dev, const struct iwl_cfg *cfg,
 		       int num_of_ch, __le32 *channels, u16 fw_mcc,
-		       u16 geo_info, u16 cap, u8 resp_ver);
+		       u16 geo_info, u32 cap, u8 resp_ver);
 
 /**
  * struct iwl_nvm_section - describes an NVM section in memory.
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index cac4aa062cd4..7ea200c85cac 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -108,7 +108,7 @@ struct ieee80211_regdomain *iwl_mvm_get_regdomain(struct wiphy *wiphy,
 	struct ieee80211_regdomain *regd = NULL;
 	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
-	struct iwl_mcc_update_resp *resp;
+	struct iwl_mcc_update_resp_v8 *resp;
 	u8 resp_ver;
 
 	IWL_DEBUG_LAR(mvm, "Getting regdomain data for %s from FW\n", alpha2);
@@ -138,7 +138,7 @@ struct ieee80211_regdomain *iwl_mvm_get_regdomain(struct wiphy *wiphy,
 				      resp->channels,
 				      __le16_to_cpu(resp->mcc),
 				      __le16_to_cpu(resp->geo_info),
-				      __le16_to_cpu(resp->cap), resp_ver);
+				      le32_to_cpu(resp->cap), resp_ver);
 	/* Store the return source id */
 	src_id = resp->source_id;
 	if (IS_ERR_OR_NULL(regd)) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index bba3acd64131..ee3a6d1ef07b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2219,7 +2219,7 @@ static inline void iwl_mvm_vendor_cmds_register(struct iwl_mvm *mvm) {}
 #endif
 
 /* Location Aware Regulatory */
-struct iwl_mcc_update_resp *
+struct iwl_mcc_update_resp_v8 *
 iwl_mvm_update_mcc(struct iwl_mvm *mvm, const char *alpha2,
 		   enum iwl_mcc_source src_id);
 int iwl_mvm_init_mcc(struct iwl_mvm *mvm);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
index 6d18a1fd649b..435eba0ed506 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
@@ -404,7 +404,7 @@ int iwl_nvm_init(struct iwl_mvm *mvm)
 	return ret < 0 ? ret : 0;
 }
 
-struct iwl_mcc_update_resp *
+struct iwl_mcc_update_resp_v8 *
 iwl_mvm_update_mcc(struct iwl_mvm *mvm, const char *alpha2,
 		   enum iwl_mcc_source src_id)
 {
@@ -412,7 +412,7 @@ iwl_mvm_update_mcc(struct iwl_mvm *mvm, const char *alpha2,
 		.mcc = cpu_to_le16(alpha2[0] << 8 | alpha2[1]),
 		.source_id = (u8)src_id,
 	};
-	struct iwl_mcc_update_resp *resp_cp;
+	struct iwl_mcc_update_resp_v8 *resp_cp;
 	struct iwl_rx_packet *pkt;
 	struct iwl_host_cmd cmd = {
 		.id = MCC_UPDATE_CMD,
@@ -420,7 +420,7 @@ iwl_mvm_update_mcc(struct iwl_mvm *mvm, const char *alpha2,
 		.data = { &mcc_update_cmd },
 	};
 
-	int ret;
+	int ret, resp_ver;
 	u32 status;
 	int resp_len, n_channels;
 	u16 mcc;
@@ -439,25 +439,55 @@ iwl_mvm_update_mcc(struct iwl_mvm *mvm, const char *alpha2,
 
 	pkt = cmd.resp_pkt;
 
+	resp_ver = iwl_fw_lookup_notif_ver(mvm->fw, IWL_ALWAYS_LONG_GROUP,
+					   MCC_UPDATE_CMD, 0);
+
 	/* Extract MCC response */
-	if (fw_has_capa(&mvm->fw->ucode_capa,
-			IWL_UCODE_TLV_CAPA_MCC_UPDATE_11AX_SUPPORT)) {
-		struct iwl_mcc_update_resp *mcc_resp = (void *)pkt->data;
-
-		n_channels =  __le32_to_cpu(mcc_resp->n_channels);
-		resp_len = sizeof(struct iwl_mcc_update_resp) +
-			   n_channels * sizeof(__le32);
-		resp_cp = kmemdup(mcc_resp, resp_len, GFP_KERNEL);
+	if (resp_ver >= 8) {
+		struct iwl_mcc_update_resp_v8 *mcc_resp_v8 = (void *)pkt->data;
+
+		n_channels =  __le32_to_cpu(mcc_resp_v8->n_channels);
+		resp_len = struct_size(resp_cp, channels, n_channels);
+		resp_cp = kzalloc(resp_len, GFP_KERNEL);
 		if (!resp_cp) {
 			resp_cp = ERR_PTR(-ENOMEM);
 			goto exit;
 		}
+		resp_cp->status = mcc_resp_v8->status;
+		resp_cp->mcc = mcc_resp_v8->mcc;
+		resp_cp->cap = mcc_resp_v8->cap;
+		resp_cp->source_id = mcc_resp_v8->source_id;
+		resp_cp->time = mcc_resp_v8->time;
+		resp_cp->geo_info = mcc_resp_v8->geo_info;
+		resp_cp->n_channels = mcc_resp_v8->n_channels;
+		memcpy(resp_cp->channels, mcc_resp_v8->channels,
+		       n_channels * sizeof(__le32));
+	} else if (fw_has_capa(&mvm->fw->ucode_capa,
+			       IWL_UCODE_TLV_CAPA_MCC_UPDATE_11AX_SUPPORT)) {
+		struct iwl_mcc_update_resp_v4 *mcc_resp_v4 = (void *)pkt->data;
+
+		n_channels =  __le32_to_cpu(mcc_resp_v4->n_channels);
+		resp_len = struct_size(resp_cp, channels, n_channels);
+		resp_cp = kzalloc(resp_len, GFP_KERNEL);
+		if (!resp_cp) {
+			resp_cp = ERR_PTR(-ENOMEM);
+			goto exit;
+		}
+
+		resp_cp->status = mcc_resp_v4->status;
+		resp_cp->mcc = mcc_resp_v4->mcc;
+		resp_cp->cap = cpu_to_le32(le16_to_cpu(mcc_resp_v4->cap));
+		resp_cp->source_id = mcc_resp_v4->source_id;
+		resp_cp->time = mcc_resp_v4->time;
+		resp_cp->geo_info = mcc_resp_v4->geo_info;
+		resp_cp->n_channels = mcc_resp_v4->n_channels;
+		memcpy(resp_cp->channels, mcc_resp_v4->channels,
+		       n_channels * sizeof(__le32));
 	} else {
 		struct iwl_mcc_update_resp_v3 *mcc_resp_v3 = (void *)pkt->data;
 
 		n_channels =  __le32_to_cpu(mcc_resp_v3->n_channels);
-		resp_len = sizeof(struct iwl_mcc_update_resp) +
-			   n_channels * sizeof(__le32);
+		resp_len = struct_size(resp_cp, channels, n_channels);
 		resp_cp = kzalloc(resp_len, GFP_KERNEL);
 		if (!resp_cp) {
 			resp_cp = ERR_PTR(-ENOMEM);
@@ -466,7 +496,7 @@ iwl_mvm_update_mcc(struct iwl_mvm *mvm, const char *alpha2,
 
 		resp_cp->status = mcc_resp_v3->status;
 		resp_cp->mcc = mcc_resp_v3->mcc;
-		resp_cp->cap = cpu_to_le16(mcc_resp_v3->cap);
+		resp_cp->cap = cpu_to_le32(mcc_resp_v3->cap);
 		resp_cp->source_id = mcc_resp_v3->source_id;
 		resp_cp->time = mcc_resp_v3->time;
 		resp_cp->geo_info = mcc_resp_v3->geo_info;
-- 
2.38.1

