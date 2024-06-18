Return-Path: <linux-wireless+bounces-9214-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A387390DA27
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 19:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A365281084
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 16:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AFC13AA46;
	Tue, 18 Jun 2024 16:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i3K6WqUW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB101CA80
	for <linux-wireless@vger.kernel.org>; Tue, 18 Jun 2024 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718729996; cv=none; b=skDf5eLnKhbKyFtpC1StjDZEpV3ruygTyjSe3Df+xe1pk54rsl/adlxOuSkMkbc1RT9waHhKw93XpqRoKn3aFYSeW0grC97/7NqX/UbsbTI5otF5SPesD7Tibcu0fTZNv9g99qBm0VLnkwfx7wgdx2upDWXqYkptsjAbUhQQk18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718729996; c=relaxed/simple;
	bh=xQt3dlVw/02oRMBmT2/R0uOYTfbwSNAYKGkC4ZzxIVU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RDim5d9++M0TF7wxeqWSy075k45ZQbBA5iTvORxxfh6dhQL92T1fymN/VKtFKKyuXywVvVLzYrJNP5utfN7ACPBOQ3Ld38q/NQkoZWTOnqZRD2PmcE3DYPo4luEPuSgqHDs3xs2YbJqfwBeEx+8RnQnn3tASjLPsEtzntOQBfZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i3K6WqUW; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718729993; x=1750265993;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xQt3dlVw/02oRMBmT2/R0uOYTfbwSNAYKGkC4ZzxIVU=;
  b=i3K6WqUWmOsG9i0LnPBnjSIRITfwXoxgd1FPUbaIIo2atDh9EsTgDIml
   y29vc9YAqpNU1acWLJ62A6qs0c7pfLlKuvrgIYgIKnxtlOghJRngrRDnU
   tDtW5OjPJYfOC2vMCqUqAkbyDBmdejUfipy1RR7mc+vnNyQQO3ScXbhfQ
   qdpPL/jOtcaoOZ+UsrdKxPqrEooQSNIdHbu4AYETRyJSPvNXICM3DQEtb
   kHw/2bWsxwk60Wbk1/HC2GlPPyDo8mg7Jup1lQJyFh3owVtu3l5OPbu3S
   BUIBmJ82nWt/NP00RwV4zlnN5rN1s95qRI6oXy9j3jQAhffC4pJipR/Jm
   Q==;
X-CSE-ConnectionGUID: 6APNcwCiTaK/mGNaiOm42w==
X-CSE-MsgGUID: Bl3KseFGShOrKBGSzfQnYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="27042952"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="27042952"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 09:59:53 -0700
X-CSE-ConnectionGUID: CqItZYDASEKjart+CIdyeQ==
X-CSE-MsgGUID: g/BZCIh1S/OwE+v4fzoreA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="64860525"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 09:59:51 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: iwlwifi: mvm: don't limit VLP/AFC to UATS-enabled
Date: Tue, 18 Jun 2024 19:59:45 +0300
Message-Id: <20240618195731.a81e7234c4f6.Ic0131180d38e0f1ead2f7fa0e7583407ceaa0bd1@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

When UATS isn't enabled (no VLP/AFC AP support), we need to still
set the right bits in the channel/regulatory flags, so remove the
uats_enabled argument to the parsing etc.

Also, firmware deals just fine with getting the UATS table if it
supports the command even if the bits aren't set, so always send
it, since it's also needed if BIT(31) is set, but the driver need
not have any knowledge of that. Remove 'uats_enabled' entirely.

Fixes: 0d2fc8821a7d ("wifi: iwlwifi: nvm: parse the VLP/AFC bit from regulatory")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
Sending this to wireless-next even it is a fix, because it requires
"wifi: iwlwifi: mvm: enable VLP AP on VLP channels"
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  2 --
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 21 ++++++++-----------
 .../wireless/intel/iwlwifi/iwl-nvm-parse.h    |  4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 15 +------------
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  3 +--
 5 files changed, 13 insertions(+), 32 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index 3fcc08b3c0db..048877fa7c71 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -103,7 +103,6 @@ struct iwl_txf_iter_data {
  * @cur_fw_img: current firmware image, must be maintained by
  *	the driver by calling &iwl_fw_set_current_image()
  * @dump: debug dump data
- * @uats_enabled: VLP or AFC AP is enabled
  * @uats_table: AP type table
  * @uefi_tables_lock_status: The status of the WIFI GUID UEFI variables lock:
  *	0: Unlocked, 1 and 2: Locked.
@@ -183,7 +182,6 @@ struct iwl_fw_runtime {
 	bool sgom_enabled;
 	struct iwl_mcc_allowed_ap_type_cmd uats_table;
 	u8 uefi_tables_lock_status;
-	bool uats_enabled;
 };
 
 void iwl_fw_runtime_init(struct iwl_fw_runtime *fwrt, struct iwl_trans *trans,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index c2656dee5a86..d902121da009 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -1610,8 +1610,7 @@ IWL_EXPORT_SYMBOL(iwl_parse_nvm_data);
 static u32 iwl_nvm_get_regdom_bw_flags(const u16 *nvm_chan,
 				       int ch_idx, u16 nvm_flags,
 				       struct iwl_reg_capa reg_capa,
-				       const struct iwl_cfg *cfg,
-				       bool uats_enabled)
+				       const struct iwl_cfg *cfg)
 {
 	u32 flags = NL80211_RRF_NO_HT40;
 
@@ -1662,15 +1661,13 @@ static u32 iwl_nvm_get_regdom_bw_flags(const u16 *nvm_chan,
 	}
 
 	/* Set the AP type for the UHB case. */
-	if (uats_enabled) {
-		if (nvm_flags & NVM_CHANNEL_VLP)
-			flags |= NL80211_RRF_ALLOW_6GHZ_VLP_AP;
-		else
-			flags |= NL80211_RRF_NO_6GHZ_VLP_CLIENT;
+	if (nvm_flags & NVM_CHANNEL_VLP)
+		flags |= NL80211_RRF_ALLOW_6GHZ_VLP_AP;
+	else
+		flags |= NL80211_RRF_NO_6GHZ_VLP_CLIENT;
 
-		if (!(nvm_flags & NVM_CHANNEL_AFC))
-			flags |= NL80211_RRF_NO_6GHZ_AFC_CLIENT;
-	}
+	if (!(nvm_flags & NVM_CHANNEL_AFC))
+		flags |= NL80211_RRF_NO_6GHZ_AFC_CLIENT;
 
 	/*
 	 * reg_capa is per regulatory domain so apply it for every channel
@@ -1726,7 +1723,7 @@ static struct iwl_reg_capa iwl_get_reg_capa(u32 flags, u8 resp_ver)
 struct ieee80211_regdomain *
 iwl_parse_nvm_mcc_info(struct device *dev, const struct iwl_cfg *cfg,
 		       int num_of_ch, __le32 *channels, u16 fw_mcc,
-		       u16 geo_info, u32 cap, u8 resp_ver, bool uats_enabled)
+		       u16 geo_info, u32 cap, u8 resp_ver)
 {
 	int ch_idx;
 	u16 ch_flags;
@@ -1793,7 +1790,7 @@ iwl_parse_nvm_mcc_info(struct device *dev, const struct iwl_cfg *cfg,
 
 		reg_rule_flags = iwl_nvm_get_regdom_bw_flags(nvm_chan, ch_idx,
 							     ch_flags, reg_capa,
-							     cfg, uats_enabled);
+							     cfg);
 
 		/* we can't continue the same rule */
 		if (ch_idx == 0 || prev_reg_rule_flags != reg_rule_flags ||
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
index 5a1b5ab62de1..fd82feb24b2d 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2015, 2018-2023 Intel Corporation
+ * Copyright (C) 2005-2015, 2018-2024 Intel Corporation
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
 #ifndef __iwl_nvm_parse_h__
@@ -50,7 +50,7 @@ iwl_parse_nvm_data(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 struct ieee80211_regdomain *
 iwl_parse_nvm_mcc_info(struct device *dev, const struct iwl_cfg *cfg,
 		       int num_of_ch, __le32 *channels, u16 fw_mcc,
-		       u16 geo_info, u32 cap, u8 resp_ver, bool uats_enabled);
+		       u16 geo_info, u32 cap, u8 resp_ver);
 
 /**
  * struct iwl_nvm_section - describes an NVM section in memory.
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 0a8bd957bd6c..ef5acecd11fc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -28,9 +28,6 @@
 #define MVM_UCODE_ALIVE_TIMEOUT	(2 * HZ)
 #define MVM_UCODE_CALIB_TIMEOUT	(2 * HZ)
 
-#define IWL_UATS_VLP_AP_SUPPORTED BIT(29)
-#define IWL_UATS_AFC_AP_SUPPORTED BIT(30)
-
 struct iwl_mvm_alive_data {
 	bool valid;
 	u32 scd_base_addr;
@@ -491,17 +488,11 @@ static void iwl_mvm_uats_init(struct iwl_mvm *mvm)
 		.dataflags[0] = IWL_HCMD_DFL_NOCOPY,
 	};
 
-	if (!(mvm->trans->trans_cfg->device_family >=
-	      IWL_DEVICE_FAMILY_AX210)) {
+	if (mvm->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210) {
 		IWL_DEBUG_RADIO(mvm, "UATS feature is not supported\n");
 		return;
 	}
 
-	if (!mvm->fwrt.uats_enabled) {
-		IWL_DEBUG_RADIO(mvm, "UATS feature is disabled\n");
-		return;
-	}
-
 	cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, cmd.id,
 					IWL_FW_CMD_VER_UNKNOWN);
 	if (cmd_ver != 1) {
@@ -1223,10 +1214,6 @@ static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 					"Failed to send LARI_CONFIG_CHANGE (%d)\n",
 					ret);
 	}
-
-	if (le32_to_cpu(cmd.oem_uhb_allow_bitmap) & IWL_UATS_VLP_AP_SUPPORTED ||
-	    le32_to_cpu(cmd.oem_uhb_allow_bitmap) & IWL_UATS_AFC_AP_SUPPORTED)
-		mvm->fwrt.uats_enabled = true;
 }
 
 void iwl_mvm_get_bios_tables(struct iwl_mvm *mvm)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 4f16ada07e2f..8c732becd281 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -151,8 +151,7 @@ struct ieee80211_regdomain *iwl_mvm_get_regdomain(struct wiphy *wiphy,
 				      resp->channels,
 				      __le16_to_cpu(resp->mcc),
 				      __le16_to_cpu(resp->geo_info),
-				      le32_to_cpu(resp->cap), resp_ver,
-				      mvm->fwrt.uats_enabled);
+				      le32_to_cpu(resp->cap), resp_ver);
 	/* Store the return source id */
 	src_id = resp->source_id;
 	if (IS_ERR_OR_NULL(regd)) {
-- 
2.34.1


